local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local V = Altoholic.vars

local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2
local THIS_ACCOUNT = "Default"

local TEAL		= "|cFF00FF9A"
local WHITE		= "|cFFFFFFFF"
local GOLD		= "|cFFFFD700"
local YELLOW	= "|cFFFFFF00"
local GREEN		= "|cFF00FF00"

local VIEW_BAGS = 1
local VIEW_MAILS = 3
local VIEW_QUESTS = 4
local VIEW_AUCTIONS = 5
local VIEW_BIDS = 6
local VIEW_COMPANIONS = 7
local VIEW_MOUNTS = 8

local ICON_FACTION_HORDE = "Interface\\Icons\\INV_BannerPVP_01"
local ICON_FACTION_ALLIANCE = "Interface\\Icons\\INV_BannerPVP_02"

function Altoholic:AccountSummary_Update()
	local VisibleLines = 14
	local frame = "AltoholicFrameSummary"
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
			if lineType == INFO_REALM_LINE then
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

				_G[entry..i.."Money"]:SetText("")
				_G[entry..i.."Played"]:SetText("")
				_G[entry..i.."XP"]:SetText("")
				_G[entry..i.."Rested"]:SetText("")
				_G[entry..i.."AvgILevelNormalText"]:SetText("")
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
						icon = self:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18) .. " "
					else
						icon = self:TextureToFontstring(ICON_FACTION_HORDE, 18, 18) .. " "
					end
					
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(170)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 10, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(170)
					_G[entry..i.."NameNormalText"]:SetText(icon .. format("%s%s (%s)", self:GetClassColor(c.englishClass), s.name, c.class))
					_G[entry..i.."Level"]:SetText(GREEN .. c.level)

					_G[entry..i.."Money"]:SetText(self:GetMoneyString(c.money))
					_G[entry..i.."Played"]:SetText(self:GetTimeString(c.played))
					_G[entry..i.."XP"]:SetText(GREEN .. floor((c.xp / c.xpmax) * 100) .. "%")
										
					if c.level == MAX_PLAYER_LEVEL then
						_G[entry..i.."Rested"]:SetText(WHITE .. "0%")
					else
						_G[entry..i.."Rested"]:SetText( self:GetRestedXP(c.xpmax, c.restxp, c.lastlogout, c.isResting) )
					end
					
					_G[entry..i.."AvgILevelNormalText"]:SetText(YELLOW..format("%.1f", c.averageItemLvl))
					
				elseif (lineType == INFO_TOTAL_LINE) then
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(200)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(200)
					_G[entry..i.."NameNormalText"]:SetText(L["Totals"])
					_G[entry..i.."Level"]:SetText(s.level)
					_G[entry..i.."Money"]:SetText(s.money)
					_G[entry..i.."Money"]:SetTextColor(1.0, 1.0, 1.0)
					_G[entry..i.."Played"]:SetText(s.played)
					_G[entry..i.."XP"]:SetText("")
					_G[entry..i.."Rested"]:SetText("")
					_G[entry..i.."AvgILevelNormalText"]:SetText("")
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

function Altoholic:GetFactionTotals(f, line)
	local r = Altoholic:GetRealmTableByLine(line)
	
	local level = 0
	local money = 0
	local played = 0
	
	for CharacterName, c in pairs(r.char) do
		if c.faction == f then
			level = level + c.level
			money = money + c.money
			played = played + c.played
		end
	end
	
	return level, money, played
end

