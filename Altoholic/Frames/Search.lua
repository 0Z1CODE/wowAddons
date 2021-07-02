local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local THIS_ACCOUNT = "Default"
local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local RED		= "|cFFFF0000"
local TEAL		= "|cFF00FF9A"
local YELLOW	= "|cFFFFFF00"

Altoholic.Search = {}
Altoholic.Search.Results = {}

function Altoholic.Search:Update()
	self[self.updateHandler](self)
end

function Altoholic.Search:SetUpdateHandler(h)
	self.updateHandler = h
end

function Altoholic.Search:Realm_Update()
	local VisibleLines = 7
	local frame = "AltoholicFrameSearch"
	local entry = frame.."Entry"
	
	local numResults = self.Results:GetNumber()
	
	if numResults == 0 then
		Altoholic:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 41)
		return
	end

	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	
	for i=1, VisibleLines do
		local line = i + offset
		local s = self.Results:Get(line)
		if s then
			local account, realm, guildName
			local charName
			local location
			
			if type(s.char) == "number" then
				charName, realm, account = Altoholic:GetCharacterInfo(s.char)
				local c = Altoholic:GetCharacterTableByLine(s.char)
				_G[ entry..i.."Stat1" ]:SetText(Altoholic:GetClassColor(c.englishClass) .. charName)
				
				location = Altoholic:GetFactionColour(c.faction) .. realm
				if account ~= THIS_ACCOUNT then
					location = location .. "\n" ..WHITE.. L["Account"] .. ": " ..GREEN.. account
				end
			else
				account, realm, guildName = strsplit("|", s.char)
				local r = Altoholic:GetRealmTable(realm, account)
				_G[ entry..i.."Stat1" ]:SetText(GREEN .. guildName)
				
				location = Altoholic:GetFactionColour(r.guild[guildName].faction) .. realm
				if account ~= THIS_ACCOUNT then
					location = location .. "\n" ..WHITE.. L["Account"] .. ": " ..GREEN.. account
				end
			end
			
			_G[ entry..i.."Stat2" ]:SetText(location)
				
			local itemID = s.id
			local itemName, itemRarity, itemIcon, hex
			local hex = WHITE
			local itemButton = _G[ entry..i.."Item" ]
			
			Altoholic:CreateButtonBorder(itemButton)
			itemButton.border:Hide()
			
			if not itemID then		-- nil item ID only in the case of enchanting recipes. Adjust later if necessary.
				_G[ entry..i.."ItemIconTexture" ]:SetTexture("Interface\\Icons\\Trade_Engraving");
			else
				itemName, _, itemRarity, _, _, _, _, _, _, itemIcon = GetItemInfo(itemID)
				if itemRarity then
					local r, g, b
					r, g, b, hex = GetItemQualityColor(itemRarity)
					if itemRarity >= 2 then
						itemButton.border:SetVertexColor(r, g, b, 0.5)
						itemButton.border:Show()
					end
				end
				_G[ entry..i.."ItemIconTexture" ]:SetTexture(GetItemIcon(itemID));
			end
			
			if s.craftNum then
				local c = Altoholic:GetCharacterTableByLine(s.char)
				local _, _, spellID = strsplit("^", c.recipes[s.location].list[s.craftNum])
				
				_G[ entry..i.."Name" ]:SetText(hex .. GetSpellInfo(tonumber(spellID)))
				_G[ entry..i.."SourceNormalText" ]:SetText(Altoholic.TradeSkills.Recipes:GetLink(spellID, s.location))
				_G[ entry..i.."Source" ]:SetID(line)
			else 
				_G[ entry..i.."Name" ]:SetText(hex .. itemName)
				_G[ entry..i.."Source" ]:SetText(TEAL .. s.location)
				_G[ entry..i.."Source" ]:SetID(0)
			end
			
			if s.count and s.count > 1 then
				_G[ entry..i.."ItemCount" ]:SetText(s.count)
				_G[ entry..i.."ItemCount" ]:Show()
			else
				_G[ entry..i.."ItemCount" ]:Hide()
			end
			
					-- local itemCooldown = _G[ entry..i.."Cooldown" ]
					-- local startTime = 0
					-- local duration = 0
					-- local	isEnabled = 0
					
					-- if b.cooldowns[itemIndex] then
						-- startTime, duration, isEnabled = strsplit("|", b.cooldowns[itemIndex])
						-- startTime = tonumber(startTime)
						-- duration = tonumber(duration)
						-- isEnabled = tonumber(isEnabled)
						
						-- local remaining = duration - (GetTime() - startTime)
						-- if remaining <= 0 then
							-- b.cooldowns[itemIndex] = nil
							-- startTime = 0
							-- duration = 0
							-- isEnabled = 0
						-- else
							-- itemButton.startTime = startTime
							-- itemButton.duration = duration
						-- end
					-- else
						-- itemButton.startTime = nil
						-- itemButton.duration = nil
					-- end
					
					-- CooldownFrame_SetTimer(itemCooldown, startTime, duration, isEnabled)

			_G[ entry..i.."Item" ]:SetID(line)
			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end

	if (offset+VisibleLines) <= numResults then
		AltoholicTabSearchStatus:SetText(numResults .. L[" results found (Showing "] .. (offset+1) .. "-" .. (offset+VisibleLines) .. ")")
	else
		AltoholicTabSearchStatus:SetText(numResults .. L[" results found (Showing "] .. (offset+1) .. "-" .. numResults .. ")")
	end
	
	if numResults < VisibleLines then
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleLines, VisibleLines, 41);
	else
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], numResults, VisibleLines, 41);
	end
	
	if not AltoholicFrameSearch:IsVisible() then
		AltoholicFrameSearch:Show()
	end
