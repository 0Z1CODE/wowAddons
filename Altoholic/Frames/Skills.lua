local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local V = Altoholic.vars

local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2

local WHITE		= "|cFFFFFFFF"
local TEAL		= "|cFF00FF9A"
local RED		= "|cFFFF0000"
local ORANGE	= "|cFFFF7F00"
local YELLOW	= "|cFFFFFF00"
local GREEN		= "|cFF00FF00"

local RECIPE_GREY		= "|cFF808080"
local RECIPE_GREEN	= "|cFF40C040"
local RECIPE_ORANGE	= "|cFFFF8040"

function Altoholic.TradeSkills:Update()
	local VisibleLines = 14
	local frame = "AltoholicFrameSkills"
	local entry = frame.."Entry"
	
	if #Altoholic.CharacterInfo == 0 then
		-- added these 2 lines to make sur that the table is correct when the user gets here. 
		-- For some reason, a few users get a empty window..only an empty table could cuase this
		Altoholic:BuildCharacterInfoTable()
		Altoholic:BuildCharacterInfoView()
	
		if #Altoholic.CharacterInfo == 0 then
			-- if by any chance the table is still empty, then draw an empty frame
			Altoholic:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 18)
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
				_G[entry..i.."Skill1NormalText"]:SetText("")
				_G[entry..i.."Skill2NormalText"]:SetText("")
				_G[entry..i.."CookingNormalText"]:SetText("")
				_G[entry..i.."FirstAidNormalText"]:SetText("")
				_G[entry..i.."FishingNormalText"]:SetText("")
				_G[entry..i.."RidingNormalText"]:SetText("")
				
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			elseif DrawRealm then
				if (lineType == INFO_CHARACTER_LINE) then
					local c = Altoholic.db.global.data[CurrentAccount][CurrentRealm].char[s.name]
				
					local icon
					if c.faction == "Alliance" then
						icon = Altoholic:TextureToFontstring("Interface\\Icons\\INV_BannerPVP_02", 18, 18) .. " "
					else
						icon = Altoholic:TextureToFontstring("Interface\\Icons\\INV_BannerPVP_01", 18, 18) .. " "
					end
					
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(170)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 10, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(170)
					_G[entry..i.."NameNormalText"]:SetText(icon .. format("%s%s (%s)", Altoholic:GetClassColor(c.englishClass), s.name, c.class))
					_G[entry..i.."Level"]:SetText(GREEN .. c.level)
					
					if s.spellID1 then
						icon = Altoholic:TextureToFontstring(Altoholic:GetSpellIcon(s.spellID1), 18, 18) .. " "
					else
						icon = ""
					end
					_G[entry..i.."Skill1NormalText"]:SetText(icon .. self:GetColor(s.skillRank1) .. s.skillRank1)
					
					if s.spellID2 then
						icon = Altoholic:TextureToFontstring(Altoholic:GetSpellIcon(s.spellID2), 18, 18) .. " "
					else
						icon = ""
					end
					_G[entry..i.."Skill2NormalText"]:SetText(icon .. self:GetColor(s.skillRank2) .. s.skillRank2)
						
					icon = Altoholic:TextureToFontstring(Altoholic:GetSpellIcon(Altoholic:GetProfessionSpellID(BI["Cooking"])), 18, 18) .. " "
					_G[entry..i.."CookingNormalText"]:SetText(icon .. self:GetColor(s.cooking) .. s.cooking)
					icon = Altoholic:TextureToFontstring(Altoholic:GetSpellIcon(Altoholic:GetProfessionSpellID(BI["First Aid"])), 18, 18) .. " "
					_G[entry..i.."FirstAidNormalText"]:SetText(icon .. self:GetColor(s.firstaid) .. s.firstaid)
					icon = Altoholic:TextureToFontstring(Altoholic:GetSpellIcon(Altoholic:GetProfessionSpellID(BI["Fishing"])), 18, 18) .. " "
					_G[entry..i.."FishingNormalText"]:SetText(icon .. self:GetColor(s.fishing) .. s.fishing)
					
					if c.coldWeatherFlying then
						icon = Altoholic:TextureToFontstring(Altoholic:GetSpellIcon(54197), 18, 18) .. " "
					elseif s.riding >= 225 then
						icon = Altoholic:TextureToFontstring("Interface\\Icons\\Ability_Mount_Gryphon_01", 18, 18) .. " "
					else
						icon = Altoholic:TextureToFontstring("Interface\\Icons\\Ability_Mount_RidingHorse", 18, 18) .. " "
					end
					_G[entry..i.."RidingNormalText"]:SetText(icon .. self:GetColor(s.riding, 300) .. s.riding)
				elseif (lineType == INFO_TOTAL_LINE) then
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(200)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(200)
					_G[entry..i.."NameNormalText"]:SetText(L["Totals"])
					_G[entry..i.."Level"]:SetText(s.level)
					_G[entry..i.."Skill1NormalText"]:SetText("")
					_G[entry..i.."Skill2NormalText"]:SetText("")
					_G[entry..i.."CookingNormalText"]:SetText("")
					_G[entry..i.."FirstAidNormalText"]:SetText("")
					_G[entry..i.."FishingNormalText"]:SetText("")
					_G[entry..i.."RidingNormalText"]:SetText("")
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

