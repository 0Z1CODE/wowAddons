local BF = LibStub("LibBabble-Faction-3.0"):GetLookupTable()
local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local TEAL		= "|cFF00FF9A"
local YELLOW	= "|cFFFFFF00"
local ORANGE	= "|cFFFF7F00"
local GRAY		= "|cFF909090"

local GENERAL_CATEGORY_ID				= 92
local QUESTS_CATEGORY_ID				= 96
local PVP_CATEGORY_ID					= 95
local PVPARENA_CATEGORY_ID				= 165
local PVPWINTERGRASP_CATEGORY_ID		= 14901
local PROFESSIONS_CATEGORY_ID			= 169
local COOKING_CATEGORY_ID				= 170
local FISHING_CATEGORY_ID				= 171
local FIRSTAID_CATEGORY_ID				= 172
local REPUTATIONS_CATEGORY_ID			= 201
local LUNARFESTIVAL_CATEGORY_ID		= 160
local FEATS_CATEGORY_ID					= 81

Altoholic.Achievements = {}

Altoholic.Achievements.RefTable = {
-- Reference Table for some achievement categories. Since progressive achievements are not listed as part of an alt's known achievements, and since
-- not all alts are at the same level (think of character level for instance), it's necessary to keep track of all achievements in a specific category.
-- Categories that contain no progressive achievements do not need to be here (ex: exploration)

-- Retrieved from http://wotlk.wowhead.com/?achievements
	[GENERAL_CATEGORY_ID] = {										-- updated Apr 22, 2009
		6, 7, 8, 9, 10, 11, 12, 13, 15, 16, 545, 546, 556, 557, 558, 559, 621, 705, 889,
		890, 891, 892, 964, 1017, 1020, 1021, 1165, 1176, 1177, 1178, 1180, 1181, 1187,
		1206, 1244, 1248, 1250, 1254, 1832, 1833, 1956, 2076, 2077, 2078, 2084, 2097,
		2141, 2142, 2143, 2516, 2536, 2537, 2556, 2557, 2716
	},
	[QUESTS_CATEGORY_ID] = {										-- updated Feb 6, 2009
		31, 32, 503, 504, 505, 506, 507, 508, 941, 973, 974, 975,
		976, 977, 978, 1182, 1576, 1681, 1682	
	},
	[PVP_CATEGORY_ID] = {											-- updated Feb 6, 2009
		227, 229, 230, 231, 238, 239, 245, 246, 247, 388, 389, 396, 509, 512, 513, 515, 516, 
		603, 604, 610, 611, 612, 613, 614, 615, 616, 617, 618, 619, 700, 701, 714, 727, 869, 
		870, 907, 908, 909, 1005, 1006, 1157, 1175, 2016, 2017
	},
	[PVPARENA_CATEGORY_ID] = {										-- updated Feb 6, 2009
		397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 699, 875, 876, 
		1159, 1160, 1161, 1162, 1163, 1174, 2090, 2091, 2092, 2093
	},
	[PVPWINTERGRASP_CATEGORY_ID] = {									-- updated Apr 22, 2009
		1717, 1718, 1721, 1722, 1723, 1727, 1731, 1737, 1739, 1751, 1752, 1755, 
		2080, 2081, 2085, 2086, 2087, 2088, 2089, 2199, 2476, 2776, 3136, 3137
	},
	[PROFESSIONS_CATEGORY_ID] = {									-- updated Feb 6, 2009
		116, 730, 731, 732, 733, 734, 735	
	},
	[COOKING_CATEGORY_ID] = {										-- updated Apr 22, 2009
		121, 122, 123, 124, 125, 877, 906, 1563, 1777, 1778, 1779, 1780, 1781, 1782, 1783, 
		1784, 1785, 1795, 1796, 1797, 1798, 1799, 1800, 1801, 1998, 1999, 2000, 2001, 2002, 
		3296
	},
	[FISHING_CATEGORY_ID] = {										-- updated Apr 22, 2009
		126, 127, 128, 129, 130, 144, 150, 153, 306, 560, 726, 878, 905, 1225,
		1243, 1257, 1516, 1517, 1556, 1557, 1558, 1559, 1560, 1561, 1836, 1837,
		1957, 1958, 2094, 2095, 2096, 3217, 3218
	},
	[FIRSTAID_CATEGORY_ID] = {										-- updated Feb 6, 2009
		131, 132, 133, 134, 135, 137, 141
	},
	[REPUTATIONS_CATEGORY_ID] = {									-- updated Feb 6, 2009
		1014, 1015, 518, 519, 520, 521, 522, 523, 524, 762, 942, 943, 945, 948, 953
	},
	[LUNARFESTIVAL_CATEGORY_ID] = {								-- updated Feb 6, 2009
		605, 606, 607, 608, 609, 626, 910, 911, 912, 914, 915, 937, 1281, 1396, 1552
	},
	[FEATS_CATEGORY_ID] = {											-- updated Apr 22, 2009
		411, 412, 414, 415, 416, 418, 419, 420, 424, 425, 426, 428, 429, 430, 431, 432,
		433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448,
		449, 450, 451, 452, 453, 454, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465,
		466, 467, 468, 469, 470, 471, 472, 473, 662, 663, 664, 665, 683, 725, 729, 871,
		879, 880, 881, 882, 883, 884, 885, 886, 887, 888, 980, 1205, 1292, 1293, 1400,
		1402, 1404, 1405, 1406, 1407, 1408, 1409, 1410, 1411, 1412, 1413, 1414, 1415,
		1416, 1417, 1418, 1419, 1420, 1421, 1422, 1423, 1424, 1425, 1426, 1427, 1436,
		1463, 1636, 1637, 1705, 1706, 2079, 2116, 2316, 2398, 2456, 2496, 3096, 3142, 3336
	}
}