function Altoholic_AccountSummaryLevel_OnEnter(self)
	local line = self:GetParent():GetID()
	local s = Altoholic.CharacterInfo[line]
	
	if mod(s.linetype, 3) == INFO_REALM_LINE then		
		return
	elseif mod(s.linetype, 3) == INFO_TOTAL_LINE then		
		AltoTooltip:ClearLines();
		AltoTooltip:SetOwner(self, "ANCHOR_TOP");
		AltoTooltip:AddLine(L["Totals"]);
		
		local aLevels, aMoney, aPlayed = Altoholic:GetFactionTotals("Alliance", line)
		local hLevels, hMoney, hPlayed = Altoholic:GetFactionTotals("Horde", line)
		
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddDoubleLine(WHITE..L["Levels"] , format("%s|r (%s %s|r, %s %s|r)", 
			s.level,
			Altoholic:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18), WHITE..aLevels,
			Altoholic:TextureToFontstring(ICON_FACTION_HORDE, 18, 18), WHITE..hLevels))
		
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddDoubleLine(WHITE..MONEY, format("%s|r (%s %s|r, %s %s|r)", 
			s.money,
			Altoholic:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18), 
			Altoholic:GetMoneyString(aMoney, WHITE),
			Altoholic:TextureToFontstring(ICON_FACTION_HORDE, 18, 18), 
			Altoholic:GetMoneyString(hMoney, WHITE)))
		
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddDoubleLine(WHITE..PLAYED , format("%s|r (%s %s|r, %s %s|r)",
			s.played,
			Altoholic:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18),
			Altoholic:GetTimeString(aPlayed),
			Altoholic:TextureToFontstring(ICON_FACTION_HORDE, 18, 18), 
			Altoholic:GetTimeString(hPlayed)))
		
		AltoTooltip:Show();
		return
	end

	local c = Altoholic:GetCharacterTableByLine(line)
	local suggestion = Altoholic:GetSuggestion("Leveling", c.level)
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	
	AltoTooltip:AddDoubleLine(Altoholic:GetClassColor(c.englishClass) .. s.name, Altoholic:ColourFaction(c.faction))
	
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
	
	if suggestion then
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddLine(L["Suggested leveling zone: "],1,1,1);
		AltoTooltip:AddLine(TEAL .. suggestion,1,1,1);
	end

	-- parse saved instances
	local bLineBreak = true
	for Instance, InstanceInfo in pairs (c.SavedInstance) do
		local InstanceName, InstanceID = strsplit("|", Instance)
			
		local reset, lastcheck = strsplit("|", InstanceInfo)
		reset = tonumber(reset)
		lastcheck = tonumber(lastcheck)
		local expiresIn = reset - (time() - lastcheck)
		
		if expiresIn > 0 then
			if bLineBreak then
				AltoTooltip:AddLine(" ",1,1,1);		-- add a line break only once
				bLineBreak = nil
			end
			AltoTooltip:AddDoubleLine(GOLD .. InstanceName .. 
				" (".. WHITE.."ID: " .. GREEN .. InstanceID .. "|r)", Altoholic:GetTimeString(expiresIn))
		else
			c.SavedInstance[Instance] = nil
		end
	end
	
	-- add PVP info if any
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddDoubleLine(WHITE.. L["Arena points: "] .. GREEN .. c.pvp_ArenaPoints, "HK: " .. GREEN .. c.pvp_hk )
	AltoTooltip:AddDoubleLine(WHITE.. L["Honor points: "] .. GREEN .. c.pvp_HonorPoints, "DK: " .. GREEN .. c.pvp_dk )
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(GREEN .. L["Right-Click for options"]);
	AltoTooltip:Show();
end

function Altoholic_AccountSummaryLevel_OnClick(self, button)
	local line = self:GetParent():GetID()
	if line == 0 then return end

	local s = Altoholic.CharacterInfo[line]

	local linetype = mod(s.linetype, 3)
	
	if linetype == INFO_TOTAL_LINE then		
		return
	end
	
	if button == "RightButton" then
		V.CharInfoLine = line	-- line containing info about the alt on which action should be taken (delete, ..)
		ToggleDropDownMenu(1, nil, AltoholicFrameSummaryRightClickMenu, self:GetName(), 0, -5);
		return
	elseif button == "LeftButton" and linetype == INFO_CHARACTER_LINE then
		Altoholic:SetCurrentCharacter( Altoholic:GetCharacterInfo(line) )
	
		AltoholicTabCharacters:SelectRealmDropDown_Initialize()
		UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectRealm, V.CurrentAccount .."|".. V.CurrentRealm)
		
		AltoholicTabCharacters:SelectCharDropDown_Initialize()
		UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectChar, V.CurrentAlt)
		
		Altoholic.Reputations:BuildView()
		Altoholic.Tabs:OnClick(2)
		AltoholicFrameContainers:UpdateContainerCache()
		AltoholicFrameAchievements:Hide()
		AltoholicTabCharacters:ViewCharInfo(VIEW_BAGS)
	end
