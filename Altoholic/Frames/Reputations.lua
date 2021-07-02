local BF = LibStub("LibBabble-Faction-3.0"):GetLookupTable()
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local TEAL		= "|cFF00FF9A"
local YELLOW	= "|cFFFFFF00"
local ORANGE	= "|cFFFF7F00"

Altoholic.Reputations = {}

Altoholic.Reputations.RefTable = {
	-- Factions reference table, based on http://www.wowwiki.com/Factions
	-- a view with a similar structure (but only with required lines) will be build to make the reputations frame
	
	{ FACTION_ALLIANCE },
	BZ["Darnassus"],
	BF["Exodar"],
	BF["Gnomeregan Exiles"],
	BZ["Ironforge"],
	BF["Stormwind"],
	{ FACTION_HORDE },
	BF["Darkspear Trolls"],
	BZ["Orgrimmar"],
	BZ["Thunder Bluff"],
	BZ["Undercity"],
	BZ["Silvermoon City"],
	{ L["Alliance Forces"] },
	BF["The League of Arathor"],
	BF["Silverwing Sentinels"],
	BF["Stormpike Guard"],
	{ L["Horde Forces"] },
	BF["The Defilers"],
	BF["Warsong Outriders"],
	BF["Frostwolf Clan"],
	{ L["Steamwheedle Cartel"] },
	BZ["Booty Bay"],
	BZ["Everlook"],
	BZ["Gadgetzan"],
	BZ["Ratchet"],
	{ BZ["Outland"] },
	BF["Ashtongue Deathsworn"],
	BF["Cenarion Expedition"],
	BF["The Consortium"],
	BF["Honor Hold"],
	BF["Kurenai"],
	BF["The Mag'har"],
	BF["Netherwing"],
	BF["Ogri'la"],
	BF["Sporeggar"],
	BF["Thrallmar"],
	{ BZ["Shattrath City"] },
	BF["Lower City"],
	BF["Sha'tari Skyguard"],
	BF["Shattered Sun Offensive"],
	BF["The Aldor"],
	BF["The Scryers"],
	BF["The Sha'tar"],

	-- *** Wotlk ***
	-- TO DO: once more data are available, make sure that all translations are in libfactions, categorize properly.
	{ "Wrath of the Lick King" },
	BF["Argent Crusade"],
	BF["Kirin Tor"],
	BF["The Kalu'ak"],
	BF["The Wyrmrest Accord"],
	BF["The Sunreavers"],
	BF["Knights of the Ebon Blade"],
	BF["The Sons of Hodir"],
	{ BF["Alliance Vanguard"] },
	BF["Alliance Vanguard"],
	BF["Explorers' League"],
	BF["The Frostborn"],
	BF["The Silver Covenant"],
	BF["Valiance Expedition"],
	{ BF["Horde Expedition"] },
	BF["Horde Expedition"],
	BF["The Hand of Vengeance"],
	BF["The Taunka"],
	BF["Warsong Offensive"],
	{ BZ["Sholazar Basin"] },
	BF["Frenzyheart Tribe"],
	BF["The Oracles"],

	-- ** end wotlk **

	{ L["Other"] },
	BF["Argent Dawn"],
	BF["Bloodsail Buccaneers"],
	BF["Brood of Nozdormu"],
	BF["Cenarion Circle"],
	BF["Darkmoon Faire"],
	BF["Gelkis Clan Centaur"],
	BF["Hydraxian Waterlords"],
	BF["Keepers of Time"],
	BF["Magram Clan Centaur"],
	BF["Ravenholdt"],
	BF["The Scale of the Sands"],
	BF["Shen'dralar"],
	BF["Syndicate"],
	BF["Thorium Brotherhood"],
	BF["Timbermaw Hold"],
	BF["Tranquillien"],
	BF["Wintersaber Trainers"],
	BF["The Violet Eye"],
	BF["Zandalar Tribe"]
}

function Altoholic.Reputations:BuildView()
	local r = Altoholic:GetRealmTable()
	local repDB = r.reputation
	
	self.view = self.view or {}
	Altoholic:ClearTable(self.view)
	
	local factionGroup
	for i, f in pairs(self.RefTable) do		-- browse the reference table
		if type(f) == "string" then		-- is the entry a string or a table ?
			for repName, _ in pairs(repDB) do
				if repName == f then			-- if the current rep from the reference table exists in the DB ..
					if factionGroup ~= nil then
						table.insert(self.view, {			 	-- save the header table
							name = self.RefTable[factionGroup][1],
							isHeader = true,
							isCollapsed = false
						} )
						factionGroup = nil
					end
				
					table.insert(self.view, f)	-- then save the current line (a string)
					break
				end
			end
		else
			factionGroup = i		-- save the index of the last faction group encountered in the refTable
		end
	end