function Altoholic.TradeSkills:OnEnter(self)
	local line = self:GetParent():GetID()
	local s = Altoholic.CharacterInfo[line]
	
	if mod(s.linetype, 3) ~= INFO_CHARACTER_LINE then		
		return
	end
	local id = self:GetID()
	local skillName, rank, suggestion
	local categoryName = L["Secondary Skills"]
	
	if id == 1 then
		skillName = s.skillName1
		categoryName = L["Professions"]
	elseif id == 2 then
		skillName = s.skillName2
		categoryName = L["Professions"]
	elseif id == 3 then
		skillName = BI["Cooking"]
	elseif id == 4 then
		skillName = BI["First Aid"]
	elseif id == 5 then
		skillName = BI["Fishing"]
	elseif id == 6 then
		skillName = L["Riding"]
	end

	local ts = Altoholic.TradeSkills
	local c = Altoholic:GetCharacterTableByLine(line)
	local curRank, maxRank = ts:GetRank( c.skill[categoryName][skillName] )
	
	if (id >= 1) and (id <= 6) then
		if id == 6 then	-- riding
			rank = ts:GetColor(curRank, 300) .. curRank .. "/" .. maxRank
		else
			rank = ts:GetColor(curRank) .. curRank .. "/" .. maxRank
		end
		suggestion = Altoholic:GetSuggestion(skillName, curRank)
	elseif id == 7 then	-- class
		if c.englishClass ~= "ROGUE" then
			return
		end
		skillName = L["Rogue Proficiencies"]
		
		local curLock, maxLock = ts:GetRank( c.skill[L["Class Skills"]][L["Lockpicking"]] )
		rank = TEAL .. L["Lockpicking"] .. " " .. curLock .. "/" .. maxLock
		suggestion = Altoholic:GetSuggestion(L["Lockpicking"], curLock)
	end
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	AltoTooltip:AddLine(skillName,1,1,1);
	AltoTooltip:AddLine(GREEN..rank,1,1,1);
	
	if id <= 4 then	-- all skills except fishing & riding
		AltoTooltip:AddLine(" ");
		local p = c.recipes[skillName]
		if not p or p.TotalCount == 0 then
			AltoTooltip:AddLine(L["No data"].. ": 0 " .. TRADESKILL_SERVICE_LEARN,1,1,1);
		else
			AltoTooltip:AddLine(p.TotalCount .. " " .. TRADESKILL_SERVICE_LEARN,1,1,1);
			AltoTooltip:AddLine(format(WHITE .. "%d " .. RECIPE_GREEN .. "Green|r /" 
				..	WHITE .. " %d " .. YELLOW .. "Yellow|r /" 
				..	WHITE .. " %d " .. RECIPE_ORANGE .. "Orange", 
				p.GreenCount, p.YellowCount, p.OrangeCount))
		end
	end
	
	local skillCap = 450
	if id == 6 then
		skillCap = 300
	end
	
	AltoTooltip:AddLine(" ");
	AltoTooltip:AddLine(RECIPE_GREY .. L["Grey"] .. "|r " .. L["up to"] .. " " .. (floor(skillCap*0.25)-1),1,1,1);
	AltoTooltip:AddLine(RED .. RED_GEM .. "|r " .. L["up to"] .. " " .. (floor(skillCap*0.50)-1),1,1,1);
	AltoTooltip:AddLine(ORANGE .. BI["Orange"] .. "|r " .. L["up to"] .. " " .. (floor(skillCap*0.75)-1),1,1,1);
	AltoTooltip:AddLine(YELLOW .. YELLOW_GEM .. "|r " .. L["up to"] .. " " .. (skillCap-1),1,1,1);
	AltoTooltip:AddLine(GREEN .. BI["Green"] .. "|r " .. L["at"] .. " "..skillCap.." " .. L["and above"],1,1,1);

	if suggestion then
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddLine(L["Suggestion"] .. ": ",1,1,1);
		AltoTooltip:AddLine(TEAL .. suggestion,1,1,1);
	end
	
	-- parse profession cooldowns
	local bCooldownFound
	for k, v in pairs(c.ProfessionCooldowns) do
		if not bCooldownFound then
			AltoTooltip:AddLine(" ",1,1,1);		-- add a line break only once
			bCooldownFound = true
		end
		
		local ProfessionName, craftName = strsplit("|", k)		-- keys are like : ["Tailoring|craftName"] = "315459.769|1211033170"
		if skillName == ProfessionName	then		-- if we're on the right tradeskill ..
			local reset, lastcheck = strsplit("|", v)
			reset = tonumber(reset)
			lastcheck = tonumber(lastcheck)
			local expiresIn = reset - (time() - lastcheck)
			
			if expiresIn > 0 then
				--AltoTooltip:AddDoubleLine(select(2, GetItemInfo(itemID) ), Altoholic:GetTimeString(expiresIn));
				AltoTooltip:AddDoubleLine(craftName, Altoholic:GetTimeString(expiresIn));
			end
		end
	end
	
	if not bCooldownFound then
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddLine(L["All cooldowns are up"],1,1,1);
	end
	
	AltoTooltip:Show();
