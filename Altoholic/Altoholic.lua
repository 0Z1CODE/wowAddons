--[[	*** Altoholic ***
Written by : Thaoky, EU-Marécages de Zangar
--]]

local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()

local V = Altoholic.vars
Altoholic.Version = "v3.1.002b"

local WHITE		= "|cFFFFFFFF"
local RED		= "|cFFFF0000"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"
local ORANGE	= "|cFFFF7F00"
local TEAL		= "|cFF00FF9A"
local GOLD		= "|cFFFFD700"

Altoholic.ProfessionSpellID = {
	[BI["Alchemy"]] = 2259,
	[BI["Blacksmithing"]] = 3100,
	[BI["Cooking"]] = 2550,
	[BI["Enchanting"]] = 7411,
	[BI["Engineering"]] = 4036,
	[BI["First Aid"]] = 3279,
	[BI["Jewelcrafting"]] = 25229,
	[BI["Leatherworking"]] = 2108,
	[BI["Tailoring"]] = 3908,
	[L["Inscription"]] = 45357,
	[L["Skinning"]] = 8613,
	[L["Mining"]] = 2575,
	[L["Herbalism"]] = 2366,
	[BI["Fishing"]] = 7733,
}

Altoholic.ClassInfo = {
	["MAGE"] = "|cFF69CCF0",
	["WARRIOR"] = "|cFFC79C6E",
	["HUNTER"] = "|cFFABD473",
	["ROGUE"] = "|cFFFFF569",
	["WARLOCK"] = "|cFF9482CA", 
	["DRUID"] = "|cFFFF7D0A", 
	["SHAMAN"] = "|cFF2459FF",
	["PALADIN"] = "|cFFF58CBA", 
	["PRIEST"] = WHITE,
	["DEATHKNIGHT"] = "|cFFC41F3B"
}

local function Hook_LinkWrangler (frame)
	local name, link = frame:GetItem ()
	if name and link then
		Altoholic:ProcessTooltip(frame, name, link)
	end
end

local THIS_ACCOUNT = "Default"
local MSG_GUILD_ANNOUNCELOGIN		= 1
local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2

function Altoholic:OnEnable()
	self.Profiler:Init()
	
	self:RegisterEvent("PLAYER_ALIVE")
	self:RegisterEvent("PLAYER_LEVEL_UP")
	self:RegisterEvent("PLAYER_MONEY")
	self:RegisterEvent("PLAYER_XP_UPDATE")
	self:RegisterEvent("PLAYER_LOGOUT")
	self:RegisterEvent("PLAYER_UPDATE_RESTING")
	self:RegisterEvent("PLAYER_GUILD_UPDATE")		-- for gkick, gquit, etc..
	
	self:RegisterEvent("UPDATE_INSTANCE_INFO", "UpdateRaidTimers")
	self:RegisterEvent("RAID_INSTANCE_WELCOME", "RequestUpdateRaidInfo")
	
	self:RegisterEvent("ZONE_CHANGED", "UpdatePlayerLocation")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "UpdatePlayerLocation")
	self:RegisterEvent("ZONE_CHANGED_INDOORS", "UpdatePlayerLocation")
	
	self:RegisterEvent("TIME_PLAYED_MSG")
	
	self:RegisterEvent("BANKFRAME_OPENED", Altoholic.Containers.OnBankOpened)
	self:RegisterEvent("GUILDBANKFRAME_OPENED", Altoholic.GuildBank.OnOpen)
	self:RegisterEvent("AUCTION_HOUSE_SHOW", Altoholic.AuctionHouse.OnShow)
	
	self:RegisterEvent("PLAYER_TALENT_UPDATE");
	self:RegisterEvent("MAIL_SHOW", Altoholic.Mail.OnShow)
	
	AltoholicFrameName:SetText("Altoholic |cFFFFFFFF".. Altoholic.Version .. " by |cFF69CCF0Thaoky")

	local realm = GetRealmName()
	local player = UnitName("player")
	
	self.ThisAccount = Altoholic.db.global.data[THIS_ACCOUNT]
	self.ThisRealm = self.ThisAccount[realm]
	self.ThisCharacter = self.ThisRealm.char[player]
	
	Altoholic:SetCurrentCharacter(player)
	Altoholic:SetCurrentRealm(realm)
	Altoholic:SetCurrentAccount(THIS_ACCOUNT)

	local c = Altoholic.ThisCharacter
	c.lastlogout = 0
	c.faction = UnitFactionGroup("player")
	
	-- Summary tab DDM
	UIDropDownMenu_SetSelectedValue(AltoholicTabSummary_SelectLocation, self.Options:Get("TabSummaryMode"))
	UIDropDownMenu_SetText(AltoholicTabSummary_SelectLocation, select(self.Options:Get("TabSummaryMode"), L["This realm"], L["All realms"], L["All accounts"]))

	UIDropDownMenu_Initialize(AltoholicTabSummary_SelectLocation, function(self) 
		AltoholicTabSummary:SelectLocation_Initialize();
	end)

	AltoholicTabCharacters:Initialize()
	AltoholicFrameContainers:Initialize()
	AltoholicFramePets:Initialize()

	UIDropDownMenu_Initialize(AltoholicTabGuildBank_SelectGuild, function(self) 
		AltoholicTabGuildBank:SelectGuildDropDown_Initialize();
	end)
	
	
	-- do not move this one into the frame's OnLoad
	UIDropDownMenu_Initialize(AltoholicFrameEquipmentRightClickMenu, Equipment_RightClickMenu_OnLoad, "MENU");
	
	
	RequestTimePlayed()	-- trigger a TIME_PLAYED_MSG event if playtime is unavailable for this character
	
	-- *** Create Scroll Frames' children lines ***
	self:CreateScrollLines("AltoholicFrameSummary", "CharacterSummaryTemplate", 14);
	self:CreateScrollLines("AltoholicFrameBagUsage", "BagUsageTemplate", 14);
	self:CreateScrollLines("AltoholicFrameContainers", "ContainerTemplate", 7, 14);
	
	-- guild bank frames
	local p = _G[ "AltoGuildBank" ]					-- parent frame
	local e = "GuildBankEntry"
	local f = CreateFrame("Button", e .. 1, p, "ContainerTemplate")
	f:SetPoint("TOPLEFT", p, "TOPLEFT", 0, 0)
	
	for i = 2, 7 do
		f = CreateFrame("Button", e .. i, p, "ContainerTemplate")
		f:SetPoint("TOPLEFT", e .. (i-1), "BOTTOMLEFT", 0, 0)
	end
	
	for i=1, 7 do
		_G[e..i.."Item14"]:SetPoint("BOTTOMRIGHT", e..i, "BOTTOMRIGHT", -15, 0);
		for j=13, 1, -1 do
			_G[e..i.."Item" .. j]:SetPoint("BOTTOMRIGHT", e..i.."Item" .. (j + 1), "BOTTOMLEFT", -5, 0);
		end
	end		

	self:CreateScrollLines("AltoholicFrameMail", "MailEntryTemplate", 7);
	self:CreateScrollLines("AltoholicFrameSearch", "SearchEntryTemplate", 7);
	self:CreateScrollLines("AltoholicFrameEquipment", "EquipmentEntryTemplate", 7, 10);

	-- Manually fill the reputation frame
	local frame = "AltoholicFrameReputations"
	f = CreateFrame("Button", frame .. "Entry" .. 1, _G[frame], "ReputationEntryTemplate")
	f:SetPoint("TOPLEFT", frame .. "ScrollFrame", "TOPLEFT", 3, 3)
	
	for i = 2, 14 do
		f = CreateFrame("Button", frame .. "Entry" .. i, _G[frame], "ReputationEntryTemplate")
		f:SetPoint("TOPLEFT", frame .. "Entry" .. (i-1), "BOTTOMLEFT", 0, 0)
	end
	
	for i=1, 14 do
		_G[frame.."Entry"..i.."Item10"]:SetPoint("BOTTOMRIGHT", frame .. "Entry"..i, "BOTTOMRIGHT", -15, 0);
		for j=9, 1, -1 do
			_G[frame.."Entry"..i.."Item" .. j]:SetPoint("BOTTOMRIGHT", frame.."Entry"..i.."Item" .. (j + 1), "BOTTOMLEFT", -5, 0);
		end
	end
	
	-- do the same for achievements
	local frame = "AltoholicFrameAchievements"
	f = CreateFrame("Button", frame .. "Entry" .. 1, _G[frame], "AchievementEntryTemplate")
	f:SetPoint("TOPLEFT", frame .. "ScrollFrame", "TOPLEFT", 3, 3)
	
	for i = 2, 8 do
		f = CreateFrame("Button", frame .. "Entry" .. i, _G[frame], "AchievementEntryTemplate")
		f:SetPoint("TOPLEFT", frame .. "Entry" .. (i-1), "BOTTOMLEFT", 0, 0)
	end
	
	for i=1, 8 do
		_G[frame.."Entry"..i.."Item10"]:SetPoint("BOTTOMRIGHT", frame .. "Entry"..i, "BOTTOMRIGHT", -15, 0);
		for j=9, 1, -1 do
			_G[frame.."Entry"..i.."Item" .. j]:SetPoint("BOTTOMRIGHT", frame.."Entry"..i.."Item" .. (j + 1), "BOTTOMLEFT", -5, 0);
		end
	end
	
	-- reuse achievement templates for pet/mounts all-in-one view
	frame = "AltoholicFramePetsAllInOne"
	f = CreateFrame("Button", frame .. "Entry" .. 1, _G[frame], "AchievementEntryTemplate")
	f:SetPoint("TOPLEFT", frame .. "ScrollFrame", "TOPLEFT", 3, 3)
	
	for i = 2, 8 do
		f = CreateFrame("Button", frame .. "Entry" .. i, _G[frame], "AchievementEntryTemplate")
		f:SetPoint("TOPLEFT", frame .. "Entry" .. (i-1), "BOTTOMLEFT", 0, 0)
	end
	
	for i=1, 8 do
		_G[frame.."Entry"..i.."Item10"]:SetPoint("BOTTOMRIGHT", frame .. "Entry"..i, "BOTTOMRIGHT", -15, 0);
		for j=9, 1, -1 do
			_G[frame.."Entry"..i.."Item" .. j]:SetPoint("BOTTOMRIGHT", frame.."Entry"..i.."Item" .. (j + 1), "BOTTOMLEFT", -5, 0);
		end
	end
	

	_G["AltoholicFrameClassesItem10"]:SetPoint("BOTTOMRIGHT", "AltoholicFrameClasses", "BOTTOMRIGHT", -15, 0);
	for j=9, 1, -1 do
		_G["AltoholicFrameClassesItem" .. j]:SetPoint("BOTTOMRIGHT", "AltoholicFrameClassesItem" .. (j + 1), "BOTTOMLEFT", -5, 0);
	end
	
	self:CreateScrollLines("AltoholicFrameSkills", "SkillsTemplate", 14);
	self:CreateScrollLines("AltoholicFrameActivity", "ActivityTemplate", 14);
	self:CreateScrollLines("AltoholicFrameGuildMembers", "GuildMembersTemplate", 14);
	self:CreateScrollLines("AltoholicFrameGuildProfessions", "GuildProfessionsTemplate", 14);
	self:CreateScrollLines("AltoholicFrameGuildBankTabs", "GuildBankTabsTemplate", 14);
	self:CreateScrollLines("AltoholicFrameQuests", "QuestEntryTemplate", 14);
	self:CreateScrollLines("AltoholicFrameRecipes", "RecipesEntryTemplate", 14);
	self:CreateScrollLines("AltoholicFrameAuctions", "AuctionEntryTemplate", 7);

	self.Options:RestoreToUI()

	if Altoholic.Options:Get("ShowMinimap") == 1 then
		self:MoveMinimapIcon()
		AltoholicMinimapButton:Show();
	else
		AltoholicMinimapButton:Hide();
	end
	
	self.Containers:ScanPlayerBags()		-- manually update bags 0 to 4, then register the event
	self:RegisterEvent("BAG_UPDATE", self.Containers.OnBagUpdate)
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", self.Equipment.Scan)
	self:RegisterEvent("UNIT_QUEST_LOG_CHANGED", self.Quests.OnLogChanged)
	
	self:RegisterEvent("TRADE_SKILL_SHOW", self.TradeSkills.OnShow)
	self:RegisterEvent("CHAT_MSG_SKILL")
	
	self:RegisterEvent("COMPANION_UPDATE")
	self:RegisterEvent("ACHIEVEMENT_EARNED");
	self:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
	
	self:RegisterEvent("GLYPH_ADDED", Altoholic.Glyphs.Scan);
	self:RegisterEvent("GLYPH_REMOVED", Altoholic.Glyphs.Scan);
	self:RegisterEvent("GLYPH_UPDATED", Altoholic.Glyphs.Scan);
	
	self:RegisterEvent("CHAT_MSG_SYSTEM");
	
	self:RegisterEvent("UNIT_PET", Altoholic.Pets.OnChange);
