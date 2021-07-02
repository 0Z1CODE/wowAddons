local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"
local LIGHTBLUE = "|cFFB0B0FF"

local NORMALPLAYER_LINE = 0		-- a guild mate who does not use altoholic
local ALTO_MAIN_LINE = 1			-- the currently connected character of a guild mate using altoholic
local ALTO_ALT_LINE = 2				-- an alt belonging to the previous line

Altoholic.Guild.Members = {}
Altoholic.Guild.Members.List = {}

function Altoholic.Guild.Members:BuildView()
	
	self.view = self.view or {}
	Altoholic:ClearTable(self.view)
	
	for k, v in pairs(self.List) do
		if v.version == L["N/A"] then		-- non altoholic user
			table.insert(self.view, {
				linetype = NORMALPLAYER_LINE,
				parentID = k
			} )
		else										-- altoholic user
			-- main character first
			for skillIdx, s in pairs(v.skills) do
				if s.name == v.name then
					table.insert(self.view, {
						linetype = ALTO_MAIN_LINE,
						isCollapsed = true,
						parentID = k,
						skillIndex = skillIdx,
					} )
				end
			end
			
			-- then alts
			for skillIdx, s in pairs(v.skills) do
				if s.name ~= v.name then
					table.insert(self.view, {
						linetype = ALTO_ALT_LINE,
						parentID = k,
						skillIndex = skillIdx,
					} )
				end
			end
		end
	end
end

function Altoholic.Guild.Members:Update()
	if AltoholicFrameGuildMembers.InitRequired then
		self:LoadTextures()
		AltoholicFrameGuildMembers.InitRequired = nil
	end

	local VisibleLines = 14
	local frame = "AltoholicFrameGuildMembers"
	local entry = frame.."Entry"
	
	AltoholicTabSummaryStatus:SetText(L["Click a character's AiL to see its equipment"])
	
	if self.GetNumber() == 0 then
		Altoholic:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 18)
		return
	end
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawAlts
	local i=1
	
	for line, v in pairs(self.view) do
		local c = self:Get(v.parentID)
		
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if v.linetype == NORMALPLAYER_LINE then
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif v.linetype == ALTO_MAIN_LINE then							-- then keep track of counters
				if v.isCollapsed == false then
					DrawAlts = true
				else
					DrawAlts = false
				end
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif DrawAlts then
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			end
		else		-- line will be displayed
			if v.linetype == NORMALPLAYER_LINE then
				_G[entry..i.."Collapse"]:Hide()
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
				_G[entry..i.."NameNormalText"]:SetText(YELLOW..c.name)
				_G[entry..i.."Level"]:SetText(GREEN .. c.level)
				_G[entry..i.."AvgILevelNormalText"]:SetText(YELLOW..format("%.1f", c.averageItemLvl))
				_G[entry..i.."Version"]:SetText(WHITE..c.version)
				_G[entry..i.."Class"]:SetText(format("%s%s", Altoholic:GetClassColor(c.englishClass), c.class))
				
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
				
			elseif v.linetype == ALTO_MAIN_LINE then
				if v.isCollapsed == false then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawAlts = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawAlts = false
				end
				_G[entry..i.."Collapse"]:Show()
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 25, 0)
				_G[entry..i.."NameNormalText"]:SetText(YELLOW..c.name)
				_G[entry..i.."Level"]:SetText(GREEN .. c.level)
				_G[entry..i.."AvgILevelNormalText"]:SetText(YELLOW..format("%.1f", c.averageItemLvl))
				_G[entry..i.."Version"]:SetText(WHITE..c.version)
				_G[entry..i.."Class"]:SetText(format("%s%s", Altoholic:GetClassColor(c.englishClass), c.class))
				
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1

			elseif DrawAlts then
				local char = c.skills[v.skillIndex]
				
				_G[entry..i.."Collapse"]:Hide()
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
				_G[entry..i.."NameNormalText"]:SetText(LIGHTBLUE..char.name)
				_G[entry..i.."Level"]:SetText(GREEN .. char.level)
				if char.averageItemLvl then
					_G[entry..i.."AvgILevelNormalText"]:SetText(YELLOW..format("%.1f", char.averageItemLvl))
				else
					_G[entry..i.."AvgILevelNormalText"]:SetText(YELLOW..0)
				end
				_G[entry..i.."Version"]:SetText(WHITE..c.version)
				_G[entry..i.."Class"]:SetText(format("%s%s", Altoholic:GetClassColor(char.englishClass), char.class))
				
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

