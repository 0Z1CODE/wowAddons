local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2

local SUMMARY_THISREALM = 1
local SUMMARY_ALLREALMS = 2
local SUMMARY_ALLACCOUNTS = 3

function AltoholicTabSummary:SelectLocation_Initialize()
	local info = UIDropDownMenu_CreateInfo();
	
	info.text = L["This realm"]
	info.value = SUMMARY_THISREALM
	info.func = AltoholicTabSummary.SetRealmFilter
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
	
	info.text = L["All realms"]
	info.value = SUMMARY_ALLREALMS
	info.func = AltoholicTabSummary.SetRealmFilter
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	

	info.text = L["All accounts"]
	info.value = SUMMARY_ALLACCOUNTS
	info.func = AltoholicTabSummary.SetRealmFilter
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
end

function AltoholicTabSummary:SetRealmFilter()
	UIDropDownMenu_SetSelectedValue(AltoholicTabSummary_SelectLocation, self.value);
	
	Altoholic.Options:Set("TabSummaryMode", self.value)
	Altoholic:BuildCharacterInfoTable()
	Altoholic:BuildCharacterInfoView()
	AltoholicTabSummary:RefreshCurrentFrame()
end

function AltoholicTabSummary:SummaryMenuOnClick(index)
	
	AltoholicFrameSummary:Hide()
	AltoholicFrameBagUsage:Hide()
	AltoholicFrameSkills:Hide()
	AltoholicFrameActivity:Hide()
	AltoholicFrameGuildMembers:Hide()
	AltoholicFrameGuildProfessions:Hide()
	AltoholicFrameGuildBankTabs:Hide()

	AltoholicTabSummary:SetMode(index)
	
	if index == 1 then
		AltoholicFrameSummary:Show()
		Altoholic:AccountSummary_Update()
	elseif index == 2 then
		AltoholicFrameBagUsage:Show()
		Altoholic:BagUsage_Update()
	elseif index == 3 then
		AltoholicFrameSkills:Show()
		Altoholic.TradeSkills:Update()
	elseif index == 4 then
		AltoholicFrameActivity:Show()
		Altoholic:Activity_Update()
	elseif index == 5 then
		if IsInGuild() then
			GuildRoster()
		end
		Altoholic.Guild.Members:BuildView()
		AltoholicFrameGuildMembers:Show()
		Altoholic.Guild.Members:Update()
	elseif index == 6 then
		Altoholic.Guild.Professions:BuildView()
		AltoholicFrameGuildProfessions:Show()
		Altoholic.Guild.Professions:Update()
	elseif index == 7 then
		Altoholic.Guild.BankTabs:BuildView()
		AltoholicFrameGuildBankTabs:Show()
		Altoholic.Guild.BankTabs:Update()
	end
	
	for i=1, 7 do 
		_G[ "AltoholicTabSummaryMenuItem"..i ]:UnlockHighlight();
	end
	_G[ "AltoholicTabSummaryMenuItem"..index ]:LockHighlight();
end

