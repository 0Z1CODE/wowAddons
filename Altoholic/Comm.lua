local LibComp = LibStub:GetLibrary("LibCompress")
local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

Altoholic.Comm = {}

-- Message types
local MSG_ACCOUNT_SHARING_REQUEST			= 1
local MSG_ACCOUNT_SHARING_REFUSED			= 2
local MSG_ACCOUNT_SHARING_REFUSEDINCOMBAT	= 3
local MSG_ACCOUNT_SHARING_REFUSEDDISABLED	= 4
local MSG_ACCOUNT_SHARING_ACCEPTED			= 5
local MSG_ACCOUNT_SHARING_SENDNEXT			= 6
local MSG_ACCOUNT_SHARING_COMPLETED			= 7
local MSG_ACCOUNT_SHARING_SKIPNEXT			= 8
local MSG_ACCOUNT_SHARING_SKIP_ACK			= 9	-- item skip acknowledged
local MSG_ACCOUNT_SHARING_NODATA				= 10	-- requested data is not available

local CMD_FACTION_XFER			= 100
local CMD_TOKEN_XFER				= 101
local CMD_GUILD_XFER				= 102
local CMD_CHAR_XFER				= 103
local CMD_REFDATA_XFER			= 104

local TOC_SEP = "|"	-- separator used between items

-- TOC Item Types
local TOC_REPUTATION				= "1"
local TOC_TOKEN					= "2"
local TOC_GUILD					= "3"
local TOC_CHARACTER				= "4"
local TOC_REFERENCEDATA			= "5"

--[[	*** Protocol ***

Client				Server

==> MSG_ACCOUNT_SHARING_REQUEST 
<== MSG_ACCOUNT_SHARING_REFUSED (stop)   
or 
<== MSG_ACCOUNT_SHARING_ACCEPTED (receives the TOC)

while toc not empty
==> MSG_ACCOUNT_SHARING_SENDNEXT (pass the type, based on the TOC)
<== CMD_??? (transfer & save data)
wend

==> MSG_ACCOUNT_SHARING_COMPLETED

--]]

Altoholic.Comm.Sharing = {}
Altoholic.Comm.Sharing.CompMode = 1
Altoholic.Comm.Sharing.Callbacks = {
	[MSG_ACCOUNT_SHARING_REQUEST] = "OnSharingRequest",
	[MSG_ACCOUNT_SHARING_REFUSED] = "OnSharingRefused",
	[MSG_ACCOUNT_SHARING_REFUSEDINCOMBAT] = "OnPlayerInCombat",
	[MSG_ACCOUNT_SHARING_REFUSEDDISABLED] = "OnSharingDisabled",
	[MSG_ACCOUNT_SHARING_ACCEPTED] = "OnSharingAccepted",
	[MSG_ACCOUNT_SHARING_SENDNEXT] = "OnNextItemReceived",
	[MSG_ACCOUNT_SHARING_COMPLETED] = "OnSharingCompleted",
	[MSG_ACCOUNT_SHARING_SKIPNEXT] = "OnNextItemSkipped",
	[MSG_ACCOUNT_SHARING_SKIP_ACK] = "OnNextItemSkipAck",
	[MSG_ACCOUNT_SHARING_NODATA] = "OnDataNotAvailable",
	[CMD_FACTION_XFER] = "OnFactionReceived",
	[CMD_TOKEN_XFER] = "OnCurrenciesReceived",
	[CMD_GUILD_XFER] = "OnGuildsReceived",
	[CMD_CHAR_XFER] = "OnCharacterReceived",
	[CMD_REFDATA_XFER] = "OnRefDataReceived",
}

function Altoholic:AccSharingHandler(prefix, message, distribution, sender)
	-- 	since Ace 3 communication handlers cannot be enabled/disabled on the fly, 
	--	let's use a function pointer to either an empty function, or the normal one
	local self = Altoholic.Comm.Sharing

	if self and self.msgHandler then
		self[self.msgHandler](self, prefix, message, distribution, sender)
	end
end

function Altoholic.Comm.Sharing:SetMessageHandler(handler)
	self.msgHandler = handler
end