end

function Altoholic.Search:Loots_Update()
	local VisibleLines = 7
	local frame = "AltoholicFrameSearch"
	local entry = frame.."Entry"
	
	local numResults = self.Results:GetNumber()
	
	if numResults == 0 then
		Altoholic:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 41)
		return
	end

	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	
	for i=1, VisibleLines do
		local line = i + offset
		local s = self.Results:Get(line)
		if s then
			local itemID = s.id
			
			local itemButton = _G[ entry..i.."Item" ]
			Altoholic:CreateButtonBorder(itemButton)
			itemButton.border:Hide()
			
			local itemName, _, itemRarity, itemLevel = GetItemInfo(itemID)
			local r, g, b, hex = GetItemQualityColor(itemRarity)
			
			if itemRarity >= 2 then
				itemButton.border:SetVertexColor(r, g, b, 0.5)
				itemButton.border:Show()
			end
			
			_G[ entry..i.."ItemIconTexture" ]:SetTexture(GetItemIcon(itemID));

			_G[ entry..i.."Stat2" ]:SetText(YELLOW .. itemLevel)
			_G[ entry..i.."Name" ]:SetText(hex .. itemName)
			_G[ entry..i.."Source" ]:SetText(TEAL .. s.dropLocation)
			_G[ entry..i.."Source" ]:SetID(0)
			
			_G[ entry..i.."Stat1" ]:SetText(GREEN .. s.bossName)
			
			if (s.count ~= nil) and (s.count > 1) then
				_G[ entry..i.."ItemCount" ]:SetText(s.count)
				_G[ entry..i.."ItemCount" ]:Show()
			else
				_G[ entry..i.."ItemCount" ]:Hide()
			end

			_G[ entry..i.."Item" ]:SetID(line)
			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end

	if (offset+VisibleLines) <= numResults then
		AltoholicTabSearchStatus:SetText(numResults .. L[" results found (Showing "] .. (offset+1) .. "-" .. (offset+VisibleLines) .. ")")
	else
		AltoholicTabSearchStatus:SetText(numResults .. L[" results found (Showing "] .. (offset+1) .. "-" .. numResults .. ")")
	end
	
	if numResults < VisibleLines then
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleLines, VisibleLines, 41);
	else
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], numResults, VisibleLines, 41);
	end
	
	if not AltoholicFrameSearch:IsVisible() then
		AltoholicFrameSearch:Show()
	end
end