--	self:RegisterEvent("LOCALPLAYER_PET_RENAMED");
	
	if IsInGuild() then
		self:RegisterEvent("GUILD_ROSTER_UPDATE", Altoholic.Guild.Members.OnRosterUpdate);
	end
	
	local currentGuild = GetGuildInfo("player")
	if not currentGuild then	-- if the player is not in a guild, set the drop down to the first guild available on this realm, if any.
		for GuildName, _ in pairs(Altoholic.db.global.data[THIS_ACCOUNT][GetRealmName()].guild) do
			currentGuild = GuildName
			break	-- if there's at least one guild, let's set the right value and break immediately
		end
	end
	
	if currentGuild then	-- if the current guild or at least a guild on this realm was found..set the right values
		UIDropDownMenu_SetSelectedValue(AltoholicTabGuildBank_SelectGuild, 
				THIS_ACCOUNT .. "|" .. GetRealmName() .."|".. currentGuild )
		UIDropDownMenu_SetText(AltoholicTabGuildBank_SelectGuild, 
				GREEN .. currentGuild .. WHITE .. " (" .. GetRealmName() .. ")"	)

		AltoholicTabGuildBank:LoadGuild(THIS_ACCOUNT, GetRealmName(), currentGuild)
	end
	
	self.UnsafeItems:BuildList()
	
	-- LinkWrangler supoprt
   if LinkWrangler then
      LinkWrangler.RegisterCallback ("Altoholic",  Hook_LinkWrangler, "refresh")
   end
	self.DoInitialBroadcast = true
	self.DoMailExpiryCheck = true	

	-- temporary fix to help Bean Counter's hooking the right mail function
	self.UpdatePlayerMail = self.Mail.Scan
	
	self:ConvertDB()
end

function Altoholic:OnDisable()
end

function Altoholic:ToggleUI()
	if (AltoholicFrame:IsVisible()) then
		AltoholicFrame:Hide();
	else
		AltoholicFrame:Show();
	end
end

function Altoholic:OnShow()
	self:UpdatePlayerStats()
	self.Containers:ScanPlayerBags()
	
	SetPortraitTexture(AltoholicFramePortrait, "player");	

	self.Reputations:BuildView()
	self:BuildCharacterInfoTable()
	self:BuildCharacterInfoView()
	
	AltoholicTabSummary:SummaryMenuOnClick(1)
end

function Altoholic:ConvertDB()
	local done = Altoholic.Options:Get("CraftDBConversionDone")
	if done then return end
	
	-- this converts all recipes from the old format (table) to the new (string) - huge memory gain
	local spellID
	for AccountName, a in pairs(Altoholic.db.global.data) do
		for RealmName, r in pairs(a) do
			for CharacterName, c in pairs(r.char) do	-- loop through all alts, all realms, all accounts
				-- convert professions
				for ProfessionName, p in pairs(c.recipes) do			
					if p.list then
						local corruptedList
						for index, craft in pairs(p.list) do
							
							if type(craft) == "table" then		-- old type = stored as table, new type = string
								if craft.isHeader then
									if craft.name then
										p.list[index] = "0^" .. craft.name
									else
										corruptedList = true
										break
									end
								else
									spellID = Altoholic:GetSpellIDFromLink(craft.link)
									p.list[index] = (craft.color or 4) .. "^" .. (craft.id or "") .. "^" .. spellID .. "^" .. craft.reagents
								end
							end
						end
						
						if corruptedList then
							p.ScanFailed = true	-- DB corruption detected, invalidate data
						end
					end
				end
				
				-- convert pets
				for PetType, PetTable in pairs(c.pets) do
					for index, p in pairs(PetTable) do
						if type(p) == "table" then
							PetTable[index] = p.name .. "|" .. p.spellID .. "|" .. string.gsub(p.icon, "Interface\\Icons\\", "") .. "|" .. p.modelID
						end
					end
				end
			end
		end
	end
	
	Altoholic.Options:Set("CraftDBConversionDone", true)
end


local SUMMARY_THISREALM = 1
local SUMMARY_ALLREALMS = 2
local SUMMARY_ALLACCOUNTS = 3

function Altoholic:BuildCharacterInfoTable()
	local money = 0
	local played = 0
	local levels = 0
	
	local mode = self.Options:Get("TabSummaryMode")
	self:ClearTable(Altoholic.CharacterInfo)
	
	local realmID = 0 -- will be required for sorting purposes

	-- The info table is static and contains characters of all realms on all accounts
	for AccountName, a in pairs(Altoholic.db.global.data) do
		for RealmName, _ in pairs(a) do
			local realmmoney, realmplayed, realmlevels = self:AddRealmTable(AccountName, RealmName, realmID)

			if mode == SUMMARY_THISREALM then
				-- if we show only this realm, then counters for other accounts or other realms are at 0
				if (AccountName ~= THIS_ACCOUNT) or (RealmName ~= GetRealmName()) then
					realmmoney = 0
					realmplayed = 0
					realmlevels = 0
				end
			elseif mode == SUMMARY_ALLREALMS then
				-- All realms, but this account only
				if (AccountName ~= THIS_ACCOUNT) then
					realmmoney = 0
					realmplayed = 0
					realmlevels = 0
				end
			end

			money = money + realmmoney
			played = played + realmplayed
			levels = levels + realmlevels
			
			realmID = realmID + 1
		end
	end
	
	AltoholicFrameTotalLv:SetText(WHITE .. levels .. " |rLv")
	AltoholicFrameTotalGold:SetText(floor( money / 10000 ) .. "|cFFFFD700g")
	AltoholicFrameTotalPlayed:SetText(floor(played / 86400) .. "|cFFFFD700d")