function Altoholic.Achievements:BuildView(categoryID)
	
	self.view = self.view or {}
	Altoholic:ClearTable(self.view)

	if not self.RefTable[categoryID] then
		-- if the category does not contain progressive achievements, then add all achievements to the view
		for i = 1, GetCategoryNumAchievements(categoryID) do
			local id = GetAchievementInfo(categoryID, i)
			table.insert(self.view, id)		-- simply insert the id
		end
	else
		for _, id in pairs(self.RefTable[categoryID]) do
			table.insert(self.view, id)		-- simply insert the id
		end
	end

	-- regardless of the content, sort the achievements view in alphabetical order (based on achievement name, of course)
	table.sort(self.view, function(a, b)
			local nameA = select(2, GetAchievementInfo(a)) or ""
			local nameB = select(2, GetAchievementInfo(b)) or ""
			return nameA < nameB
		end)
end

function Altoholic.Achievements:Update()
	local VisibleLines = 8
	local frame = "AltoholicFrameAchievements"
	local entry = frame.."Entry"
		
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local r = Altoholic:GetRealmTable()
	
	for i=1, VisibleLines do
		local line = i + offset
		if line <= #self.view then	-- if the line is visible
			local achievementID = self.view[line]
			local _, achName, _, _, _, _, _, _, _, achImage = GetAchievementInfo(achievementID)
			
			_G[entry..i.."Name"]:SetText(WHITE .. achName)
			_G[entry..i.."Name"]:SetJustifyH("LEFT")
			_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
			
			local j = 1
			for CharacterName, c in pairs(r.char) do
				local itemName = entry.. i .. "Item" .. j;
				local itemButton = _G[itemName]
				local itemTexture = _G[itemName .. "_Background"]
				
				itemTexture:SetTexture(achImage)
				
				if type( c.achievements[achievementID] ) == "string" then
					itemTexture:SetVertexColor(0.9, 0.6, 0.2);
					_G[itemName .. "Name"]:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Waiting:14\124t")

				elseif c.achievements[achievementID] == true then
					itemTexture:SetVertexColor(1.0, 1.0, 1.0);
					_G[itemName .. "Name"]:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t")
					
				else
					itemTexture:SetVertexColor(0.4, 0.4, 0.4);
					_G[itemName .. "Name"]:SetText("\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t")
				end
				
				itemButton.CharName = CharacterName
				itemButton.id = line
				itemButton:Show()
				
				j = j + 1
			end
			
			while j <= 10 do
				_G[ entry.. i .. "Item" .. j ]:Hide()
				_G[ entry.. i .. "Item" .. j ].CharName = nil
				_G[ entry.. i .. "Item" .. j ].id = nil
				j = j + 1
			end
			
			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end

	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], #self.view, VisibleLines, 41);
end