end

local VIEW_MOUNTS = 8

function Altoholic.TradeSkills:OnClick(self, button)
	local line = self:GetParent():GetID()
	local s = Altoholic.CharacterInfo[line]
	
	if mod(s.linetype, 3) ~= INFO_CHARACTER_LINE then		
		return
	end
	local id = self:GetID()
	
	if id == 5 then return end		-- fishing ? do nothing
	
	Altoholic:SetCurrentCharacter( Altoholic:GetCharacterInfo(line) )

	local c = Altoholic:GetCharacterTable()
	local skillName
	if id == 1 then
		skillName = s.skillName1
	elseif id == 2 then
		skillName = s.skillName2
	elseif id == 3 then
		skillName = BI["Cooking"]
	elseif id == 4 then
		skillName = BI["First Aid"]
	end
	
	if skillName then
		if c.recipes[skillName].TotalCount == 0 then		-- if profession hasn't been scanned (or scan failed), exit
			return
		end
	end
	
	AltoholicTabCharacters:SelectRealmDropDown_Initialize()
	UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectRealm, V.CurrentAccount .."|".. V.CurrentRealm)
	
	AltoholicTabCharacters:SelectCharDropDown_Initialize()
	UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectChar, V.CurrentAlt)
	Altoholic.Tabs:OnClick(2)

	if id == 6 then
		AltoholicTabCharacters:ViewCharInfo(VIEW_MOUNTS)
	else
		AltoholicTabCharacters:ViewCharSkills(skillName)
	end
end

function Altoholic.TradeSkills:GetRank(skillString)
	-- from "200/225", returns the numeric values
	if type(skillString) ~= "string" then
		return 0, 0
	end
	
	local rank, maxRank = strsplit("|", skillString)
	return tonumber(rank), tonumber(maxRank)
end

local skillColors = { RECIPE_GREY, RED, ORANGE, YELLOW, GREEN }

function Altoholic.TradeSkills:GetColor(rank, skillCap)
	skillCap = skillCap or 450
	return skillColors[ floor(rank / (skillCap/4)) + 1 ]
end

function Altoholic.TradeSkills:GetInfo(link)
	-- returns info about a tradeskill based on the full profession link 
		
	if link then
		-- "|cffffd000|Htrade:51296:450:450:78000000042AFB1:2/73//7///9////7//////////g+/B|h[Cooking]|h|r",
		-- return profession_spell_id, current_rank, max_rank
		return link:match("trade:(%d+):(%d+):(%d+)")
	end
end

function Altoholic.TradeSkills:SaveActiveFilters()
	self.SelectedID = GetTradeSkillSelectionIndex()
	
	self.subClasses = { GetTradeSkillSubClasses() }
	self.invSlots = { GetTradeSkillInvSlots() }
	self.subClassID = UIDropDownMenu_GetSelectedID(TradeSkillSubClassDropDown)
	self.invSlotID = UIDropDownMenu_GetSelectedID(TradeSkillInvSlotDropDown)
	
	-- Subclasses
	SetTradeSkillSubClassFilter(0, 1, 1)	-- this checks "All subclasses"
	UIDropDownMenu_SetSelectedID(TradeSkillSubClassDropDown, 1)
	
	-- Inventory slots
	SetTradeSkillInvSlotFilter(0, 1, 1)		-- this checks "All slots"
	UIDropDownMenu_SetSelectedID(TradeSkillInvSlotDropDown, 1)
	
	-- Have Materials
	self.HaveMats = TradeSkillFrameAvailableFilterCheckButton:GetChecked()	-- nil or true
	TradeSkillFrameAvailableFilterCheckButton:SetChecked(false)
	TradeSkillOnlyShowMakeable(false)
