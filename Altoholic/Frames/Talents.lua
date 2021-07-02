local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"

local INITIAL_OFFSET_X = 25				-- constants used for positioning talents
local INITIAL_OFFSET_Y = 15
local TALENT_OFFSET_X = 62
local TALENT_OFFSET_Y = 55

local TALENT_ICON_PATH = "Interface\\Icons\\"

Altoholic.Talents = {}
Altoholic.Talents.Buttons = {}
Altoholic.Talents.Arrows = {}
Altoholic.Talents.Branches = {}
Altoholic.Glyphs = {}
Altoholic.Glyphs.Buttons = {}

function Altoholic.Talents:Update(treeIndex)
	
	-- Altoholic.Profiler:Begin("TalentUpdate")
	
	Altoholic.Glyphs:Update()
	
	treeIndex = treeIndex or 1
	
	AltoholicFrameTalents_ScrollFrameScrollBar:SetMinMaxValues(0, 330);
	
	-- stop all autocast
	for i = 1, 3 do
		AutoCastShine_AutoCastStop(_G[ "AltoholicFrameTalents_SpecIcon" .. i .. "Shine" ]);
	end
	AltoholicFrameTalents:Hide()
	
	local c = Altoholic:GetCharacterTable()
	
	if c.activeTalents == 1 then
		AltoholicFrameTalents_PrimaryText:SetText(format("%s (%s)",WHITE..TALENT_SPEC_PRIMARY..GREEN, TALENT_ACTIVE_SPEC_STATUS ))
		AltoholicFrameTalents_SecondaryText:SetText(WHITE..TALENT_SPEC_SECONDARY)
	else
		AltoholicFrameTalents_PrimaryText:SetText(WHITE..TALENT_SPEC_PRIMARY)
		AltoholicFrameTalents_SecondaryText:SetText(format("%s (%s)",WHITE..TALENT_SPEC_SECONDARY..GREEN, TALENT_ACTIVE_SPEC_STATUS ))
	end
	
	local ref = Altoholic:GetReferenceTable()
	local tree = ref[c.englishClass].talentInfo[treeIndex]
	
	if not tree.background then
		-- Altoholic.Profiler:End("TalentUpdate")
		return
	end
	
	self.Parent = _G["AltoholicFrameTalents_ScrollFrameTalent1"]:GetParent()

	-- draw spec icons
	for k, v in ipairs(ref[c.englishClass].talentInfo) do
		Altoholic:SetItemButtonTexture("AltoholicFrameTalents_SpecIcon"..k, TALENT_ICON_PATH .. v.icon, 30, 30)
		
		if strfind(c.talent, ":") then			-- new format =	name:points | name:points | name:points
			-- local talent = select(k, strsplit("|", c.talent))
			local talent = select(((self.group-1)*3) + k, strsplit("|", c.talent))
			local name, points = strsplit(":", talent)

			_G["AltoholicFrameTalents_SpecIcon"..k .."Count"]:SetText(WHITE ..points)
			_G["AltoholicFrameTalents_SpecIcon"..k .."Count"]:Show()
		else
			_G["AltoholicFrameTalents_SpecIcon"..k .."Count"]:Hide()
		end
		
		_G["AltoholicFrameTalents_SpecIcon"..k]:Show()
	end
	
	local isActiveTalentGroup = self.group == c.activeTalents
	
	-- textures are 90.625% of the original size
	local bg = "Interface\\TalentFrame\\"..tree.background
	AltoholicFrameTalents_bgTopLeft:SetTexture(bg.."-TopLeft")
	AltoholicFrameTalents_bgTopRight:SetTexture(bg.."-TopRight")
	AltoholicFrameTalents_bgBottomLeft:SetTexture(bg.."-BottomLeft")
	AltoholicFrameTalents_bgBottomRight:SetTexture(bg.."-BottomRight")
	
	SetDesaturation(AltoholicFrameTalents_bgTopLeft, not isActiveTalentGroup)
	SetDesaturation(AltoholicFrameTalents_bgTopRight, not isActiveTalentGroup)
	SetDesaturation(AltoholicFrameTalents_bgBottomLeft, not isActiveTalentGroup)
	SetDesaturation(AltoholicFrameTalents_bgBottomRight, not isActiveTalentGroup)

	AutoCastShine_AutoCastStart(_G[ "AltoholicFrameTalents_SpecIcon" .. treeIndex .. "Shine" ]);
	AltoholicFrameTalents_ScrollFrame:SetID(treeIndex)

	self.Buttons:ResetCount()
	self.Arrows:ResetCount()
	self.Branches:ResetCount()
	self.Branches:InitializeArray()
	
	-- draw all icons in their respective slot
	for k, v in ipairs(tree.list) do
		local id, name, texture, tier, column, maxRank = strsplit("|", v)
		tier = tonumber(tier)
		column = tonumber(column)
		
		self.Buttons:Draw(texture, tier, column, c["tree"..((self.group-1)*3) + treeIndex][k], k)
		self.Branches.Array[tier][column].node = true;
				
		-- Draw arrows & branches where applicable
		if tree.prereqs[k] then
			local prereqTier, prereqColumn = strsplit("|", tree.prereqs[k])
			
			prereqTier = tonumber(prereqTier)
			prereqColumn = tonumber(prereqColumn)
			
			local left = min(column, prereqColumn);
			local right = max(column, prereqColumn);

			if ( left == prereqColumn ) then		-- Don't check the location of the current button
				left = left + 1;
			else
				right = right - 1;
			end
			
			local blocked								-- Check for blocking talents
			for _, talent in ipairs(tree.list) do		-- browse the same list
				local _, _, _, searchedTier, searchedColumn = strsplit("|", talent)
			
				searchedTier = tonumber(searchedTier)
				searchedColumn = tonumber(searchedColumn)
			
				if searchedTier == prereqTier then				-- do nothing if lower tier, process if same tier, exit if higher tier
					if (searchedColumn >= left) and (searchedColumn <= right) then
						blocked = true
						break
					end
				elseif searchedTier > prereqTier then
					break
				end
			end
			
			self.Arrows:Draw(tier, column, prereqTier, prereqColumn, blocked)
			self.Branches:Init(tier, column, prereqTier, prereqColumn, blocked)
		end
	end
	self.Branches:Draw()
	
	self.Buttons:HideUnused()
	self.Arrows:HideUnused()
	self.Branches:HideUnused()
	self.Branches:ClearArray()
	AltoholicFrameTalents:Show()
	
	-- Altoholic.Profiler:End("TalentUpdate")