function Altoholic.Achievements:OnEnter(self)
	if not self.CharName then return end
	
	local c = Altoholic:GetCharacterTable(self.CharName)
	local ach = c.achievements
	local achievementID = Altoholic.Achievements.view[self.id]
	local _, achName, points, _, _, _, _, description, _, _, rewardText = GetAchievementInfo(achievementID);
	
	AltoTooltip:SetOwner(self, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	AltoTooltip:AddDoubleLine(Altoholic:GetClassColor(c.englishClass) .. self.CharName, achName)
	AltoTooltip:AddLine(WHITE .. description, 1, 1, 1, 1, 1);
	AltoTooltip:AddLine(WHITE .. ACHIEVEMENT_TITLE .. ": " .. YELLOW .. points);
	AltoTooltip:AddLine(" ");
	
	if type(ach[achievementID]) == "string" then
		local numCriteria = GetAchievementNumCriteria(achievementID);
	
		for i = 1, numCriteria do	-- browse all criterias
			local criteriaString, criteriaType, _, _, reqQuantity = GetAchievementCriteriaInfo(achievementID, i);
			local isComplete
			
			local j = 1	-- index in the saved criterias string
			local criteria = select(j, strsplit(",", ach[achievementID]))
			while criteria ~= nil do
				local numCrit = tonumber(criteria)
				if type(numCrit) == "number" then
					if numCrit == i then					-- a completed criteria will contain the index number as-is.
						isComplete = true					-- "2,3,5 ..." mean that criterias 2 3 & 5 are complete
						break
					end
				else	-- if it's not a number, it will have this format : index .. ":" .. quantity .. ":" .. reqQuantity, but only if reqQuantity > 1 (0/1 is implicit)
					if reqQuantity > 1 then
						local idxCrit, qtyCrit = strsplit(":", criteria)
						idxCrit = tonumber(idxCrit)
						if idxCrit == i then
							if tonumber(qtyCrit) > 0 then
								criteriaString = criteriaString .. WHITE
							end
							criteriaString = criteriaString .. " (" .. qtyCrit .. "/" .. reqQuantity .. ")"
							break
						end
					end
				end
				
				j = j + 1
				criteria = select(j, strsplit(",", ach[achievementID]))
			end
			
			if isComplete then
				AltoTooltip:AddLine("\124TInterface\\AchievementFrame\\UI-Achievement-Criteria-Check:14\124t".. GREEN .. criteriaString);
			else
				AltoTooltip:AddLine(GRAY .. " - " .. criteriaString);
			end
		end
	
	elseif ach[achievementID] == true then
		AltoTooltip:AddLine(WHITE .. STATUS .. ": " .. GREEN .. COMPLETE);
	else
		for i = 1, GetAchievementNumCriteria(achievementID) do	-- write all criterias in gray
			AltoTooltip:AddLine(GRAY .. " - " .. GetAchievementCriteriaInfo(achievementID, i));
		end
	end
	
	if strlen(rewardText) > 0 then		-- not nil if empty, so test the length of the string
		AltoTooltip:AddLine(" ");
		AltoTooltip:AddLine(GREEN .. rewardText);
	end
	-- AltoTooltip:AddLine(" ");
	-- AltoTooltip:AddDoubleLine(GREEN .. L["Shift-Click to link this info"], TEAL .. "ID: " ..achievementID);
	AltoTooltip:Show();
end

function Altoholic.Achievements:Scan()
	local c = Altoholic.ThisCharacter
	local ach = c.achievements
	
	local total, completed = GetNumCompletedAchievements()
	c.TotalAchievements = total
	c.CompletedAchievements = completed
	c.TotalAchievementPoints = GetTotalAchievementPoints()
	
	Altoholic:ClearTable(ach)
	
	local cats = GetCategoryList()
	
	for Index, categoryID in ipairs(cats) do
--		local categoryName, parentID = GetCategoryInfo(categoryID)
		local numAchievements = GetCategoryNumAchievements(categoryID)	-- number of achievements in this category
		
		for i=1, numAchievements do
			local achievementID, _, _, achCompleted = GetAchievementInfo(categoryID, i);
			self:ScanSingle(achievementID, achCompleted)
			
			-- track previous steps of a progressive achievements
			local prevID = GetPreviousAchievement(achievementID)
			
			while type(prevID) ~= "nil" do
				achievementID, _, _, achCompleted = GetAchievementInfo(prevID);
				self:ScanSingle(achievementID, achCompleted)
				prevID = GetPreviousAchievement(achievementID)
			end
		end
	end	
end

function Altoholic.Achievements:ScanSingle(id, completed)
	local c = Altoholic.ThisCharacter
	local ach = c.achievements
	
	if completed then
		ach[id] = true		-- true when completed, all criterias are completed thus
	else
		local numCriteria = GetAchievementNumCriteria(id);
		
		local criterias
		for j = 1, numCriteria do
			-- ** calling GetAchievementCriteriaInfo in this loop is what costs the most in terms of cpu time **
			local _, criteriaType, critCompleted, quantity, reqQuantity = GetAchievementCriteriaInfo(id, j);
			local currentCrit
			
			if critCompleted then				-- if this criteria is complete, simply save its index
				currentCrit = tostring(j)
			else										-- otherwise check if we should save the progress values (ie: if reqQuantity <> 1)
				if reqQuantity > 1 then
					currentCrit = j .. ":" .. quantity
				end
			end
			
			if currentCrit then					-- if there was a usable criteria in this pass ..
				if not criterias then			-- .. was the result string already  initialized ?
					criterias = currentCrit
				else
					criterias = criterias .. "," .. currentCrit
				end
			end
		end
	
		if criterias then		-- if at least one criteria completed, save the entry, do nothing otherwise (check later for progress 100/230)
			ach[id] = criterias
		end
	end

end

function Altoholic:ACHIEVEMENT_EARNED(self, id)
	-- when an achievement is earned, this event is triggered twice, but only once with an id (find out which ..), so let's filter to update only once
	if id then
		Altoholic.Achievements:ScanSingle(id, true)
		
		local c = Altoholic.ThisCharacter
		local total, completed = GetNumCompletedAchievements()
		c.TotalAchievements = total
		c.CompletedAchievements = completed
	end
end
