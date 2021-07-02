local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local V = Altoholic.vars

local WHITE		= "|cFFFFFFFF"
local RED		= "|cFFFF0000"
local GREEN		= "|cFF00FF00"
local TEAL		= "|cFF00FF9A"

Altoholic.Quests = {}

function Altoholic.Quests:Update()
	local c = Altoholic:GetCharacterTable()
	local VisibleLines = 14
	local frame = "AltoholicFrameQuests"
	local entry = frame.."Entry"
	
	if #c.questlog == 0 then
		AltoholicTabCharactersStatus:SetText(L["No quest found for "] .. V.CurrentAlt)
		Altoholic:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 18)
		return
	end
	AltoholicTabCharactersStatus:SetText("")
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawGroup
	local i=1
	
	for line, s in pairs(c.questlog) do
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if s.isHeader then													-- then keep track of counters
				if s.isCollapsed == false then
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
			if s.isHeader then
				if s.isCollapsed == false then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawGroup = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawGroup = false
				end
				_G[entry..i.."Collapse"]:Show()
				_G[entry..i.."QuestLinkNormalText"]:SetText(TEAL .. s.name)
				_G[entry..i.."QuestLink"]:SetID(0)
				_G[entry..i.."QuestLink"]:SetPoint("TOPLEFT", 25, 0)
				
				_G[entry..i.."Tag"]:Hide()
				_G[entry..i.."Status"]:Hide()
				_G[entry..i.."Money"]:Hide()
				
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
				
			elseif DrawGroup then
				_G[entry..i.."Collapse"]:Hide()
				
				local _, id, level = self:GetInfo(s.link)
				_G[entry..i.."QuestLinkNormalText"]:SetText(WHITE .. "[" .. level .. "] " .. s.link)
				_G[entry..i.."QuestLink"]:SetID(line)
				_G[entry..i.."QuestLink"]:SetPoint("TOPLEFT", 15, 0)
				if s.tag then 
					_G[entry..i.."Tag"]:SetText(self:GetTypeString(s.tag, s.groupsize))
					_G[entry..i.."Tag"]:Show()
				else
					_G[entry..i.."Tag"]:Hide()
				end
				
				if s.isComplete then
					if s.isComplete == 1 then
						_G[entry..i.."Status"]:SetText(GREEN .. COMPLETE)
					elseif s.isComplete == -1 then
						_G[entry..i.."Status"]:SetText(RED .. FAILED)
					end
					_G[entry..i.."Status"]:Show()
				else
					_G[entry..i.."Status"]:Hide()
				end
				
				if s.money then
					_G[entry..i.."Money"]:SetText(Altoholic:GetMoneyString(s.money))
					_G[entry..i.."Money"]:Show()
				else
					_G[entry..i.."Money"]:Hide()
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

function Altoholic.Quests:GetInfo(questString)
	if not questString then return nil end
	
	local _, _, questInfo, questName = strsplit("|", questString)
	local _, questId, questLevel = strsplit(":", questInfo)
	questName = string.sub(questName, 3, -2)

	return questName, questId, questLevel
end

function Altoholic.Quests:IsKnown(quest)
	if not quest then return nil end
	
	local bOtherCharsOnQuest		-- is there at least one other char on the quest ?
	for CharacterName, c in pairs(Altoholic.ThisRealm.char) do
		if CharacterName ~= UnitName("player") then
			for _, q in pairs(c.questlog) do	-- parse all quests
				local altQuestName = self:GetInfo(q.link)
				if altQuestName == quest then
					if not bOtherCharsOnQuest then
						ItemRefTooltip:AddLine(" ",1,1,1);
						ItemRefTooltip:AddLine(GREEN .. L["Are also on this quest:"],1,1,1);
						bOtherCharsOnQuest = true	-- pass here only once
					end
					ItemRefTooltip:AddLine(Altoholic:GetClassColor(c.englishClass) .. CharacterName,1,1,1);
				end
			end
		end
	end
end

