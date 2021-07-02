local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local V = Altoholic.vars

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local RED		= "|cFFFF0000"

Altoholic.Tabs.Search = {}

function Altoholic.Tabs.Search:BuildView()
	
	self.view = self.view or {}
	Altoholic:ClearTable(self.view)
	
	local itemClasses =  { GetAuctionItemClasses() };
	local classNum = 1
	for _, itemClass in pairs(itemClasses) do
		table.insert(self.view, { name = itemClass, isCollapsed = true } )
		table.insert(self.view, L["Any"] )
		
		local itemSubClasses =  { GetAuctionItemSubClasses(classNum) };
		for _, itemSubClass in pairs(itemSubClasses) do
			table.insert(self.view, itemSubClass )
		end
		
		classNum = classNum + 1
	end
end

function Altoholic.Tabs.Search:Update()
	local VisibleLines = 15

	local itemTypeIndex				-- index of the item type in the menu table
	local itemTypeCacheIndex		-- index of the item type in the cache table
	local MenuCache = {}
	
	for k, v in pairs (self.view) do		-- rebuild the cache
		if type(v) == "table" then		-- header
			itemTypeIndex = k
			table.insert(MenuCache, { linetype=1, nameIndex=k } )
			itemTypeCacheIndex = #MenuCache
		else
			if self.view[itemTypeIndex].isCollapsed == false then
				table.insert(MenuCache, { linetype=2, nameIndex=k, parentIndex=itemTypeIndex } )
				
				if (self.highlightIndex) and (self.highlightIndex == k) then
					MenuCache[#MenuCache].needsHighlight = true
					MenuCache[itemTypeCacheIndex].needsHighlight = true
				end
			end
		end
	end
	
	local buttonWidth = 156
	if #MenuCache > 15 then
		buttonWidth = 136
	end
	
	local offset = FauxScrollFrame_GetOffset( _G[ "AltoholicSearchMenuScrollFrame" ] );
	local itemButtom = "AltoholicTabSearchMenuItem"
	for i=1, VisibleLines do
		local line = i + offset
		
		if line > #MenuCache then
			_G[itemButtom..i]:Hide()
		else
			local p = MenuCache[line]
			
			_G[itemButtom..i]:SetWidth(buttonWidth)
			_G[itemButtom..i.."NormalText"]:SetWidth(buttonWidth - 21)
			if p.needsHighlight then
				_G[itemButtom..i]:LockHighlight()
			else
				_G[itemButtom..i]:UnlockHighlight()
			end			
			
			if p.linetype == 1 then
				_G[itemButtom..i.."NormalText"]:SetText(WHITE .. self.view[p.nameIndex].name)
				_G[itemButtom..i]:SetScript("OnClick", Altoholic.Tabs.Search.Header_OnClick)
				_G[itemButtom..i].itemTypeIndex = p.nameIndex
			elseif p.linetype == 2 then
				_G[itemButtom..i.."NormalText"]:SetText("|cFFBBFFBB   " .. self.view[p.nameIndex])
				_G[itemButtom..i]:SetScript("OnClick", Altoholic.Tabs.Search.Item_OnClick)
				_G[itemButtom..i].itemTypeIndex = p.parentIndex
				_G[itemButtom..i].itemSubTypeIndex = p.nameIndex
			end

			_G[itemButtom..i]:Show()
		end
	end
	
	FauxScrollFrame_Update( _G[ "AltoholicSearchMenuScrollFrame" ], #MenuCache, VisibleLines, 20);
end

function Altoholic.Tabs.Search:Header_OnClick()
	local i = self.itemTypeIndex
	local self = Altoholic.Tabs.Search
	local h = self.view[i]
	
	if h.isCollapsed == true then
		h.isCollapsed = false
	else
		h.isCollapsed = true
	end
	self:Update()
end

function Altoholic.Tabs.Search:Item_OnClick()
	local itemType = self.itemTypeIndex
	local itemSubType = self.itemSubTypeIndex
	local self = Altoholic.Tabs.Search

	self.highlightIndex = itemSubType
	self:Update()
	
	-- around 5-7 ms on the current realm, 25-40 ms in the loot tables
	if self.view[itemSubType] == L["Any"] then
		Altoholic.Search:FindItem(self.view[itemType].name)
	else
		Altoholic.Search:FindItem(self.view[itemType].name, self.view[itemSubType])
	end
end

function Altoholic.Tabs.Search:Reset()
	AltoholicFrame_SearchEditBox:SetText("")
	AltoholicTabSearch_MinLevel:SetText("")
	AltoholicTabSearch_MaxLevel:SetText("")
	AltoholicTabSearchStatus:SetText("")				-- .. the search results
	AltoholicFrameSearch:Hide()
	Altoholic.Search.Results:Clear()
	
	for k, v in pairs (self.view) do		-- rebuild the cache
		if type(v) == "table" then		-- header
			v.isCollapsed = true
		end
	end
	self.highlightIndex = nil
	
	for i = 1, 8 do 
		_G[ "AltoholicTabSearch_Sort"..i ]:Hide()
		_G[ "AltoholicTabSearch_Sort"..i ].ascendingSort = nil
	end
	self:Update()
end

function Altoholic.Tabs.Search:DropDownRarity_Initialize()
	local info = UIDropDownMenu_CreateInfo(); 

	for i = 0, 6 do		-- Quality: 0 = poor .. 5 = legendary
		info.text = ITEM_QUALITY_COLORS[i].hex .. _G["ITEM_QUALITY"..i.."_DESC"]
		info.value = i
		info.func = function(self)	
			UIDropDownMenu_SetSelectedValue(AltoholicTabSearch_SelectRarity, self.value);
		end
		info.checked = nil; 
		info.icon = nil; 
		UIDropDownMenu_AddButton(info, 1); 
	end
end 

function Altoholic.Tabs.Search:DropDownSlot_Initialize()
	local info = UIDropDownMenu_CreateInfo(); 
	
	info.text = L["Any"]
	info.value = 0
	info.func = function(self)	
		UIDropDownMenu_SetSelectedValue(AltoholicTabSearch_SelectSlot, self.value);
	end
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
	for i = 1, 18 do
		info.text = Altoholic.Equipment.Slots[i]
		info.value = i
		info.func = function(self)	
			UIDropDownMenu_SetSelectedValue(AltoholicTabSearch_SelectSlot, self.value);
		end
		info.checked = nil; 
		info.icon = nil; 
		UIDropDownMenu_AddButton(info, 1); 
	end
end 

local SEARCH_THISCHAR = 1
local SEARCH_THISREALM_THISFACTION = 2
local SEARCH_THISREALM_BOTHFACTIONS = 3
local SEARCH_ALLREALMS = 4
local SEARCH_ALLACCOUNTS = 5
local SEARCH_LOOTS = 6

function Altoholic.Tabs.Search:DropDownLocation_Initialize()
	local function SetSearchLocation(self) 
		UIDropDownMenu_SetSelectedValue(AltoholicTabSearch_SelectLocation, self.value)
	end

	local info = UIDropDownMenu_CreateInfo();
	
	info.text = L["This character"]
	info.value = SEARCH_THISCHAR
	info.func = SetSearchLocation
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
	
	info.text = format("%s %s(%s)", L["This realm"], GREEN, L["This faction"])
	info.value = SEARCH_THISREALM_THISFACTION
	info.func = SetSearchLocation
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
	
	info.text = format("%s %s(%s)", L["This realm"], GREEN, L["Both factions"])
	info.value = SEARCH_THISREALM_BOTHFACTIONS
	info.func = SetSearchLocation
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
	
	info.text = L["All realms"]
	info.value = SEARCH_ALLREALMS
	info.func = SetSearchLocation
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 
	
	info.text = L["All accounts"]
	info.value = SEARCH_ALLACCOUNTS
	info.func = SetSearchLocation
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	

	info.text = L["Loot tables"]
	info.value = SEARCH_LOOTS
	info.func = SetSearchLocation
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
end

function Altoholic.Tabs.Search:SetMode(mode)

	for i = 1, 8 do 
		_G[ "AltoholicTabSearch_Sort" .. i .. "Arrow"]:Hide()
		_G[ "AltoholicTabSearch_Sort"..i ].ascendingSort = nil	-- not sorted by default
	end

	-- sets the search mode, and prepares the frame accordingly (search update callback, column sizes, headers, etc..)
	if mode == "realm" then
		Altoholic.Search:SetUpdateHandler("Realm_Update")
		
		AltoholicTabSearch_Sort1:SetText(XML_ALTO_SEARCH_COL1)
		AltoholicTabSearch_Sort2:SetText(XML_ALTO_CHAR_DD2)
		AltoholicTabSearch_Sort3:SetText(XML_ALTO_CHAR_DD1)
		
		AltoholicTabSearch_Sort1:SetWidth(240)
		AltoholicTabSearch_Sort2:SetWidth(160)
		AltoholicTabSearch_Sort3:SetWidth(150)
		
		AltoholicTabSearch_Sort1:SetScript("OnClick", function(self) 
			Altoholic.Search.Results:Sort(self, "item") 
		end)
		AltoholicTabSearch_Sort2:SetScript("OnClick", function(self) 
			Altoholic.Search.Results:Sort(self, "char") 
		end)
		AltoholicTabSearch_Sort2:SetPoint("LEFT", AltoholicTabSearch_Sort1, "RIGHT", 5, 0)
		AltoholicTabSearch_Sort3:SetScript("OnClick", function(self) 
			Altoholic.Search.Results:Sort(self, "realm") 
		end)
		AltoholicTabSearch_Sort3:SetPoint("LEFT", AltoholicTabSearch_Sort2, "RIGHT", 5, 0)
		
		for i = 4, 8 do
			_G["AltoholicTabSearch_Sort"..i]:Hide()
		end
		
		for i=1, 7 do
			_G[ "AltoholicFrameSearchEntry"..i.."Name" ]:SetWidth(240)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat1" ]:SetWidth(160)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat1" ]:SetPoint("LEFT", _G[ "AltoholicFrameSearchEntry"..i.."Name" ], "RIGHT", 5, 0)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat2" ]:SetWidth(150)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat2" ]:SetPoint("LEFT", _G[ "AltoholicFrameSearchEntry"..i.."Stat1" ], "RIGHT", 5, 0)
			
			for j=3, 6 do
				_G[ "AltoholicFrameSearchEntry"..i.."Stat"..j ]:Hide()
			end
			_G[ "AltoholicFrameSearchEntry"..i.."ILvl" ]:Hide()
			
			_G[ "AltoholicFrameSearchEntry"..i ]:SetScript("OnEnter", nil)
			_G[ "AltoholicFrameSearchEntry"..i ]:SetScript("OnLeave", nil)
		end
				
	elseif mode == "loots" then
		Altoholic.Search:SetUpdateHandler("Loots_Update")
		
		AltoholicTabSearch_Sort1:SetText(XML_ALTO_SEARCH_COL1)
		AltoholicTabSearch_Sort2:SetText(L["Source"])
		AltoholicTabSearch_Sort3:SetText(L["Item Level"])

		AltoholicTabSearch_Sort1:SetWidth(240)
		AltoholicTabSearch_Sort2:SetWidth(160)
		AltoholicTabSearch_Sort2:SetPoint("LEFT", AltoholicTabSearch_Sort1, "RIGHT", 5, 0)
		AltoholicTabSearch_Sort3:SetWidth(150)
		AltoholicTabSearch_Sort3:SetPoint("LEFT", AltoholicTabSearch_Sort2, "RIGHT", 5, 0)
		
		AltoholicTabSearch_Sort1:SetScript("OnClick", function(self) 
			Altoholic.Search.Results:Sort(self, "item") 
		end)
		AltoholicTabSearch_Sort2:SetScript("OnClick", function(self) 
			Altoholic.Search.Results:Sort(self, "bossName") 
		end)
		AltoholicTabSearch_Sort3:SetScript("OnClick", function(self) 
			Altoholic.Search.Results:Sort(self, "iLvl") 
		end)
		
		for i = 4, 8 do
			_G["AltoholicTabSearch_Sort"..i]:Hide()
		end
		
		for i=1, 7 do
			_G[ "AltoholicFrameSearchEntry"..i.."Name" ]:SetWidth(240)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat1" ]:SetWidth(160)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat1" ]:SetPoint("LEFT", _G[ "AltoholicFrameSearchEntry"..i.."Name" ], "RIGHT", 5, 0)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat2" ]:SetWidth(150)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat2" ]:SetPoint("LEFT", _G[ "AltoholicFrameSearchEntry"..i.."Stat1" ], "RIGHT", 5, 0)
			
			for j=3, 6 do
				_G[ "AltoholicFrameSearchEntry"..i.."Stat"..j ]:Hide()
			end
			_G[ "AltoholicFrameSearchEntry"..i.."ILvl" ]:Hide()
			
			_G[ "AltoholicFrameSearchEntry"..i ]:SetScript("OnEnter", nil)
			_G[ "AltoholicFrameSearchEntry"..i ]:SetScript("OnLeave", nil)
		end
		
	elseif mode == "upgrade" then
		Altoholic.Search:SetUpdateHandler("Upgrade_Update")
		
		AltoholicTabSearch_Sort1:SetText(XML_ALTO_SEARCH_COL1)
	
		AltoholicTabSearch_Sort1:SetWidth(200)
		AltoholicTabSearch_Sort2:SetWidth(50)
		AltoholicTabSearch_Sort2:SetPoint("LEFT", AltoholicTabSearch_Sort1, "RIGHT", 0, 0)
		AltoholicTabSearch_Sort3:SetWidth(50)
		AltoholicTabSearch_Sort3:SetPoint("LEFT", AltoholicTabSearch_Sort2, "RIGHT", 0, 0)

		AltoholicTabSearch_Sort1:SetScript("OnClick", function(self) 
			Altoholic.Search.Results:Sort(self, "item") 
		end)
		
		for i=1, 6 do 
			local button = _G[ "AltoholicTabSearch_Sort"..(i+1) ]
			local text = select(i, strsplit("|", Altoholic.Equipment.FormatStats[Altoholic.Search:GetClass()]))
			if text then
				button:SetText(string.sub(text, 1, 3))
				button:Show()
				button:SetScript("OnClick", function(self) 
					Altoholic.Search.Results:Sort(self, "stat") -- use a getID to know which stat
				end)
			else
				button:Hide()
			end
		end
		AltoholicTabSearch_Sort8:SetText("iLvl")
		AltoholicTabSearch_Sort8:Show()
		AltoholicTabSearch_Sort8:SetScript("OnClick", function(self) 
			Altoholic.Search.Results:Sort(self, "iLvl") 
		end)
		
		for i=1, 7 do
			_G[ "AltoholicFrameSearchEntry"..i.."Name" ]:SetWidth(190)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat1" ]:SetWidth(50)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat1" ]:SetPoint("LEFT", _G[ "AltoholicFrameSearchEntry"..i.."Name" ], "RIGHT", 0, 0)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat2" ]:SetWidth(50)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat2" ]:SetPoint("LEFT", _G[ "AltoholicFrameSearchEntry"..i.."Stat1" ], "RIGHT", 0, 0)
			
			_G[ "AltoholicFrameSearchEntry"..i ]:SetScript("OnEnter", function(self) 
				Altoholic.Tabs.Search:TooltipStats(self) 
			end)
			_G[ "AltoholicFrameSearchEntry"..i ]:SetScript("OnLeave", function(self) 
				AltoTooltip:Hide()
			end)
		end
	end
	
	AltoholicTabSearch_Sort1:Show()
	AltoholicTabSearch_Sort2:Show()
	AltoholicTabSearch_Sort3:Show()
end

function Altoholic.Tabs.Search:TooltipStats(self)
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	
	AltoTooltip:AddLine(STATS_LABEL)
	AltoTooltip:AddLine(" ");
	
	local s = Altoholic.Search.Results:Get(self:GetID())

	for i=1, 6 do
		local text = select(i, strsplit("|", Altoholic.Equipment.FormatStats[Altoholic.Search:GetClass()]))
		if text then 
			local diff = select(2, strsplit("|", s["stat"..i]))
			diff = tonumber(diff)

			if diff < 0 then
				AltoTooltip:AddLine(RED .. diff .. " " .. text)
			elseif diff > 0 then 
				AltoTooltip:AddLine(GREEN .. "+" .. diff .. " " .. text)
			else
				AltoTooltip:AddLine(WHITE .. diff .. " " .. text)
			end
		end
	end
	AltoTooltip:Show()
end