end

function Altoholic_AccountSummaryAIL_OnEnter(self)
	local line = self:GetParent():GetID()
	local s = Altoholic.CharacterInfo[line]
	
	if mod(s.linetype, 3) ~= INFO_CHARACTER_LINE then		
		return
	end
		
	local c = Altoholic:GetCharacterTableByLine(line)
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	AltoTooltip:AddLine(Altoholic:GetClassColor(c.englishClass) .. s.name,1,1,1);
	AltoTooltip:AddLine(WHITE .. L["Average Item Level"] ..": " .. GREEN.. format("%.1f", c.averageItemLvl),1,1,1);

	Altoholic:AiLTooltip()
	AltoTooltip:Show();
end

function Altoholic:AiLTooltip()
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(TEAL .. L["Level"] .. " 60",1,1,1);
	AltoTooltip:AddDoubleLine(YELLOW .. "58-63", WHITE .. "Tier 0")
	AltoTooltip:AddDoubleLine(YELLOW .. "66", WHITE .. "Tier 1")
	AltoTooltip:AddDoubleLine(YELLOW .. "76", WHITE .. "Tier 2")
	AltoTooltip:AddDoubleLine(YELLOW .. "86-92", WHITE .. "Tier 3")
	AltoTooltip:AddLine(" ",1,1,1);
	
	AltoTooltip:AddLine(TEAL .. L["Level"] .. " 70",1,1,1);
	AltoTooltip:AddDoubleLine(YELLOW .. "115", WHITE .. BZ["Karazhan"])
	AltoTooltip:AddDoubleLine(YELLOW .. "120", WHITE .. "Tier 4")
	AltoTooltip:AddDoubleLine(YELLOW .. "128", WHITE .. BZ["Zul'Aman"])
	AltoTooltip:AddDoubleLine(YELLOW .. "133", WHITE .. "Tier 5")
	AltoTooltip:AddDoubleLine(YELLOW .. "146-154", WHITE .. "Tier 6")
	AltoTooltip:AddLine(" ",1,1,1);

	AltoTooltip:AddLine(TEAL .. L["Level"] .. " 80",1,1,1);
	AltoTooltip:AddDoubleLine(YELLOW .. "200", WHITE .. BZ["Naxxramas"] .. " (10)")
	AltoTooltip:AddDoubleLine(YELLOW .. "213", WHITE .. BZ["Naxxramas"] .. " (25)")
	AltoTooltip:AddDoubleLine(YELLOW .. "219", WHITE .. BZ["Ulduar"] .. " (10)")
end

