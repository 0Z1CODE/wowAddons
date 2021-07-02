local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local V = Altoholic.vars

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"
local RED		= "|cFFFF0000"
local TEAL		= "|cFF00FF9A"

local MAIL_LINE = 1				-- this is a normal line, coming from c.mail
-- this is a cached line, a mail saved by Altoholic itself via network communication, required to work around the fact 
-- that mails are saved BEFORE they actually get into the player's mailbox
local MAILCACHE_LINE = 2		

Altoholic.Mail = {}

function Altoholic.Mail:BuildView(field, sortOrder)
	
	field = field or "expiry"

	self.view = self.view or {}
	Altoholic:ClearTable(self.view)
	
	local c = Altoholic:GetCharacterTable()
	if not c then return end
	
	for k, _ in pairs(c.mail) do
		table.insert(self.view, {
			linetype = MAIL_LINE,
			parentID = k
		} )
	end
	
	for k, _ in pairs(c.mailCache) do
		table.insert(self.view, {
			linetype = MAILCACHE_LINE,
			parentID = k
		} )
	end
	
	if field == "name" then
		table.sort(self.view, function(a, b)
				local c = Altoholic:GetCharacterTable()
				local aRef, bRef
				
				if a.linetype == MAIL_LINE then
					aRef = c.mail[a.parentID]
				else
					aRef = c.mailCache[a.parentID]
				end
		
				if b.linetype == MAIL_LINE then
					bRef = c.mail[b.parentID]
				else
					bRef = c.mailCache[b.parentID]
				end
		
				local textA, textB
				
				if aRef.link then
					local id = Altoholic:GetIDFromLink(aRef.link)
					textA = GetItemInfo(id)		-- item name
				else
					textA = aRef.subject
				end
				
				if bRef.link then
					local id = Altoholic:GetIDFromLink(bRef.link)
					textB = GetItemInfo(id)		-- item name
				else
					textB = bRef.subject
				end
				
				if sortOrder then
					return textA < textB
				else
					return textA > textB
				end
			end)
	
	elseif field == "from" then
		table.sort(self.view, function(a, b)
				local c = Altoholic:GetCharacterTable()
				local aRef, bRef
				
				if a.linetype == MAIL_LINE then
					aRef = c.mail[a.parentID]
				else
					aRef = c.mailCache[a.parentID]
				end
		
				if b.linetype == MAIL_LINE then
					bRef = c.mail[b.parentID]
				else
					bRef = c.mailCache[b.parentID]
				end
		
				if sortOrder then
					return aRef.sender < bRef.sender
				else
					return aRef.sender > bRef.sender
				end
			end)
	elseif field == "expiry" then
		table.sort(self.view, function(a, b)
				local c = Altoholic:GetCharacterTable()
				local aRef, bRef
				
				if a.linetype == MAIL_LINE then
					aRef = c.mail[a.parentID]
				else
					aRef = c.mailCache[a.parentID]
				end
		
				if b.linetype == MAIL_LINE then
					bRef = c.mail[b.parentID]
				else
					bRef = c.mailCache[b.parentID]
				end
				
				local _, expiryA = Altoholic.Mail:GetExpiry(aRef.lastcheck, aRef.daysleft)
				local _, expiryB = Altoholic.Mail:GetExpiry(bRef.lastcheck, bRef.daysleft)
				
				if sortOrder then
					return expiryA < expiryB
				else
					return expiryA > expiryB
				end
			end)
	end
end