function Altoholic.Guild.Members:Name_OnEnter(self)
	local line = self:GetParent():GetID()		-- get the id of the line that was clicked
	if line == 0 then return end		-- 0 is for hidden frames, should never happen
	
	local owner = self
	local self = Altoholic.Guild.Members
	
	local player = self.view[line]
	local c = self:Get(player.parentID)
	if not c.skills then return end	-- not an altoholic user
	
	local char = c.skills[player.skillIndex]
	
	if not char then return end
	
	local name, rank, rankIndex, zone, note, officernote
	local playerFound

  	for i=1, GetNumGuildMembers(true) do		-- browse offline players too !
		name, rank, rankIndex, _, _, zone, note, officernote = GetGuildRosterInfo(i);
		if name == char.name then
			playerFound = true
			break
		end
	end
  
	if not playerFound then return end
  
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(owner, "ANCHOR_RIGHT");
	AltoTooltip:AddLine(Altoholic:GetClassColor(char.englishClass) .. char.name,1,1,1);
	AltoTooltip:AddLine(WHITE .. RANK_COLON .. "|r " .. rank .. GREEN .. " (".. rankIndex .. ")");
	if zone then
		AltoTooltip:AddLine(WHITE .. ZONE_COLON .. "|r " .. zone);
	end
	
	if note then
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddLine(WHITE .. NOTE .. ":");
		AltoTooltip:AddLine(note);
	end
	
	if officernote then
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddLine(WHITE .. GUILD_OFFICER_NOTE .. ":");
		AltoTooltip:AddLine(officernote);
	end

	AltoTooltip:Show();
end

function Altoholic.Guild.Members:Level_OnClick(self, button)
	if button ~= "LeftButton" then return end
	
	local line = self:GetParent():GetID()		-- get the id of the line that was clicked
	if line == 0 then return end		-- 0 is for hidden frames, should never happen
	
	local self = Altoholic.Guild.Members
	local player = self.view[line]
	local c = self:Get(player.parentID)
	if not c.skills then return end	-- not an altoholic user
	
	local char = c.skills[player.skillIndex]
	
	if not char then return end
	if char.averageItemLvl == 0 then return end
	
	Altoholic.Comm.Guild:Whisper(c.name, 6, char.name)		-- MSG_GUILD_EQUIPMENTREQUEST = 6
	AltoholicFrameGuildMembers_Name:SetText(char.name)
end

function Altoholic.Guild.Members:Level_OnEnter(self)
	local line = self:GetParent():GetID()		-- get the id of the line that was clicked
	if line == 0 then return end		-- 0 is for hidden frames, should never happen
	
	local owner = self
	local self = Altoholic.Guild.Members
	local player = self.view[line]
	local c = self:Get(player.parentID)
	if not c.skills then return end	-- not an altoholic user
	
	local char = c.skills[player.skillIndex]
	
	if not char then return end
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(owner, "ANCHOR_RIGHT");
	AltoTooltip:AddLine(Altoholic:GetClassColor(char.englishClass) .. char.name,1,1,1);
	AltoTooltip:AddLine(WHITE .. L["Average Item Level"] ..": " .. GREEN.. format("%.1f", char.averageItemLvl),1,1,1);

	Altoholic:AiLTooltip()
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(GREEN .. L["Left-click to see this character's equipment"],1,1,1);
	AltoTooltip:Show();
end

function Altoholic.Guild.Members:OnRosterUpdate()
	local numMembers, numTotal = (GetNumGuildMembers()), (GetNumGuildMembers(true));
	
	if numMembers == numTotal then
		-- for some reason I did not understand, the number of online members is sometimes equal to the total, which is obviously wrong, so exit if that's the case
		return
	end
	
	local self = Altoholic.Guild.Members
	if self.UpdateInProgress then return end
	
	self.UpdateInProgress = true				-- shouldn't be necessary, but let's be safe in case the guild roster turns out to be big
	local rosterChanged		-- will be true if a player is added or deleted

	-- get rid of disconnected users
	for k, v in pairs(self.List) do
		if not self:IsConnected(v.name) then		
			-- warn other altoholic users in the guild that player v.name has disconnected

			-- deprecated
			-- self.Comm.Guild:Broadcast(2, v.name)		-- MSG_GUILD_ANNOUNCELOGOUT = 2

			-- if a character present in the local info table is no longer in the roster, remove it
			if not v.RemoveForbidden then		-- should never happen, let's be safe..
				self:Delete(k)
				rosterChanged = true
			end
		end
	end
	
	-- now add members who do not have the addon and who are not yet in the list
	for i=1, numMembers do		-- browse online players
		local charName, _, _, charLevel, charClass, _, _, _, _, _, charEnglishClass = GetGuildRosterInfo(i)
		
		if not self:IsKnown(charName) then
			self:Add({
				name = charName,
				level = charLevel,
				averageItemLvl = 0,
				class = charClass,
				englishClass = charEnglishClass,
				version = L["N/A"]
			})
			rosterChanged = true
		end
	end
	
	AltoholicTabSummaryMenuItem5:SetText(format("%s %s(%d)", XML_ALTO_SUMMARY_MENU5, GREEN, self.GetNumber()))
	
	if rosterChanged then
		AltoholicTabSummary:RefreshCurrentFrame()
	end
	self.UpdateInProgress = nil
