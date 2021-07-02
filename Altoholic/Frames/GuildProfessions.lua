local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local WHITE		= "|cFFFFFFFF"
local GRAY		= "|cFFBBBBBB"
local GREEN		= "|cFF00FF00"
local LIGHTBLUE = "|cFFB0B0FF"
local YELLOW	= "|cFFFFFF00"

local MAIN_LINE = 0
local ALT_LINE = 1

Altoholic.Guild.Professions = {}

local function SortByMemberInfo(a, b, fieldID, ascending)
	local m = Altoholic.Guild.Members
	local levelA = select(fieldID, m:GetInfo(a))
	local levelB = select(fieldID, m:GetInfo(b))
	
	if ascending then
		return levelA < levelB
	else
		return levelA > levelB
	end
end

local function SortBySkillLevel(a, b, field, ascending)
	local guild = Altoholic:GetThisGuild()
	local m = guild.members

	local ts = Altoholic.TradeSkills
	local _, levelA = ts:GetInfo(m[a][field])
	local _, levelB = ts:GetInfo(m[b][field])
	
	levelA = tonumber(levelA) or 0
	levelB = tonumber(levelB) or 0
	
	if ascending then
		return levelA < levelB
	else
		return levelA > levelB
	end
end

function Altoholic.Guild.Professions:BuildView()
	
	self.view = self.view or {}
	Altoholic:ClearTable(self.view)
	
	local line = 0
	
	for k, v in pairs(Altoholic.Guild.Members.List) do
		if v.version ~= L["N/A"] then		-- only take altoholic users into account
			-- main character first
			for skillIdx, s in pairs(v.skills) do
				if s.name == v.name then
					table.insert(self.view, {
						linetype = line,
						isCollapsed = false,
						parentID = k,
						skillIndex = skillIdx,
					} )
				end
			end
			
			-- then alts
			for skillIdx, s in pairs(v.skills) do
				if s.name ~= v.name then
					table.insert(self.view, {
						linetype = line+1,
						parentID = k,
						skillIndex = skillIdx,
					} )
				end
			end
			
			line = line + 2
		end
	end
	
	local guild = Altoholic:GetThisGuild()
	if not guild then return end
	
	-- add a line for the "offline members" category header
	table.insert(self.view, {
		linetype = line,
		isCollapsed = false,
		parentID = L["Offline Members"]
	} )
	
	local offlineMembers = {}
	
	for k, v in pairs(guild.members) do
		local level = Altoholic.Guild.Members:GetInfo(k)
		if not level then	-- no level found = no longer in the guild, remove it
			v = nil
		else
			-- if character is not connected (or under an alt), list it
			if not Altoholic.Guild.Members:IsKnown(k, true) then
				offlineMembers[ #offlineMembers + 1 ] = k
			end
		end
	end
	
	local field = AltoholicTabSummary.GuildProfessionsSortBy
	
	if field then
		local ascending = AltoholicTabSummary.GuildProfessionsSortOrder
	
		if field == "level" then
			table.sort(offlineMembers, function(a, b) return SortByMemberInfo(a, b, 1, ascending) end)
		elseif field == "englishClass" then
			table.sort(offlineMembers, function(a, b) return SortByMemberInfo(a, b, 3, ascending) end)
		elseif field == "prof1link" or field == "prof2link" or field == "cookinglink"  then
			table.sort(offlineMembers, function(a, b) return SortBySkillLevel(a, b, field, ascending) end)
		else
			if ascending then				-- by default, sort by name, ascending
				table.sort(offlineMembers)
			else
				table.sort(offlineMembers, function(a, b)	return a > b end)
			end
		end
	end
	
	for k, v in ipairs(offlineMembers) do
		table.insert(self.view, {
			linetype = line+1,
			parentID = v
		} )
	end
end

function Altoholic.Guild.Professions:Update()
	local VisibleLines = 14
	local frame = "AltoholicFrameGuildProfessions"
	local entry = frame.."Entry"
	
	if #self.view == 0 then
		Altoholic:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 18)
		return
	end
	
	local function WriteLink(frame, link)
		if not link then 
			frame:Hide()
			return 
		end
		frame:Show()
		
		local ts = Altoholic.TradeSkills
		local spellID, curRank, maxRank = ts:GetInfo(link)
		
		if spellID then		-- recent version, spell ID available, draw icon + level
			local icon = Altoholic:TextureToFontstring(Altoholic:GetSpellIcon(tonumber(spellID)), 18, 18) .. " "
			frame:SetText(icon .. ts:GetColor(curRank) .. curRank .. "/" .. maxRank)
		else	-- older version, spell id missing, draw the link, not the level
			frame:SetText(WHITE..link)
		end
	end
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawAlts
	local i=1
	
	local guild = Altoholic:GetThisGuild()
	
	for line, v in pairs(self.view) do
		local c = Altoholic.Guild.Members.List[v.parentID]
		local lineType = mod(v.linetype, 2)
		
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if lineType == MAIN_LINE then								-- then keep track of counters
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
			local char
			
			if type(v.parentID) == "number" then				-- number = online member
				char = c.skills[v.skillIndex]
			end
			
			if lineType == MAIN_LINE then
				if v.isCollapsed == false then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawAlts = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawAlts = false
				end
				_G[entry..i.."Collapse"]:Show()
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 25, 0)
				
				if type(v.parentID) == "number" then				-- number = online member
					_G[entry..i.."NameNormalText"]:SetText(YELLOW..c.name)
					_G[entry..i.."Level"]:SetText(GREEN .. c.level)
					_G[entry..i.."Class"]:SetText(format("%s%s", Altoholic:GetClassColor(char.englishClass), char.class))

					WriteLink( _G[entry..i.."Skill1NormalText"], char.prof1link )
					WriteLink( _G[entry..i.."Skill2NormalText"], char.prof2link )
					WriteLink( _G[entry..i.."Skill3NormalText"], char.cookinglink )					
				else
					_G[entry..i.."NameNormalText"]:SetText(YELLOW..v.parentID)		-- "Offline Members"
					_G[entry..i.."Level"]:SetText("")
					_G[entry..i.."Class"]:SetText("")
					
					WriteLink( _G[entry..i.."Skill1NormalText"], nil)
					WriteLink( _G[entry..i.."Skill2NormalText"], nil)
					WriteLink( _G[entry..i.."Skill3NormalText"], nil)
				end
				
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			elseif DrawAlts then
				_G[entry..i.."Collapse"]:Hide()
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
				
				if type(v.parentID) == "number" then				-- number = online member
					_G[entry..i.."NameNormalText"]:SetText(LIGHTBLUE..char.name)
					_G[entry..i.."Level"]:SetText(GREEN .. char.level)
					_G[entry..i.."Class"]:SetText(format("%s%s", Altoholic:GetClassColor(char.englishClass), char.class))
				else
					char = guild.members[v.parentID]		-- replace "char" reference to use data of an offline player
					_G[entry..i.."NameNormalText"]:SetText(GRAY..v.parentID)
					
					local level, class, englishClass = Altoholic.Guild.Members:GetInfo(v.parentID)
					
					if level then
						_G[entry..i.."Level"]:SetText(GREEN .. level)
						_G[entry..i.."Class"]:SetText(format("%s%s", Altoholic:GetClassColor(englishClass), class))
					else
						_G[entry..i.."Level"]:SetText("")
						_G[entry..i.."Class"]:SetText("")
					end
				end
				
				WriteLink( _G[entry..i.."Skill1NormalText"], char.prof1link )
				WriteLink( _G[entry..i.."Skill2NormalText"], char.prof2link )
				WriteLink( _G[entry..i.."Skill3NormalText"], char.cookinglink )

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