end

function Altoholic.Reputations:Update()
	local VisibleLines = 14
	local frame = "AltoholicFrameReputations"
	local entry = frame.."Entry"
		
	AltoholicTabCharactersStatus:SetText("")
	
	local r = Altoholic:GetRealmTable()
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawFactionGroup
	
	i=1
	for line, s in pairs(self.view) do
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if type(s) == "table" then								-- then keep track of counters
				if s.isCollapsed == false then
					DrawFactionGroup = true
				else
					DrawFactionGroup = false
				end
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif DrawFactionGroup then
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			end
		else		-- line will be displayed
			if type(s) == "table" then
				if s.isCollapsed == false then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawFactionGroup = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawFactionGroup = false
				end
				_G[entry..i.."Collapse"]:Show()

				_G[entry..i.."Name"]:SetText(s.name)
				_G[entry..i.."Name"]:SetJustifyH("LEFT")
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 25, 0)

				for j=1, 10 do		-- hide the 10 rep buttons
					itemButton = _G[entry.. i .. "Item" .. j];
					itemButton.CharName = nil
					itemButton:Hide()
				end
				
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			elseif DrawFactionGroup then
				local rep = r.reputation[s]
				
				_G[entry..i.."Collapse"]:Hide()
				_G[entry..i.."Name"]:SetText(WHITE .. s)
				_G[entry..i.."Name"]:SetJustifyH("RIGHT")
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
				
				local j = 1
				for CharacterName, c in pairs(r.char) do
					local itemName = entry.. i .. "Item" .. j;
					local itemButton = _G[itemName];
					
					if rep and rep[CharacterName] then		-- if the current char has info for this faction ..
						local bottom, _, _, rate = self:GetInfo(rep[CharacterName])

						_G[itemName .. "Name"]:SetText(format("%2d", floor(rate)) .. "%")

						if bottom == -42000 then
							_G[itemName .. "Name"]:SetTextColor(0.8, 0.13, 0.13)
						elseif bottom == -6000 then
							_G[itemName .. "Name"]:SetTextColor(1.0, 0.0, 0.0)
						elseif bottom == -3000 then
							_G[itemName .. "Name"]:SetTextColor(0.93, 0.4, 0.13)
						elseif bottom == 0 then
							_G[itemName .. "Name"]:SetTextColor(1.0, 1.0, 0.0)
						elseif bottom == 3000 then
							_G[itemName .. "Name"]:SetTextColor(0.0, 1.0, 0.0)
						elseif bottom == 9000 then
							_G[itemName .. "Name"]:SetTextColor(0.0, 1.0, 0.53)
						elseif bottom == 21000 then
							_G[itemName .. "Name"]:SetTextColor(0.0, 1.0, 0.8)
						elseif bottom == 42000 then
							_G[itemName .. "Name"]:SetTextColor(0.0, 1.0, 1.0)
						end
						itemButton.CharName = CharacterName
						itemButton:Show()
					else
						itemButton.CharName = nil
						itemButton:Hide()
					end
					j = j + 1
				end
				
				while j <= 10 do
					_G[ entry.. i .. "Item" .. j ]:Hide()
					_G[ entry.. i .. "Item" .. j ].CharName = nil
					j = j + 1
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

	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleCount, VisibleLines, 41);
end