end

function Altoholic.Talents.Buttons:ResetCount()
	self.count = 1
end

function Altoholic.Talents.Buttons:Draw(texture, tier, column, count, id)
	-- Altoholic.Profiler:Begin("TalentButtonsDraw")

	local itemName = "AltoholicFrameTalents_ScrollFrameTalent" .. self.count
	local itemButton = _G[itemName]

	itemButton:SetPoint("TOPLEFT", itemButton:GetParent(), "TOPLEFT", 
		INITIAL_OFFSET_X + ((column-1) * TALENT_OFFSET_X), 
		-(INITIAL_OFFSET_Y + ((tier-1) * TALENT_OFFSET_Y)))
	itemButton:SetID(id)

	if texture then
		Altoholic:SetItemButtonTexture(itemName, TALENT_ICON_PATH..texture, 37, 37)
	end
	
	local itemCount = _G[itemName .. "Count"]
	local itemTexture = _G[itemName .. "IconTexture"]
	
	if count and count > 0 then
		itemCount:SetText(GREEN .. count)
		itemCount:Show()
		itemTexture:SetDesaturated(0)
	else
		itemTexture:SetDesaturated(1)
		itemCount:Hide()
	end
	itemButton:Show()

	self.count = self.count + 1
	-- Altoholic.Profiler:End("TalentButtonsDraw")