end

function Altoholic:AddRealmTable(AccountName, RealmName, realmID)

	local comm = Altoholic.Comm.Sharing
	if comm.SharingInProgress then
		if comm.account == AccountName and RealmName == GetRealmName() then
			-- if we're trying to add the account+realm we're currently copying, then don't add it now.
			return 0, 0, 0
		end
	end

	local realmmoney = 0
	local realmplayed = 0
	local realmlevels = 0
	local realmBagSlots = 0
	local realmFreeBagSlots = 0
	local realmBankSlots = 0
	local realmFreeBankSlots = 0
	
	local SkillsCache = { {name = "", rank = 0}, {name = "", rank = 0} }
	
	table.insert(Altoholic.CharacterInfo, { linetype = INFO_REALM_LINE + (realmID*3),
		isCollapsed = false,
		account = AccountName,
		realm = RealmName
	} )
	
	local parentRealm = #Altoholic.CharacterInfo
	local r = self:GetRealmTable(RealmName, AccountName)
	
	for CharacterName, c in pairs(r.char) do
		SkillsCache[1].name = ""
		SkillsCache[1].rank = 0
		SkillsCache[1].spellID = nil
		SkillsCache[2].name = ""
		SkillsCache[2].rank = 0
		SkillsCache[2].spellID = nil

		local i = 1
		for SkillName, s in pairs(c.skill[L["Professions"]]) do
			SkillsCache[i].name = SkillName
			SkillsCache[i].rank = self.TradeSkills:GetRank(s)
			SkillsCache[i].spellID = self:GetProfessionSpellID(SkillName)
			i = i + 1
			
			if i > 2 then		-- it seems that under certain conditions, the loop continues after 2 professions.., so break
				break
			end
		end
		
		local sk = c.skill[L["Secondary Skills"]]
		
		table.insert(Altoholic.CharacterInfo, { linetype = INFO_CHARACTER_LINE + (realmID*3),
			name = CharacterName,
			parentID = parentRealm,
			skillName1 = SkillsCache[1].name,
			skillRank1 = SkillsCache[1].rank,
			spellID1 = SkillsCache[1].spellID,
			skillName2 = SkillsCache[2].name,
			skillRank2 = SkillsCache[2].rank,
			spellID2 = SkillsCache[2].spellID,
			cooking = self.TradeSkills:GetRank( sk[BI["Cooking"]] ),
			firstaid = self.TradeSkills:GetRank( sk[BI["First Aid"]] ),
			fishing = self.TradeSkills:GetRank( sk[BI["Fishing"]] ),
			riding = self.TradeSkills:GetRank( sk[L["Riding"]] ),
		} )

		realmlevels = realmlevels + c.level
		realmmoney = realmmoney + c.money
		realmplayed = realmplayed + c.played
		realmBagSlots = realmBagSlots + c.numBagSlots
		realmFreeBagSlots = realmFreeBagSlots + c.numFreeBagSlots
		realmBankSlots = realmBankSlots + c.numBankSlots
		realmFreeBankSlots = realmFreeBankSlots + c.numFreeBankSlots
	end		-- end char

	table.insert(Altoholic.CharacterInfo, { linetype = INFO_TOTAL_LINE + (realmID*3),
		parentID = parentRealm,
		level = WHITE .. realmlevels,
		money = self:GetMoneyString(realmmoney, WHITE),
		played = self:GetTimeString(realmplayed),
		bagSlots = realmBagSlots,
		freeBagSlots = realmFreeBagSlots,
		bankSlots = realmBankSlots,
		freeBankSlots = realmFreeBankSlots
	} )

	return realmmoney, realmplayed, realmlevels
end

function Altoholic:BuildCharacterInfoView()
	-- The character info index is a small table that basically indexes character info
	-- ex: character info contains data for 4 realms on two accounts, but the index only cares about the summary tab filter,
	-- and indexes just one realm, or one account
	
	local mode = self.Options:Get("TabSummaryMode")
	self:ClearTable(Altoholic.CharacterInfoView)
	
	if mode == SUMMARY_THISREALM then
		self:AddRealmView(THIS_ACCOUNT, GetRealmName())
	elseif mode == SUMMARY_ALLREALMS then
		for RealmName, _ in pairs(Altoholic.db.global.data[THIS_ACCOUNT]) do
			self:AddRealmView(THIS_ACCOUNT, RealmName)
		end
	elseif mode == SUMMARY_ALLACCOUNTS then
		for AccountName, a in pairs(Altoholic.db.global.data) do
			for RealmName, _ in pairs(a) do
				self:AddRealmView(AccountName, RealmName)
			end
		end
	end
end

function Altoholic:AddRealmView(AccountName, RealmName)
	for line, s in pairs(Altoholic.CharacterInfo) do
		if mod(s.linetype, 3) == INFO_REALM_LINE then
			if (s.account == AccountName) and (s.realm == RealmName) then
				-- insert index to current line (INFO_REALM_LINE)
				table.insert(Altoholic.CharacterInfoView, line)
				line = line + 1

				-- insert index to the rest of the realm 
				local linetype = mod(Altoholic.CharacterInfo[line].linetype, 3)
				while (linetype ~= INFO_REALM_LINE) do
					table.insert(Altoholic.CharacterInfoView, line)
					line = line + 1
					if line > #Altoholic.CharacterInfo then
						return
					end
					linetype = mod(Altoholic.CharacterInfo[line].linetype, 3)
				end
				return
			end
		end
	end
end

function Altoholic:SendPublicInfo(msgType, player, guildName)

	guildName = guildName or GetGuildInfo("player")
	
	local c = Altoholic.ThisCharacter
	local t = {
		name = UnitName("player"),					-- can be removed in a future release (like 4.0)
		level = c.level,								-- can be removed
		averageItemLvl = c.averageItemLvl,
		class = c.class,								-- can be removed
		englishClass = c.englishClass,			-- can be removed
		version = Altoholic.Version
	}
	
	local r = Altoholic.ThisRealm
	local SkillsCache = { {}, {}, {} }	-- 3 tables for prof 1, 2, cooking
	
	t.skills = {}
	for CharacterName, charTable in pairs(r.char) do
		-- broadcast the skills of all chars of the same realm, same guild
		if c.guildName and charTable.guildName then
			if c.guildName == charTable.guildName then
				for i = 1, 3 do 
					SkillsCache[i].link = nil
				end
				
				local i = 1
				for SkillName, s in pairs(charTable.skill[L["Professions"]]) do
					-- if there's a full link for this profession, use it
					if charTable.recipes[SkillName].FullLink then
						SkillsCache[i].link = charTable.recipes[SkillName].FullLink
					else
						SkillsCache[i].link = SkillName
					end
					i = i + 1
				end

				if charTable.recipes[BI["Cooking"]].FullLink then
					SkillsCache[3].link = charTable.recipes[BI["Cooking"]].FullLink
				end
				
				table.insert(t.skills, {
					name = CharacterName,
					level = charTable.level,							-- can be removed
					class = charTable.class,							-- can be removed
					englishClass = charTable.englishClass,			-- can be removed
					averageItemLvl = charTable.averageItemLvl,
					prof1link = SkillsCache[1].link,
					prof2link = SkillsCache[2].link,
					cookinglink = SkillsCache[3].link,
				})
			end
		end
	end
	
	-- GetGuildInfo("player") may not yet return a correct value at this point, so get it from the player table
	if r.guild[guildName] then		-- if faction is not nil, there's a known guild
		t.guildbank = {}
		
		for i=1, 6 do
			local tab = r.guild[guildName].bank[i]
		
			if tab.ClientDate then			-- if there's a client date, the tab can be sent
				table.insert(t.guildbank, {
					name = tab.name,
					ClientDate = tab.ClientDate,
					ClientHour = tab.ClientHour,
					ClientMinute = tab.ClientMinute,
					ServerHour = tab.ServerHour,
					ServerMinute = tab.ServerMinute
				})
			end
		end
	end
	
	if msgType == MSG_GUILD_ANNOUNCELOGIN then
		self.Comm.Guild:Broadcast(MSG_GUILD_ANNOUNCELOGIN, t)
	else
		self.Comm.Guild:Whisper(player, msgType, t)
	end
end

function Altoholic:UpdatePlayerStats()

	self:PLAYER_XP_UPDATE()
	self:PLAYER_UPDATE_RESTING()
	self:PLAYER_GUILD_UPDATE()
	self.Talents:Scan()
	self:UpdateSpells()
	self:UpdatePlayerSkills()
	self.Equipment:Scan()
	self:PLAYER_MONEY()
	self.Reputations:Scan()
	self.Quests:Scan()
	self:UpdatePVPStats()
	self:UpdateCompanions("CRITTER")
	self:UpdateCompanions("MOUNT")
	self:UpdateTokens()
	self.Glyphs:Scan()
	-- ** updates up to here take roughly 2ms altogether **
end