function Altoholic.Search:Upgrade_Update()
	local VisibleLines = 7
	local frame = "AltoholicFrameSearch"
	local entry = frame.."Entry"
	
	local numResults = self.Results:GetNumber()
	
	if numResults == 0 then
		Altoholic:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 41)
		return
	end

	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	
	for i=1, VisibleLines do
		local line = i + offset
		local s = self.Results:Get(line)
		if s then
			local itemID = s.id
			
			local itemButton = _G[ entry..i.."Item" ]
			Altoholic:CreateButtonBorder(itemButton)
			itemButton.border:Hide()
			
			local itemName, _, itemRarity, itemLevel = GetItemInfo(itemID)
			local r, g, b, hex = GetItemQualityColor(itemRarity)
			
			if itemRarity >= 2 then
				itemButton.border:SetVertexColor(r, g, b, 0.5)
				itemButton.border:Show()
			end
			
			_G[ entry..i.."ItemIconTexture" ]:SetTexture(GetItemIcon(itemID));

			_G[ entry..i.."Name" ]:SetText(hex .. itemName)
			_G[ entry..i.."Source" ]:SetText(TEAL .. s.dropLocation)
			_G[ entry..i.."Source" ]:SetID(0)
		
			for j=1, 6 do
				if s["stat"..j] ~= nil then
					local statValue, diff = strsplit("|", s["stat"..j])
					local color
					diff = tonumber(diff)
					
					if diff < 0 then
						color = RED
					elseif diff > 0 then 
						color = GREEN
					else
						color = WHITE
					end
					
					_G[ entry..i.."Stat"..j ]:SetText(color .. statValue)
					_G[ entry..i.."Stat"..j ]:Show()
				else
					_G[ entry..i.."Stat"..j ]:Hide()
				end
			end

			_G[ entry..i.."ILvl" ]:SetText(YELLOW .. itemLevel)
			_G[ entry..i.."ILvl" ]:Show()
			
			if (s.count ~= nil) and (s.count > 1) then
				_G[ entry..i.."ItemCount" ]:SetText(s.count)
				_G[ entry..i.."ItemCount" ]:Show()
			else
				_G[ entry..i.."ItemCount" ]:Hide()
			end

			_G[ entry..i.."Item" ]:SetID(line)
			_G[ entry..i ]:SetID(line)
			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end

	if (offset+VisibleLines) <= numResults then
		AltoholicTabSearchStatus:SetText(numResults .. L[" results found (Showing "] .. (offset+1) .. "-" .. (offset+VisibleLines) .. ")")
	else
		AltoholicTabSearchStatus:SetText(numResults .. L[" results found (Showing "] .. (offset+1) .. "-" .. numResults .. ")")
	end
	
	if numResults < VisibleLines then
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleLines, VisibleLines, 41);
	else
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], numResults, VisibleLines, 41);
	end
	
	if not AltoholicFrameSearch:IsVisible() then
		AltoholicFrameSearch:Show()
	end
end

function Altoholic.Search.Results:Clear()
	self.List = self.List or {}
	Altoholic:ClearTable(self.List)
end

function Altoholic.Search.Results:Add(t)
	table.insert(self.List, t)	
end

function Altoholic.Search.Results:GetNumber()
	return #self.List or 0
end

function Altoholic.Search.Results:Get(n)
	if n then						-- if n is specified ..
		return self.List[n]		-- .. return that entry
	else
		return self.List			-- .. otherwise a reference to the whole list
	end
end

local function SortByItemName(a, b, ascending)
	local nameA = GetItemInfo(a.id)
	local nameB = GetItemInfo(b.id)
	
	if ascending then
		return nameA < nameB
	else
		return nameA > nameB
	end
end

local function SortByChar(a, b, ascending)
	local nameA, nameB
	
	if type(a.char) == "number" then
		nameA = Altoholic.CharacterInfo[a.char].name	-- a character
	else
		nameA = select(3, strsplit("|", a.char))		-- a guild
	end
	
	if type(b.char) == "number" then
		nameB = Altoholic.CharacterInfo[b.char].name
	else
		nameB = select(3, strsplit("|", b.char))
	end

	if nameA == nameB then								-- if it's the same character name ..
		return SortByItemName(a, b, ascending)	-- .. then sort by item name
	elseif ascending then
		return nameA < nameB
	else
		return nameA > nameB
	end
end