end

function Altoholic.Talents.Buttons:HideUnused()
	while self.count <= 40 do
		_G["AltoholicFrameTalents_ScrollFrameTalent" .. self.count]:Hide()
		_G["AltoholicFrameTalents_ScrollFrameTalent" .. self.count]:SetID(0)	
		self.count = self.count + 1
	end
	self.count = nil
end

function Altoholic.Talents.Arrows:ResetCount()
	self.count = 1
end

function Altoholic.Talents.Arrows:Draw(tier, column, prereqTier, prereqColumn, blocked)
	-- Altoholic.Profiler:Begin("TalentArrowsDraw")
	local arrowType					-- algorithm taken from TalentFrameBase.lua, adjusted for my needs
	
	if (column == prereqColumn) then			-- Same column ? ==> TOP
		arrowType = "top"
	elseif (tier == prereqTier) then			-- Same tier ? ==> LEFT or RIGHT
		if (column < prereqColumn) then
			arrowType = "right"
		else
			arrowType = "left"
		end
	else												-- None of these ? ==> diagonal
		if not blocked then
			arrowType = "top"
		else
			if (column < prereqColumn) then
				arrowType = "right"
			else
				arrowType = "left"
			end
		end
	end
	
	if not arrowType then
		-- Altoholic.Profiler:End("TalentArrowsDraw")
		return
	end
	
	local x, y
	if arrowType == "top" then
		x = 2
		y = 18
	elseif arrowType == "left" then
		x = -17
		y = -2
	elseif arrowType == "right" then
		x = 22
		y = -2
	end
	
	x = x + INITIAL_OFFSET_X + ((column-1) * TALENT_OFFSET_X)
	y = y - (INITIAL_OFFSET_Y + ((tier-1) * TALENT_OFFSET_Y))
	
	local arrow = _G["AltoholicFrameTalents_Arrow" .. self.count]
	local tc = TALENT_ARROW_TEXTURECOORDS[arrowType][1]
	
	arrow:SetTexCoord(tc[1], tc[2], tc[3], tc[4]);
	arrow:SetPoint("TOPLEFT",	Altoholic.Talents.Parent, "TOPLEFT", x, y)
	arrow:Show()
	
	self.count = self.count + 1
	-- Altoholic.Profiler:End("TalentArrowsDraw")
end

function Altoholic.Talents.Arrows:HideUnused()
	while self.count <= 30 do
		_G["AltoholicFrameTalents_Arrow" .. self.count]:Hide()
		self.count = self.count + 1
	end
	self.count = nil
end

function Altoholic.Talents.Branches:ResetCount()
	self.count = 1
end

function Altoholic.Talents.Branches:InitializeArray()
	
	self.Array = self.Array or {};		-- branch array
	Altoholic.ClearTable(self.Array)
	
	for i = 1, MAX_NUM_TALENT_TIERS do
		self.Array[i] = {};
		for j = 1, NUM_TALENT_COLUMNS do
			self.Array[i][j] = {};
		end
	end
end

function Altoholic.Talents.Branches:ClearArray()
	Altoholic.ClearTable(self.Array)
	self.Array = nil
end

function Altoholic.Talents.Branches:Init(tier, column, prereqTier, prereqColumn, blocked)

	-- algorithm taken from TalentFrameBase.lua, adjusted for my needs
	local left = min(column, prereqColumn);
	local right = max(column, prereqColumn);
	
	if (column == prereqColumn) then			-- Same column ? ==> TOP
		for i = prereqTier, tier - 1 do
			self.Array[i][column].down = true;
			if ( (i + 1) <= (tier - 1) ) then
				self.Array[i+1][column].up = true;
			end
		end
		return
	end
		
	if (tier == prereqTier) then			-- Same tier ? ==> LEFT or RIGHT
		for i = left, right-1 do
			self.Array[prereqTier][i].right = true;
			self.Array[prereqTier][i+1].left = true;
		end
		return
	end

	-- None of these ? ==> diagonal
	if not blocked then
		self.Array[prereqTier][column].down = true;
		self.Array[tier][column].up = true;
		
		for i = prereqTier, tier - 1 do
			self.Array[i][column].down = true;
			self.Array[i + 1][column].up = true;
		end

		for i = left, right - 1 do
			self.Array[prereqTier][i].right = true;
			self.Array[prereqTier][i+1].left = true;
		end
	else
		for i=prereqTier, tier-1 do
			self.Array[i][column].up = true;
			self.Array[i + 1][column].down = true;
		end
	end