function Altoholic.Quests:GetTypeString(tag, size)
	local color

	if size == 2 then
		color = GREEN
	elseif size == 3 then
		color = YELLOW
	elseif size == 4 then
		color = ORANGE
	elseif size == 5 then
		color = RED
	end

	if color then
		return format("%s%s%s (%d)", WHITE, tag, color, size)
	else
		return format("%s%s", WHITE, tag)
	end
end

function Altoholic.Quests:Link_OnEnter(self)
	local id = self:GetID()
	if id == 0 then return end

	local player = V.CurrentAlt
	local r = Altoholic:GetRealmTable()
	local link = r.char[player].questlog[id].link
	if not link then return end

	GameTooltip:ClearLines();
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetHyperlink(link);
	GameTooltip:AddLine(" ",1,1,1);
	
	local _, questID, level = Altoholic.Quests:GetInfo(link)
	GameTooltip:AddDoubleLine(LEVEL .. ": |cFF00FF9A" .. level, L["QuestID"] .. ": |cFF00FF9A" .. questID);
	
	local bOtherCharsOnQuest		-- is there at least one other char on the quest ?
	
	for CharacterName, c in pairs(r.char) do		-- browse all chars on this realm ..
		if CharacterName ~= player then				-- .. skip current char of course
			for index, q in pairs(c.questlog) do	-- parse all quests
				local _, altQuestID = Altoholic.Quests:GetInfo(q.link)
				if altQuestID == questID then
					if not bOtherCharsOnQuest then
						GameTooltip:AddLine(" ",1,1,1);
						GameTooltip:AddLine(GREEN .. L["Are also on this quest:"],1,1,1);
						bOtherCharsOnQuest = true	-- pass here only once
					end
					GameTooltip:AddLine(Altoholic:GetClassColor(c.englishClass) .. CharacterName,1,1,1);
				end
			end
		end
	end
	
	GameTooltip:Show();
end

function Altoholic.Quests:Scan()
	local c = Altoholic.ThisCharacter
	local q = c.questlog

	Altoholic:ClearTable(q)

	local currentSelection = GetQuestLogSelection()		-- save the currently selected quest
	local headersState = {} 	-- save the state of headers, restore it after scan
	
	for i = GetNumQuestLogEntries(), 1, -1 do
		local title, _, _, _, isHeader, isCollapsed = GetQuestLogTitle(i);
		if isHeader and isCollapsed then
			headersState[title] = isCollapsed
			ExpandQuestHeader(i)
		end
	end

	for i = 1, GetNumQuestLogEntries() do
		local title, _, questTag, groupSize, isHeader, _, isComplete = GetQuestLogTitle(i);
		if not isHeader then
			q[i].link = GetQuestLink(i)
			q[i].tag = questTag
			q[i].groupsize = groupSize
			q[i].isComplete = isComplete
			
			SelectQuestLogEntry(i);
			q[i].money= GetQuestLogRewardMoney();
		else
			q[i].name = title
			q[i].isHeader = true
		end
	end
	
	-- restore headers
	for i = GetNumQuestLogEntries(), 1, -1 do
		local title, _, _, _, isHeader = GetQuestLogTitle(i);
		if isHeader and headersState[title] then
			CollapseQuestHeader(i)
		end
	end
	
	SelectQuestLogEntry(currentSelection)		-- restore the selection to match the cursor, must be properly set if a user abandons a quest
end

-- *** EVENT HANDLERS ***

function Altoholic.Quests:OnLogChanged()		-- triggered when accepting/validating a quest .. but too soon to refresh data
	Altoholic:RegisterEvent("QUEST_LOG_UPDATE", Altoholic.Quests.OnLogUpdate)			-- so register for this one ..
end

function Altoholic.Quests:OnLogUpdate()
	Altoholic:UnregisterEvent("QUEST_LOG_UPDATE")		-- .. and unregister it right away, since we only want it to be processed once (and it's triggered way too often otherwise)
	Altoholic.Quests:Scan()
end