function Altoholic.Mail:Update()
	local c = Altoholic:GetCharacterTable()
	local VisibleLines = 7
	local frame = "AltoholicFrameMail"
	local entry = frame.."Entry"
	
	local player = V.CurrentAlt
	
	if c.MailCheckClientDate then
		-- new timestamps
		local localDate = format(L["Last visit: %s by %s"], GREEN..c.MailCheckClientDate..WHITE, GREEN..player)
		local localTime = format("%s%02d%s:%s%02d", GREEN, c.MailCheckClientHour, WHITE, GREEN, c.MailCheckClientMinute )
		AltoholicFrameMailInfo1:SetText(localDate .. WHITE .. " @ " .. localTime)
		AltoholicFrameMailInfo1:Show()
		
		if #self.view == 0 then
			AltoholicTabCharactersStatus:SetText(format(L["%s has no mail"], player))
			Altoholic:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 41)
			return
		else
			AltoholicTabCharactersStatus:SetText("")
		end
		
	else
		-- old timestamps
		AltoholicFrameMailInfo1:Hide()
		
		-- this part can be removed next time the DB will be wiped
		if #c.mail == 0 then
			if c.lastmailcheck == 0 then
				AltoholicTabCharactersStatus:SetText(player .. L[" has not visited his/her mailbox yet"])
			else
				AltoholicTabCharactersStatus:SetText(player .. L[" has no mail, last check "] .. self:GetDelayInDays(c.lastmailcheck).. L[" days ago"])
			end
		
			Altoholic:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 41)
			return
		end
		AltoholicTabCharactersStatus:SetText(L["Mail was last checked "] .. self:GetDelayInDays(c.lastmailcheck).. L[" days ago"])
	end
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	
	for i=1, VisibleLines do
		local line = i + offset
		if line <= #self.view then
			local m = self.view[line]
			local s
			if m.linetype == MAIL_LINE then
				s = c.mail[m.parentID]
			else
				s = c.mailCache[m.parentID]
			end
			
			if s.link then
				_G[ entry..i.."Name" ]:SetText(s.link)
			else
				_G[ entry..i.."Name" ]:SetText(s.subject)
			end
			
			_G[ entry..i.."Character" ]:SetText(s.sender)
			_G[ entry..i.."Expiry" ]:SetText(self:FormatExpiry(s.lastcheck, s.daysleft))
			_G[ entry..i.."ItemIconTexture" ]:SetTexture(s.icon);
			if (s.count ~= nil) and (s.count > 1) then
				_G[ entry..i.."ItemCount" ]:SetText(s.count)
				_G[ entry..i.."ItemCount" ]:Show()
			else
				_G[ entry..i.."ItemCount" ]:Hide()
			end
			-- trick: pass the index of the current item in the results table, required for the tooltip
			_G[ entry..i.."Item" ]:SetID(line)
			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end
	
	if #c.mail < VisibleLines then
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleLines, VisibleLines, 41);
	else
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], #self.view, VisibleLines, 41);
	end
end

function Altoholic.Mail:FormatExpiry(lastcheck, mailexpiry)

	local days, seconds = self:GetExpiry(lastcheck, mailexpiry)
	local colour
	
	if days > 10 then
		colour =  GREEN
	elseif days > 5 then
		colour = YELLOW
	else
		colour = RED
	end
	return colour .. SecondsToTime(seconds)
end

function Altoholic.Mail:GetExpiry(lastcheck, mailexpiry)
	-- return the mail expiry, expressed in days and in seconds
	local diff = time() - lastcheck
	local days = mailexpiry - (diff / 86400)
	local seconds = (mailexpiry*86400) - diff
	return days, seconds
end

function Altoholic.Mail:CheckExpiries()
	if not Altoholic.DoMailExpiryCheck then return end		-- do it only once per session
	Altoholic.DoMailExpiryCheck = nil
	
	-- this function checks the expiry date of each mail stored on all realms, and sets a flag if any is below threshold
	if Altoholic.Options:Get("CheckMailExpiry") == 0 then return end
	
	for RealmName, r in pairs(Altoholic.ThisAccount) do
		for CharacterName, c in pairs(r.char) do
			if (self:GetNumExpiredMails(c.mail) > 0) or
				(self:GetNumExpiredMails(c.mailCache) > 0) then
				
				AltoMsgBox:SetHeight(130)
				AltoMsgBox_Text:SetHeight(60)
				AltoMsgBox.ButtonHandler = AltoholicMailExpiry_ButtonHandler
				AltoMsgBox_Text:SetText(format("%sAltoholic: %s%s", TEAL, WHITE, 
					"\n" .. L["Mail is about to expire on at least one character."] .. "\n" 
					.. L["Refer to the activity pane for more details."].. "\n\n")
					.. L["Do you want to view it now ?"])
				AltoMsgBox:Show()
				return
			end
		end
	end
end

function Altoholic.Mail:GetNumExpiredMails(t)
	local threshold = Altoholic.Options:Get("MailWarningThreshold")
	local count = 0
	
	for k, v in pairs(t) do		--  parses a mail entry, either c.mail or c.mailCache
		if self:GetExpiry(v.lastcheck, v.daysleft) < threshold then
			count = count + 1
		end
	end
	
	return count
end

function AltoholicMailExpiry_ButtonHandler(self, button)
	AltoMsgBox.ButtonHandler = nil		-- prevent any other call to msgbox from coming back here
	if not button then return end
	
	Altoholic:ToggleUI()
	AltoholicTabSummary:SummaryMenuOnClick(4)