end

function Altoholic.TradeSkills:RestoreActiveFilters()
	-- Subclasses
	SetTradeSkillSubClassFilter(self.subClassID-1, 1, 1)	-- this checks the previously checked value
	UIDropDownMenu_SetSelectedID(TradeSkillSubClassDropDown, self.subClassID)
	if self.subClassID == 1 then
		UIDropDownMenu_SetText(TradeSkillSubClassDropDown, ALL_SUBCLASSES);
	else
		UIDropDownMenu_SetText(TradeSkillSubClassDropDown, self.subClasses[self.subClassID-1]);
	end	
	
	self.subClassID = nil
	Altoholic:ClearTable(self.subClasses)
	self.subClasses = nil
	
	-- Inventory slots
	self.invSlotID = self.invSlotID or 1
	SetTradeSkillInvSlotFilter(self.invSlotID-1, 1, 1)	-- this checks the previously checked value
	UIDropDownMenu_SetSelectedID(TradeSkillInvSlotDropDown, self.invSlotID)
	if self.invSlotID == 1 then
		UIDropDownMenu_SetText(TradeSkillInvSlotDropDown, ALL_INVENTORY_SLOTS);
	else
		UIDropDownMenu_SetText(TradeSkillInvSlotDropDown, self.invSlots[self.invSlotID-1]);
	end
	
	self.invSlotID = nil
	Altoholic:ClearTable(self.invSlots)
	self.invSlots = nil
	
	-- Have Materials
	TradeSkillFrameAvailableFilterCheckButton:SetChecked(self.HaveMats or false)
	TradeSkillOnlyShowMakeable(self.HaveMats or false)
	self.HaveMats = nil
	
	SelectTradeSkill(self.SelectedID)
	self.SelectedID = nil
end

function Altoholic.TradeSkills:SaveHeaders()
	self.headersState = {} 	-- save the state of headers, restore it after scan
	self.headerCount = 0		-- use a counter to avoid being bound to header names, which might not be unique.
	
	for i = GetNumTradeSkills(), 1, -1 do		-- 1st pass, expand all categories
		local _, skillType, _, isExpanded  = GetTradeSkillInfo(i)
		 if (skillType == "header") then
			self.headerCount = self.headerCount + 1
			if not isExpanded then
				ExpandTradeSkillSubClass(i)
				self.headersState[self.headerCount] = true
			end
		end
	end
end

function Altoholic.TradeSkills:RestoreHeaders()
	self.headerCount = 0
	for i = GetNumTradeSkills(), 1, -1 do
		local _, skillType  = GetTradeSkillInfo(i)
		if (skillType == "header") then
			self.headerCount = self.headerCount + 1
			if self.headersState[self.headerCount] then
				CollapseTradeSkillSubClass(i)
			end
		end
	end
end

