local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local WHITE		= "|cFFFFFFFF"
local GRAY		= "|cFFBBBBBB"
local GREEN		= "|cFF00FF00"
local LIGHTBLUE = "|cFFB0B0FF"
local YELLOW	= "|cFFFFFF00"

local TABINFO_LINE = 0	-- Bank tab info line
local CHAR_LINE = 1		-- Character line

Altoholic.Guild.BankTabs = {}

function Altoholic.Guild.BankTabs:BuildView()
	
	self.view = self.view or {}
	Altoholic:ClearTable(self.view)
		
	local guild = Altoholic:GetThisGuild()
	if not guild then return end
	
	local line = 0
	
	for tabID, guildTab in pairs (guild.bank) do
		if guildTab.name then
			table.insert(self.view, {			-- insert an entry for the tab name
				linetype = line,
				isCollapsed = false,
				parentID = tabID
			} )
			
			line = line + 1
			
			for playerIndex, playerTable in pairs(Altoholic.Guild.Members.List) do
				if (playerTable.version ~= L["N/A"]) and 
					(playerTable.name ~= UnitName("player")) and playerTable.guildbank then		-- only take altoholic users into account
					
					for i=1, #playerTable.guildbank do
						if guildTab.name == playerTable.guildbank[i].name then
							table.insert(self.view, {
								linetype = line,
								parentID = playerIndex,
								tabIndex = i,
							} )
						end
					end
				end
			end
			
			line = line + 1
		end
	end
end

function Altoholic.Guild.BankTabs:Update()
	local VisibleLines = 14
	local frame = "AltoholicFrameGuildBankTabs"
	local entry = frame.."Entry"
	
	if #self.view == 0 then
		Altoholic:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 18)
		return
	end
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawAlts
	local i=1
	
	local guild = Altoholic:GetThisGuild()
	
	for line, v in pairs(self.view) do
		
		local lineType = mod(v.linetype, 2)
		
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if lineType == TABINFO_LINE then								-- then keep track of counters
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
			
			if lineType == TABINFO_LINE then
				
				if v.isCollapsed == false then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawAlts = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawAlts = false
				end

				local tab = guild.bank[v.parentID]
				local localTime
				localTime = format("%s%02d%s:%s%02d", GREEN, tab.ClientHour, WHITE, GREEN, tab.ClientMinute )
				
				_G[entry..i.."Collapse"]:Show()
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 25, 0)
				_G[entry..i.."NameNormalText"]:SetText(YELLOW..tab.name)
				_G[entry..i.."Client"]:SetText(format("%s%s %s", WHITE, tab.ClientDate, localTime))
				_G[entry..i.."Client"]:Show()
				_G[entry..i.."Server"]:SetText(format("%s%02d%s:%s%02d", GREEN, tab.ServerHour, WHITE, GREEN, tab.ServerMinute ))
				_G[entry..i.."Server"]:Show()
				_G[entry..i.."UpdateTab"]:Hide()
				
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			elseif DrawAlts then
				local c = Altoholic.Guild.Members.List[v.parentID]
				local s = c.guildbank[v.tabIndex]
				_G[entry..i.."Collapse"]:Hide()
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
				_G[entry..i.."NameNormalText"]:SetText(LIGHTBLUE..c.name)
				
				local localTime
				localTime = format("%s%02d%s:%s%02d", GREEN, s.ClientHour, WHITE, GREEN, s.ClientMinute )
				_G[entry..i.."Client"]:SetText(format("%s%s %s", GRAY, s.ClientDate, localTime))
				_G[entry..i.."Client"]:Show()
				_G[entry..i.."Server"]:SetText(format("%s%02d%s:%s%02d", GREEN, s.ServerHour, WHITE, GREEN, s.ServerMinute ))
				_G[entry..i.."Server"]:Show()
				_G[entry..i.."UpdateTab"]:Show()

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

function Altoholic.Guild.BankTabs:OnClick(self, button)
	if button ~= "LeftButton" then return end
	
	local line = self:GetParent():GetID()		-- get the id of the line that was clicked
	if line == 0 then return end		-- 0 is for hidden frames, should never happen
	
	local player =  Altoholic.Guild.BankTabs.view[line]
	local c = Altoholic.Guild.Members.List[player.parentID]
	local tab = c.guildbank[player.tabIndex]
	
	-- DEFAULT_CHAT_FRAME:AddMessage("requesting player " .. c.name)
	-- DEFAULT_CHAT_FRAME:AddMessage("tab " .. tab.name)
	
	if c.name == UnitName("player") then return end		-- do nothing if clicking on own alts

	Altoholic:Print(format(L["Requesting %s information from %s"], tab.name, c.name ))
	Altoholic.Comm.Guild:Whisper(c.name, 4, tab.name)		-- MSG_GUILD_BANKUPDATEREQUEST = 4
end

function Altoholic.Guild.BankTabs:OnEnter(self)
	local line = self:GetParent():GetID()		-- get the id of the line that was clicked
	if line == 0 then return end		-- 0 is for hidden frames, should never happen
	
	local player = Altoholic.Guild.BankTabs.view[line]
	local c = Altoholic.Guild.Members.List[player.parentID]
	local tab = c.guildbank[player.tabIndex]
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	
	AltoTooltip:AddLine(L["Guild Bank Remote Update"]);
	AltoTooltip:AddLine(format(L["Clicking this button will update\nyour local %s%s|r bank tab\nbased on %s%s's|r data"], LIGHTBLUE, tab.name, YELLOW, c.name),1,1,1);
	AltoTooltip:Show();
end