local function SortByRealm(a, b, ascending)
	local nameA, nameB
	
	if type(a.char) == "number" then
		nameA = select(2, Altoholic:GetCharacterInfo(a.char))	-- a character
	else
		nameA = select(2, strsplit("|", a.char))		-- a guild
	end
	
	if type(b.char) == "number" then
		nameB = select(2, Altoholic:GetCharacterInfo(b.char))
	else
		nameB = select(2, strsplit("|", b.char))
	end
	
	if nameA == nameB then								-- if it's the same realm ..
		return SortByChar(a, b, ascending)	-- .. then sort by character name
	elseif ascending then
		return nameA < nameB
	else
		return nameA > nameB
	end
end

local function SortByStat(a, b, field, ascending)
	local statA = strsplit("|", a[field])
	local statB = strsplit("|", b[field])
	
	statA = tonumber(statA)
	statB = tonumber(statB)
	
	if ascending then
		return statA < statB
	else
		return statA > statB
	end
end

local function SortByField(a, b, field, ascending)
	if ascending then
		return a[field] < b[field]
	else
		return a[field] > b[field]
	end
end

function Altoholic.Search.Results:Sort(self, field)
	
	local id = self:GetID()
	
	for i = 1, 8 do
		_G[ "AltoholicTabSearch_Sort" .. i .. "Arrow"]:Hide()
	end
	
	local button = _G[ "AltoholicTabSearch_Sort" .. id .. "Arrow"]
	button:Show()
	
	if not self.ascendingSort then
		self.ascendingSort = true
		button:SetTexCoord(0, 0.5625, 1.0, 0);		-- arrow pointing up
	else
		self.ascendingSort = nil
		button:SetTexCoord(0, 0.5625, 0, 1.0);		-- arrow pointing down
	end
	
	local ascending = self.ascendingSort
	local self = Altoholic.Search.Results
	
	if self:GetNumber() == 0 then return end
		
	if field == "item" then
		table.sort(self.List, function(a, b) return SortByItemName(a, b, ascending) end)
	elseif field == "char" then
		table.sort(self.List, function(a, b) return SortByChar(a, b, ascending) end)
	elseif field == "realm" then
		table.sort(self.List, function(a, b) return SortByRealm(a, b, ascending) end)
	elseif field == "stat" then
		table.sort(self.List, function(a, b) return SortByStat(a, b, "stat" .. id-1, ascending) end)
	else
		table.sort(self.List, function(a, b) return SortByField(a, b, field, ascending) end)
	end
	
	Altoholic.Search:Update()
end

local SEARCH_THISCHAR = 1
local SEARCH_THISREALM_THISFACTION = 2
local SEARCH_THISREALM_BOTHFACTIONS = 3
local SEARCH_ALLREALMS = 4
local SEARCH_ALLACCOUNTS = 5
local SEARCH_LOOTS = 6