function AltoholicTabSummary:SetMode(mode)
	self.mode = mode
	
	for i = 1, 8 do 
		_G[ "AltoholicTabSummary_Sort" .. i .. "Arrow"]:Hide()
		_G[ "AltoholicTabSummary_Sort"..i ].ascendingSort = nil	-- not sorted by default
	end
	
	AltoholicTabSummaryStatus:SetText("")
	
	if mode == 1 then
		AltoholicTabSummary_Sort1:SetText(NAME)
		AltoholicTabSummary_Sort2:SetText(LEVEL)
		AltoholicTabSummary_Sort3:SetText(MONEY)
		AltoholicTabSummary_Sort4:SetText(PLAYED)
		AltoholicTabSummary_Sort5:SetText(XP)
		AltoholicTabSummary_Sort6:SetText(TUTORIAL_TITLE26)	-- = Rested 
		AltoholicTabSummary_Sort7:SetText("AiL")	-- average item level
		
		AltoholicTabSummary_Sort1:SetWidth(100)
		AltoholicTabSummary_Sort2:SetWidth(60)
		AltoholicTabSummary_Sort3:SetWidth(115)
		AltoholicTabSummary_Sort4:SetWidth(105)
		AltoholicTabSummary_Sort5:SetWidth(55)
		AltoholicTabSummary_Sort6:SetWidth(70)
		AltoholicTabSummary_Sort7:SetWidth(55)

		AltoholicTabSummary_Sort1:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "name") 
		end)
		AltoholicTabSummary_Sort2:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "level") 
		end)
		AltoholicTabSummary_Sort3:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "money") 
		end)
		AltoholicTabSummary_Sort4:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "played") 
		end)
		AltoholicTabSummary_Sort5:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "xp") 
		end)
		AltoholicTabSummary_Sort6:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "restxp") 
		end)
		AltoholicTabSummary_Sort7:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "averageItemLvl") 
		end)

		self:ShowSortButtonsUpTo(7)
	
	elseif mode == 2 then
		AltoholicTabSummary_Sort1:SetText(NAME)
		AltoholicTabSummary_Sort2:SetText(LEVEL)
		AltoholicTabSummary_Sort3:SetText(L["Bags"])
		AltoholicTabSummary_Sort4:SetText(L["free"])
		AltoholicTabSummary_Sort5:SetText(L["Bank"])
		AltoholicTabSummary_Sort6:SetText(L["free"])
		
		AltoholicTabSummary_Sort1:SetWidth(100)
		AltoholicTabSummary_Sort2:SetWidth(60)
		AltoholicTabSummary_Sort3:SetWidth(120)
		AltoholicTabSummary_Sort4:SetWidth(50)
		AltoholicTabSummary_Sort5:SetWidth(190)
		AltoholicTabSummary_Sort6:SetWidth(50)

		AltoholicTabSummary_Sort1:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "name") 
		end)
		AltoholicTabSummary_Sort2:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "level") 
		end)
		AltoholicTabSummary_Sort3:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "numBagSlots") 
		end)
		AltoholicTabSummary_Sort4:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "numFreeBagSlots") 
		end)
		AltoholicTabSummary_Sort5:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "numBankSlots") 
		end)
		AltoholicTabSummary_Sort6:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "numFreeBankSlots") 
		end)
		
		self:ShowSortButtonsUpTo(6)
		
	elseif mode == 3 then
		AltoholicTabSummary_Sort1:SetText(NAME)
		AltoholicTabSummary_Sort2:SetText(LEVEL)
		AltoholicTabSummary_Sort3:SetText(L["Prof. 1"])
		AltoholicTabSummary_Sort4:SetText(L["Prof. 2"])
		AltoholicTabSummary_Sort5:SetText(BI["Cooking"])
		AltoholicTabSummary_Sort6:SetText(BI["First Aid"])
		AltoholicTabSummary_Sort6:SetText(BI["First Aid"])
		AltoholicTabSummary_Sort7:SetText(BI["Fishing"])
		AltoholicTabSummary_Sort8:SetText(L["Riding"])
		
		AltoholicTabSummary_Sort1:SetWidth(100)
		AltoholicTabSummary_Sort2:SetWidth(60)
		AltoholicTabSummary_Sort3:SetWidth(65)
		AltoholicTabSummary_Sort4:SetWidth(65)
		AltoholicTabSummary_Sort5:SetWidth(65)
		AltoholicTabSummary_Sort6:SetWidth(65)
		AltoholicTabSummary_Sort7:SetWidth(65)
		AltoholicTabSummary_Sort8:SetWidth(65)
		
		AltoholicTabSummary_Sort1:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "name") 
		end)
		AltoholicTabSummary_Sort2:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "level") 
		end)
		AltoholicTabSummary_Sort3:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "skillName1") 
		end)
		AltoholicTabSummary_Sort4:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "skillName2") 
		end)
		AltoholicTabSummary_Sort5:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, BI["Cooking"]) 
		end)
		AltoholicTabSummary_Sort6:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, BI["First Aid"]) 
		end)
		AltoholicTabSummary_Sort7:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, BI["Fishing"]) 
		end)
		AltoholicTabSummary_Sort8:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, L["Riding"])
		end)
		
		self:ShowSortButtonsUpTo(8)
		
	elseif mode == 4 then
		AltoholicTabSummary_Sort1:SetText(NAME)
		AltoholicTabSummary_Sort2:SetText(LEVEL)
		AltoholicTabSummary_Sort3:SetText(L["Mails"])
		AltoholicTabSummary_Sort4:SetText(L["Visited"])
		AltoholicTabSummary_Sort5:SetText(AUCTIONS)
		AltoholicTabSummary_Sort6:SetText(BIDS)
		AltoholicTabSummary_Sort7:SetText(L["Visited"])
		AltoholicTabSummary_Sort8:SetText(LASTONLINE)
		
		AltoholicTabSummary_Sort1:SetWidth(100)
		AltoholicTabSummary_Sort2:SetWidth(60)
		AltoholicTabSummary_Sort3:SetWidth(60)
		AltoholicTabSummary_Sort4:SetWidth(60)
		AltoholicTabSummary_Sort5:SetWidth(70)
		AltoholicTabSummary_Sort6:SetWidth(60)
		AltoholicTabSummary_Sort7:SetWidth(60)
		AltoholicTabSummary_Sort8:SetWidth(90)
		
		AltoholicTabSummary_Sort1:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "name") 
		end)
		AltoholicTabSummary_Sort2:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "level") 
		end)
		AltoholicTabSummary_Sort3:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "mail") 
		end)
		AltoholicTabSummary_Sort4:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "lastmailcheck") 
		end)
		AltoholicTabSummary_Sort5:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "auctions") 
		end)
		AltoholicTabSummary_Sort6:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "bids") 
		end)
		AltoholicTabSummary_Sort7:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "lastAHcheck") 
		end)
		AltoholicTabSummary_Sort8:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortSearch(self, "lastlogout")
		end)
		self:ShowSortButtonsUpTo(8)
		
	elseif mode == 5 then
	
		AltoholicTabSummary_Sort1:SetText(NAME)
		AltoholicTabSummary_Sort2:SetText(LEVEL)
		AltoholicTabSummary_Sort3:SetText("AiL")	-- average item level
		AltoholicTabSummary_Sort4:SetText(GAME_VERSION_LABEL)
		AltoholicTabSummary_Sort5:SetText(CLASS)
		
		AltoholicTabSummary_Sort1:SetWidth(100)
		AltoholicTabSummary_Sort2:SetWidth(60)
		AltoholicTabSummary_Sort3:SetWidth(65)
		AltoholicTabSummary_Sort4:SetWidth(80)
		AltoholicTabSummary_Sort5:SetWidth(100)
		
		AltoholicTabSummary_Sort1:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortGuild(self, "name") 
		end)
		AltoholicTabSummary_Sort2:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortGuild(self, "level") 
		end)
		AltoholicTabSummary_Sort3:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortGuild(self, "averageItemLvl") 
		end)
		AltoholicTabSummary_Sort4:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortGuild(self, "version") 
		end)
		AltoholicTabSummary_Sort5:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortGuild(self, "englishClass") 
		end)
		
		self:ShowSortButtonsUpTo(5)
	elseif mode == 6 then
		AltoholicTabSummary_Sort1:SetText(NAME)
		AltoholicTabSummary_Sort2:SetText(LEVEL)
		AltoholicTabSummary_Sort3:SetText(CLASS)
		AltoholicTabSummary_Sort4:SetText(L["Prof. 1"])
		AltoholicTabSummary_Sort5:SetText(L["Prof. 2"])
		AltoholicTabSummary_Sort6:SetText(BI["Cooking"])
		
		AltoholicTabSummary_Sort1:SetWidth(60)
		AltoholicTabSummary_Sort2:SetWidth(60)
		AltoholicTabSummary_Sort3:SetWidth(120)
		AltoholicTabSummary_Sort4:SetWidth(110)
		AltoholicTabSummary_Sort5:SetWidth(110)
		AltoholicTabSummary_Sort6:SetWidth(110)
		
		AltoholicTabSummary_Sort1:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortGuild(self, "name") 
		end)
		AltoholicTabSummary_Sort2:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortGuild(self, "level") 
		end)
		AltoholicTabSummary_Sort3:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortGuild(self, "englishClass") 
		end)
		AltoholicTabSummary_Sort4:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortGuild(self, "prof1link") 
		end)
		AltoholicTabSummary_Sort5:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortGuild(self, "prof2link") 
		end)
		AltoholicTabSummary_Sort6:SetScript("OnClick", function(self) 
			AltoholicTabSummary:SortGuild(self, "cookinglink") 
		end)
		self:ShowSortButtonsUpTo(6)
		
	elseif mode == 7 then
		AltoholicTabSummary_Sort1:SetText(NAME)
		AltoholicTabSummary_Sort2:SetText(TIMEMANAGER_TOOLTIP_LOCALTIME)
		AltoholicTabSummary_Sort3:SetText(TIMEMANAGER_TOOLTIP_REALMTIME)
		
		AltoholicTabSummary_Sort1:SetWidth(100)
		AltoholicTabSummary_Sort2:SetWidth(120)
		AltoholicTabSummary_Sort3:SetWidth(120)
		
		AltoholicTabSummary_Sort1:SetScript("OnClick", nil)
		AltoholicTabSummary_Sort2:SetScript("OnClick", nil)
		AltoholicTabSummary_Sort3:SetScript("OnClick", nil)
		
		self:ShowSortButtonsUpTo(3)
	end