end

function Altoholic.Guild.Members:Add(t)
	assert(type(t) == "table")
	table.insert(self.List, t)
end

function Altoholic.Guild.Members:Delete(index)
	assert(type(index) == "number")
	table.remove(self.List, index)
end

function Altoholic.Guild.Members:Clear(player)
	assert(type(player) == "string")
	-- an entry in self.List will contain guildmates that either have Altoholic or not
	-- this function clears a "non-altoholic" user before inserting his updated entry
	for k, v in pairs(self.List) do
		if v.name == player and not v.RemoveForbidden then	-- only filter on the name, in case it's present multiple times (eg: after a manual reloadui)
			-- if the player is already in the roster and not a known altoholic user yet, remove the entry, as it will be replaced
			self:Delete(k)
		end
	end
end

function Altoholic.Guild.Members:GetNumber()
	return #Altoholic.Guild.Members.List
end

function Altoholic.Guild.Members:Get(n)
	return Altoholic.Guild.Members.List[n]
end

function Altoholic.Guild.Members:GetInfo(player)
	for i=1, GetNumGuildMembers(true) do		-- browse offline players too !
		local charName, _, _, charLevel, charClass, _, _, _, _, _, charEnglishClass = GetGuildRosterInfo(i)		
		if charName == player then
			return charLevel, charClass, charEnglishClass
		end
	end
	-- this may happen if the alt has been renamed or migrated to another realm 
	return nil, nil, nil
end

function Altoholic.Guild.Members:IsConnected(player)
	for i=1, GetNumGuildMembers() do		-- browse online players only
		if GetGuildRosterInfo(i) == player then
			return true
		end
	end
	return nil
end

function Altoholic.Guild.Members:IsKnown(player, checkAlts)
	-- is the player already in self.List ?
	for k, v in pairs(self.List) do
		if v.name == player then
			return true
		elseif checkAlts and v.skills then
			for _, s in pairs(v.skills) do
				if s.name == player then
					return true
				end
			end
		end
	end
	return nil
end

function Altoholic.Guild.Members:GetNameOfMain(player)
	-- returns the name of the guild mate to whom an alt belongs
	-- ex, player x has alts a, b, c	if b is passed, return x, if x is passed, return x too..this is the name of the connected player.
	for k, v in pairs(self.List) do
		if v.name == player then
			return v.name
		end
		
		-- check alts
		if v.skills then
			for _, s in pairs (v.skills) do
				if s.name == player then
					return v.name
				end
			end
		end
	end
	return nil
end

function Altoholic.Guild.Members:Save(player)
	-- saves a player and his alts into the list of "known" guild members who have at least one full profession link.
	local guild = Altoholic:GetThisGuild()
	
	for k, v in pairs(player.skills) do
		-- if this alt has at least one profession link..
		if v.prof1link or v.prof2link or v.cookinglink then
			Altoholic:ClearTable(guild.members[v.name])
			local m = guild.members[v.name]		-- copy fields manually, we don't want everything that's under v
			m.prof1link = v.prof1link
			m.prof2link = v.prof2link
			m.cookinglink = v.cookinglink
		end
	end
end

local function SortByMemberInfo(a, b, fieldID, ascending)
	local m = Altoholic.Guild.Members
	local levelA = select(fieldID, m:GetInfo(a.name))
	local levelB = select(fieldID, m:GetInfo(b.name))
	
	if ascending then
		return levelA < levelB
	else
		return levelA > levelB
	end
