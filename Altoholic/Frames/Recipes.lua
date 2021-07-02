local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local V = Altoholic.vars

local WHITE				= "|cFFFFFFFF"
local TEAL				= "|cFF00FF9A"
local YELLOW			= "|cFFFFFF00"
local GREEN				= "|cFF00FF00"
local RECIPE_GREY		= "|cFF808080"
local RECIPE_GREEN	= "|cFF40C040"
local RECIPE_ORANGE	= "|cFFFF8040"

local RecipeColors = { RECIPE_GREEN, YELLOW, RECIPE_ORANGE, RECIPE_GREY }
local RecipeColorNames = { BI["Green"], BI["Yellow"], BI["Orange"], L["Grey"] }

function Altoholic.TradeSkills.Recipes:BuildView()
	self.view = self.view or {}
	Altoholic:ClearTable(self.view)
	
	local ts = Altoholic.TradeSkills
	local c = Altoholic:GetCharacterTable()
	local p = c.recipes[ts.CurrentProfession]	-- dereference current profession

	if p.ScanFailed then return end
	
	local selectedColor = UIDropDownMenu_GetSelectedValue(AltoholicFrameRecipesInfo_SelectColor)
	local selectedClass = UIDropDownMenu_GetSelectedValue(AltoholicFrameRecipesInfo_SelectSubclass)
	local selectedSlot = UIDropDownMenu_GetSelectedValue(AltoholicFrameRecipesInfo_SelectInvSlot)
	
	local hideCategory		-- hide or show the current header ?
	local hideLine			-- hide or show the current line ?
	
	for index, s in pairs(p.list) do
		local color, title = strsplit("^", s)
		color = tonumber(color)
		
		if color == 0 then		-- header
			hideCategory = false
			if selectedClass ~= ALL_SUBCLASSES and selectedClass ~= title then
				hideCategory = true	-- hide if a specific subclass is selected AND we're not on it
			end

			if not hideCategory then
				table.insert(self.view, { id = index, isCollapsed = false } )
			end
		else		-- data line
			if not hideCategory then
				hideLine = false
				if selectedColor ~= 0 and selectedColor ~= color then
					hideLine = true
				elseif selectedSlot ~= ALL_INVENTORY_SLOTS then
					-- reuse of the second variable "title" as itemID, to avoid strsplit'ing again
					local itemID = tonumber(title)
					
					if itemID then
						local _, _, _, _, _, itemType, _, _, itemEquipLoc = GetItemInfo(itemID)

						if itemType == BI["Armor"] or itemType == BI["Weapon"] then
							if itemEquipLoc and strlen(itemEquipLoc) > 0 then
								if selectedSlot ~= itemEquipLoc then
									hideLine = true
								end
							end
						else	-- not a weapon or armor ? then test if it's a generic "Created item"
							if selectedSlot ~= NONEQUIPSLOT then
								hideLine = true
							end
						end
					else
						if selectedSlot ~= NONEQUIPSLOT then
							hideLine = true
						end
					end
				end
				
				if not hideLine then
					table.insert(self.view, index)
				end
			end
		end
	end

	-- going from last to first, if two headers follow one another, it means that the smallest index is an empty category, so delete it
	for i = (#self.view - 1), 1, -1 do
		if type(self.view[i]) == "table" and type(self.view[i+1]) == "table" then
			table.remove(self.view, i)
		end
	end
	
	-- to avoid testing for exceptions in the previous loop, deal with the only shortcoming here (if the last entry is a table, it's an empty category, delete it)
	if type(self.view[#self.view]) == "table" then
		table.remove(self.view)
	end
end

function Altoholic.TradeSkills.Recipes:Update()
	local ts = Altoholic.TradeSkills
	local c = Altoholic:GetCharacterTable()
	local VisibleLines = 14
	local frame = "AltoholicFrameRecipes"
	local entry = frame.."Entry"
	local p = c.recipes[ts.CurrentProfession]	-- dereference current profession
	
	if not p or p.ScanFailed then
		AltoholicFrameRecipesInfo:Hide()
		AltoholicTabCharactersStatus:SetText(L["No data"] .. ": " .. ts.CurrentProfession .. L[" scan failed for "] .. V.CurrentAlt)
		Altoholic:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 18)
		return
	else
		AltoholicFrameRecipesInfo:Show()
		AltoholicTabCharactersStatus:SetText("")
	end
	
	local curRank, maxRank
	if (ts.CurrentProfession == BI["Cooking"]) or 
		(ts.CurrentProfession == BI["First Aid"]) or
		(ts.CurrentProfession == BI["Fishing"]) then
		curRank, maxRank = ts:GetRank( c.skill[L["Secondary Skills"]][ts.CurrentProfession] )
	else
		curRank, maxRank = ts:GetRank( c.skill[L["Professions"]][ts.CurrentProfession] )
	end
	
	AltoholicFrameRecipesInfo_NumRecipes:SetText(
		format("%s" ..TEAL .. " %d/%d", ts.CurrentProfession, curRank, maxRank )
	)
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawGroup = true
	local i=1
	
	local isHeader
	local isCollapsed
	
	for index, s in pairs(self.view) do
		if type(s) == "table" then
			isHeader = true
			isCollapsed = s.isCollapsed
		else
			isHeader = nil
		end
		
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if isHeader then													-- then keep track of counters
				if isCollapsed == false then
					DrawGroup = true
				else
					DrawGroup = false
				end
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif DrawGroup then
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			end
		else		-- line will be displayed
			if isHeader then
				if isCollapsed == false then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawGroup = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawGroup = false
				end
				_G[entry..i.."Collapse"]:Show()
				_G[entry..i.."Craft"]:Hide()
				
				local _, name = strsplit("^", p.list[s.id])
				_G[entry..i.."RecipeLinkNormalText"]:SetText(TEAL .. name)
				_G[entry..i.."RecipeLink"]:SetID(0)
				_G[entry..i.."RecipeLink"]:SetPoint("TOPLEFT", 25, 0)

				for j=1, 8 do
					_G[ entry..i .. "Item" .. j ]:Hide()
				end
				
				_G[ entry..i ]:SetID(index)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
				
			elseif DrawGroup then
				_G[entry..i.."Collapse"]:Hide()

				local color, itemID, spellID, reagents = strsplit("^", p.list[s])
				color = RecipeColors[tonumber(color)]
				itemID = tonumber(itemID)
				
				if itemID then
					Altoholic:SetItemButtonTexture(entry..i.."Craft", GetItemIcon(itemID), 18, 18);
					_G[entry..i.."Craft"]:SetID(itemID)
					_G[entry..i.."Craft"]:Show()
				else
					_G[entry..i.."Craft"]:Hide()
				end
				
				_G[entry..i.."RecipeLinkNormalText"]:SetText(self:GetLink(spellID, ts.CurrentProfession, color))
				--_G[entry..i.."RecipeLink"]:SetID(index)
				_G[entry..i.."RecipeLink"]:SetID(s)
				_G[entry..i.."RecipeLink"]:SetPoint("TOPLEFT", 32, 0)

				for j=1, 8 do
					local itemName = entry..i .. "Item" .. j;
					local reagent = select(j, strsplit("|", reagents))
					
					if reagent then
						local reagentID, reagentCount = strsplit(":", reagent)
						reagentID = tonumber(reagentID)
						if reagentID then
							reagentCount = tonumber(reagentCount)
							
							_G[itemName]:SetID(reagentID)
							Altoholic:SetItemButtonTexture(itemName, GetItemIcon(reagentID), 18, 18);

							local itemCount = _G[itemName .. "Count"]
							itemCount:SetText(reagentCount);
							itemCount:Show();
						
							_G[ itemName ]:Show()
						else
							_G[ itemName ]:Hide()
						end
					else
						_G[ itemName ]:Hide()
					end
				end
					
				_G[ entry..i ]:SetID(index)
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

function Altoholic.TradeSkills.Recipes:DropDownColor_Initialize()
	local ts = Altoholic.TradeSkills
	local info = UIDropDownMenu_CreateInfo(); 
	
	if not ts.CurrentProfession then 
		info.text = L["Any"]
		info.value = 0
		info.func = Altoholic.TradeSkills.Recipes.ChangeColor
		info.checked = nil; 
		info.icon = nil; 
		UIDropDownMenu_AddButton(info, 1); 
		return
	end
	
	local c = Altoholic:GetCharacterTable()
	local p = c.recipes[ts.CurrentProfession]	-- dereference current profession

	info.text = L["Any"]
	info.text = format("%s %s(%s)", L["Any"], GREEN, p.TotalCount )
	info.value = 0
	info.func = Altoholic.TradeSkills.Recipes.ChangeColor
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 
	
	local count = {p.GreenCount, p.YellowCount, p.OrangeCount, p.TotalCount - p.GreenCount - p.YellowCount - p.OrangeCount}
	
	for i = 1, 4 do
		info.text = format("%s %s(%s)", RecipeColors[i] .. RecipeColorNames[i], GREEN, count[i] )
		info.value = i
		info.func = Altoholic.TradeSkills.Recipes.ChangeColor
		info.checked = nil; 
		info.icon = nil; 
		UIDropDownMenu_AddButton(info, 1); 
	end
end

function Altoholic.TradeSkills.Recipes:ChangeColor()
	UIDropDownMenu_SetSelectedValue(AltoholicFrameRecipesInfo_SelectColor, self.value);
	
	local self = Altoholic.TradeSkills.Recipes
	self:BuildView()
	self:Update()
end

function Altoholic.TradeSkills.Recipes:DropDownSubclass_Initialize()
	local info = UIDropDownMenu_CreateInfo(); 
	
	info.text = ALL_SUBCLASSES
	info.value = ALL_SUBCLASSES
	info.func = Altoholic.TradeSkills.Recipes.ChangeSubClass
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 

	local ts = Altoholic.TradeSkills
	if not ts.CurrentProfession then return end
	
	local c = Altoholic:GetCharacterTable()
	local p = c.recipes[ts.CurrentProfession]	-- dereference current profession
	
	for index, s in pairs(p.list) do				-- browse the list to find headers only, and add them as subclasses
		local color, name = strsplit("^", s)
		color = tonumber(color)
		
		if color == 0 then		-- header
			info.text = name
			info.value = name
			info.func = Altoholic.TradeSkills.Recipes.ChangeSubClass
			info.checked = nil; 
			info.icon = nil; 
			UIDropDownMenu_AddButton(info, 1);
		end
	end
end

function Altoholic.TradeSkills.Recipes:ChangeSubClass()
	UIDropDownMenu_SetSelectedValue(AltoholicFrameRecipesInfo_SelectSubclass, self.value);
	
	local self = Altoholic.TradeSkills.Recipes
	self:BuildView()
	self:Update()
end

function Altoholic.TradeSkills.Recipes:DropDownInvSlot_Initialize()
	local info = UIDropDownMenu_CreateInfo(); 
	
	info.text = ALL_INVENTORY_SLOTS
	info.value = ALL_INVENTORY_SLOTS
	info.func = Altoholic.TradeSkills.Recipes.ChangeInvSlot
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 

	local ts = Altoholic.TradeSkills
	if not ts.CurrentProfession then return end
	
	local c = Altoholic:GetCharacterTable()
	local p = c.recipes[ts.CurrentProfession]	-- dereference current profession
	
	local invSlots = {}
	for index, s in pairs(p.list) do				-- browse the list to find headers only, and add them as subclasses
		local color, itemID = strsplit("^", s)
		color = tonumber(color)
		
		if color ~= 0 then		-- NON header !!
			itemID = tonumber(itemID)
			if itemID then
				local _, _, _, _, _, itemType, _, _, itemEquipLoc = GetItemInfo(itemID)
				
				-- if itemType ~= BI["Armor"] and itemType ~= BI["Weapon"] then
					-- DEFAULT_CHAT_FRAME:AddMessage(itemType)
				-- end
				
				if itemEquipLoc and strlen(itemEquipLoc) > 0 then
					local slot = Altoholic.Equipment:GetInventoryTypeName(itemEquipLoc)
					if slot then
						invSlots[slot] = itemEquipLoc
					end
				end
			end
		end
	end
	
	for k, v in pairs(invSlots) do		-- add all the slots found
		info.text = k
		info.value = v
		info.func = Altoholic.TradeSkills.Recipes.ChangeInvSlot
		info.checked = nil; 
		info.icon = nil; 
		UIDropDownMenu_AddButton(info, 1);
	end

	info.text = NONEQUIPSLOT			--NONEQUIPSLOT = "Created Items"; -- Items created by enchanting
	info.value = NONEQUIPSLOT
	info.func = Altoholic.TradeSkills.Recipes.ChangeInvSlot
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1);
end

function Altoholic.TradeSkills.Recipes:ChangeInvSlot()
	UIDropDownMenu_SetSelectedValue(AltoholicFrameRecipesInfo_SelectInvSlot, self.value);
	
	local self = Altoholic.TradeSkills.Recipes
	self:BuildView()
	self:Update()
end

function Altoholic.TradeSkills.Recipes:GetList()
	local ts = Altoholic.TradeSkills
	local c = Altoholic:GetCharacterTable()			-- current alt
	return c.recipes[ts.CurrentProfession].list		-- current profession
end

function Altoholic.TradeSkills.Recipes:GetLink(spellID, profession, color)
	local name = GetSpellInfo(spellID)
	color = color or "|cffffd000"
	return format("%s|Henchant:%s|h[%s: %s]|h|r", color, spellID, profession, name)
end

function Altoholic.TradeSkills.Recipes:GetLinkByLine(index)
	local craft = self:GetList()[index]
	local _, _, spellID = strsplit("^", craft)
	
	return self:GetLink(spellID, Altoholic.TradeSkills.CurrentProfession)
end

function Altoholic.TradeSkills.Recipes:ResetDropDownMenus()
	UIDropDownMenu_SetSelectedValue(AltoholicFrameRecipesInfo_SelectColor, 0);
	UIDropDownMenu_SetText(AltoholicFrameRecipesInfo_SelectColor, L["Any"])
	UIDropDownMenu_SetSelectedValue(AltoholicFrameRecipesInfo_SelectSubclass, ALL_SUBCLASSES);
	UIDropDownMenu_SetText(AltoholicFrameRecipesInfo_SelectSubclass, ALL_SUBCLASSES)
	UIDropDownMenu_SetSelectedValue(AltoholicFrameRecipesInfo_SelectInvSlot, ALL_INVENTORY_SLOTS);
	UIDropDownMenu_SetText(AltoholicFrameRecipesInfo_SelectInvSlot, ALL_INVENTORY_SLOTS)
end

function Altoholic.TradeSkills.Recipes:ToggleAll(self)
	-- expand or collapse all sections of the currently displayed alt /tradeskill
	local c = Altoholic:GetCharacterTable()
	local ts = Altoholic.TradeSkills
	
	if c.recipes[ts.CurrentProfession].ScanFailed then
		return
	end

	if not self.isCollapsed then
		self.isCollapsed = true
		AltoholicFrameRecipesInfo_ToggleAll:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
	else
		self.isCollapsed = nil
		AltoholicFrameRecipesInfo_ToggleAll:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
	end

	for _, s in pairs(ts.Recipes.view) do
		if type(s) == "table" then		-- it's a header
			s.isCollapsed = (self.isCollapsed) or false
		end
	end
	
	ts.Recipes:Update()
end

function Altoholic.TradeSkills.Recipes:Link_OnClick(self, button)
	if ( button ~= "LeftButton" ) then
		return
	end
	
	if V.CurrentRealm ~= GetRealmName() then
		Altoholic:Print(L["Cannot link another realm's tradeskill"])
		return
	end
	
	-- if V.CurrentAccount ~= THIS_ACCOUNT then
		-- Altoholic:Print(L["Cannot link another account's tradeskill"])
		-- return
	-- end

	local c = Altoholic:GetCharacterTable()
	local link = c.recipes[Altoholic.TradeSkills.CurrentProfession].FullLink	

	if not link then
		Altoholic:Print(L["Invalid tradeskill link"])
		return
	end
	
	if ( ChatFrameEditBox:IsShown() ) then
		ChatFrameEditBox:Insert(V.CurrentAlt .. ": " .. link);
	end
end