end

function Altoholic.Talents.Branches:Draw()
	-- Altoholic.Profiler:Begin("TalentBranchesDraw")
	local x, y
	local ignoreUp
	
	for i = 1, MAX_NUM_TALENT_TIERS do
		for j = 1, NUM_TALENT_COLUMNS do
			local p = self.Array[i][j]
			
			x = INITIAL_OFFSET_X + ((j-1) * TALENT_OFFSET_X) + 2
			y = -(INITIAL_OFFSET_Y + ((i-1) * TALENT_OFFSET_Y)) - 2
			
			if p.node then			-- there's a talent there
				if p.up then
					if not ignoreUp then
						self:SetTexture("up", x, y + TALENT_BUTTON_SIZE)
					else
						ignoreUp = nil
					end
				end
				if p.down then
					self:SetTexture("down", x, y - TALENT_BUTTON_SIZE + 1)
				end
				if p.left then
					self:SetTexture("left", x - TALENT_BUTTON_SIZE, y)
				end
				if p.right then
					self:SetTexture("right", x + TALENT_BUTTON_SIZE, y)
				end			
			else
				if p.up and p.left and p.right then
					self:SetTexture("tup", x, y)
				elseif p.down and p.left and p.right then
					self:SetTexture("tdown", x, y)
				elseif p.left and p.down then
					self:SetTexture("topright", x, y)
					self:SetTexture("down", x, y-32)
				elseif p.left and p.up then
					self:SetTexture("bottomright", x, y)
				elseif p.left and p.right then
					self:SetTexture("right", x + TALENT_BUTTON_SIZE, y)
					self:SetTexture("left", x+1, y)
				elseif p.right and p.down then
					self:SetTexture("topleft", x, y)
					self:SetTexture("down", x, y-32)
				elseif p.right and p.up then
					self:SetTexture("bottomleft", x, y)
				elseif p.up and p.down then
					self:SetTexture("up", x, y)
					self:SetTexture("down", x, y-32)
					ignoreUp = true
				end
			end

			p.up = nil			-- clear after use
			p.left = nil
			p.right = nil
			p.down = nil
			p.node = nil
		end
	end
	-- Altoholic.Profiler:End("TalentBranchesDraw")
end

function Altoholic.Talents.Branches:SetTexture(branchType, x, y)
	local branch = _G["AltoholicFrameTalents_Branch" .. self.count]
	local tc = TALENT_BRANCH_TEXTURECOORDS[branchType][1]
	
	branch:SetTexCoord(tc[1], tc[2], tc[3], tc[4]);
	branch:SetPoint("TOPLEFT",	Altoholic.Talents.Parent, "TOPLEFT", x, y)
	branch:Show()
	
	self.count = self.count + 1
end

function Altoholic.Talents.Branches:HideUnused()
	while self.count <= 30 do
		_G["AltoholicFrameTalents_Branch" .. self.count]:Hide()
		self.count = self.count + 1
	end
	self.count = nil
end