end

function AltoholicTabSummary:ShowSortButtonsUpTo(n)
	-- shows the sort button up to (and including) n, and hides all others
	
	for i = 1, n do
		_G["AltoholicTabSummary_Sort"..i]:Show()
	end
	
	for i = n+1, 8 do
		_G["AltoholicTabSummary_Sort"..i]:Hide()
	end
end

function AltoholicTabSummary:HideSortArrows()
	for i = 1, 8 do
		_G[ "AltoholicTabSummary_Sort" .. i .. "Arrow"]:Hide()
	end
end

function AltoholicTabSummary:SortSearch(self, field)

	AltoholicTabSummary:HideSortArrows()
	
	local button = _G[ "AltoholicTabSummary_Sort" .. self:GetID() .. "Arrow"]
	button:Show()
	
	if not self.ascendingSort then
		self.ascendingSort = true
		button:SetTexCoord(0, 0.5625, 1.0, 0);		-- arrow pointing up
	else
		self.ascendingSort = nil
		button:SetTexCoord(0, 0.5625, 0, 1.0);		-- arrow pointing down
	end
	
	-- Because the CharacterInfo table contains parentID's to quickly find realm & account for each character,
	-- it is necessary to keep the indexes of the parent rows unchanged, however, lua does not guarantee this, so 
	-- each INFO_CHARACTER_LINE will be enriched before the sort, and cleaned after it.
	
	local account, realm
	for _, s in pairs(Altoholic.CharacterInfo) do
		local lineType = mod(s.linetype, 3)
		
		if lineType == INFO_REALM_LINE then
			account = s.account
			realm = s.realm
		elseif lineType == INFO_CHARACTER_LINE then
			s.account = account
			s.realm = realm
		end
	end
		
	if field == "name" then
		table.sort(Altoholic.CharacterInfo, function(a, b)
				return AltoholicTabSummary:SortByName(a, b, self.ascendingSort)
			end)
	elseif field == "xp" then
		table.sort(Altoholic.CharacterInfo, function(a, b)
				return AltoholicTabSummary:SortByXP(a, b, self.ascendingSort)
			end)
	elseif field == "restxp" then
		table.sort(Altoholic.CharacterInfo, function(a, b)
				return AltoholicTabSummary:SortByRestXP(a, b, self.ascendingSort)
			end)
	elseif (field == "mail") or (field == "auctions") or 
			(field == "bids") then
		table.sort(Altoholic.CharacterInfo, function(a, b)
				return AltoholicTabSummary:SortByTableSize(a, b, field, self.ascendingSort)
			end)
	elseif (field == "lastmailcheck") or (field == "lastAHcheck") or 
			(field == "lastlogout") then
		table.sort(Altoholic.CharacterInfo, function(a, b)
				return AltoholicTabSummary:SortByDelay(a, b, field, self.ascendingSort)
			end)
		
	-- Primary Skill
	elseif (field == "skillName1") or (field == "skillName2") then
		table.sort(Altoholic.CharacterInfo, function(a, b)
				return AltoholicTabSummary:SortByPrimarySkill(a, b, field, self.ascendingSort)
			end)
	-- Secondary Skill
	elseif (field == BI["Cooking"]) or (field == BI["First Aid"]) or 
			(field == BI["Fishing"]) or (field == L["Riding"]) then
		table.sort(Altoholic.CharacterInfo, function(a, b)
				return AltoholicTabSummary:SortBySecondarySkill(a, b, field, self.ascendingSort)
			end)
	else
		table.sort(Altoholic.CharacterInfo, function(a, b)
				return AltoholicTabSummary:SortByField(a, b, field, self.ascendingSort)
			end)
	end
	
	for _, s in pairs(Altoholic.CharacterInfo) do
		local lineType = mod(s.linetype, 3)
		
		if lineType == INFO_CHARACTER_LINE then
			s.account = nil		-- clean up the additional info added just for the sort
			s.realm = nil
		end
	end

	AltoholicTabSummary:RefreshCurrentFrame()