end

function Altoholic.Mail:Scan()
	local c = Altoholic.ThisCharacter
	local numItems = GetInboxNumItems();
	
	Altoholic:ClearTable(c.mail)
	if numItems == 0 then
		return
	end
	
	-- check the cache, and clean entries that are about to be replaced in the scan
	for i = #c.mailCache, 1, -1 do
		if c.mailCache[i].lastcheck then
			local age = time() - c.mailCache[i].lastcheck
			
			if age > 3600 then		-- if older than 1 hour, delete this entry
				table.remove(c.mailCache, i)
			end
		end
	end
	
	for i = 1, numItems do
		local _, stationaryIcon, mailSender, mailSubject, mailMoney, _, daysLeft, numAttachments = GetInboxHeaderInfo(i);
		if numAttachments ~= nil then			-- treat attachments as separate entries
			for j = 1, 12 do		-- mandatory, loop through all 12 slots, since attachments could be anywhere (ex: slot 4,5,8)
				local item, mailIcon, itemCount = GetInboxItem(i, j)
				if item ~= nil then
					table.insert(c.mail, {
						icon = mailIcon,
						count = itemCount,
						link = GetInboxItemLink(i, j),
						sender = mailSender,
						lastcheck = time(),
						daysleft = daysLeft
					} )
				end
			end
		end

		local inboxText
		if Altoholic.Options:Get("ScanMailBody") == 1 then
			inboxText = GetInboxText(i)					-- this marks the mail as read
		end
		
		if (mailMoney > 0) or inboxText then			-- if there's money or text .. save the entry
			if mailMoney > 0 then
				mailIcon = "Interface\\Icons\\INV_Misc_Coin_01"
			else
				mailIcon = stationaryIcon
			end
			table.insert(c.mail, {
				icon = mailIcon,
				money = mailMoney,
				text = inboxText,
				subject = mailSubject,
				sender = mailSender,
				lastcheck = time(),
				daysleft = daysLeft
			} )
		end
	end
	
	table.sort(c.mail, function(a, b)		-- show mails with the lowest expiry first
		return a.daysleft < b.daysleft
	end)
end

function Altoholic.Mail:GetItemCount(searchedID)
	local c = Altoholic.CountCharacter
	
	local count = 0
	for _, v in pairs (c.mail) do
		if v.link and (Altoholic:GetIDFromLink(v.link) == searchedID) then
			count = count + (v.count or 1)
		end
	end
	
	for _, v in pairs (c.mailCache) do
		if v.link and (Altoholic:GetIDFromLink(v.link) == searchedID) then
			count = count + (v.count or 1)
		end
	end
	
	return count
end

-- *** Hooks ***

local Orig_SendMail = SendMail

-- from Comm.lua
local MSG_GUILD_SENDMAIL_INIT				= 10
local MSG_GUILD_SENDMAIL_END				= 11
local MSG_GUILD_SENDMAIL_ATTACHMENTS	= 12
local MSG_GUILD_SENDMAIL_BODY				= 13