function Altoholic.Talents:Scan()

	local c = Altoholic.ThisCharacter
	if not c.level or c.level < 10 then return end
	
	local ref = Altoholic:GetReferenceTable()
	
	c.activeTalents = GetActiveTalentGroup()		-- returns 1 or 2
	c.talent = ""
	
	-- first talent tree, gather reference + user specific
	for i = 1, GetNumTalentTabs() do
		local name, _, pointsSpent, fileName = GetTalentTabInfo( i, nil, nil, 1 );
		
		c.talent = c.talent .. name .. ":".. pointsSpent .. "|"
		
		local ti = ref[c.englishClass].talentInfo[i]		-- ti for talent info

		ti.name = name
		ti.background = fileName
		ti.icon = select(2, GetSpellTabInfo(i+1))
		ti.icon = string.gsub(ti.icon, TALENT_ICON_PATH, "")
		
		for j = 1, GetNumTalents(i) do
			local nameTalent, iconPath, tier, column, currentRank, maximumRank = GetTalentInfo(i, j, nil, nil, 1 )

			-- all paths start with this prefix, let's hope blue does not change this :)
			-- saves a lot of memory not to keep the full path for each talent (about 16k in total for all classes)
			iconPath = string.gsub(iconPath, TALENT_ICON_PATH, "")
			
			local link = GetTalentLink(i, j)
			local id = tonumber(link:match("talent:(%d+)"))
			
			c["tree"..i][j] = currentRank
			ti.list[j] = id .. "|" .. nameTalent .. "|" .. iconPath .. "|" .. tier .. "|" ..  column .. "|" .. maximumRank
			
			prereqTier, prereqColumn = GetTalentPrereqs(i, j)		-- talent prerequisites
			if prereqTier and prereqColumn then
				ti.prereqs[j] = prereqTier .. "|" .. prereqColumn
			end
		end
	end
	
	-- second talent tree, user specific only
	for i = 1, GetNumTalentTabs() do
		local name, _, pointsSpent = GetTalentTabInfo( i, nil, nil, 2 );
		
		c.talent = c.talent .. name .. ":".. pointsSpent
		if i ~= 3 then
			c.talent = c.talent .. "|"
		end
		
		for j = 1, GetNumTalents(i) do
			local _, _, _, _, currentRank = GetTalentInfo(i, j, nil, nil, 2 )
			
			c["tree"..i+3][j] = currentRank
		end
	end
end

function Altoholic.Talents:GetLink(self)

	local c = Altoholic:GetCharacterTable()
	local ref = Altoholic:GetReferenceTable()
	local treeIndex = self:GetParent():GetParent():GetID()
	
	local tree = ref[c.englishClass].talentInfo[treeIndex]
	if not tree then return	end
	
	local spellNumber = self:GetID()

	local id, name = strsplit("|", tree.list[spellNumber])
	
	local rank = c["tree"..((Altoholic.Talents.group-1)*3) + treeIndex][spellNumber] or 0

	return format("|cff4e96f7|Htalent:%s:%s|h[%s]|h|r", id, (rank-1), name)
end

function Altoholic.Talents:SetCurrentGroup(group)
	self.group = group
end

-- copied from Blizzard_GlyphUI.lua, no idea why they're not visible from here .. :/
Altoholic.Glyphs.Buttons.SlotsTC = {

	-- Empty Texture
	[0] = { left = 0.78125, right = 0.91015625, top = 0.69921875, bottom = 0.828125 },
	[1] = { left = 0, right = 0.12890625, top = 0.87109375, bottom = 1 },
	[2] = { left = 0.130859375, right = 0.259765625, top = 0.87109375, bottom = 1 },
	[3] = { left = 0.392578125, right = 0.521484375, top = 0.87109375, bottom = 1 },
	[4] = { left = 0.5234375, right = 0.65234375, top = 0.87109375, bottom = 1 },
	[5] = { left = 0.26171875, right = 0.390625, top = 0.87109375, bottom = 1 },
	[6] = { left = 0.654296875, right = 0.783203125, top = 0.87109375, bottom = 1 }
}

function Altoholic.Glyphs:Update()
	-- GLYPHTYPE_MAJOR = 1;
	-- GLYPHTYPE_MINOR = 2;

	--		1
	--	3		5
	--	6		4
	--		2

	-- Altoholic.Profiler:Begin("GlyphsUpdate")
	for i = 1, 6 do
		self.Buttons:Draw(i)
	end
	-- Altoholic.Profiler:End("GlyphsUpdate")