function Summary_RightClickMenu_OnLoad()
	
	if not V.CharInfoLine then return end
	local s = Altoholic.CharacterInfo[V.CharInfoLine]
	if not s then return end
	
	local info = UIDropDownMenu_CreateInfo(); 

	if mod(s.linetype, 3) == INFO_REALM_LINE then
		
		local r = Altoholic:GetRealmTable(s.realm, s.account)

		if r and r.lastUpdatedWith then
			info.text		= format("Update from %s", GREEN..r.lastUpdatedWith)
			info.func		= AltoholicFrameSummary_UpdateRealm;
			UIDropDownMenu_AddButton(info, 1);
		end
		
		info.text		= L["Delete this Realm"]
		info.func		= AltoholicFrameSummary_DeleteRealm;
		UIDropDownMenu_AddButton(info, 1);
		return
	end

	info.text		= L["View bags"]
	info.value		= VIEW_BAGS
	info.func		= Altoholic_ViewAltInfo;
	UIDropDownMenu_AddButton(info, 1); 

	info.text		= L["View mailbox"]
	info.value		= VIEW_MAILS
	info.func		= Altoholic_ViewAltInfo;
	UIDropDownMenu_AddButton(info, 1); 
	
	info.text		= L["View quest log"]
	info.value		= VIEW_QUESTS
	info.func		= Altoholic_ViewAltInfo;
	UIDropDownMenu_AddButton(info, 1); 
	
	info.text		= L["View auctions"]
	info.value		= VIEW_AUCTIONS
	info.func		= Altoholic_ViewAltInfo;
	UIDropDownMenu_AddButton(info, 1); 

	info.text		= L["View bids"]
	info.value		= VIEW_BIDS
	info.func		= Altoholic_ViewAltInfo;
	UIDropDownMenu_AddButton(info, 1);
	
	info.text		= COMPANIONS
	info.value		= VIEW_COMPANIONS
	info.func		= Altoholic_ViewAltInfo;
	UIDropDownMenu_AddButton(info, 1); 
	
	info.text		= MOUNTS
	info.value		= VIEW_MOUNTS
	info.func		= Altoholic_ViewAltInfo;
	UIDropDownMenu_AddButton(info, 1); 
	
	info.text		= L["Delete this Alt"]
	info.func		= AltoholicFrameSummary_DeleteAlt;
	UIDropDownMenu_AddButton(info, 1); 
end

function Altoholic_ViewAltInfo()
	local line = V.CharInfoLine
	V.CharInfoLine = nil
	
	Altoholic:SetCurrentCharacter( Altoholic:GetCharacterInfo(line) )

	UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectRealm, V.CurrentAccount .."|".. V.CurrentRealm)
	UIDropDownMenu_SetText(AltoholicTabCharacters_SelectRealm, V.CurrentRealm)
	AltoholicTabCharacters:SelectCharDropDown_Initialize()
	UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectChar, V.CurrentAlt)

	Altoholic.Tabs:OnClick(2)
	AltoholicTabCharacters:ViewCharInfo(this.value)
end

function AltoholicFrameSummary_DeleteAlt()
	local s = Altoholic.CharacterInfo[V.CharInfoLine] -- no validity check, this comes from the dropdownmenu, it's been secured earlier
	local _, realm, account = Altoholic:GetCharacterInfo(V.CharInfoLine)
	
	if (account == "Default") and	(realm == GetRealmName()) and (s.name == UnitName("player")) then
		V.CharInfoLine = nil
		Altoholic:Print(L["Cannot delete current character"])
		return
	end

	AltoMsgBox.ButtonHandler = AltoholicFrameSummary_DeleteAltButtonHandler
	AltoMsgBox_Text:SetText(L["Delete this Alt"] .. "?\n" .. s.name)
	AltoMsgBox:Show()
end

function AltoholicFrameSummary_DeleteAltButtonHandler(self, button)
	AltoMsgBox.ButtonHandler = nil		-- prevent any other call to msgbox from coming back here
	local line = V.CharInfoLine
	V.CharInfoLine = nil
	if not button then return end
	
	local s = Altoholic.CharacterInfo[line] -- no validity check, this comes from the dropdownmenu, it's been secured earlier
	local AltName = s.name
	local _, realm, account = Altoholic:GetCharacterInfo(line)
	local r = Altoholic:GetRealmTableByLine(line)
	
	-- delete factions
	for RepName, RepTable in pairs(r.reputation) do
		RepTable[s.name] = nil
	end
	
	-- delete the character
	Altoholic:ClearTable(r.char[s.name])	-- clear all content for this char ..
	r.char[s.name] = nil							-- .. then the char entry itself
	
	local charCount = 0
	for _, _ in pairs(r.char) do
		charCount = charCount + 1
	end
	
	if charCount == 0 then		-- if no more chars on this realm, the realm can be deleted ..
		Altoholic:ClearTable(Altoholic.db.global.data[account][realm])
		Altoholic.db.global.data[account][realm] = nil
	end
	
	local realmCount = 0			
	for _, _ in pairs(Altoholic.db.global.data[account]) do
		realmCount = realmCount + 1
	end

	if realmCount == 0 then		-- if no more realms in this account, the account can be deleted ..
		Altoholic:ClearTable(Altoholic.db.global.data[account])
		Altoholic.db.global.data[account] = nil
	end	
	
	-- rebuild the main character table, and all the menus
	Altoholic:BuildCharacterInfoTable()
	Altoholic:BuildCharacterInfoView()
	Altoholic.Reputations:BuildView()
	AltoholicFrameAchievements:Hide()
	Altoholic:AccountSummary_Update()
		
	Altoholic:Print(format( L["Character %s successfully deleted"], AltName))
