local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local V = Altoholic.vars

local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"
local GREY		= "|cFF808080"
local GOLD		= "|cFFFFD700"
local RED		= "|cFFFF0000"

function Altoholic:Activity_Update()
	local VisibleLines = 14
	local frame = "AltoholicFrameActivity"
	local entry = frame.."Entry"
	
	if #Altoholic.CharacterInfo == 0 then
		-- added these 2 lines to make sur that the table is correct when the user gets here. 
		-- For some reason, a few users get a empty window..only an empty table could cuase this
		self:BuildCharacterInfoTable()
		self:BuildCharacterInfoView()
	
		if #Altoholic.CharacterInfo == 0 then
			-- if by any chance the table is still empty, then draw an empty frame
			self:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 18)
			return
		end
	end	
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawRealm
	local CurrentAccount, CurrentRealm
	local i=1
	
	for _, line in pairs(Altoholic.CharacterInfoView) do
		local s = Altoholic.CharacterInfo[line]
		local lineType = mod(s.linetype, 3)
		
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if lineType == INFO_REALM_LINE then								-- then keep track of counters
				CurrentAccount = s.account
				CurrentRealm = s.realm
				if s.isCollapsed == false then
					DrawRealm = true
				else
					DrawRealm = false
				end
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif DrawRealm then
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			end
		else		-- line will be displayed
			if lineType== INFO_REALM_LINE then
				CurrentAccount = s.account
				CurrentRealm = s.realm
				if s.isCollapsed == false then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawRealm = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawRealm = false
				end
				_G[entry..i.."Collapse"]:Show()
				_G[entry..i.."Name"]:SetWidth(300)
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 25, 0)
				_G[entry..i.."NameNormalText"]:SetWidth(300)
				if s.account == "Default" then	-- saved as default, display as localized.
					_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s|r)", s.realm, WHITE, GREEN, L["Default"]))
				else
					local r = Altoholic:GetRealmTable(CurrentRealm, CurrentAccount)
					if r and r.lastAccountSharing then
						_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s %s%s|r)", s.realm, WHITE, GREEN, s.account, YELLOW, r.lastAccountSharing))
					else
						_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s|r)", s.realm, WHITE, GREEN, s.account))
					end
				end				
				_G[entry..i.."Level"]:SetText("")
				_G[entry..i.."MailsNormalText"]:SetText("")
				_G[entry..i.."LastMailCheckNormalText"]:SetText("")
				_G[entry..i.."AuctionsNormalText"]:SetText("")
				_G[entry..i.."BidsNormalText"]:SetText("")
				_G[entry..i.."LastAHCheckNormalText"]:SetText("")
				_G[entry..i.."LastLogoutNormalText"]:SetText("")
				
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			elseif DrawRealm then
				if (lineType == INFO_CHARACTER_LINE) then
					local c = self.db.global.data[CurrentAccount][CurrentRealm].char[s.name]
				
					local icon
					if c.faction == "Alliance" then
						icon = self:TextureToFontstring("Interface\\Icons\\INV_BannerPVP_02", 18, 18) .. " "
					else
						icon = self:TextureToFontstring("Interface\\Icons\\INV_BannerPVP_01", 18, 18) .. " "
					end
					
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(170)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 10, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(170)
					_G[entry..i.."NameNormalText"]:SetText(icon .. format("%s%s (%s)", self:GetClassColor(c.englishClass), s.name, c.class))
					_G[entry..i.."Level"]:SetText(GREEN .. c.level)
				
					local numMails = #c.mail + #c.mailCache
					if numMails == 0 then
						_G[entry..i.."MailsNormalText"]:SetText(GREY .. "0")
					else
						local color = GREEN		-- green by default, red if at least one mail is about to expire
						
						if (Altoholic.Mail:GetNumExpiredMails(c.mail) > 0) or
							(Altoholic.Mail:GetNumExpiredMails(c.mailCache) > 0) then
							color = RED
						end
					
						_G[entry..i.."MailsNormalText"]:SetText(color .. numMails)
					end
					
					_G[entry..i.."LastMailCheckNormalText"]:SetText(WHITE .. Altoholic:FormatDelay(c.lastmailcheck))
					
					if #c.auctions == 0 then
						_G[entry..i.."AuctionsNormalText"]:SetText(GREY .. "0")
					else
						_G[entry..i.."AuctionsNormalText"]:SetText(GREEN .. #c.auctions)
					end
					
					if #c.bids == 0 then
						_G[entry..i.."BidsNormalText"]:SetText(GREY .. "0")
					else
						_G[entry..i.."BidsNormalText"]:SetText(GREEN .. #c.bids)
					end
					
					_G[entry..i.."LastAHCheckNormalText"]:SetText(WHITE .. Altoholic:FormatDelay(c.lastAHcheck))

					if (s.name == UnitName("player")) and (CurrentRealm == GetRealmName()) and (CurrentAccount == "Default") then
						_G[entry..i.."LastLogoutNormalText"]:SetText(GREEN .. GUILD_ONLINE_LABEL)
					else
						_G[entry..i.."LastLogoutNormalText"]:SetText(WHITE .. Altoholic:FormatDelay(c.lastlogout))
					end
				elseif (lineType == INFO_TOTAL_LINE) then
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(200)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(200)
					_G[entry..i.."NameNormalText"]:SetText(L["Totals"])
					_G[entry..i.."Level"]:SetText(s.level)
					_G[entry..i.."MailsNormalText"]:SetText("")
					_G[entry..i.."LastMailCheckNormalText"]:SetText("")
					_G[entry..i.."AuctionsNormalText"]:SetText("")
					_G[entry..i.."BidsNormalText"]:SetText("")
					_G[entry..i.."LastAHCheckNormalText"]:SetText("")
					_G[entry..i.."LastLogoutNormalText"]:SetText("")
				end
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			end
		end
	end
	
	while i <= VisibleLines do
		_G[ entry..i ]:SetID(0)
		_G[ entry..i ]:Hide()
		i = i + 1
	end

	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleCount, VisibleLines, 18);
end	

function Altoholic_Activity_OnEnter(self)
	local line = self:GetParent():GetID()
	local s = Altoholic.CharacterInfo[line]
	
	if mod(s.linetype, 3) ~= INFO_CHARACTER_LINE then		
		return
	end
	
	local r = Altoholic:GetRealmTableByLine(line)
	local c = r.char[s.name]
	local suggestion = Altoholic:GetSuggestion("Leveling", c.level)
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	
	AltoTooltip:AddLine(Altoholic:GetClassColor(c.englishClass) .. s.name,1,1,1);
	AltoTooltip:AddLine(L["Level"] .. " " .. GREEN .. c.level .. " |r".. c.race .. " " .. c.class,1,1,1);
	AltoTooltip:AddLine(L["Zone"] .. ": " .. GOLD .. c.zone .. " |r(" .. GOLD .. c.subzone .."|r)",1,1,1);	
	AltoTooltip:AddLine(EXPERIENCE_COLON .. " " 
				.. GREEN .. c.xp .. WHITE .. "/" 
				.. GREEN .. c.xpmax .. WHITE .. " (" 
				.. GREEN .. floor((c.xp / c.xpmax) * 100) .. "%"
				.. WHITE .. ")",1,1,1);	
	
	if c.restxp then
		AltoTooltip:AddLine(L["Rest XP"] .. ": " .. GREEN .. c.restxp,1,1,1);
	end

	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(GOLD..CURRENCY..":",1,1,1);
	
	local bCurrencyFound = false
	for currency, ownerList in pairs(r.tokens) do
		if ownerList[s.name] then
			bCurrencyFound = true
			AltoTooltip:AddLine(currency..": "..GREEN..ownerList[s.name],1,1,1);
		end
	end
	
	if bCurrencyFound == false then
		AltoTooltip:AddLine(WHITE..NONE,1,1,1);
	end
	
	AltoTooltip:Show();
end

local VIEW_MAILS = 3
local VIEW_AUCTIONS = 5
local VIEW_BIDS = 6

function Altoholic_Activity_OnClick(self)
	local line = self:GetParent():GetID()
	local s = Altoholic.CharacterInfo[line]
	
	if mod(s.linetype, 3) ~= INFO_CHARACTER_LINE then		
		return
	end
	
	local id = self:GetID()
	if (id == 2) or (id >= 5) then	-- exit if it's not the right column
		return
	end
	
	Altoholic:SetCurrentCharacter( Altoholic:GetCharacterInfo(line) )
	
	local action
	local c = Altoholic:GetCharacterTable()
	
	if id == 1 then			-- mails
		if (#c.mail+#c.mailCache) > 0 then				-- only set the action if there are data to show
			action = VIEW_MAILS
		end
	elseif id == 3 then		-- auctions
		if #c.auctions > 0 then
			action = VIEW_AUCTIONS
		end
	elseif id == 4 then		-- bids
		if #c.bids > 0 then
			action = VIEW_BIDS
		end
	end
	
	if action then
		AltoholicTabCharacters:SelectRealmDropDown_Initialize()
		UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectRealm, V.CurrentAccount .."|".. V.CurrentRealm)
		
		AltoholicTabCharacters:SelectCharDropDown_Initialize()
		UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectChar, V.CurrentAlt)
		
		Altoholic.Tabs:OnClick(2)
		AltoholicTabCharacters:ViewCharInfo(action)	
	end
end