function Altoholic:UpdatePlayerSkills()
	local c = Altoholic.ThisCharacter
	
	if not c then return end

	for i = GetNumSkillLines(), 1, -1 do		-- 1st pass, expand all categories
		local _, isHeader = GetSkillLineInfo(i)
		if isHeader then
			ExpandSkillHeader(i)
		end
	end

	-- local category
	for i = 1, GetNumSkillLines() do
		local skillName, isHeader, _, skillRank, _, _, skillMaxRank = GetSkillLineInfo(i)
		if isHeader then
			category = skillName
		else
			if category and skillName then
				c.skill[category][skillName] = skillRank .. "|" .. skillMaxRank
				if category == L["Professions"] or category == L["Secondary Skills"] then
					-- should be nil anyway for fishing, mining, etc..
					local newLink = select(2, GetSpellLink(skillName))
					if newLink then		-- sometimes a nil value may be returned, so keep the old one if nil
						c.recipes[skillName].FullLink = newLink
					end
				end
			end
		end
	end
end

function Altoholic:UpdatePVPStats()
	local c = Altoholic.ThisCharacter
	
	c.pvp_hk, c.pvp_dk = GetPVPLifetimeStats()
	c.pvp_ArenaPoints = GetArenaCurrency()
	c.pvp_HonorPoints = GetHonorCurrency()
end

function Altoholic:UpdateSpells()
	-- at this point, only check Cold Weather Flying
   local name, _, offset, numSpells = GetSpellTabInfo(1);
	
	if not name then return end

	local coldWeatherFlyingName = GetSpellInfo(54197)
	
	for s = offset + 1, offset + numSpells do
		local	spell = GetSpellName(s, BOOKTYPE_SPELL);
		
		if spell == coldWeatherFlyingName then
			local c = Altoholic.ThisCharacter
			c.coldWeatherFlying = true
			break
		end
	end
end

function Altoholic:UpdateRaidTimers()	
	local c = Altoholic.ThisCharacter
	
	self:ClearTable(c.SavedInstance)
	
	for i=1, GetNumSavedInstances() do
		local instanceName, instanceID, instanceReset, difficulty = GetSavedInstanceInfo(i)
		
		if difficulty > 1 then
			instanceName = instanceName .. L[" (Heroic)"]
		end
		
		c.SavedInstance[instanceName.. "|" .. instanceID ] =  instanceReset .. "|" .. time()
	end
end

function Altoholic:UpdateCompanions(companionType)
	local c = Altoholic.ThisCharacter
	local p = c.pets[companionType]
	
	self:ClearTable(p)
	
	for i = 1, GetNumCompanions(companionType) do
		local modelID, name, spellID, icon = GetCompanionInfo(companionType, i);
		if name and spellID and icon and modelID then
			p[i] = name .. "|" .. spellID .. "|" .. string.gsub(icon, "Interface\\Icons\\", "") .. "|" .. modelID
		end
	end
end

function Altoholic:UpdateTokens()
	
	for i = GetCurrencyListSize(), 1, -1 do		-- 1st pass, expand all headers (from last to first), otherwise data can't be collected
		local _, isHeader, isExpanded = GetCurrencyListInfo(i);
		if isHeader and not isExpanded then
			ExpandCurrencyList(i, 1)
		end
	end
	
	local r = Altoholic.ThisRealm
	
	for i = 1, GetCurrencyListSize() do
		local name, isHeader, _, _, _, count = GetCurrencyListInfo(i);
		count = (count or 0)
		if (name) and (not isHeader) and (count > 0) then	-- don't track if it's a header or if count = 0
			r.tokens[name][UnitName("player")] = count
		end
	end
end


-- *** DB functions ***

function Altoholic:GetCharacterTable(charName, realm, account)
	-- Usage: 
	-- 	local c = Altoholic:GetCharacterTable(char, realm, account)
	--	all 3 parameters default to current player, realm or account
	-- use this for features that have to work regardless of an alt's location (any realm, any account)
	charName = charName or V.CurrentAlt
	realm = realm or V.CurrentRealm
	account = account or V.CurrentAccount
	
	return Altoholic.db.global.data[account][realm].char[charName]
end

function Altoholic:GetCharacterTableByLine(line)
	-- shortcut to get the right character table based on the line number in the info table.
	
	local charName, realm, account = Altoholic:GetCharacterInfo(line)
	return Altoholic.db.global.data[account][realm].char[charName]
end

function Altoholic:GetRealmTable(realm, account)
	-- Usage: 
	-- 	local c = Altoholic:GetRealmTable(char, realm, account)
	--	both parameters default to current realm or account
	realm = realm or V.CurrentRealm
	account = account or V.CurrentAccount
	
	return Altoholic.db.global.data[account][realm]
end

function Altoholic:GetRealmTableByLine(line)
	-- shortcut to get the right realm table based on the line number in the info table.

	local _, realm, account = Altoholic:GetCharacterInfo(line)
	return Altoholic.db.global.data[account][realm]
end

function Altoholic:GetThisGuild()
	return Altoholic.db.global.data[THIS_ACCOUNT][GetRealmName()].guild[GetGuildInfo("player")]
end

function Altoholic:GetReferenceTable()
	return Altoholic.db.global.reference
end

function Altoholic:GetClassReferenceTable(class)
	return Altoholic.db.global.reference[class]
end

function Altoholic:SetCurrentCharacter(charName, realm, account)
	V.CurrentAlt = charName
	if realm then
		Altoholic:SetCurrentRealm(realm)
	end
	if account then
		Altoholic:SetCurrentAccount(account)
	end
end

function Altoholic:SetCurrentRealm(name)
	V.CurrentRealm = name
end

function Altoholic:SetCurrentAccount(name)
	V.CurrentAccount = name
end

function Altoholic:GetProfessions(charName, realm, account)
	-- return the two main professions of a character
	-- either prof1, prof2
	-- or prof1, nil
	-- or nil, nil
	local c = Altoholic:GetCharacterTable(charName, realm, account)
	
	local prof1, prof2
	for SkillName, _ in pairs(c.skill[L["Professions"]]) do
		if not prof1 then
			prof1 = SkillName
		elseif not prof2 then
			prof2 = SkillName
		end
	end
	return prof1, prof2
end

function Altoholic:IsProfessionKnown(profession, charName, realm, account)
	-- does an alt know this profession or not ?
	local c = Altoholic:GetCharacterTable(charName, realm, account)
	local professionType

	if (profession == BI["Cooking"]) or (profession == BI["First Aid"]) or (profession == BI["Fishing"]) then
		professionType = L["Secondary Skills"] 
	else
		professionType = L["Professions"]
	end
	
	if type(c.skill[professionType][profession]) == "nil" then
		return nil
	else
		return true
	end
end


-- *** Utility functions ***
function Altoholic:ClearTable(t)
	if type(t) ~= "table" then
		return
	end
	
	for k in pairs (t) do
		if type(t[k]) == "table" then
			self:ClearTable(t[k])
		end
		t[k] = nil
	end
end

function Altoholic:CopyTable(src, dest)
	for k, v in pairs (src) do
		if type(v) == "table" then
			dest[k] = {}
			self:CopyTable(v, dest[k])
		else
			dest[k] = v
		end
	end	
end

function Altoholic:ClearScrollFrame(name, entry, lines, height)
	for i=1, lines do					-- Hides all entries of the scrollframe, and updates it accordingly
		_G[ entry..i ]:Hide()
	end
	FauxScrollFrame_Update( name, lines, lines, height);
end

function Altoholic:CreateScrollLines(parentFrame, inheritsFrom, numLines, numItems)
	local f = CreateFrame("Button", parentFrame .. "Entry1", _G[parentFrame], inheritsFrom)
	f:SetPoint("TOPLEFT", parentFrame .. "ScrollFrame", "TOPLEFT", 0, 0)
	
	for i = 2, numLines do
		f = CreateFrame("Button", parentFrame .. "Entry" .. i, _G[parentFrame], inheritsFrom)
		f:SetPoint("TOPLEFT", parentFrame .. "Entry" .. (i-1), "BOTTOMLEFT", 0, 0)
	end
	
	if not numItems then return end
	
	for i=1, numLines do
		_G[parentFrame.."Entry"..i.."Item" .. numItems]:SetPoint("BOTTOMRIGHT", parentFrame .. "Entry"..i, "BOTTOMRIGHT", -15, 0);
		for j=(numItems-1), 1, -1 do
			_G[parentFrame.."Entry"..i.."Item" .. j]:SetPoint("BOTTOMRIGHT", parentFrame.."Entry"..i.."Item" .. (j + 1), "BOTTOMLEFT", -5, 0);
		end
	end
end

function Altoholic:Print(message, color)
	color = color or WHITE
	print(format("%sAltoholic: %s%s", TEAL, color, message))
end

function Altoholic:SetItemButtonTexture(button, texture, width, height)
	-- wrapper for SetItemButtonTexture from ItemButtonTemplate.lua
	width = width or 36
	height = height or 36

	local itemTexture = _G[button.."IconTexture"]
	
	itemTexture:SetWidth(36);
	itemTexture:SetHeight(36);
	itemTexture:SetAllPoints(_G[button]);
	
	SetItemButtonTexture(_G[button], texture)