end

local function SortBySkillLevel(a, b, field, ascending)
	local ts = Altoholic.TradeSkills
	local _, levelA = ts:GetInfo(a[field])
	local _, levelB = ts:GetInfo(b[field])
	
	levelA = tonumber(levelA) or 0
	levelB = tonumber(levelB) or 0
	
	if ascending then
		return levelA < levelB
	else
		return levelA > levelB
	end
end

local function SortByField(a, b, field, ascending)
	if ascending then
		return a[field] < b[field]
	else
		return a[field] > b[field]
	end
end
			
function Altoholic.Guild.Members:Sort(orderBy, ascending)
	-- expected types : "name", "level", "averageItemLvl", "version", "englishClass", "prof1", "prof2", "cooking"

	-- sort main characters (main level of the table actually)
	if orderBy == "level" then
		table.sort(self.List, function(a, b) return SortByMemberInfo(a, b, 1, ascending) end)
	elseif orderBy == "englishClass" then
		table.sort(self.List, function(a, b) return SortByMemberInfo(a, b, 3, ascending) end)
	elseif orderBy == "name" or orderBy == "averageItemLvl" or orderBy == "version"  then
		table.sort(self.List, function(a, b) return SortByField(a, b, orderBy, ascending) end)
	end

	-- sort alts in the skills table.
	for k, v in pairs(self.List) do
		if v.version ~= L["N/A"] then		-- altoholic users only
			if orderBy == "level" then
				table.sort(v.skills, function(a, b) return SortByMemberInfo(a, b, 1, ascending) end)
			elseif orderBy == "englishClass" then
				table.sort(v.skills, function(a, b) return SortByMemberInfo(a, b, 3, ascending) end)
			elseif orderBy == "prof1link" or orderBy == "prof2link" or orderBy == "cookinglink"  then
				table.sort(v.skills, function(a, b) return SortBySkillLevel(a, b, orderBy, ascending) end)
			elseif orderBy == "name" or orderBy == "averageItemLvl" then
				table.sort(v.skills, function(a, b) return SortByField(a, b, orderBy, ascending) end)
			end
		end
	end
end


local EquipmentToFrame = { 1,3,5,9,10,6,7,8,11,12,13,14,15,4,2,19,16,17,18 }

function Altoholic.Guild.Members:LoadTextures()
	local itemName
	
	for i = 1, 19 do
		itemName = "AltoholicFrameGuildMembersItem".. i;
		Altoholic:SetItemButtonTexture(itemName, Altoholic.Equipment:GetSlotTexture(EquipmentToFrame[i]));
		_G[itemName]:Show()
	end
end

function Altoholic.Guild.Members:UpdateEquipment(equipment)
--[[
	button layout				equipment table layout
	
	1	5	9				1	10	11
	2	6	10 				3	6	12
	3	7	11				5	7	13
	4	8	12 				9	8	14
	
	15 13 14 16				2 15 4 19
	
	17 18 19					16 17 18
--]]

	local itemName
	
	for i = 1, 19 do
		itemName = "AltoholicFrameGuildMembersItem".. i;
		local itemButton = _G[itemName];
		local itemCount = _G[itemName .. "Count"]
		itemCount:Hide();

		Altoholic:CreateButtonBorder(itemButton)
		itemButton.border:Hide()
	
		local itemID = equipment[EquipmentToFrame[i]]
		if itemID ~= nil then
			Altoholic:SetItemButtonTexture(itemName, GetItemIcon(itemID));

			-- set link and id for Altoholic:Item_OnEnter(self)
			if type(itemID) == "string" then
				itemButton.link = itemID
				itemButton.id = Altoholic:GetIDFromLink(itemID)
			elseif type(itemID) == "number" then
				itemButton.id = itemID
				itemButton.link = nil
			end
			
			-- display the coloured border
			local _, _, itemRarity, itemLevel = GetItemInfo(itemID)
			if itemRarity and itemRarity >= 2 then
				local r, g, b = GetItemQualityColor(itemRarity)
				itemButton.border:SetVertexColor(r, g, b, 0.5)
				itemButton.border:Show()
			end
			
			itemCount:SetText(itemLevel);
			itemCount:Show();
		else
			Altoholic:SetItemButtonTexture(itemName, Altoholic.Equipment:GetSlotTexture(EquipmentToFrame[i]));
			itemButton.id = nil
			itemButton.link = nil
		end
		
		itemButton:Show()
	end
end