function SendMail(recipient, subject, body, ...)
	
	local r = Altoholic.ThisRealm
	local isRecipientAnAlt
	local attachments = Altoholic.Mail.Attachments

	-- check if recipient in an alt
	for CharacterName, c in pairs(r.char) do
		if strlower(CharacterName) == strlower(recipient) then			-- if recipient is a known alt
			for k, v in pairs(attachments) do		--  .. save attachments into his mailbox
				table.insert(c.mail, {
					icon = v.icon,
					link = v.link,
					count = v.count,
					sender = UnitName("player"),
					lastcheck = time(),
					daysleft = 30,
					realm = GetRealmName()
				} )
			end
			
			-- .. then save the mail itself + gold if any
			local moneySent = GetSendMailMoney()
			if (moneySent > 0) or (strlen(body) > 0) then
				local mailIcon
				if moneySent > 0 then
					mailIcon = "Interface\\Icons\\INV_Misc_Coin_01"
				else
					mailIcon = "Interface\\Icons\\INV_Misc_Note_01"
				end
				table.insert(c.mail, {
					money = moneySent,
					icon = mailIcon,
					text = body,
					subject = subject,
					sender = UnitName("player"),
					lastcheck = time(),
					daysleft = 30,
					realm = GetRealmName()
				} )
			end
			
			if (c.lastmailcheck == nil) or (c.lastmailcheck == 0) then
				-- if the alt has never checked his mail before, this value won't be correct, so set it to make sure expiry returns proper results.
				c.lastmailcheck = time()
			end
			
			table.sort(c.mail, function(a, b)		-- show mails with the lowest expiry first
				return a.daysleft < b.daysleft
			end)
			
			isRecipientAnAlt = true
			
			break
		end
	end
	
	if not isRecipientAnAlt then
		local player = Altoholic.Guild.Members:GetNameOfMain(recipient)
		
		if player then 
			-- this mail is sent to "player", but is for alt  "recipient"
			local comm = Altoholic.Comm.Guild
			
			comm:Whisper(player, MSG_GUILD_SENDMAIL_INIT, recipient)
			comm:Whisper(player, MSG_GUILD_SENDMAIL_ATTACHMENTS, attachments)
			
			-- .. then save the mail itself + gold if any
			local moneySent = GetSendMailMoney()
			if (moneySent > 0) or (strlen(body) > 0) then
				comm:Whisper(player, MSG_GUILD_SENDMAIL_BODY, { moneySent, body, subject })
			end
			
			comm:Whisper(player, MSG_GUILD_SENDMAIL_END)
		end
	end
	
	Altoholic:ClearTable(attachments)
	Orig_SendMail(recipient, subject, body, ...)
end

local Orig_SendMailNameEditBox_OnChar = SendMailNameEditBox:GetScript("OnChar")
SendMailNameEditBox:SetScript("OnChar", function(...)
	local text = this:GetText(); 
	local textlen = strlen(text); 
	
	for name, c in pairs(Altoholic.ThisRealm.char) do
		if c.faction == UnitFactionGroup("player") then
			if ( strfind(strupper(name), strupper(text), 1, 1) == 1 ) then
				SendMailNameEditBox:SetText(name);
				SendMailNameEditBox:HighlightText(textlen, -1);
				return;
			end
		end
	end
	
	return Orig_SendMailNameEditBox_OnChar(...)
end)


-- *** EVENT HANDLERS ***

function Altoholic.Mail:OnShow()
	local self = Altoholic.Mail
	
	CheckInbox()
	Altoholic:RegisterEvent("MAIL_CLOSED", self.OnClose)
	Altoholic:RegisterEvent("MAIL_INBOX_UPDATE", self.OnInboxUpdate)
	Altoholic:RegisterEvent("MAIL_SEND_INFO_UPDATE", self.OnSendInfoUpdate)
	self.Attachments = self.Attachments or {}	-- create a temporary table to hold the attachments that will be sent, keep it local since the event is rare
	self.AllowMailUpdate = true
	self.isOpen = true
end

function Altoholic.Mail:OnClose()
	local self = Altoholic.Mail
	
	self.isOpen = nil
	Altoholic:UnregisterEvent("MAIL_CLOSED");
	self:Scan()
	
	local c = Altoholic.ThisCharacter
	c.lastmailcheck = time()
	if GetLocale() == "enUS" then				-- adjust this test if there's demand
		c.MailCheckClientDate = date("%m/%d/%Y")
	else
		c.MailCheckClientDate = date("%d/%m/%Y")
	end
	c.MailCheckClientHour = tonumber(date("%H"))
	c.MailCheckClientMinute = tonumber(date("%M"))
	
	Altoholic.Containers:ScanPlayerBags()
	Altoholic:UnregisterEvent("MAIL_INBOX_UPDATE");
	Altoholic:UnregisterEvent("MAIL_SEND_INFO_UPDATE");
	
	Altoholic:ClearTable(self.Attachments)
end

function Altoholic.Mail:OnInboxUpdate()
	local self = Altoholic.Mail
	
	-- don't try to update mail if MAIL_SHOW did not happen, or if an update is already happening, only do it once
	if self.AllowMailUpdate then
		self:Scan()
		self.AllowMailUpdate = false
	end
end

function Altoholic.Mail:OnSendInfoUpdate()
	local self = Altoholic.Mail
	
	Altoholic:ClearTable(self.Attachments)

	for i=1, 12 do
		local name, itemIcon, itemCount = GetSendMailItem(i)
		if name ~= nil then								-- if attachment slot is not empty .. save it
			table.insert(self.Attachments, {
				icon = itemIcon,
				link = GetSendMailItemLink(i),
				count = itemCount
			} )
		end
	end
end