end

function Altoholic:TextureToFontstring(name, width, height)
	return format("|T%s:%s:%s|t", name, width, height)
end

function Altoholic:GetSpellIcon(spellID)
	return select(3, GetSpellInfo(spellID))
end

function Altoholic:GetIDFromLink(link)
	return tonumber(link:match("item:(%d+)"))
end

function Altoholic:GetProfessionSpellID(name)
	return Altoholic.ProfessionSpellID[name]
end

function Altoholic:GetSpellIDFromLink(link)
	return tonumber(link:match("enchant:(%d+)"))
end

function Altoholic:GetSpellIDFromRecipeLink(link)
	-- returns nil if recipe id is not in the DB, returns the spellID otherwise
	local recipeID = self:GetIDFromLink(link)
	return self.RecipeDB[recipeID]
end

function Altoholic:GetCompanionSpellID(itemID)
	-- returns nil if  id is not in the DB, returns the spellID otherwise
	return Altoholic.Pets.CompanionToSpellID[itemID]
end

function Altoholic:GetMountSpellID(itemID)
	-- returns nil if  id is not in the DB, returns the spellID otherwise
	return Altoholic.Pets.MountToSpellID[itemID]
end


function Altoholic:GetEnchantInfo(link)
	local _, _, itemString = strsplit("|", link)
	local _, itemID, enchantId, jewelId1, jewelId2, jewelId3, 
					jewelId4, suffixId = strsplit(":", itemString)

	local isEnchanted = false
	-- note: don't try to replace this code with something like : tonumber(x) or tonumber(y) etc..conversions make it slower than what's below
	
	for i=1, 6 do	-- parse all arguments
		-- if not nil and differs from "0" .. item is enchanted
		if select(i, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId) and
			select(i, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId) ~= "0" then
			
			isEnchanted = true
			break
		end
	end
	
	return isEnchanted, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId
end

function Altoholic:GetMoneyString(copper, color)
	color = color or "|cFFFFD700"

	local gold = floor( copper / 10000 );
	copper = mod(copper, 10000)
	local silver = floor( copper / 100 );
	copper = mod(copper, 100)
	
	-- use this later, when it will be possible to use texcoords in a fontstring
	--DEFAULT_CHAT_FRAME:AddMessage("|TInterface\\MoneyFrame\\UI-MoneyIcons:30|t")
	
	return color .. gold .. "|cFFFFD700g " .. color .. silver .. "|cFFC7C7CFs " .. color .. copper .. "|cFFEDA55Fc"
end

function Altoholic:GetTimeString(seconds)
	local days = floor(seconds / 86400);				-- TotalTime is expressed in seconds
	seconds = mod(seconds, 86400)
	local hours = floor(seconds / 3600);
	seconds = mod(seconds, 3600)
	local minutes = floor(seconds / 60);
	seconds = mod(seconds, 60)
	
	local c1 = WHITE
	local c2 = "|r"

	return c1 .. days .. c2 .. "d " .. c1 .. hours .. c2 .. "h " .. c1 .. minutes .. c2 .. "m"
end

function Altoholic:ColourFaction(faction)
	if faction == "Alliance" then
		return "|cFF2459FF" .. FACTION_ALLIANCE
	else
		return "|cFFFF0000" .. FACTION_HORDE
	end
end

function Altoholic:GetFactionColour(faction)
	if faction == "Alliance" then
		return "|cFF2459FF"
	else
		return "|cFFFF0000"
	end
end

function Altoholic:GetClassColor(class)
	-- parameter should be the english class, as in :
	-- c.class, c.englishClass = UnitClass("player")

	return Altoholic.ClassInfo[class] or WHITE
end

function Altoholic:GetDelayInDays(delay)
	return floor((time() - delay) / 86400)
end

function Altoholic:FormatDelay(timeStamp)
	-- timeStamp = value when time() was last called for a given variable (ex: last time the mailbox was checked)
	if timeStamp == 0 then
		return YELLOW .. "N/A"
	end
	
	local seconds = (time() - timeStamp)
	
	-- 86400 seconds per day
	-- assuming 30 days / month = 2.592.000 seconds
	-- assuming 365 days / year = 31.536.000 seconds
	-- in the absence of possibility to track real dates, these approximations will have to do the trick, as it's not possible at this point to determine the number of days in a month, or in a year.

	local year = floor(seconds / 31536000);
	seconds = mod(seconds, 31536000)

	local month = floor(seconds / 2592000);
	seconds = mod(seconds, 2592000)

	local day = floor(seconds / 86400);
	seconds = mod(seconds, 86400)

	local hour = floor(seconds / 3600);
	seconds = mod(seconds, 3600)

	-- note: RecentTimeDate is not a direct API function, it's in UIParent.lua
	return RecentTimeDate(year, month, day, hour)
end

function Altoholic:GetRestedXP(maxXP, restXP, logout, isResting)
	-- get the known rate of rest xp (the one saved at last logout) + the rate represented by the elapsed time since last logout
	-- (elapsed time / 3600) * 0.625 * (2/3)  simplifies to elapsed time / 8640
	-- 0.625 comes from 8 hours rested = 5% of a level, *2/3 because 100% rested = 150% of xp (1.5 level)
	local rate = self:GetRestXPRate(maxXP, restXP)
	
	if logout ~= 0 then		-- time since last logout, 0 for current char, <> for all others
		if isResting then
			rate = rate + ((time() - logout) / 8640)
		else
			rate = rate + ((time() - logout) / 34560)	-- 4 times less if not at an inn
		end
	end

	local coeff = 1
	if Altoholic.Options:Get("RestXPMode") == 1 then
		coeff = 1.5
	end
	rate = rate * coeff
	
	-- second return value = the actual percentage of rest xp, as a numeric value (1 to 100, not 150)
	if rate >= (100 * coeff) then 
		return "|cFF00FF00" .. format("%d", (100 * coeff)) .. "%", 100
	else
		local color
		if rate < (30 * coeff) then
			color = "|cFFFF0000"
		elseif rate < (60 * coeff) then
			color = "|cFFFFFF00"
		else
			color = GREEN
		end
		return color .. format("%d", rate) .. "%", rate
	end
end

function Altoholic:GetRestXPRate(maxXP, restXP)

	-- after extensive tests, it seems that the known formula to calculate rest xp is incorrect.
	-- I believed that the maximum rest xp was exactly 1.5 level, and since 8 hours of rest = 5% of a level
	-- being 100% rested would mean having 150% xp .. but there's a trick...
	-- One would expect that 150% of rest xp would be split over the following levels, and that calculating the exact amount of rest
	-- would require taking into account that 30% are over the current level, 100% over lv+1, and the remaining 20% over lv+2 ..
	
	-- .. But that is not the case.Blizzard only takes into account 150% of rest xp AT THE CURRENT LEVEL RATE.
	-- ex: at level 15, it takes 13600 xp to go to 16, therefore the maximum attainable rest xp is:
	--	136 (1% of the level) * 150 = 20400 

	-- thus, to calculate the exact rate (ex at level 15): 
		-- divide xptonext by 100 : 		13600 / 100 = 136	==> 1% of the level
		-- multiply by 1.5				136 * 1.5 = 204
		-- divide rest xp by this value	20400 / 204 = 100	==> rest xp rate
		
	if not restXP then return 0 end
	return (restXP / ((maxXP / 100) * 1.5))
end

function Altoholic:GetCharacterInfo(line)
	-- with the line number in the Altoholic.CharacterInfo table, return the realm & account based on the parent id of this line
	local c = Altoholic.CharacterInfo[line]
	local p = Altoholic.CharacterInfo[ c.parentID ]
	return c.name, p.realm, p.account
end

function Altoholic:GetCharacterInfoLine(charName, realm, account)
	-- with the name of a character, returns the line number in the Altoholic.CharacterInfo table
	-- This prevents from saving the character name, realm and account in the search results table.

	for k, v in pairs(Altoholic.CharacterInfo) do
		if mod(v.linetype,3) == INFO_CHARACTER_LINE then
			local s = Altoholic.CharacterInfo[ v.parentID ] 
			if v.name == charName and s.account == account and s.realm == realm then 
				return k
			end
		end
	end
end

function Altoholic:GetGuildBankItemCount(searchedID, guildName, realm, account)

	local r = Altoholic:GetRealmTable(realm, account)

	local guildCount = 0
	for TabName, t in pairs(r.guild[guildName].bank) do
		for slotID, id in pairs(t.ids) do
			if (id) and (id == searchedID) then
				guildCount = guildCount + (t.counts[slotID] or 1)
			end
		end	-- end slots
	end	-- end tabs

	return guildCount
end

-- finally some decent code for the tooltip counters ...
local ItemCounts = {}
local ItemCountsLabels = {	L["Bags"], L["Bank"], L["AH"], L["Equipped"], L["Mail"] }