end

function AltoholicFrameSummary_UpdateRealm()
	local s = Altoholic.CharacterInfo[V.CharInfoLine] -- no validity check, this comes from the dropdownmenu, it's been secured earlier
	local r = Altoholic:GetRealmTable(s.realm, s.account)
	
	AltoAccountSharing_AccNameEditBox:SetText(s.account)
	AltoAccountSharing_UseTarget:SetChecked(nil)
	AltoAccountSharing_UseName:SetChecked(1)
	AltoAccountSharing_AccTargetEditBox:SetText(r.lastUpdatedWith)
	
	-- this part is the OnClick of AltoholicTabSummary_RequestSharing, avoid duplicating the code
	if Altoholic.Options:Get("AccSharingHandlerEnabled") == 0 then
		Altoholic:Print(XML_ALTO_SUMMARY_TEXT3)
		return
	end
	Altoholic:ToggleUI()
	AltoAccountSharing:Show()
end

function AltoholicFrameSummary_DeleteRealm()
	local s = Altoholic.CharacterInfo[V.CharInfoLine] -- no validity check, this comes from the dropdownmenu, it's been secured earlier
		
	if (s.account == "Default") and	(s.realm == GetRealmName()) then
		V.CharInfoLine = nil
		Altoholic:Print(L["Cannot delete current realm"])
		return
	end

	AltoMsgBox.ButtonHandler = AltoholicFrameSummary_DeleteRealmButtonHandler
	AltoMsgBox_Text:SetText(L["Delete this Realm"] .. "?\n" .. s.realm)
	AltoMsgBox:Show()
end

function AltoholicFrameSummary_DeleteRealmButtonHandler(self, button)
	AltoMsgBox.ButtonHandler = nil		-- prevent any other call to msgbox from coming back here
	local line = V.CharInfoLine
	V.CharInfoLine = nil
	if not button then return end

	local s = Altoholic.CharacterInfo[line] -- no validity check, this comes from the dropdownmenu, it's been secured earlier
	local realmName = s.realm
	
	Altoholic:ClearTable(Altoholic.db.global.data[s.account][s.realm])
	Altoholic.db.global.data[s.account][s.realm] = nil

	-- if the realm being deleted was the current ..
	if V.CurrentRealm == s.realm and V.CurrentAccount == s.account then
		
		-- reset to this player
		Altoholic:SetCurrentCharacter(UnitName("player"), GetRealmName(), THIS_ACCOUNT)
		
		AltoholicTabCharacters:SelectRealmDropDown_Initialize()
		UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectRealm, THIS_ACCOUNT .."|".. GetRealmName())
		
		AltoholicTabCharacters:SelectCharDropDown_Initialize()
		UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectChar, V.CurrentAlt)
		
		AltoholicFrameContainers:UpdateContainerCache()
		AltoholicTabCharacters:ViewCharInfo(VIEW_BAGS)
	end
	
	-- rebuild the main character table, and all the menus
	Altoholic:BuildCharacterInfoTable()
	Altoholic:BuildCharacterInfoView()
	Altoholic.Reputations:BuildView()
	AltoholicFrameAchievements:Hide()
	Altoholic:AccountSummary_Update()
		
	Altoholic:Print(format( L["Realm %s successfully deleted"], realmName))
end