end

function AltoholicTabSummary:SortGuild(self, field)

	AltoholicTabSummary:HideSortArrows()
	
	local button = _G[ "AltoholicTabSummary_Sort" .. self:GetID() .. "Arrow"]
	button:Show()
	
	if not self.ascendingSort then
		self.ascendingSort = true
		button:SetTexCoord(0, 0.5625, 1.0, 0);		-- arrow pointing up
	else
		self.ascendingSort = nil
		button:SetTexCoord(0, 0.5625, 0, 1.0);		-- arrow pointing down
	end
	
	if AltoholicTabSummary.mode == 6 then
		AltoholicTabSummary.GuildProfessionsSortBy = field
		AltoholicTabSummary.GuildProfessionsSortOrder = self.ascendingSort
	end
	
	Altoholic.Guild.Members:Sort(field, self.ascendingSort)
	AltoholicTabSummary:RefreshCurrentFrame()
end

function AltoholicTabSummary:RefreshCurrentFrame()
	if AltoholicFrameSummary:IsVisible() then
		Altoholic:AccountSummary_Update()
	elseif AltoholicFrameBagUsage:IsVisible() then
		Altoholic:BagUsage_Update()
	elseif AltoholicFrameSkills:IsVisible() then
		Altoholic.TradeSkills:Update()
	elseif AltoholicFrameActivity:IsVisible() then
		Altoholic:Activity_Update()
	elseif AltoholicFrameGuildMembers:IsVisible() then
		Altoholic.Guild.Members:BuildView()
		Altoholic.Guild.Members:Update()
	elseif AltoholicFrameGuildProfessions:IsVisible() then
		Altoholic.Guild.Professions:BuildView()
		Altoholic.Guild.Professions:Update()
	elseif AltoholicFrameGuildBankTabs:IsVisible() then
		Altoholic.Guild.BankTabs:BuildView()
		Altoholic.Guild.BankTabs:Update()
	end