function Altoholic:GetCharacterItemCount(searchedID, charName, realm, account)
	
	-- keep a pointer to the character that will be scanned
	self.CountCharacter = self:GetCharacterTable(charName, realm, account)
	local c = self.CountCharacter

	ItemCounts[1], ItemCounts[2] = self.Containers:GetItemCount(searchedID)
	ItemCounts[3] = self.AuctionHouse:GetItemCount(searchedID)
	ItemCounts[4] = self.Equipment:GetItemCount(searchedID)
	ItemCounts[5] = self.Mail:GetItemCount(searchedID)
	
	local charCount = 0
	for _, v in ipairs(ItemCounts) do
		charCount = charCount + v
	end
	
	if charCount > 0 then
		local name = Altoholic:GetClassColor(c.englishClass) .. charName
		-- if after this call, the name is displayed in white for a class other than priest, there's a problem.
		-- 25/03/2009: I fixed a bug that caused invalid character entries to be automatically added to the DB due to Ace3 DB's magic wildcard.
		-- the issue happened when mousing over an achievement AFTER having changed realm, thereby creating new alts from another realm in the current one.
		-- the solution was to actually hide the buttons to prevent this from happening, but a better fix will be brought later when tabs will be reviewed.
		
		if account ~= THIS_ACCOUNT then
			name = name .. YELLOW .. " (" .. account .. ")"
		end
		
		local t = {}
		for k, v in ipairs(ItemCounts) do
			if v > 0 then	-- if there are more than 0 items in this container
				table.insert(t, WHITE .. ItemCountsLabels[k] .. ": "  .. TEAL .. v)
			end
		end

		-- charInfo should look like 	(Bags: 4, Bank: 8, Equipped: 1, Mail: 7), table concat takes care of this
		V.ItemCount[name] = format("%s (%s%s)", ORANGE .. charCount .. WHITE,
			table.concat(t, WHITE..", "), WHITE	)
	end
	
	self.CountCharacter = nil
	
	return charCount
end

function Altoholic:GetAccountItemCount(searchedID, account)
	
	local realm = GetRealmName()		-- implicit: this realm only
	local count = 0

	for CharacterName, c in pairs(Altoholic.db.global.data[account][realm].char) do
		if Altoholic.Options:Get("TooltipCrossFaction") == 1 then
			count = count + Altoholic:GetCharacterItemCount(searchedID, CharacterName, realm, account)
		else
			if	c.faction == UnitFactionGroup("player") then
				count = count + Altoholic:GetCharacterItemCount(searchedID, CharacterName, realm, account)
			end
		end
	end
	return count
end

function Altoholic:GetItemCount(searchedID)
	-- Return the total amount of times an item is present on this realm, and prepares the V.ItemCount table for later display by the tooltip

	V.ItemCount = V.ItemCount or {}
	self:ClearTable(V.ItemCount)

	local count = 0
	if Altoholic.Options:Get("TooltipMultiAccount") == 1 and not Altoholic.Comm.Sharing.SharingInProgress then
		for AccountName, a in pairs(Altoholic.db.global.data) do
			count = count + Altoholic:GetAccountItemCount(searchedID, AccountName)
		end
	else
		count = Altoholic:GetAccountItemCount(searchedID, THIS_ACCOUNT)
	end
	
	if Altoholic.Options:Get("TooltipGuildBank") == 1 then
		-- multi account ici
		for guildName, g in pairs(Altoholic.db.global.data[THIS_ACCOUNT][GetRealmName()].guild) do
			if not g.hideInTooltip then
				local guildCount = Altoholic:GetGuildBankItemCount(searchedID, guildName, GetRealmName(), THIS_ACCOUNT)
				if guildCount > 0 then
					V.ItemCount[GREEN .. guildName] = WHITE .. L["(Guild bank: "] .. TEAL .. guildCount .. WHITE .. ")"
				end
				
				if Altoholic.Options:Get("TooltipGuildBankCount") == 1 then
					count = count + guildCount
				end
			end	-- end if not hidden
		end	-- end guild
	end

	return count
end

function Altoholic:IsGatheringNode(name)
	-- returns the itemID if "name" is a known type of gathering node (mines & herbs)
	if not name then return nil end

	for k, v in pairs( self.Gathering ) do
		if name == k then
			return v
		end
	end
	return nil	-- not found, return nil
end

function Altoholic:GetSuggestion(index, level)
	if self.Suggestions[index] == nil then return nil end
	
	for k, v in pairs( self.Suggestions[index] ) do
		if level < v[1] then		-- the suggestions are sorted by level, so whenever we're below, return the text
			return v[2]
		end
	end
	return nil	-- already at max level, no suggestion
end

function Altoholic:UpdateSlider(name, text, field)
	local s = getglobal(name)
	getglobal(name .. "Text"):SetText(text .. " (" .. s:GetValue() ..")");

	if not Altoholic.db then return end
	local a = Altoholic.db.global
	if a == nil then return	end
	
	a.options[field] = s:GetValue()
	self:MoveMinimapIcon()
end

function Altoholic:ShowClassIcons()
	local r = Altoholic:GetRealmTable()
	local i = 1
	
	for CharacterName, c in pairs(r.char) do
		local itemName = "AltoholicFrameClassesItem" .. i;
		local itemButton = _G[itemName];
		itemButton:SetScript("OnEnter", function(self) 
				Altoholic:DrawCharacterTooltip(self, self.CharName)
			end)
		itemButton:SetScript("OnLeave", function(self) 
				AltoTooltip:Hide()
			end)
		itemButton:SetScript("OnClick", Altoholic_Equipment_OnClick)
		
		local tc = CLASS_ICON_TCOORDS[c.englishClass]
		local itemTexture = _G[itemName .. "IconTexture"]
		itemTexture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes");
		itemTexture:SetTexCoord(tc[1], tc[2], tc[3], tc[4]);
		itemTexture:SetWidth(36);
		itemTexture:SetHeight(36);
		itemTexture:SetAllPoints(itemButton);
		
		Altoholic:CreateButtonBorder(itemButton)

		if c.faction == "Alliance" then
			itemButton.border:SetVertexColor(0.1, 0.25, 1, 0.5)
		else
			itemButton.border:SetVertexColor(1, 0, 0, 0.5)
		end
		itemButton.border:Show()
		
		itemButton.CharName = CharacterName
		itemButton:Show()
		
		i = i + 1
	end
	
	while i <= 10 do
		_G[ "AltoholicFrameClassesItem" .. i ]:Hide()
		_G[ "AltoholicFrameClassesItem" .. i ].CharName = nil
		i = i + 1
	end
end

function Altoholic:CreateButtonBorder(frame)
	if frame.border ~= nil then return end

	-- this part was taken from Combuctor
	local border = frame:CreateTexture(nil, 'OVERLAY')
	border:SetWidth(67);
	border:SetHeight(67)
	border:SetPoint('CENTER', frame)
	border:SetTexture('Interface/Buttons/UI-ActionButton-Border')
	border:SetBlendMode('ADD')
	border:Hide()
	
	frame.border = border
end