function Altoholic.TradeSkills:Scan(tradeskillName, mandatoryScan)
	local c = Altoholic.ThisCharacter
	local r = c.recipes[tradeskillName].list
	
	c.recipes[tradeskillName].FullLink = select(2, GetSpellLink(tradeskillName))

	self:SaveActiveFilters()
	self:SaveHeaders()

	if not mandatoryScan then
		-- Only allow the function to exit if the scan is not mandatory. It will be mandatory after a craft (to check if a cooldown was activated)
		local numSkills = GetNumTradeSkills()
		if numSkills < #r then 						-- leave if there are more skills in the db than what the game returns
			self:RestoreHeaders()
			self:RestoreActiveFilters()
			return
		elseif numSkills == #r then 		-- if the number is identical, chances are high that the DB already has the right data
			if c.recipes[tradeskillName].ScanFailed == false then
				self:RestoreHeaders()
				self:RestoreActiveFilters()
				return	-- , leave, but make sure scanfailed is false
			end
		end
	end
	
	Altoholic:ClearTable(r)
	
	for k, v in pairs(c.ProfessionCooldowns) do
		local skill = strsplit("|", k)		-- keys are like : ["Tailoring|craftName"] = "315459.769|1211033170"
		if skill == tradeskillName	then		-- if we're on the right tradeskill .. clear this entry, as it will be refreshed a bit further in this method
			v = nil
		end
	end
	
	local numGreen = 0
	local numYellow = 0
	local numOrange = 0
	local numTotal = 0
	local bScanFailed = false
	
	local color

	for i = 1, GetNumTradeSkills() do
		local skillName, skillType = GetTradeSkillInfo(i)
		
		if skillType == "header" then
			r[i] = "0^" .. skillName
		else
			numTotal = numTotal + 1
			local spellID = Altoholic:GetSpellIDFromLink(GetTradeSkillRecipeLink(i))
			
			local itemLink = GetTradeSkillItemLink(i)		-- in certain cases, scanning the item link will fail
			if not itemLink then				-- this usually happens  after a patch, when the local skills  cache has been reset
				bScanFailed = true
				break
			end

			local itemID = Altoholic:GetIDFromLink(itemLink)
			
			if skillType == "easy" then
				color = 1								-- 1 = green
				numGreen = numGreen + 1
			elseif skillType == "medium" then
				color = 2								-- 2 = yellow
				numYellow = numYellow + 1
			elseif skillType == "optimal" then
				color = 3								-- 3 = orange
				numOrange = numOrange + 1
			else
				color = 4
			end
			
			local cooldown = GetTradeSkillCooldown(i)
			if cooldown then
				c.ProfessionCooldowns[ tradeskillName .. "|" .. skillName ] = cooldown .. "|" .. time()
			end
			
			local reagents = {}
			for j=1, GetTradeSkillNumReagents(i) do
				local _, _, reagentCount = GetTradeSkillReagentInfo(i, j);
				local link = GetTradeSkillReagentItemLink(i, j)
				if link then
					table.insert(reagents, Altoholic:GetIDFromLink( link ) .. ":" .. reagentCount)
				else	-- when the trading skill window is opened, this should never happen, if it does, let the user known
					bScanFailed = true
				end
			end
			
			r[i] = color .. "^" .. (itemID or "") .. "^" .. spellID .. "^" .. table.concat(reagents, "|")
		end
	end
	
	self:RestoreHeaders()
	self:RestoreActiveFilters()
	
	c.recipes[tradeskillName].ScanFailed = bScanFailed
		
	if bScanFailed then
		Altoholic:Print(L["At least one recipe could not be read"])
		Altoholic:Print(L["Please open this window again"], YELLOW)
	end
	
	c.recipes[tradeskillName].GreenCount = numGreen
	c.recipes[tradeskillName].YellowCount = numYellow
	c.recipes[tradeskillName].OrangeCount = numOrange
	c.recipes[tradeskillName].TotalCount = numTotal
end

-- *** Hooks ***

local Orig_DoTradeSkill = DoTradeSkill

function DoTradeSkill(index, repeatCount, ...)
	Orig_DoTradeSkill(index, repeatCount, ...)
	Altoholic:RegisterEvent("TRADE_SKILL_UPDATE", Altoholic.TradeSkills.OnUpdate)
end

local Orig_AbandonSkill = AbandonSkill

function AbandonSkill(index, ...)
	local skillName = GetSkillLineInfo(index)				-- get the name of the profession that is being abandonned

	Orig_AbandonSkill(index, ...)
	
	local c = Altoholic.ThisCharacter
	
	c.skill[L["Professions"]][skillName] = nil			-- clear the skill entry
	
	Altoholic:ClearTable(c.recipes[skillName])			-- and the list of recipes
	c.recipes[skillName] = nil
end


-- *** EVENT HANDLERS ***

function Altoholic.TradeSkills:OnShow()
	--	local linked, name = IsTradeSkillLinked()
	if IsTradeSkillLinked() then return end
	
	local self = Altoholic.TradeSkills
	self.isOpen = true

	Altoholic:RegisterEvent("TRADE_SKILL_CLOSE", self.OnClose)
	
	self:Scan(GetTradeSkillLine(), nil)
end

function Altoholic.TradeSkills:OnUpdate()
	-- The hook in DoTradeSkill will register this event so that we only update skills once.
	-- unregister it before calling the update, or the event will be called recursively (due to expand/collapse)
	Altoholic:UnregisterEvent("TRADE_SKILL_UPDATE")
	Altoholic.TradeSkills:Scan(GetTradeSkillLine(), true)
end

function Altoholic.TradeSkills:OnClose()
	Altoholic:UnregisterEvent("TRADE_SKILL_CLOSE")
	Altoholic:UnregisterEvent("TRADE_SKILL_UPDATE")
	
	local self = Altoholic.TradeSkills
	self.isOpen = nil
end