function Altoholic.Comm.Sharing:EmptyHandler(prefix, message, distribution, sender)
	-- automatically reply that the option is disabled
	self:Whisper(sender, MSG_ACCOUNT_SHARING_REFUSEDDISABLED)
end

function Altoholic.Comm.Sharing:ActiveHandler(prefix, message, distribution, sender)
	local success, msgType, msgData
	
	if self.CompMode == 1 then	
		success, msgType, msgData = Altoholic:Deserialize(message)
	else
		local decompData = LibComp:Decompress(message)
		success, msgType, msgData = Altoholic:Deserialize(decompData)
	end
	
	if not success then
		self.SharingEnabled = nil
		-- self:Print(msgType)
		-- self:Print(string.sub(decompData, 1, 15))
		return
	end
	
	if success and msgType then
		local comm = Altoholic.Comm.Sharing
		local cb = comm.Callbacks[msgType]
		
		if cb then
			comm[cb](self, sender, msgData)
		end
	end
end

function Altoholic.Comm.Sharing:Request()

	self.account = AltoAccountSharing_AccNameEditBox:GetText()
	if not self.account or strlen(self.account) == 0 then 		-- account name cannot be empty
		Altoholic:Print("[" .. XML_ALTO_TEXT10 .. "] " .. XML_ALTO_SHARING_HINT2)
		return 
	end

	local player	-- name of the player to whom the account sharing request will be sent
	
	if AltoAccountSharing_UseTarget:GetChecked() then
		player = UnitName("target")
	elseif AltoAccountSharing_UseName:GetChecked() then
		player = AltoAccountSharing_AccTargetEditBox:GetText()
	end

	if not player or strlen(player) == 0 then 		-- exit if no valid target is found
		return 
	end
	
	self.SharingInProgress = true
	AltoAccountSharing:Hide()
	Altoholic:Print(format(L["Sending account sharing request to %s"], player))
	self:Whisper(player, MSG_ACCOUNT_SHARING_REQUEST)
end