function Altoholic:DrawCharacterTooltip(self, charName)
	local r = Altoholic:GetRealmTable()
	local c = r.char[charName]
	
	AltoTooltip:SetOwner(self, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();

	AltoTooltip:AddDoubleLine(Altoholic:GetClassColor(c.englishClass) .. charName, Altoholic:ColourFaction(c.faction))
	AltoTooltip:AddLine(L["Level"] .. " " .. GREEN .. c.level .. " |r".. c.race .. " " .. c.class,1,1,1);
	AltoTooltip:AddLine(L["Zone"] .. ": " .. GOLD .. c.zone .. " |r(" .. GOLD .. c.subzone .."|r)",1,1,1);
	if c.restxp then
		AltoTooltip:AddLine(L["Rest XP"] .. ": " .. GREEN .. c.restxp,1,1,1);
	end
	AltoTooltip:AddLine("Average iLevel: " .. GREEN .. format("%.1f", c.averageItemLvl),1,1,1);	
	if c.CompletedAchievements > 0 then
		AltoTooltip:AddLine(ACHIEVEMENTS_COMPLETED ..": " .. GREEN .. c.CompletedAchievements .. "/"..c.TotalAchievements)
		AltoTooltip:AddLine(ACHIEVEMENT_TITLE ..": " .. GREEN .. c.TotalAchievementPoints)
	end
	
	AltoTooltip:Show();
end


-- *** Hooks ***
local Orig_ChatEdit_InsertLink = ChatEdit_InsertLink

function ChatEdit_InsertLink(text, ...)
	if text and AltoholicFrame_SearchEditBox:IsVisible() then
		if not Altoholic.TradeSkills.isOpen then
			AltoholicFrame_SearchEditBox:Insert(GetItemInfo(text))
			return true
		end
	end
	return Orig_ChatEdit_InsertLink(text, ...)
end

-- ** GameTooltip Hooks **

local Orig_GameTooltip_SetItem = GameTooltip:GetScript("OnTooltipSetItem")
GameTooltip:SetScript("OnTooltipSetItem", function(tooltip, ...)
	if Orig_GameTooltip_SetItem then
		Orig_GameTooltip_SetItem(tooltip, ...)
	end

	if (not V.TooltipDone) and tooltip then
		local name, link = tooltip:GetItem()
		V.TooltipDone = true
		if link then
			Altoholic:ProcessTooltip(tooltip, name, link)
		end
	end
end)

local Orig_GameTooltip_ClearItem = GameTooltip:GetScript("OnTooltipCleared")
GameTooltip:SetScript("OnTooltipCleared", function(tooltip, ...)
	V.TooltipDone = nil
	return Orig_GameTooltip_ClearItem(tooltip, ...)
end)

local Orig_GameTooltip_OnShow = GameTooltip:GetScript("OnShow")
GameTooltip:SetScript("OnShow", function(...)

	if Orig_GameTooltip_OnShow then
		Orig_GameTooltip_OnShow(...)
	end	

	-- exit if player does not want counters for known gathering nodes
	if Altoholic.Options:Get("TooltipGatheringNode") == 0 then return end
	
	local itemID = Altoholic:IsGatheringNode( _G["GameTooltipTextLeft1"]:GetText() )
	if itemID and (itemID ~= V.ToolTipCachedItemID) then			-- is the item in the tooltip a known type of gathering node ?

		-- check player bags to see how many times he owns this item, and where
		if Altoholic.Options:Get("TooltipCount") == 1 or Altoholic.Options:Get("TooltipTotal") == 1 then
			V.ToolTipCachedCount = Altoholic:GetItemCount(itemID) -- if one of the 2 options is active, do the count
			if V.ToolTipCachedCount > 0 then
				V.ToolTipCachedTotal = GOLD .. L["Total owned"] .. ": |cff00ff9a" .. V.ToolTipCachedCount
			else
				V.ToolTipCachedTotal = nil
			end
		end		
		
		if (Altoholic.Options:Get("TooltipCount") == 1) and (V.ToolTipCachedCount > 0) then			-- add count per character
			GameTooltip:AddLine(" ",1,1,1);
			for CharacterName, c in pairs (V.ItemCount) do
				--GameTooltip:AddDoubleLine(CharacterName .. ":",  TEAL .. c);
				GameTooltip:AddDoubleLine(CharacterName,  TEAL .. c);
			end
		end
		
		if (Altoholic.Options:Get("TooltipTotal") == 1) and (V.ToolTipCachedTotal) then		-- add total count
			GameTooltip:AddLine(V.ToolTipCachedTotal,1,1,1);
		end		
	end
	
	GameTooltip:Show()
end)

local Orig_ItemRefTooltip_OnShow = ItemRefTooltip:GetScript("OnShow")
ItemRefTooltip:SetScript("OnShow", function(...)
	
	if Orig_ItemRefTooltip_OnShow then
		Orig_ItemRefTooltip_OnShow(...)
	end

	Altoholic.Quests:IsKnown( _G["ItemRefTooltipTextLeft1"]:GetText() )
	ItemRefTooltip:Show()
end)

local Orig_ItemRefTooltip_SetItem = ItemRefTooltip:GetScript("OnTooltipSetItem")
ItemRefTooltip:SetScript("OnTooltipSetItem", function(tooltip, ...)
	if Orig_ItemRefTooltip_SetItem then
		Orig_ItemRefTooltip_SetItem(tooltip, ...)
	end
	
	if (not V.TooltipDone) and tooltip then
		local name, link = tooltip:GetItem()
		V.TooltipDone = true
		if link then
			Altoholic:ProcessTooltip(tooltip, name, link)
		end
	end
end)

local Orig_ItemRefTooltip_ClearItem = ItemRefTooltip:GetScript("OnTooltipCleared")
ItemRefTooltip:SetScript("OnTooltipCleared", function(tooltip, ...)
	V.TooltipDone = nil
	return Orig_ItemRefTooltip_ClearItem(tooltip, ...)
end)

--[[	*** Note about tooltips ***
If an error occurs with a specific item, like a gathering node, make sure its item id is valid in core.lua
28/12/2008: I fixed an issue with black lotus, which did not display its counters at all, this was due to an invalid item id
--]]

function Altoholic:ProcessTooltip(tooltip, name, link)
	local itemID = self:GetIDFromLink(link)
	
	-- if there's no cached item id OR if it's different from the previous one ..
	if (not V.ToolTipCachedItemID) or 
		(V.ToolTipCachedItemID and (itemID ~= V.ToolTipCachedItemID)) then

		V.TooltipRecipeCache = nil
		
		-- these are the cpu intensive parts of the update .. so do them only if necessary
		if Altoholic.Options:Get("TooltipSource") == 1 then
			local Instance, Boss = self.Loots:GetSource(itemID)
			
			V.ToolTipCachedItemID = itemID			-- we have searched this ID ..
		
			if (Instance == nil) then
				V.ToolTipCachedSource = nil			--  no results found, or the option is unchecked
			else
				V.ToolTipCachedSource = GOLD .. L["Source"]..  ": |cff00ff9a" .. Instance .. ", " .. Boss
			end
		else
			V.ToolTipCachedSource = nil			--  make sure nothing is displayed if the option is unchecked
		end
		
		-- .. then check player bags to see how many times he owns this item, and where
		if Altoholic.Options:Get("TooltipCount") == 1 or Altoholic.Options:Get("TooltipTotal") == 1 then
			V.ToolTipCachedCount = self:GetItemCount(itemID) -- if one of the 2 options is active, do the count
			if V.ToolTipCachedCount > 0 then
				V.ToolTipCachedTotal = GOLD .. L["Total owned"] .. ": |cff00ff9a" .. V.ToolTipCachedCount
			else
				V.ToolTipCachedTotal = nil
			end
		end
	end

	-- add item cooldown text
	local owner = tooltip:GetOwner()
	if owner and owner.startTime then
		tooltip:AddLine(format(ITEM_COOLDOWN_TIME, 
				SecondsToTime(owner.duration - (GetTime() - owner.startTime))),1,1,1);
	end
	
	if (Altoholic.Options:Get("TooltipCount") == 1) and (V.ToolTipCachedCount > 0) then			-- add count per character
		tooltip:AddLine(" ",1,1,1);
		for CharacterName, c in pairs (V.ItemCount) do
			tooltip:AddDoubleLine(CharacterName,  TEAL .. c);
		end
	end
	
	if (Altoholic.Options:Get("TooltipTotal") == 1) and (V.ToolTipCachedTotal) then		-- add total count
		tooltip:AddLine(V.ToolTipCachedTotal,1,1,1);
	end
	
	if V.ToolTipCachedSource then		-- add item source
		tooltip:AddLine(" ",1,1,1);
		tooltip:AddLine(V.ToolTipCachedSource,1,1,1);
	end
	
	-- Altoholic:CheckMaterialUtility(itemID)
	
	if Altoholic.Options:Get("TooltipItemID") == 1 then
		local iLevel = select(4, GetItemInfo(itemID))
		
		if iLevel then
			tooltip:AddLine(" ",1,1,1);
			tooltip:AddDoubleLine("Item ID: " .. GREEN .. itemID,  "iLvl: " .. GREEN .. iLevel);
--			tooltip:AddLine(TEAL .. select(10, GetItemInfo(itemID)));		-- texture path
		end
	end
	
	local companionID = Altoholic:GetCompanionSpellID(itemID)
	if companionID then
		tooltip:AddLine(" ",1,1,1);	
		Altoholic:WhoKnowsPet(companionID, "CRITTER", tooltip)
		return	-- it's certainly not a recipe if we passed here
	end
	
	local mountID = Altoholic:GetMountSpellID(itemID)
	if mountID then
		tooltip:AddLine(" ",1,1,1);	
		Altoholic:WhoKnowsPet(mountID, "MOUNT", tooltip)
		return	-- it's certainly not a recipe if we passed here
	end
	
	
	if Altoholic.Options:Get("TooltipRecipeInfo") == 0 then return end -- exit if recipe information is not wanted
	
	local _, _, _, _, _, itemType, itemSubType = GetItemInfo(itemID)
	if itemType ~= BI["Recipe"] then return end		-- exit if not a recipe
	if itemSubType == BI["Book"] then return end		-- exit if it's a book

	if not V.TooltipRecipeCache then
		local tooltipName = tooltip:GetName()
		local reqLevel
		for i = 2, tooltip:NumLines() do			-- parse all tooltip lines, one by one
			local tooltipText = _G[tooltipName .. "TextLeft" .. i]:GetText()
			if tooltipText then
				if string.find(tooltipText, "%d+") then	-- try to find a numeric value .. 
					reqLevel = tonumber(string.sub(tooltipText, string.find(tooltipText, "%d+")))
					break
				end
			end
		end
		V.TooltipRecipeCache = self:WhoKnowsRecipe(itemSubType, link, reqLevel)
	end
	
	if V.TooltipRecipeCache then
		tooltip:AddLine(" ",1,1,1);	
		tooltip:AddLine(V.TooltipRecipeCache, 1, 1, 1, 1, 1);
	end	
end

function Altoholic:GetCraftFromRecipe(link)
	-- get the craft name from the itemlink (strsplit on | to get the 4th value, then split again on ":" )
	local recipeName = select(4, strsplit("|", link))
	local craftName

	-- try to determine if it's a transmute (has 2 colons in the string --> Alchemy: Transmute: blablabla)
	local pos = string.find(recipeName, L["Transmute"])
	if pos then	-- it's a transmute
		return string.sub(recipeName, pos, -2)
	else
		craftName = select(2, strsplit(":", recipeName))
	end
	
	if craftName == nil then		-- will be nil for enchants
		return string.sub(recipeName, 3, -2)		-- ex: "Enchant Weapon - Striking"
	end
	
	return string.sub(craftName, 2, -2)	-- at this point, get rid of the leading space and trailing square bracket
end

function Altoholic:WhoKnowsPet(companionSpellID, petType, tooltip)
	local know = {}				-- list of alts who know this pet
	local couldLearn = {}		-- list of alts who could learn it
	
	for CharacterName, c in pairs(Altoholic.ThisRealm.char) do
		local p = c.pets[petType]
		if p then
			local isKnownByChar
			for k, v in pairs(p) do
				local _, spellID = strsplit("|", v)
			
				if tonumber(spellID) == companionSpellID then
					isKnownByChar = true
					break
				end
			end
			
			if isKnownByChar then
				table.insert(know, CharacterName)
			else
				table.insert(couldLearn, CharacterName)
			end
		end
	end
	
	if #know > 0 then
		tooltip:AddLine(TEAL .. L["Already known by "] ..": ".. WHITE.. table.concat(know, ", "), 1, 1, 1, 1, 1);
	end
	
	if #couldLearn > 0 then
		tooltip:AddLine(YELLOW .. L["Could be learned by "] ..": ".. WHITE.. table.concat(couldLearn, ", "), 1, 1, 1, 1, 1);
	end
end

function Altoholic:WhoKnowsRecipe(profession, link, recipeLevel)
	local craftName

	local spellID = self:GetSpellIDFromRecipeLink(link)
	if not spellID then		-- spell id unknown ? let's parse the tooltip
		craftName = self:GetCraftFromRecipe(link)
	
		if not craftName then return end		-- still nothing usable ? then exit
		-- keep these 2 for debug.
		-- DEFAULT_CHAT_FRAME:AddMessage("searching with craft name : "..craftName)
	-- else
		-- DEFAULT_CHAT_FRAME:AddMessage("searching with spell id : "..spellID)
	end
	
	local know = {}				-- list of alts who know this recipe
	local couldLearn = {}		-- list of alts who could learn it
	local willLearn = {}			-- list of alts who will be able to learn it later
	
	for CharacterName, c in pairs(Altoholic.ThisRealm.char) do
		local p = c.recipes[profession]
		if p.ScanFailed == false then
			local isKnownByChar
			
			if spellID then			-- if spell id is known, just find its equivalent in the professions
				for _, TradeSkillInfo in pairs (p.list) do
					local _, _, id = strsplit("^", TradeSkillInfo)
					id = tonumber(id)
					if id and spellID == id then
						isKnownByChar = true
						break
					end
				end
			else
				for _, TradeSkillInfo in pairs (p.list) do
					local _, _, id = strsplit("^", TradeSkillInfo)
					id = tonumber(id)
					if id then
						local skillName = GetSpellInfo(id) or ""

						if string.lower(skillName) == string.lower(craftName) then
							isKnownByChar = true
							break
						end
					end
				end	-- known skills loop
			end

			if isKnownByChar then
				table.insert(know, CharacterName)
			else
				local curRank
				if (profession == BI["Cooking"]) or 
					(profession == BI["First Aid"]) or
					(profession == BI["Fishing"]) then
					curRank = self.TradeSkills:GetRank( c.skill[L["Secondary Skills"]][profession] )
				else
					curRank = self.TradeSkills:GetRank( c.skill[L["Professions"]][profession] )
				end
				if curRank < recipeLevel then
					table.insert(willLearn, CharacterName)
				else
					table.insert(couldLearn, CharacterName)
				end
			end
		end
	end
	
	local lines = {}
	if #know > 0 then
		table.insert(lines, TEAL .. L["Already known by "] ..": ".. WHITE.. table.concat(know, ", "))
	end
	
	if #couldLearn > 0 then
		table.insert(lines, YELLOW .. L["Could be learned by "] ..": ".. WHITE.. table.concat(couldLearn, ", "))
	end
	
	if #willLearn > 0 then
		table.insert(lines, RED .. L["Will be learnable by "] ..": ".. WHITE.. table.concat(willLearn, ", "))
	end
	
	return table.concat(lines, "\n")
end

function Altoholic:CheckMaterialUtility(itemID)
	for CharacterName, c in pairs(Altoholic.db.global.data[THIS_ACCOUNT][GetRealmName()].char) do
		-- for each character ... 
		for SkillName, s in pairs(c.skill[L["Professions"]]) do
			if Altoholic.TradeSkills:GetRank(s) ~= 450 then		-- if the tradeskill level is not at 450
				local p = c.recipes[SkillName]
				if p.ScanFailed == false then
					-- loop through all recipes of this tradeskill that are yellow or orange
					for craftIndex, craft in pairs(p.list) do
						if craft.color and (craft.color >= 2) then
							-- test if the mat would be useful
							local i=1
							local reagent = select(i, strsplit("|", craft.reagents))
							
							while reagent do
								local reagentID = select(1, strsplit(":", reagent))
								reagentID = tonumber(reagentID)
								if reagentID and (reagentID == itemID) then
									DEFAULT_CHAT_FRAME:AddMessage("found !" .. CharacterName .. ", " .. SkillName .. ", " ..craft.link )
								end
								i = i + 1
								reagent = select(i, strsplit("|", craft.reagents))
							end
						end
					end
				end
			end
		end
	end
end

-- *** EVENT HANDLERS ***
function Altoholic:PLAYER_ALIVE()
	local c = Altoholic.ThisCharacter

	c.level = UnitLevel("player")
	c.race = UnitRace("player")
	c.class, c.englishClass = UnitClass("player")
	
	self:UpdatePlayerStats()
	self.Talents:Scan()
	self.Achievements:Scan()		-- ** updating achievements takes 165 ms on my machine, try not to call this too often.
end

function Altoholic:PLAYER_LEVEL_UP(event, newLevel)
	local c = Altoholic.ThisCharacter
	c.level = newLevel
end

function Altoholic:PLAYER_XP_UPDATE()
	local c = Altoholic.ThisCharacter
	c.xp = UnitXP("player")
	c.xpmax = UnitXPMax("player")
	c.restxp = GetXPExhaustion() or 0
end

function Altoholic:PLAYER_MONEY()
	local c = Altoholic.ThisCharacter
	c.money = GetMoney();
end

function Altoholic:PLAYER_UPDATE_RESTING()
	local c = Altoholic.ThisCharacter
	c.isResting = IsResting();
end

function Altoholic:PLAYER_GUILD_UPDATE()
	-- at login this event is called between OnEnable and PLAYER_ALIVE, where GetGuildInfo returns a wrong value
	-- however, the value returned here is correct
	if IsInGuild() then
		local c = Altoholic.ThisCharacter
		c.guildName = GetGuildInfo("player")
		
		if self.DoInitialBroadcast and c.guildName then
			-- best place to do this, since it depends on the guild name returned above.
			Altoholic:SendPublicInfo(MSG_GUILD_ANNOUNCELOGIN, nil, c.guildName)
			self.DoInitialBroadcast = nil
		end
	end
end

function Altoholic:CHAT_MSG_SKILL(self, msg)
	if msg then
		Altoholic:UpdatePlayerSkills()
	end
end

function Altoholic:COMPANION_UPDATE()
	self:UpdateCompanions("CRITTER")
	self:UpdateCompanions("MOUNT")
end

function Altoholic:CHAT_MSG_COMBAT_FACTION_CHANGE(event, text)
	self.Reputations:Scan()
end

function Altoholic:UpdatePlayerLocation()
	local c = Altoholic.ThisCharacter
	c.zone = GetRealZoneText()
	c.subzone = GetSubZoneText()
end

function Altoholic:PLAYER_LOGOUT()
	local c = Altoholic.ThisCharacter
	c.lastlogout = time()
end

function Altoholic:TIME_PLAYED_MSG(event, TotalTime, CurrentLevelTime)
	local c = Altoholic.ThisCharacter
	c.played = TotalTime

	-- I'm not entirely happy to have to put this here, but in all events triggered prior to this one, the icon button is not yet valid,
	-- and can't be hidden programmatically. Hopefully, this event is only triggered at login and when /played is typed, so minimal impact.
	if self:IsFuBarMinimapAttached() then
		-- still required to test if it's not nil, when a new character  is created for instance.
		if type(_G["LibFuBarPlugin-Mod-3.0_Altoholic_FrameMinimapButton"]) ~= "nil" then
			_G["LibFuBarPlugin-Mod-3.0_Altoholic_FrameMinimapButton"]:Hide()
		end
	end

	self.Mail:CheckExpiries()
end

function Altoholic:RequestUpdateRaidInfo()
	RequestRaidInfo()
end

function Altoholic:CHAT_MSG_SYSTEM(event, arg)
	if arg then
		if arg:match(L["has come online"]) or arg:match(L["has gone offline"]) then
			if IsInGuild() then
				GuildRoster()
			end
		elseif tostring(arg1) == INSTANCE_SAVED then
			Altoholic:RequestUpdateRaidInfo()
		end
	end
end

function Altoholic:PLAYER_TALENT_UPDATE()
	Altoholic.Talents:Scan()
	if AltoholicFrameTalents:IsVisible() then
		Altoholic.Talents:Update()
	end
end	