function Altoholic.Search:FindItem(searchType, searchSubType)
	if self.ongoingsearch then
		return		-- if a search is already happening .. then exit
	end
	self.ongoingsearch = true
	
	self.SearchType = searchType
	self.SearchSubType = searchSubType
	
	local value = AltoholicFrame_SearchEditBox:GetText()
	self.SearchValue = strlower(value)
	
	self.MinLevel = AltoholicTabSearch_MinLevel:GetNumber()
	self.MaxLevel = AltoholicTabSearch_MaxLevel:GetNumber()
	if self.MaxLevel == 0 then
		self.MaxLevel = MAX_PLAYER_LEVEL
	end
	
	self.SearchRarity = UIDropDownMenu_GetSelectedValue(AltoholicTabSearch_SelectRarity)
	self.SearchSlot = UIDropDownMenu_GetSelectedValue(AltoholicTabSearch_SelectSlot)
	local searchLocation = UIDropDownMenu_GetSelectedValue(AltoholicTabSearch_SelectLocation)
	
	self.Results:Clear()
	
	local SearchLoots
	if searchLocation == SEARCH_THISCHAR then
		Altoholic.Tabs.Search:SetMode("realm")
		self:BrowseCharacter(UnitName("player") , GetRealmName(), THIS_ACCOUNT)
	elseif searchLocation == SEARCH_THISREALM_THISFACTION or
				searchLocation == SEARCH_THISREALM_BOTHFACTIONS then
		Altoholic.Tabs.Search:SetMode("realm")
		self:BrowseRealm(GetRealmName(), THIS_ACCOUNT, (searchLocation == SEARCH_THISREALM_BOTHFACTIONS))
	elseif searchLocation == SEARCH_ALLREALMS then
		Altoholic.Tabs.Search:SetMode("realm")
		for RealmName, _ in pairs(Altoholic.db.global.data[THIS_ACCOUNT]) do
			self:BrowseRealm(RealmName, THIS_ACCOUNT, true)
		end
	elseif searchLocation == SEARCH_ALLACCOUNTS then
		Altoholic.Tabs.Search:SetMode("realm")
		-- this account first ..
		for RealmName, _ in pairs(Altoholic.db.global.data[THIS_ACCOUNT]) do
			self:BrowseRealm(RealmName, THIS_ACCOUNT, true)
		end
		
		-- .. then all other accounts
		for AccountName, a in pairs(Altoholic.db.global.data) do
			if AccountName ~= THIS_ACCOUNT then
				for RealmName, _ in pairs(a) do
					self:BrowseRealm(RealmName, AccountName, true)
				end
			end
		end
	else	-- search loot tables
		Altoholic.Tabs.Search:SetMode("loots")
		SearchLoots = true -- this value will be tested in Altoholic.Search:Update() to resize columns properly
		Altoholic.Loots:Find(self.SearchValue, self.SearchType, self.SearchSubType, 
				self.SearchRarity, self.MinLevel, self.MaxLevel, self.SearchSlot)
	end
	
	if self.Results:GetNumber() == 0 then
		if self.SearchValue == "" then 
			AltoholicTabSearchStatus:SetText(L["No match found!"])
		else
			AltoholicTabSearchStatus:SetText(value .. L[" not found!"])
		end
	end
	self.ongoingsearch = nil 	-- search done
	
	self.SearchValue = nil
	self.SearchType = nil
	self.SearchSubType = nil
	
	if SearchLoots then
		if Altoholic.Options:Get("SortDescending") == 1 then 		-- descending sort ?
			AltoholicTabSearch_Sort3.ascendingSort = true		-- say it's ascending now, it will be toggled
			self.Results:Sort(AltoholicTabSearch_Sort3, "iLvl")
		else
			AltoholicTabSearch_Sort3.ascendingSort = nil
			self.Results:Sort(AltoholicTabSearch_Sort3, "iLvl")
		end
	end
	
	if not AltoholicTabSearch:IsVisible() then
		Altoholic.Tabs:OnClick(3)
	end

	self:Update()
end

function Altoholic.Search:BrowseRealm(realm, account, bothFactions)
	
	local r = Altoholic:GetRealmTable(realm, account)
	
	for charName, c in pairs(r.char) do
		if bothFactions or c.faction == UnitFactionGroup("player") then
			self:BrowseCharacter(charName, realm, account)
		end
	end
	
	if Altoholic.Options:Get("IncludeGuildBank") == 1 then	-- Check guild bank(s) ?
		self.SearchLocation = GUILD_BANK
		for guildName, g in pairs(r.guild) do
			if bothFactions or g.faction == UnitFactionGroup("player") then
				self.SearchCharacterIndex = account .. "|" .. realm .. "|" .. guildName		-- use this variable to store guild name
				for TabName, t in pairs(g.bank) do
					for slotID, id in pairs(t.ids) do
						if id then
							if t.links[slotID] then
								self:VerifyItem(t.links[slotID], t.counts[slotID])
							else
								self:VerifyItem(id, t.counts[slotID])
							end
						end
					end	-- end slots
				end	-- end tabs
				self.SearchCharacterIndex = nil
			end
		end	-- end guild
		self.SearchLocation = nil
	end
end