function Altoholic.Guild.Professions:OnEnter(self)
	local line = self:GetParent():GetID()		-- get the id of the line that was clicked
	if line == 0 then return end		-- 0 is for hidden frames, should never happen
	
	local player = Altoholic.Guild.Professions.view[line]
	local char
	local name
		
	if type(player.parentID) == "number" then				-- number = online member
		local c = Altoholic.Guild.Members.List[player.parentID]
		char = c.skills[player.skillIndex]
		name = char.name
	else
		local guild = Altoholic:GetThisGuild()
		char = guild.members[player.parentID]
		name = player.parentID
	end
	
	local link
	local id = self:GetID()			-- id of the button that was clicked
	
	if id == 1 then
		link = char.prof1link
	elseif id == 2 then
		link = char.prof2link
	elseif id == 3 then
		link = char.cookinglink
	end
	
	if not link then return end
	
	local ts = Altoholic.TradeSkills
	local spellID, curRank, maxRank = ts:GetInfo(link)
	if not spellID then return end
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	
	local _, _, englishClass = Altoholic.Guild.Members:GetInfo(name)
	AltoTooltip:AddLine(Altoholic:GetClassColor(englishClass) .. name,1,1,1);
	
	local skillName = GetSpellInfo(spellID)
	AltoTooltip:AddLine(skillName,1,1,1);
	
	AltoTooltip:AddLine(ts:GetColor(curRank) .. curRank .. "/" .. maxRank,1,1,1);
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(GREEN..L["Left click to view"],1,1,1);
	AltoTooltip:AddLine(GREEN..L["Shift+Left click to link"],1,1,1);
	 	
	AltoTooltip:Show();
end

function Altoholic.Guild.Professions:OnClick(self, button)
	if button ~= "LeftButton" then return end
	
	local line = self:GetParent():GetID()		-- get the id of the line that was clicked
	if line == 0 then return end		-- 0 is for hidden frames, should never happen
	
	local player = Altoholic.Guild.Professions.view[line]
	local char
		
	if type(player.parentID) == "number" then				-- number = online member
		local c = Altoholic.Guild.Members.List[player.parentID]
		char = c.skills[player.skillIndex]
	else
		local guild = Altoholic:GetThisGuild()
		char = guild.members[player.parentID]
	end
	
	local link
	local id = self:GetID()			-- id of the button that was clicked
	
	if id == 1 then
		link = char.prof1link
	elseif id == 2 then
		link = char.prof2link
	elseif id == 3 then
		link = char.cookinglink
	end
	
	if not link then return end
	if not link:match("trade:") then return end

	if ChatFrameEditBox:IsShown() and IsShiftKeyDown() then
		ChatFrameEditBox:Insert(link);
	else
		SetItemRef(link:match("|H([^|]+)"), "Profession", "LeftButton")
	end
end