end

function Altoholic.Glyphs:Scan()
	local c = Altoholic.ThisCharacter
	local glyphList = ""
	
	local numGlyphs = 6
	
	for group = 1, 2 do
		for i = 1, numGlyphs do
	      -- type 1 = major, 2 = minor
		   local enabled, glyphType, spell, icon = GetGlyphSocketInfo(i, group)
			local link = GetGlyphLink(i, group)
			local glyphID
			if link then
				_, glyphID = link:match("glyph:(%d+):(%d+)")
			end
			
			glyphID = glyphID or 0
			glyphType = glyphType or 0
			enabled = enabled or 0
			spell = spell or ""
			icon = icon or ""
			
			glyphList = glyphList .. enabled ..":" .. glyphType .. ":" .. spell .. ":" .. icon .. ":" .. glyphID
			
			if i < (numGlyphs*2) then
				glyphList = glyphList .. "|"
			end
		end
	end
	
	c.glyphs = nil					--	kill the previous data
	c.glyphInfo = glyphList		-- "enabled : glyphType : spellID : icon | ... "
end

function Altoholic.Glyphs:GetData(glyphInfo, id)
	id = ((Altoholic.Talents.group-1)*6) + id

	local glyphData = select(id, strsplit("|", glyphInfo))
	local enabled, glyphType, spell, icon, glyphID = strsplit(":", glyphData)
	
	return tonumber(enabled), tonumber(glyphType), tonumber(spell), icon, tonumber(glyphID)
end

function Altoholic.Glyphs:GetLink(id, spell, glyphID)

	local name = GetSpellInfo(spell)

	return format("|cff66bbff|Hglyph:2%s:%s|h[%s]|h|r", id, glyphID, name)
end

function Altoholic.Glyphs.Buttons:Draw(id)
	local name = "AltoholicFrameTalentsGlyph" .. id
	local glyph = _G[name]
	
	local c = Altoholic:GetCharacterTable()
	if not c.glyphInfo then 
		glyph.shine:Hide();
		glyph.background:Hide();
		glyph.glyph:Hide();
		glyph.ring:Hide();
		glyph.setting:SetTexture("Interface\\Spellbook\\UI-GlyphFrame-Locked");
		glyph.setting:SetTexCoord(.1, .9, .1, .9);
		return 
	end
	
	local enabled, glyphType, spell, icon = Altoholic.Glyphs:GetData(c.glyphInfo, id)
	
	if glyphType == 1 then
		glyph.glyph:SetVertexColor(1, 0.25, 0);
	else
		glyph.glyph:SetVertexColor(0, 0.25, 1);
	end
	
	if enabled == 0 then
		glyph.shine:Hide();
		glyph.background:Hide();
		glyph.glyph:Hide();
		glyph.ring:Hide();
		glyph.setting:SetTexture("Interface\\Spellbook\\UI-GlyphFrame-Locked");
		glyph.setting:SetTexCoord(.1, .9, .1, .9);
	elseif not spell then
		local tc = self.SlotsTC[0]
		
		glyph.shine:Show();
		glyph.background:Show();
		glyph.background:SetTexCoord(tc.left, tc.right, tc.top, tc.bottom);
		glyph.glyph:Hide();
		glyph.ring:Show();
		glyph.setting:SetTexture("Interface\\Spellbook\\UI-GlyphFrame");
		glyph.setting:SetTexCoord(0.740234375, 0.953125, 0.484375, 0.697265625);
	else
		local tc = self.SlotsTC[id]
		
		glyph.shine:Show();
		glyph.background:Show();
		glyph.background:SetAlpha(1);
		glyph.background:SetTexCoord(tc.left, tc.right, tc.top, tc.bottom);
		glyph.glyph:Show();
		glyph.glyph:SetTexture(icon);
		glyph.ring:Show();
		glyph.setting:SetTexture("Interface\\Spellbook\\UI-GlyphFrame");
		glyph.setting:SetTexCoord(0.740234375, 0.953125, 0.484375, 0.697265625);
	end