function Altoholic.Search:BrowseCharacter(charName, realm, account)
	local c = Altoholic:GetCharacterTable(charName, realm, account)
	self.SearchCharacterIndex = Altoholic:GetCharacterInfoLine(charName, realm, account)
	
	for BagName, b in pairs(c.bag) do
		
		if (BagName == "Bag100") then
			self.SearchLocation = L["Bank"]
		elseif (BagName == "Bag-2") then
			self.SearchLocation = KEYRING
		else
			local bagNum = tonumber(string.sub(BagName, 4))
			if (bagNum >= 0) and (bagNum <= 4) then
				self.SearchLocation = L["Bags"]
			else
				self.SearchLocation = L["Bank"]
			end			
		end
	
		for slotID=1, b.size do
			if b.links[slotID] then		-- use the link before the id if there's one
				self:VerifyItem(b.links[slotID], b.counts[slotID])
			elseif b.ids[slotID] then
				self:VerifyItem(b.ids[slotID], b.counts[slotID])
			end
		end	-- slot loop
	end	-- bag loop
	
	self.SearchLocation = L["Equipped"]
	for k, v in pairs(c.inventory) do
		self:VerifyItem(v, 1)
	end
	
	if Altoholic.Options:Get("IncludeMailbox") == 1 then			-- check mail ?
		self.SearchLocation = L["Mail"]
		for k, v in pairs(c.mail) do
			if v.link then
				self:VerifyItem(v.link, v.count)
			end
		end
		
		for k, v in pairs(c.mailCache) do
			if v.link then
				self:VerifyItem(v.link, v.count)
			end
		end
	end
	
	if Altoholic.Options:Get("IncludeRecipes") == 1						-- check known recipes ?
		and (self.SearchType == nil) 
		and (self.SearchRarity == 0)
		and (self.SearchSlot == 0) then
	
		for ProfessionName, p in pairs(c.recipes) do
			if p.ScanFailed == false then
				for CraftNumber, craft in pairs(p.list) do
					local color, itemID, spellID = strsplit("^", craft)
					if color ~= "0" then	-- skip headers
						self:VerifyRecipe(tonumber(itemID), tonumber(spellID), ProfessionName, CraftNumber)
					end
				end
			end
		end
	end
	
	self.SearchCharacterIndex = nil
	self.SearchLocation = nil
end

function Altoholic.Search:VerifyRecipe(itemID, spellID, profession, CraftNumber)

	local name = GetSpellInfo(spellID)
	if not name then return end
	
	if string.find(strlower(name), self.SearchValue, 1, true) == nil then
		return 
	end
		
	-- All conditions ok ? save it
	self.Results:Add(	{
		id = itemID,
		char = self.SearchCharacterIndex,
		location = profession,
		craftNum = CraftNumber,
	} )	
end

function Altoholic.Search:VerifyItem(itemID, itemCount)

	local itemName, _, itemRarity, _, itemMinLevel, itemType, itemSubType, _, itemEquipLoc = GetItemInfo(itemID)
	
	if (itemName == nil) and (itemRarity == nil) then
		-- with these 2 being nil, the item isn't in the item cache, so its link would be invalid: don't list it
		-- This should never happen here, since this function deals only with alts inventories, therefore all items are supposed to be known
		return
	end
	
	if (self.SearchType ~= nil) and (self.SearchType ~= itemType) then
		return		-- if there's a type and it's invalid .. Exit
	end

	if (self.SearchSubType ~= nil) and (self.SearchSubType ~= itemSubType) then
		return		-- if there's a subtype and it's invalid .. Exit
	end	

	if (itemRarity < self.SearchRarity) then
		return		-- if rarity is too low .. exit
	end
	
	if (itemMinLevel == 0) then
		if (Altoholic.Options:Get("IncludeNoMinLevel") == 0) then
			return		-- no minimum requireement & should not be included ? .. exit
		end
	else
		if (itemMinLevel < self.MinLevel) or (itemMinLevel > self.MaxLevel) then
			return		-- not within the right level boundaries ? .. exit
		end
	end
	
	if self.SearchSlot ~= 0 then	-- if a specific equipment slot is specified ..
		if Altoholic.Equipment:GetInventoryTypeIndex(itemEquipLoc) ~= self.SearchSlot then
			return		-- not the right slot ? .. exit
		end
	end

	if string.find(strlower(itemName), self.SearchValue, 1, true) == nil then
		return		-- item name does not match search value ? .. exit
	end

	-- All conditions ok ? save it
	self.Results:Add( {
		id = itemID,
		char = self.SearchCharacterIndex,		-- line number in CharacterInfo table
		count = itemCount,
		location = self.SearchLocation
	} )
end

function Altoholic.Search:SetClass(class)
	self.CharacterClass = class
end

function Altoholic.Search:GetClass()
	return self.CharacterClass
end