function Altoholic.Comm.Sharing:RequestNext(player)
	if self.NetDestCurItem <= #self.DestTOC then
		
		
		local skipNext		-- set to true if reference data is already know for this class (item can be skipped)
		
		local TocData = self.DestTOC[self.NetDestCurItem]
		local TocType = strsplit(TOC_SEP, TocData)
		
		if TocType == TOC_REFERENCEDATA then
			-- it the next item is class reference data (ie: info on talent trees) .. check if it's already known or not
			
			local ref = Altoholic:GetReferenceTable()
			local class = select(2, strsplit(TOC_SEP, TocData))
			
			if ref[class].talentInfo[1].background then
				skipNext = true
			else
				self.ClassRefData = class
			end
		elseif TocType == TOC_CHARACTER then
			local _, name, lastlogout = strsplit(TOC_SEP, TocData)
			lastlogout = tonumber(lastlogout)
			
			local r = Altoholic:GetRealmTable(GetRealmName(), self.account)
			
			if r.char[name] and (lastlogout ~= 0) and (r.char[name].lastlogout == lastlogout) then
				skipNext = true
			else
				self.Character = name
			end
		end
		
		if skipNext then
			Altoholic:Print(format("Skipping item %d of %d", self.NetDestCurItem, #self.DestTOC), YELLOW)
			self:Whisper(player, MSG_ACCOUNT_SHARING_SKIPNEXT)
		else
			Altoholic:Print(format(L["Requesting item %d of %d"], self.NetDestCurItem, #self.DestTOC), YELLOW)
			self:Whisper(player, MSG_ACCOUNT_SHARING_SENDNEXT)
		end
	
		self.NetDestCurItem = self.NetDestCurItem + 1
		return
	end

	Altoholic:Print(L["Transfer complete"])
	self:Whisper(player, MSG_ACCOUNT_SHARING_COMPLETED)
	Altoholic:ClearTable(self.DestTOC)
	self.DestTOC = nil
	
	self.SharingInProgress = nil
	self.SharingEnabled = nil
	self.NetDestCurItem = nil
	
	local r = Altoholic:GetRealmTable(GetRealmName(), self.account)
	r.lastAccountSharing = date()
	r.lastUpdatedWith = player		-- last player with whom the account sharing took place
	
	Altoholic:BuildCharacterInfoTable()
	Altoholic:BuildCharacterInfoView()
	AltoholicTabSummary:RefreshCurrentFrame()
end

function Altoholic.Comm.Sharing:MsgBoxHandler(button)

	local self = Altoholic.Comm.Sharing
	
	AltoMsgBox.ButtonHandler = nil		-- prevent any other call to msgbox from coming back here
	local sender = AltoMsgBox.Sender
	AltoMsgBox.Sender = nil
	
	if not button then 
		self:Whisper(sender, MSG_ACCOUNT_SHARING_REFUSED)
		self.SharingEnabled = nil
		return 
	end

	self.SharingEnabled = true
	
	local r = Altoholic.ThisRealm
	
	self.SourceTOC = { TOC_REPUTATION, TOC_TOKEN, TOC_GUILD	}
	
	for charName, c in pairs(r.char) do
		table.insert(self.SourceTOC, format("%s%s%s", TOC_CHARACTER, TOC_SEP .. charName, TOC_SEP .. c.lastlogout))
		table.insert(self.SourceTOC, format("%s%s", TOC_REFERENCEDATA, TOC_SEP .. c.englishClass))
	end

	self.NetSrcCurItem = 0					-- to display that item is 1 of x
	self.NetSrcNumItems = #self.SourceTOC
	self.AuthorizedRecipient = sender
	Altoholic:Print(format(L["Sending table of content (%d items)"], self.NetSrcNumItems))
	self:Whisper(sender, MSG_ACCOUNT_SHARING_ACCEPTED, self.SourceTOC)
end

function Altoholic.Comm.Sharing:OnSharingRequest(sender, data)
	if UnitAffectingCombat("player") ~= nil then
		-- automatically reject if requestee is in combat
		self:Whisper(sender, MSG_ACCOUNT_SHARING_REFUSEDINCOMBAT)
		return
	end
	
	Altoholic:Print(format(L["Account sharing request received from %s"], sender))
	AltoMsgBox:SetHeight(130)
	AltoMsgBox_Text:SetHeight(60)
	AltoMsgBox.ButtonHandler = Altoholic.Comm.Sharing.MsgBoxHandler
	AltoMsgBox.Sender = sender
	AltoMsgBox_Text:SetText(format(L["You have received an account sharing request\nfrom %s%s|r, accept it?"], WHITE, sender) .. "\n\n"
							.. format(L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"], WHITE, GREEN, WHITE,sender))
	AltoMsgBox:Show()
end

function Altoholic.Comm.Sharing:OnSharingRefused(sender, data)
	Altoholic:Print(format(L["Request rejected by %s"], sender))
	self.SharingInProgress = nil
end

function Altoholic.Comm.Sharing:OnPlayerInCombat(sender, data)
	Altoholic:Print(format(L["%s is in combat, request cancelled"], sender))
	self.SharingInProgress = nil
end

function Altoholic.Comm.Sharing:OnSharingDisabled(sender, data)
	Altoholic:Print(format(L["%s has disabled account sharing"], sender))
	self.SharingInProgress = nil
end

function Altoholic.Comm.Sharing:OnSharingAccepted(sender, data)
	self.DestTOC = data
	self.NetDestCurItem = 1
	Altoholic:Print(format(L["Table of content received (%d items)"], #self.DestTOC))
	self:RequestNext(sender)
end

function Altoholic.Comm.Sharing:OnNextItemReceived(sender, data)
	if self.SharingEnabled and self.AuthorizedRecipient then
		local r = Altoholic.ThisRealm
		self.NetSrcCurItem = self.NetSrcCurItem + 1
		
		local TocData = self.SourceTOC[self.NetSrcCurItem]
		local TocType = strsplit(TOC_SEP, TocData)
		
		if TocType == TOC_REPUTATION then
			if r.reputation then
				Altoholic:Print(format(L["Sending reputations (%d of %d)"], self.NetSrcCurItem, self.NetSrcNumItems))
				self:Whisper(self.AuthorizedRecipient, CMD_FACTION_XFER, r.reputation)
			else
				Altoholic:Print(L["No reputations found"])
			end
		elseif TocType == TOC_TOKEN then
			if r.tokens then
				Altoholic:Print(format(L["Sending currencies (%d of %d)"], self.NetSrcCurItem, self.NetSrcNumItems))
				self:Whisper(self.AuthorizedRecipient, CMD_TOKEN_XFER, r.tokens)
			else
				Altoholic:Print(L["No currencies found"])
			end
		elseif TocType == TOC_GUILD then
			if r.guild then
				Altoholic:Print(format(L["Sending guilds (%d of %d)"], self.NetSrcCurItem, self.NetSrcNumItems))
				self:Whisper(self.AuthorizedRecipient, CMD_GUILD_XFER, r.guild)
			else
				Altoholic:Print(L["No guild found"])
			end
		elseif TocType == TOC_CHARACTER then
			local name = select(2, strsplit(TOC_SEP, TocData))
			Altoholic:Print(format(L["Sending character %s (%d of %d)"], name, self.NetSrcCurItem, self.NetSrcNumItems))
			self:Whisper(self.AuthorizedRecipient, CMD_CHAR_XFER, r.char[name])			
			
		elseif TocType == TOC_REFERENCEDATA then
			local class = select(2, strsplit(TOC_SEP, TocData))
				
			local ref = Altoholic:GetReferenceTable()
			if not ref[class].talentInfo[1].background then
				-- data not available
				Altoholic:Print(format(L["Reference data not available"] .. ": %s (%d of %d)", strlower(class), self.NetSrcCurItem, self.NetSrcNumItems))
				self:Whisper(self.AuthorizedRecipient, MSG_ACCOUNT_SHARING_NODATA)
			else
				Altoholic:Print(format(L["Sending reference data: %s (%d of %d)"], strlower(class), self.NetSrcCurItem, self.NetSrcNumItems))
				self:Whisper(self.AuthorizedRecipient, CMD_REFDATA_XFER, ref[class])
			end
		end
	end
end

function Altoholic.Comm.Sharing:OnSharingCompleted(sender, data)
	self.SharingEnabled = nil
	self.AuthorizedRecipient = nil
	self.NetSrcCurItem = nil
	self.NetSrcNumItems = nil
	Altoholic:ClearTable(self.SourceTOC)
	self.SourceTOC = nil
	Altoholic:Print(L["Transfer complete"])
end

function Altoholic.Comm.Sharing:OnNextItemSkipped(sender, data)
	if self.SharingEnabled and self.AuthorizedRecipient then
		self.NetSrcCurItem = self.NetSrcCurItem + 1
		Altoholic:Print(format("Skipping item .. (%d of %d)", self.NetSrcCurItem, self.NetSrcNumItems))
		self:Whisper(self.AuthorizedRecipient, MSG_ACCOUNT_SHARING_SKIP_ACK)
	end
end

function Altoholic.Comm.Sharing:OnNextItemSkipAck(sender, data)
	-- silently receive the acknowledge, and proceed with the next item
	self:RequestNext(sender)
end

function Altoholic.Comm.Sharing:OnDataNotAvailable(sender, data)
	Altoholic:Print(L["Reference data not available"])
	self:RequestNext(sender)
end

function Altoholic.Comm.Sharing:OnFactionReceived(sender, data)
	Altoholic:Print(L["Reputations received !"])
	Altoholic:ClearTable( Altoholic:GetRealmTable(GetRealmName(), self.account).reputation )
	Altoholic:GetRealmTable(GetRealmName(), self.account).reputation = data
	self:RequestNext(sender)
end

function Altoholic.Comm.Sharing:OnCurrenciesReceived(sender, data)
	Altoholic:Print(L["Currencies received !"])
	Altoholic:ClearTable( Altoholic:GetRealmTable(GetRealmName(), self.account).tokens )
	Altoholic:GetRealmTable(GetRealmName(), self.account).tokens = data
	self:RequestNext(sender)
end

function Altoholic.Comm.Sharing:OnGuildsReceived(sender, data)
	Altoholic:Print(L["Guilds received !"])
	Altoholic:ClearTable( Altoholic:GetRealmTable(GetRealmName(), self.account).guild )
	Altoholic:GetRealmTable(GetRealmName(), self.account).guild = data
	self:RequestNext(sender)
end

function Altoholic.Comm.Sharing:OnCharacterReceived(sender, data)
	Altoholic:Print(format(L["Character %s received !"], self.Character))
	
	local r = Altoholic:GetRealmTable(GetRealmName(), self.account)
	
	
	if type(r.char) ~= "table" then
		r.char = {}
	else
		Altoholic:ClearTable( r.char[self.Character] )
	end
	r.char[self.Character] = data

	local c = r.char[self.Character]
	
	if type(c.skill[L["Professions"]]) ~= "table" then
		c.skill[L["Professions"]] = {}
	end
	
	if type(c.skill[L["Secondary Skills"]]) ~= "table" then
		c.skill[L["Secondary Skills"]] = {}
	end

	self.Character = nil
	
	self:RequestNext(sender)
end

function Altoholic.Comm.Sharing:OnRefDataReceived(sender, data)
	if not self.ClassRefData then return end
	local ref = Altoholic:GetReferenceTable()
	
	ref[self.ClassRefData] = data
	Altoholic:Print(format(L["Reference data received (%s) !"], self.ClassRefData))
	self.ClassRefData = nil
	
	self:RequestNext(sender)
end

function Altoholic.Comm.Sharing:Whisper(player, messageType, ...)
	local serializedData = Altoholic:Serialize(messageType, ...)

	if self.CompMode == 1 then				-- no comp
		Altoholic:SendCommMessage("AltoShare", serializedData, "WHISPER", player)
		
	elseif self.CompMode == 2 then		-- comp huff
		local compData = LibComp:CompressHuffman(serializedData)
		
		local ser, comp
		ser = strlen(serializedData)
		comp = strlen(compData)
		DEFAULT_CHAT_FRAME:AddMessage(format("Compression (%d/%d) : %2.1f", ser, comp, (comp/ser)*100))
		
		Altoholic:SendCommMessage("AltoShare", compData, "WHISPER", player)

	elseif self.CompMode == 3 then		-- comp lzw
		local compData = LibComp:CompressLZW(serializedData)
		
		local ser, comp
		ser = strlen(serializedData)
		comp = strlen(compData)
		DEFAULT_CHAT_FRAME:AddMessage(format("Compression (%d/%d) : %2.1f", ser, comp, (comp/ser)*100))
		
		Altoholic:SendCommMessage("AltoShare", compData, "WHISPER", player)
	end
end




-- Message types
local MSG_GUILD_ANNOUNCELOGIN				= 1

-- deprecated, this message is no longer sent, but is kept in the handler for backwards compatibility
local MSG_GUILD_ANNOUNCELOGOUT			= 2		-- announces the logout of ANOTHER player, not self

local MSG_GUILD_SENDPUBLICINFO			= 3		-- whisper your own data in answer to an ANNOUNCELOGIN
local MSG_GUILD_BANKUPDATEREQUEST		= 4		-- "can you please send info about bank tab "name" ?
local MSG_GUILD_BANKUPDATEREPLY			= 5		-- "sure! here it is !"
local MSG_GUILD_EQUIPMENTREQUEST			= 6		-- "can you please send info about your equipment ?
local MSG_GUILD_EQUIPMENTREPLY			= 7		-- "sure! here it is !"
local MSG_GUILD_COMMDISABLED				= 8		-- The player has disabled  guild comm
local MSG_GUILD_BANKUPDATEREFUSED		= 9		-- Negative answer to MSG_GUILD_BANKUPDATEREQUEST
local MSG_GUILD_SENDMAIL_INIT				= 10
local MSG_GUILD_SENDMAIL_END				= 11
local MSG_GUILD_SENDMAIL_ATTACHMENTS	= 12
local MSG_GUILD_SENDMAIL_BODY				= 13
local MSG_GUILD_BANKUPDATEINFO			= 14		-- after having  updated a guild bank tab, broadcast updated info
local MSG_GUILD_BANKUPDATEWAITING		= 15		-- if bank tab update is not configured to be automatic, tell the requester to wait

Altoholic.Comm.Guild = {}
Altoholic.Comm.Guild.Callbacks = {
	[MSG_GUILD_ANNOUNCELOGIN] = "OnAnnounceLogin",
	[MSG_GUILD_ANNOUNCELOGOUT] = "OnAnnounceLogout",
	[MSG_GUILD_SENDPUBLICINFO] = "OnPublicInfoReceived",
	[MSG_GUILD_COMMDISABLED] = "OnCommDisabled",
	
	[MSG_GUILD_BANKUPDATEREQUEST] = "OnBankUpdateRequest",
	[MSG_GUILD_BANKUPDATEREPLY] = "OnBankUpdateReply",
	[MSG_GUILD_BANKUPDATEINFO] = "OnBankUpdateInfo",
	[MSG_GUILD_BANKUPDATEREFUSED] = "OnBankUpdateRefused",
	[MSG_GUILD_BANKUPDATEWAITING] = "OnBankUpdateWaiting",
	
	[MSG_GUILD_EQUIPMENTREQUEST] = "OnEquipmentRequest",
	[MSG_GUILD_EQUIPMENTREPLY] = "OnEquipmentReply",
	
	[MSG_GUILD_SENDMAIL_INIT] = "OnSendMailInit",
	[MSG_GUILD_SENDMAIL_END] = "OnSendMailEnd",
	[MSG_GUILD_SENDMAIL_ATTACHMENTS] = "OnSendMailAttachments",
	[MSG_GUILD_SENDMAIL_BODY] = "OnSendMailBody",
}


function Altoholic:GuildCommHandler(prefix, message, distribution, sender)
	local self = Altoholic.Comm.Guild

	if self and self.msgHandler then
		self[self.msgHandler](self, prefix, message, distribution, sender)
	end
end

function Altoholic.Comm.Guild:SetMessageHandler(handler)
	self.msgHandler = handler
end

function Altoholic.Comm.Guild:EmptyHandler(prefix, message, distribution, sender)
	self:Whisper(sender, MSG_GUILD_COMMDISABLED)
end

function Altoholic.Comm.Guild:ActiveHandler(prefix, message, distribution, sender)
	local success, msgType, msgData = Altoholic:Deserialize(message)
	
	if success and msgType then
		local comm = Altoholic.Comm.Guild
		local cb = comm.Callbacks[msgType]
		
		if cb then
			comm[cb](self, sender, msgData)
		end
	end
end

-- *** Guild Comm Callbacks ***
--	GENERAL
function Altoholic.Comm.Guild:OnAnnounceLogin(sender, data)
	local m = Altoholic.Guild.Members
	
	-- complete data that will not be sent later on, this will minimize the amount of data broadcaster over the guild channel
	m:Clear(data.name)
	data.name = sender
	
	local level, class, englishClass = m:GetInfo(sender)
	data.level = level or 0
	data.class = class or ""
	data.englishClass = englishClass or ""

	for k, v in pairs(data.skills) do
		level, class, englishClass = m:GetInfo(v.name)
		v.level = level or 0
		v.class = class or ""
		v.englishClass = englishClass or ""
	end	
	
	m:Add(data)
	
	-- after receiving & saving info, send our own data
	if sender ~= UnitName("player") then		-- don't send back to self
		Altoholic.Guild.Members:Save(data)
		Altoholic:SendPublicInfo(MSG_GUILD_SENDPUBLICINFO, sender)
	else
		-- when saving self, make sure it can never be deleted
		m.List[#m.List].RemoveForbidden = true
	end
	
	if IsInGuild() then
		GuildRoster()
	end
	AltoholicTabSummary:RefreshCurrentFrame()
end

function Altoholic.Comm.Guild:OnAnnounceLogout(sender, data)
	-- another altoholic user in the guild has detected that player "data" has disconnected and announced it to me

	local member = Altoholic.Guild.Members
	
	if sender ~= UnitName("player") then		-- don't process if it's coming from self
		for k, v in pairs(member.List) do
			if v.name == data and not v.RemoveForbidden then
				if not member:IsConnected(v.name) then		-- if the user is still in the table, remove it
					member:Delete(k)
					break
				end
			end
		end
	end
	AltoholicTabSummary:RefreshCurrentFrame()
end

function Altoholic.Comm.Guild:OnPublicInfoReceived(sender, data)
	local m = Altoholic.Guild.Members
	
	-- complete data that will not be sent later on, this will minimize the amount of data broadcaster over the guild channel
	m:Clear(data.name)
	data.name = sender
	
	local level, class, englishClass = m:GetInfo(sender)
	data.level = level or 0
	data.class = class or ""
	data.englishClass = englishClass or ""

	for k, v in pairs(data.skills) do
		level, class, englishClass = m:GetInfo(v.name)
		v.level = level or 0
		v.class = class or ""
		v.englishClass = englishClass or ""
	end
	
	m:Add(data)
	m:Save(data)
	AltoholicTabSummary:RefreshCurrentFrame()
end

function Altoholic.Comm.Guild:OnCommDisabled(sender, data)
	Altoholic:Print(format(L["%s has disabled guild communication"], sender ))
end

--	BANK
function Altoholic.Comm.Guild:OnBankUpdateRequest(sender, data)
	if Altoholic.Options:Get("GuildBankAutoUpdate") == 1 then
		Altoholic:SendGuildTab(sender, data)
	else
		Altoholic.Comm.Guild:Whisper(sender, MSG_GUILD_BANKUPDATEWAITING)
		AltoMsgBox:SetHeight(130)
		AltoMsgBox_Text:SetHeight(60)
		AltoMsgBox.ButtonHandler = AltoholicBankTabUpdate_ButtonHandler
		AltoMsgBox.Sender = sender
		AltoMsgBox.BankTab = data
		AltoMsgBox_Text:SetText(format(L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"], WHITE, sender, WHITE, data) .. "\n\n"
								.. format(L["%sWarning:|r make sure this user may view this information before accepting"], WHITE))
		AltoMsgBox:Show()
	end
end

function Altoholic.Comm.Guild:OnBankUpdateReply(sender, data)
	local r = Altoholic.ThisRealm
	if not r then return end
	
	for i=1, 6 do
		if data.name == GetGuildBankTabInfo(i) then
			local guildName = GetGuildInfo("player")
			local tab = r.guild[guildName].bank[i]
		
			if tab.name then		-- if there's data for this tab, clean it first
				Altoholic:ClearTable(tab)
			end
			
			r.guild[GetGuildInfo("player")].bank[i] = data

			AltoholicTabGuildBank:LoadGuild("Default", GetRealmName(), guildName)
			Altoholic:Print(format(L["Guild bank tab %s successfully updated !"], data.name ))
			
			-- since bank tab info has been updated, broadcast updated data to the guild
			tab = r.guild[guildName].bank[i]
			
			local t = {
				name = tab.name,
				ClientDate = tab.ClientDate,
				ClientHour = tab.ClientHour,
				ClientMinute = tab.ClientMinute,
				ServerHour = tab.ServerHour,
				ServerMinute = tab.ServerMinute
			}
			
			self:Broadcast(MSG_GUILD_BANKUPDATEINFO, t)
			break
		end
	end
	AltoholicTabSummary:RefreshCurrentFrame()
end

function Altoholic.Comm.Guild:OnBankUpdateInfo(sender, data)
	for k, v in pairs(Altoholic.Guild.Members.List) do
		if v.name == sender and v.guildbank then		-- find the player
			for tabID, tab in ipairs(v.guildbank) do
				if tab.name == data.name then		-- find the tab
					
					-- update the info
					tab.ClientDate = data.ClientDate
					tab.ClientHour = data.ClientHour
					tab.ClientMinute = data.ClientMinute
					tab.ServerHour = data.ServerHour
					tab.ServerMinute = data.ServerMinute
					
					AltoholicTabSummary:RefreshCurrentFrame()
					break
				end
			end
		end
	end
end

function Altoholic.Comm.Guild:OnBankUpdateRefused(sender, data)
	Altoholic:Print(format(L["Request rejected by %s"], sender))
end

function Altoholic.Comm.Guild:OnBankUpdateWaiting(sender, data)
	Altoholic:Print(format(L["Waiting for %s to accept .."], sender))
end

--	EQUIPMENT
function Altoholic.Comm.Guild:OnEquipmentRequest(sender, data)
	local c = Altoholic:GetCharacterTable(data, GetRealmName(), "Default")
	if c and c.inventory then
		Altoholic.Comm.Guild:Whisper(sender, MSG_GUILD_EQUIPMENTREPLY, c.inventory)
	end
end

function Altoholic.Comm.Guild:OnEquipmentReply(sender, data)
	Altoholic.Guild.Members:UpdateEquipment(data)
end

--	MAIL
function Altoholic.Comm.Guild:OnSendMailInit(sender, data)
	self.recipient = data
end

function Altoholic.Comm.Guild:OnSendMailEnd(sender, data)
	if self.recipient and Altoholic.Options:Get("GuildMailWarning") == 1 then
		Altoholic:Print(format(L["%s|r has received a mail from %s"], GREEN..self.recipient, GREEN..sender))
	end
	self.recipient = nil
end

function Altoholic.Comm.Guild:OnSendMailAttachments(sender, data)
	if not self.recipient then return end
	
	local c = Altoholic:GetCharacterTable(self.recipient, GetRealmName(), "Default")
	if not c then return end

	-- mails are saved into c.mailCache instead of c.mail, to avoid getting deleted if the mailbox is checked BEFORE the mail actually arrives in the mailbox
	for k, v in pairs(data) do		--  .. save attachments into his mailbox
		table.insert(c.mailCache, {
			icon = v.icon,
			link = v.link,
			count = v.count,
			["sender"] = sender,
			lastcheck = time(),
			daysleft = 30,
			realm = GetRealmName()
		} )
	end
end

function Altoholic.Comm.Guild:OnSendMailBody(sender, data)
	if not self.recipient then return end
	
	local c = Altoholic:GetCharacterTable(self.recipient, GetRealmName(), "Default")
	if not c then return end

	-- data sent as :  { moneySent, body, subject }
	local moneySent = data[1]

	local mailIcon
	if moneySent > 0 then
		mailIcon = "Interface\\Icons\\INV_Misc_Coin_01"
	else
		mailIcon = "Interface\\Icons\\INV_Misc_Note_01"
	end

	table.insert(c.mailCache, {
		money = moneySent,
		icon = mailIcon,
		text = data[2],		-- body
		subject = data[3],	-- subject
		["sender"] = sender,
		lastcheck = time(),
		daysleft = 30,
		realm = GetRealmName()
	} )
end


function Altoholic.Comm.Guild:Broadcast(messageType, ...)
	local serializedData = Altoholic:Serialize(messageType, ...)
	Altoholic:SendCommMessage("AltoGuild", serializedData, "GUILD")
end

function Altoholic.Comm.Guild:Whisper(player, messageType, ...)
	local serializedData = Altoholic:Serialize(messageType, ...)
	Altoholic:SendCommMessage("AltoGuild", serializedData, "WHISPER", player)
end


function AltoholicBankTabUpdate_ButtonHandler(self, button)
	AltoMsgBox.ButtonHandler = nil		-- prevent any other call to msgbox from coming back here
	local sender = AltoMsgBox.Sender
	local tabName = AltoMsgBox.BankTab
	AltoMsgBox.Sender = nil
	AltoMsgBox.BankTab = nil
	
	if not button then 
		Altoholic.Comm.Guild:Whisper(sender, MSG_GUILD_BANKUPDATEREFUSED)
		return 
	end
	
	Altoholic:SendGuildTab(sender, tabName)
end

function Altoholic:SendGuildTab(player, tabName)
	local r = Altoholic.ThisRealm
	
	for i=1, 6 do
		local tab = r.guild[GetGuildInfo("player")].bank[i]
		
		if tab.name == tabName then
			Altoholic.Comm.Guild:Whisper(player, MSG_GUILD_BANKUPDATEREPLY, tab)
			break
		end
	end
end