end

function Altoholic.Glyphs.Buttons:OnLoad(id)
	local name = "AltoholicFrameTalentsGlyph" .. id
	local glyph = _G[name]
	
	glyph.glyph = _G[name .. "Glyph"]
	glyph.setting = _G[name .. "Setting"]
	glyph.highlight = _G[name .. "Highlight"]
	glyph.background = _G[name .. "Background"]
	glyph.ring = _G[name .. "Ring"]
	glyph.shine = _G[name .. "Shine"]
	
	local ratio
	
	if (id == 1) or (id == 4) or (id == 6) then		-- major
		ratio = 0.85
	else
		ratio = 0.70
	end

	glyph.glyph:SetWidth(63 * ratio);
	glyph.glyph:SetHeight(63 * ratio);
	
	glyph.setting:SetWidth(108 * ratio);
	glyph.setting:SetHeight(108 * ratio);
	glyph.setting:SetTexture("Interface\\Spellbook\\UI-GlyphFrame");
	glyph.setting:SetTexCoord(0.740234375, 0.953125, 0.484375, 0.697265625);
	glyph.highlight:SetWidth(108 * ratio);
	glyph.highlight:SetHeight(108 * ratio);
	glyph.highlight:SetTexCoord(0.740234375, 0.953125, 0.484375, 0.697265625);
	glyph.ring:SetWidth(82 * ratio);
	glyph.ring:SetHeight(82 * ratio);
	glyph.ring:SetPoint("CENTER", glyph, "CENTER", 0, -1);
	glyph.ring:SetTexCoord(0.767578125, 0.92578125, 0.32421875, 0.482421875);
	glyph.shine:SetTexCoord(0.9609375, 1, 0.9609375, 1);
	glyph.background:SetWidth(70 * ratio);
	glyph.background:SetHeight(70 * ratio);
end

function Altoholic.Glyphs.Buttons:OnEnter(self)
	local id = self:GetID()
	local c = Altoholic:GetCharacterTable()
	if not c.glyphInfo then return end
	
	local enabled, glyphType, spell, _, glyphID = Altoholic.Glyphs:GetData(c.glyphInfo, id)
	
	local glyphTypeText
	if tonumber(glyphType) == 1 then
		glyphTypeText = "|cFF69CCF0" .. MAJOR_GLYPH
	else
		glyphTypeText = "|cFF69CCF0" .. MINOR_GLYPH
	end	
	
	AltoTooltip:SetOwner(self, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	if enabled == 0 then
		AltoTooltip:AddLine("|cFFFF0000" .. GLYPH_LOCKED);
		AltoTooltip:AddLine(glyphTypeText);
		AltoTooltip:AddLine(_G["GLYPH_SLOT_TOOLTIP"..id]);

		AltoTooltip:Show();
		return
	elseif not spell then

		AltoTooltip:AddLine("|cFF808080" .. GLYPH_EMPTY);
		AltoTooltip:AddLine(glyphTypeText);
		AltoTooltip:AddLine(GLYPH_EMPTY_DESC);
		AltoTooltip:Show();
		return 
	end

	local link = Altoholic.Glyphs:GetLink(id, spell, glyphID)
	AltoTooltip:SetHyperlink(link);
	AltoTooltip:Show();
end

function Altoholic.Glyphs.Buttons:OnClick(self, button)
	local id = self:GetID()
	local c = Altoholic:GetCharacterTable()
	if not c.glyphInfo then return end
	
	local enabled, glyphType, spell, _, glyphID = Altoholic.Glyphs:GetData(c.glyphInfo, id)
	if not spell then return end
	
	if ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		if ( ChatFrameEditBox:IsShown() ) then
			local link = Altoholic.Glyphs:GetLink(id, spell, glyphID)
			
			ChatFrameEditBox:Insert(link);
		end
	end
end
