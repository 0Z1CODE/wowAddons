local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local RED		= "|cFFFF0000"

Altoholic.Tabs.Achievements = {}

function Altoholic.Tabs.Achievements:BuildView()

	self.view = self.view or {}
	Altoholic:ClearTable(self.view)
	
	local cats = GetCategoryList()
	for _, categoryID in ipairs(cats) do
		local _, parentID = GetCategoryInfo(categoryID)
		
		if parentID == -1 then		-- add categories, followed by their respective sub-categories
			table.insert(self.view, { id = categoryID, isCollapsed = true } )
			
			for _, subCatID in ipairs(cats) do
				local _, subCatParentID = GetCategoryInfo(subCatID)
				if subCatParentID == categoryID then
					table.insert(self.view, subCatID )
				end
			end
		end
	end
end

function Altoholic.Tabs.Achievements:Update()
	local VisibleLines = 15

	local categoryIndex				-- index of the category in the menu table
	local categoryCacheIndex		-- index of the category in the cache table
	local MenuCache = {}
	
	for k, v in pairs (self.view) do		-- rebuild the cache
		if type(v) == "table" then		-- header
			categoryIndex = k
			table.insert(MenuCache, { linetype=1, nameIndex=k } )
			categoryCacheIndex = #MenuCache
			
			if (self.highlightIndex) and (self.highlightIndex == k) then
				MenuCache[#MenuCache].needsHighlight = true
			end
		else
			if self.view[categoryIndex].isCollapsed == false then
				table.insert(MenuCache, { linetype=2, nameIndex=k, parentIndex=categoryIndex } )
				
				if (self.highlightIndex) and (self.highlightIndex == k) then
					MenuCache[#MenuCache].needsHighlight = true
					MenuCache[categoryCacheIndex].needsHighlight = true
				end
			end
		end
	end
	
	local buttonWidth = 156
	if #MenuCache > 15 then
		buttonWidth = 136
	end
	
	local offset = FauxScrollFrame_GetOffset( _G[ "AltoholicAchievementsMenuScrollFrame" ] );
	local itemButtom = "AltoholicTabAchievementsMenuItem"
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
				local catName = GetCategoryInfo(self.view[p.nameIndex].id)
				
				_G[itemButtom..i.."NormalText"]:SetText(WHITE .. catName)
				_G[itemButtom..i]:SetScript("OnClick", Altoholic.Tabs.Achievements.Header_OnClick)
				_G[itemButtom..i].categoryIndex = p.nameIndex
			elseif p.linetype == 2 then
				local catName = GetCategoryInfo(self.view[p.nameIndex])
				
				_G[itemButtom..i.."NormalText"]:SetText("|cFFBBFFBB   " .. catName)
				_G[itemButtom..i]:SetScript("OnClick", Altoholic.Tabs.Achievements.Item_OnClick)
				_G[itemButtom..i].categoryIndex = p.parentIndex
				_G[itemButtom..i].subCategoryIndex = p.nameIndex
			end

			_G[itemButtom..i]:Show()
		end
	end
	
	FauxScrollFrame_Update( _G[ "AltoholicAchievementsMenuScrollFrame" ], #MenuCache, VisibleLines, 20);
end

function Altoholic.Tabs.Achievements:Header_OnClick()
	local i = self.categoryIndex
	local self = Altoholic.Tabs.Achievements
	self.highlightIndex = i

	local h = self.view[i]
	if h.isCollapsed == true then
		h.isCollapsed = false
	else
		h.isCollapsed = true
	end

	self:Update();
	AltoholicFrameAchievements:Show()
	Altoholic.Achievements:BuildView(self.view[i].id)
	Altoholic.Achievements:Update()
end

function Altoholic.Tabs.Achievements:Item_OnClick()
	local i = self.subCategoryIndex
	local self = Altoholic.Tabs.Achievements
	self.highlightIndex = i
	
	self:Update();
	AltoholicFrameAchievements:Show()
	Altoholic.Achievements:BuildView(self.view[i])
	Altoholic.Achievements:Update()
end