end


-- from http://lua-users.org/wiki/TableLibraryTutorial
-- The comparison function must return a boolean value specifying whether the first argument 
-- should be before the second argument in the sequence.

-- the table will be rather small, we can afford a custom sort function
function AltoholicTabSummary:SortByName(a, b, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by field xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end
		
		if ascending then
			return a.name < b.name
		else
			return a.name > b.name
		end
	end
end

function AltoholicTabSummary:SortByXP(a, b, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by field xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end
		-- same linetype implies same account & same realm, so r could refer to either a or b
		local r = Altoholic.db.global.data[a.account][a.realm]
		local charA = r.char[a.name]
		local charB = r.char[b.name]
		
		if ascending then
			return (charA.xp / charA.xpmax) < (charB.xp / charB.xpmax)
		else
			return (charA.xp / charA.xpmax) > (charB.xp / charB.xpmax)
		end
	end
end

function AltoholicTabSummary:SortByRestXP(a, b, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by field xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end
		-- same linetype implies same account & same realm, so r could refer to either a or b
		local r = Altoholic.db.global.data[a.account][a.realm]
		local charA = r.char[a.name]
		local charB = r.char[b.name]
		
		local restXPA, restXPB
		
		if charA.level == MAX_PLAYER_LEVEL then
			restXPA = 0
		else
			restXPA = select(2, Altoholic:GetRestedXP(charA.xpmax, charA.restxp, charA.lastlogout, charA.isResting))
		end
		
		if charB.level == MAX_PLAYER_LEVEL then
			restXPB = 0
		else
			restXPB = select(2, Altoholic:GetRestedXP(charB.xpmax, charB.restxp, charB.lastlogout, charB.isResting))
		end
		
		if ascending then
			return restXPA < restXPB
		else
			return restXPA > restXPB
		end
	end
end

function AltoholicTabSummary:SortByTableSize(a, b, field, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by field xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end
		
		-- same linetype implies same account & same realm, so r could refer to either a or b
		local r = Altoholic.db.global.data[a.account][a.realm]
		local tableA = r.char[a.name][field]
		local tableB = r.char[b.name][field]
		
		if ascending then
			return #tableA < #tableB
		else
			return #tableA > #tableB
		end
	end
end

function AltoholicTabSummary:SortByDelay(a, b, field, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by field xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end
		
		-- same linetype implies same account & same realm, so r could refer to either a or b
		local r = Altoholic.db.global.data[a.account][a.realm]
		local delayA = r.char[a.name][field]
		if delayA ~= 0 then					-- do this because "online" means there's no delay, so leave it at zero
			delayA = time() - delayA
		end
		local delayB = r.char[b.name][field]
		if delayB ~= 0 then
			delayB = time() - delayB
		end		
		
		if ascending then
			return delayA < delayB
		else
			return delayA > delayB
		end
	end
end

function AltoholicTabSummary:SortByPrimarySkill(a, b, skillName, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by field xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end
		-- same linetype implies same account & same realm, so r could refer to either a or b
		local r = Altoholic.db.global.data[a.account][a.realm]
		local charA = r.char[a.name]
		local charB = r.char[b.name]
		
		local skillA = Altoholic.TradeSkills:GetRank( charA.skill[L["Professions"]][a[skillName]] )
		local skillB = Altoholic.TradeSkills:GetRank( charB.skill[L["Professions"]][b[skillName]] )
		
		if ascending then
			return skillA < skillB
		else
			return skillA > skillB
		end
	end
end

function AltoholicTabSummary:SortBySecondarySkill(a, b, skillName, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by field xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end
		-- same linetype implies same account & same realm, so r could refer to either a or b
		local r = Altoholic.db.global.data[a.account][a.realm]
		local charA = r.char[a.name]
		local charB = r.char[b.name]
		
		local skillA = Altoholic.TradeSkills:GetRank( charA.skill[L["Secondary Skills"]][skillName] )
		local skillB = Altoholic.TradeSkills:GetRank( charB.skill[L["Secondary Skills"]][skillName] )
		
		if ascending then
			return skillA < skillB
		else
			return skillA > skillB
		end
	end
end

function AltoholicTabSummary:SortByField(a, b, field, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by field xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end
		
		-- same linetype implies same account & same realm, so r could refer to either a or b
		local r = Altoholic.db.global.data[a.account][a.realm]
		local charA = r.char[a.name]
		local charB = r.char[b.name]
		
		if ascending then
			return charA[field] < charB[field]
		else
			return charA[field] > charB[field]
		end
	end
end

function AltoholicTabSummary:SortOfflineMembersByField(a, b)
	local guild = Altoholic:GetThisGuild()
	
	local memberA = guild.members[a]
	local memberB = guild.members[b]
	local field = self.GuildProfessionsSortBy
	
	if self.GuildProfessionsSortOrder then
		return memberA[field] < memberB[field]
	else
		return memberA[field] > memberB[field]
	end
end

function AltoholicTabSummary:ToggleView(self)
	local mode = AltoholicTabSummary.mode
	
	if not self.isCollapsed then
		self.isCollapsed = true
		AltoholicTabSummaryToggleView:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
	else
		self.isCollapsed = nil
		AltoholicTabSummaryToggleView:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
	end

	if (mode >= 1) and (mode <= 4) then
		for line, s in pairs(Altoholic.CharacterInfo) do
			if mod(s.linetype, 3) == INFO_REALM_LINE then
				s.isCollapsed = (self.isCollapsed) or false
			end
		end
		AltoholicTabSummary:RefreshCurrentFrame()
	elseif mode == 5 then
		for line, s in pairs(Altoholic.Guild.Members.view) do
			if s.linetype == 1 then			-- ALTO_MAIN_LINE = 1
				s.isCollapsed = (self.isCollapsed) or false
			end
		end
		Altoholic.Guild.Members:Update()
	elseif mode == 6 then
		for line, s in pairs(Altoholic.Guild.Professions.view) do
			if mod(s.linetype, 2) == 0 then		-- MAIN_LINE = 0
				s.isCollapsed = (self.isCollapsed) or false
			end
		end
		Altoholic.Guild.Professions:Update()
	elseif mode == 7 then
		for line, s in pairs(Altoholic.Guild.BankTabs.view) do
			if mod(s.linetype, 2) == 0 then		-- CHAR_LINE = 0
				s.isCollapsed = (self.isCollapsed) or false
			end
		end
		Altoholic.Guild.BankTabs:Update()
	end
end