function Altoholic.Reputations:OnEnter(self)
	if not self.CharName then return end
	
	local r = Altoholic:GetRealmTable()
	local repName = Altoholic.Reputations:GetName( self:GetParent():GetID() )
	local charName = self.CharName
	local c = r.char[charName]
	local bottom, top, earned, rate = Altoholic.Reputations:GetInfo( r.reputation[repName][charName] )
	
	AltoTooltip:SetOwner(self, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	AltoTooltip:AddLine(Altoholic:GetClassColor(c.englishClass) .. charName 
			.. WHITE .. " @ " ..	TEAL .. repName,1,1,1);

	local repLevel = Altoholic.Reputations:GetLevelString(bottom)
	AltoTooltip:AddLine(repLevel .. ": " ..(earned - bottom) .. "/" .. (top - bottom) 
				.. YELLOW .. " (" .. format("%d", floor(rate)) .. "%)",1,1,1);
				
	local suggestion = Altoholic:GetSuggestion(repName, bottom)
	if suggestion then
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddLine("Suggestion: ",1,1,1);
		AltoTooltip:AddLine(TEAL .. suggestion,1,1,1);
	end
	
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL1, 0.8, 0.13, 0.13);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL2, 1.0, 0.0, 0.0);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL3, 0.93, 0.4, 0.13);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL4, 1.0, 1.0, 0.0);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL5, 0.0, 1.0, 0.0);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL6, 0.0, 1.0, 0.53);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL7, 0.0, 1.0, 0.8);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL8, 0.0, 1.0, 1.0);
	
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(GREEN .. L["Shift-Click to link this info"],1,1,1);
	AltoTooltip:Show();
end

function Altoholic.Reputations:GetName(id)
	return self.view[id]
end

function Altoholic.Reputations:OnClick(self, button)
	local repID = self:GetParent():GetID()
	local charName = self.CharName
	if not charName then return end
	
	local self = Altoholic.Reputations
	
	local r = Altoholic:GetRealmTable()
	local bottom, top, earned = self:GetInfo( r.reputation[self.view[repID]][charName] )
	local repLevel = Altoholic.Reputations:GetLevelString(bottom)
	
	if ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		if ( ChatFrameEditBox:IsShown() ) then
			ChatFrameEditBox:Insert(charName .. L[" is "] .. repLevel
			.. L[" with "] .. self.view[repID] .. " (" 
			.. (earned - bottom) .. "/" .. (top - bottom) .. ")");
		end
	end	
end

function Altoholic.Reputations:Scan()
	local r = Altoholic.ThisRealm
	
	local headersState = {} 	-- save the state of headers, restore it after scan
	
	for i = GetNumFactions(), 1, -1 do		-- 1st pass, expand all headers (from last to first), otherwise data can't be collected
		local name, _, _, _, _, _, _,	_, isHeader, isCollapsed = GetFactionInfo(i)
		if isHeader and isCollapsed then
			headersState[name] = isCollapsed
			ExpandFactionHeader(i)
		end
	end

	for i = 1, GetNumFactions() do		-- 2nd pass, data collection
		local name, _, _, bottom, top, earned, _,	_, isHeader, _, hasRep = GetFactionInfo(i)
		if (not isHeader) or (isHeader and hasRep) then
			-- new in 3.0.2, headers may have rep, ex: alliance vanguard + horde expedition
			r.reputation[name][UnitName("player")] = bottom .. "|" .. top .. "|" .. earned
		end
	end
	
	-- restore headers
	for i = GetNumFactions(), 1, -1 do
		local name, _, _, _, _, _, _,	_, isHeader = GetFactionInfo(i)
		if isHeader and headersState[name] then
			CollapseFactionHeader(i)
		end
	end
end

function Altoholic.Reputations:GetInfo(repString)
	-- From "3000|9000|7680" .. returns the numeric values + rate to the caller
	local bottom, top, earned = strsplit("|", repString)
	bottom = tonumber(bottom)
	top = tonumber(top)
	earned = tonumber(earned)
	local rate = (earned - bottom) / (top - bottom) * 100
	
	return bottom, top, earned, rate
end

function Altoholic.Reputations:GetLevelString(bottom)
	if bottom == -42000 then
		return FACTION_STANDING_LABEL1 -- "Hated"
	elseif bottom == -6000 then
		return FACTION_STANDING_LABEL2 -- "Hostile"
	elseif bottom == -3000 then
		return FACTION_STANDING_LABEL3 -- "Unfriendly"
	elseif bottom == 0 then
		return FACTION_STANDING_LABEL4 -- "Neutral"
	elseif bottom == 3000 then
		return FACTION_STANDING_LABEL5 -- "Friendly"
	elseif bottom == 9000 then
		return FACTION_STANDING_LABEL6 -- "Honored"
	elseif bottom == 21000 then
		return FACTION_STANDING_LABEL7 -- "Revered"
	elseif bottom == 42000 then
		return FACTION_STANDING_LABEL8 -- "Exalted"
	end
end