function Altoholic.Search:FindEquipmentUpgrade()
	
	local upgradeType = self.value
	local self = Altoholic.Search
	
	-- debugprofilestart()
	-- Altoholic.Profiler:Begin("FindEquipmentUpgrade")
	
	local _, itemLink, _, itemLevel, _, itemType, itemSubType, _, itemEquipLoc = GetItemInfo(self.UpgradeItemID)

	self.Results:Clear()
	
	if upgradeType ~= -1 then	-- not an item level upgrade
		self:SetClass(upgradeType)
		Altoholic.Loots:FindUpgradeByStats( 
			self.UpgradeItemID, upgradeType, itemLevel, itemType, itemSubType, 
			Altoholic.Equipment:GetInventoryTypeIndex(itemEquipLoc))

	else	-- simple search, point to simple VerifyUpgrade method
		Altoholic.Loots:FindUpgrade( itemLevel, itemType, itemSubType,
			Altoholic.Equipment:GetInventoryTypeIndex(itemEquipLoc))
		AltoholicTabOptionsFrame2LootInfo:SetText(
				GREEN .. Altoholic.Options:Get("TotalLoots") .. "|r " .. L["Loots"] .. " / "
				.. GREEN .. Altoholic.Options:Get("UnknownLoots") .. "|r " .. L["Unknown"])
	end
	self.UpgradeItemID = nil

	AltoTooltip:Hide();	-- mandatory hide after processing	
	
	if upgradeType ~= -1 then	-- not an item level upgrade
		Altoholic.Tabs.Search:SetMode("upgrade")
	else
		Altoholic.Tabs.Search:SetMode("loots")
	end
	
	if Altoholic.Options:Get("SortDescending") == 1 then 		-- descending sort ?
		AltoholicTabSearch_Sort8.ascendingSort = true		-- say it's ascending now, it will be toggled
		Altoholic.Search.Results:Sort(AltoholicTabSearch_Sort8, "iLvl")
	else
		AltoholicTabSearch_Sort8.ascendingSort = nil
		Altoholic.Search.Results:Sort(AltoholicTabSearch_Sort8, "iLvl")
	end
	
	if not AltoholicTabSearch:IsVisible() then
		Altoholic.Tabs:OnClick(3)
	end
	
	-- DEFAULT_CHAT_FRAME:AddMessage(debugprofilestop())
	-- Altoholic.Profiler:End("FindEquipmentUpgrade") 
	-- DEFAULT_CHAT_FRAME:AddMessage(Altoholic.Profiler:GetSampleDuration("FindEquipmentUpgrade"))
	self:Update()
end

Altoholic.UnsafeItems = {}

function Altoholic.UnsafeItems:Save(itemID)
	if self:IsItemKnown(itemID) then			-- if the unsafe item has already been saved .. exit
		return
	end
	
	-- if not, save it
	table.insert(self.db.global.data["Default"][GetRealmName()].unsafeItems, itemID)
end

function Altoholic.UnsafeItems:IsItemKnown(itemID)
	for k, v in pairs(self.db.global.data["Default"][GetRealmName()].unsafeItems) do 	-- browse current realm's unsafe item list
		if v == itemID then		-- if the itemID passed as parameter is a known unsafe item .. return true to skip it
			return true
		end
	end
	return false			-- false if unknown
end

function Altoholic.UnsafeItems:BuildList()
	-- This method will clean the unsafe item list currently in the DB. 
	-- In the previous game session, the list has been populated with items id's that were originally unsafe and for which a query was sent to the server.
	-- In this session, a getiteminfo on these id's will keep returning a nil if the item is really unsafe, so this method will get rid of the id's that are now valid.
	local TmpUnsafe = {}		-- create a temporary table with confirmed unsafe id's
	
	local r = Altoholic.ThisRealm
	
	for k, v in pairs(r.unsafeItems) do
		local itemName = GetItemInfo(v)
		if not itemName then							-- if the item is really unsafe .. save it
			table.insert(TmpUnsafe, v)
		end
	end
	
	Altoholic:ClearTable(r.unsafeItems)	-- clear the DB table
	
	for k, v in pairs(TmpUnsafe) do
		table.insert(r.unsafeItems, v)	-- save the confirmed unsafe ids back in the db
	end
end

