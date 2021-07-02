local AddonName, AddonTable = ...
if AddonTable.OldBuild then return end
local L = AddonTable.Localize
LibStub:GetLibrary("BigLibTimer3"):Register(AddonTable)
SpellFlashAddon = {}
local s = SpellFlashAddon

function s.SpellName(GlobalSpellID, NoSubName)
	if type(GlobalSpellID) == "number" then
		local SpellName, SubName = GetSpellInfo(GlobalSpellID)
		if not NoSubName and SubName and SubName ~= "" then
			return SpellName.."("..SubName..")"
		end
		return SpellName
	end
	return GlobalSpellID
end

function s.ItemName(ItemID)
	if type(ItemID) == "number" then
		return (GetItemInfo(ItemID))
	end
	return ItemID
end


local MAXDEBUFFSLOTS = 40

local MELEESPELL = {
	DEATHKNIGHT = 45902--[[Blood Strike]],
	DRUID = 1082--[[Claw]],
	HUNTER = 2973--[[Raptor Strike]],
	PALADIN = 35395--[[Crusader Strike]],
	ROGUE = 1752--[[Sinister Strike]],
	SHAMAN = 73899--[[Primal Strike]],
	WARRIOR = 78--[[Heroic Strike]],
}

local GLOBALCOOLDOWNSPELL = {
	DEATHKNIGHT = 45902--[[Blood Strike]],
	DRUID = 5176--[[Wrath]],
	HUNTER = 883--[[Call Pet 1]],
	MAGE = 133--[[Fireball]],
	PALADIN = 635--[[Holy Light]],
	PRIEST = 585--[[Smite]],
	ROGUE = 1752--[[Sinister Strike]],
	SHAMAN = 403--[[Lightning Bolt]],
	WARLOCK = 686--[[Shadow Bolt]],
	WARRIOR = 772--[[Rend]],
}

local HEALERCLASS = {
	DRUID = "Druid",
	PALADIN = "Paladin",
	PRIEST = "Priest",
	SHAMAN = "Shaman",
}

local ALTERNATEFORM = {
	[s.SpellName(33943--[[Flight Form]], 1)] = s.SpellName(40120--[[Swift Flight Form]], 1),
	[s.SpellName(40120--[[Swift Flight Form]], 1)] = s.SpellName(33943--[[Flight Form]], 1),
}

AddonTable.ImmunityDebuffs = {
	710--[[Banish]],
	33786--[[Cyclone]],
	--605--[[Mind Control]],
}

AddonTable.BreakOnDamage = {
	19503--[[Scatter Shot]],
	1499--[[Freezing Trap]],
	6358--[[Seduction]],
	9484--[[Shackle Undead]],
	6770--[[Sap]],
	118--[[Polymorph]],
	51514--[[Hex]],
	2094--[[Blind]],
	2637--[[Hibernate]],
	76780--[[Bind Elemental]],
	--19386--[[Wyvern Sting]],
}

AddonTable.Fear = {
	5782--[[Fear]],
	5484--[[Howl of Terror]],
	8122--[[Psychic Scream]],
	1513--[[Scare Beast]],
	10326--[[Turn Evil]],
	--5246--[[Intimidating Shout]],
}

AddonTable.Root = {
	339--[[Entangling Roots]],
	122--[[Frost Nova]],
	45524--[[Chains of Ice]],
	16979--[[Feral Charge - Bear]],
}

AddonTable.MovementImpairing = {
	5116--[[Concussive Shot]],
	2974--[[Wing Clip]],
	13809--[[Ice Trap]],
	116--[[Frostbolt]],
	120--[[Cone of Cold]],
	11113--[[Blast Wave]],
	31589--[[Slow]],
	15407--[[Mind Flay]],
	3408--[[Crippling Poison]],
	26679--[[Deadly Throw]],
	8056--[[Frost Shock]],
	2484--[[Earthbind Totem]],
	18223--[[Curse of Exhaustion]],
	1715--[[Hamstring]],
	12323--[[Piercing Howl]],
}

AddonTable.PetActions = {
	Attack = "PET_ACTION_ATTACK",
	Follow = "PET_ACTION_FOLLOW",
	Stay = "PET_ACTION_WAIT",
	["Move To"] = "PET_ACTION_MOVE_TO",
	Aggressive = "PET_MODE_AGGRESSIVE",
	Defensive = "PET_MODE_DEFENSIVE",
	Passive = "PET_MODE_PASSIVE",
	PET_ACTION_ATTACK = "PET_ACTION_ATTACK",
	PET_ACTION_FOLLOW = "PET_ACTION_FOLLOW",
	PET_ACTION_WAIT = "PET_ACTION_WAIT",
	PET_ACTION_MOVE_TO = "PET_ACTION_MOVE_TO",
	PET_MODE_AGGRESSIVE = "PET_MODE_AGGRESSIVE",
	PET_MODE_DEFENSIVE = "PET_MODE_DEFENSIVE",
	PET_MODE_PASSIVE = "PET_MODE_PASSIVE",
	[PET_ACTION_ATTACK or "PET_ACTION_ATTACK"] = "PET_ACTION_ATTACK",
	[PET_ACTION_FOLLOW or "PET_ACTION_FOLLOW"] = "PET_ACTION_FOLLOW",
	[PET_ACTION_WAIT or "PET_ACTION_WAIT"] = "PET_ACTION_WAIT",
	[PET_ACTION_MOVE_TO or "PET_ACTION_MOVE_TO"] = "PET_ACTION_MOVE_TO",
	[PET_MODE_AGGRESSIVE or "PET_MODE_AGGRESSIVE"] = "PET_MODE_AGGRESSIVE",
	[PET_MODE_DEFENSIVE or "PET_MODE_DEFENSIVE"] = "PET_MODE_DEFENSIVE",
	[PET_MODE_PASSIVE or "PET_MODE_PASSIVE"] = "PET_MODE_PASSIVE",
}

-- http://www.wowhead.com/npcs?filter=cr=34;crs=0;crv=270
AddonTable.DummyIDNumbers = {
	["1921"] = "Combat Dummy",
	["32542"] = "Disciple's Training Dummy",
	["25297"] = "Drill Dummy",
	["32546"] = "Ebon Knight's Training Dummy",
	["17059"] = "Hellfire Combat Dummy",
	["17060"] = "Hellfire Combat Dummy Small",
	["17578"] = "Hellfire Training Dummy",
	["32547"] = "Highlord's Nemesis Trainer",
	["32541"] = "Initiate's Training Dummy",
	["32545"] = "Initiate's Training Dummy",
	["33229"] = "Melee Target",
	["19139"] = "Nagrand Target Dummy",
	["16211"] = "Naxxramas Combat Dummy",
	["42328"] = "Practice Dummy",
	["25225"] = "Practice Dummy",
	["31146"] = "Raider's Training Dummy",
	["18504"] = "Silvermoon Practice Dummy",
	["43560"] = "Smilin' Timmy Sticks",
	["4952"] = "Theramore Combat Dummy",
	["38038"] = "Tiki Target",
	["44171"] = "Training Dummy",
	["48304"] = "Training Dummy",
	["44937"] = "Training Dummy",
	["44389"] = "Training Dummy",
	["44614"] = "Training Dummy",
	["44548"] = "Training Dummy",
	["44703"] = "Training Dummy",
	["44794"] = "Training Dummy",
	["44820"] = "Training Dummy",
	["44848"] = "Training Dummy",
	["32666"] = "Training Dummy",
	["32667"] = "Training Dummy",
	["31144"] = "Training Dummy",
	["46647"] = "Training Dummy",
	["5652"] = "Undercity Practice Dummy",
	["32543"] = "Veteran's Training Dummy",
}


local DEFAULT_FLASH_SIZE_PERCENT = 240
local DEFAULT_FLASH_BRIGHTNESS_PERCENT = 100
local FLASH_SIZE_PERCENT = DEFAULT_FLASH_SIZE_PERCENT
local FLASH_BRIGHTNESS_PERCENT = DEFAULT_FLASH_BRIGHTNESS_PERCENT
local ENABLE_BLINKING = nil
local DISABLE_MACRO_FLASHING = nil
local SUPPRESS_RANGE_CHECK = nil
local SUPPRESS_SPEED_CHECK = nil
local CLASS = select(2, UnitClass("player"))
local RACE = select(2, UnitRace("player")):upper():gsub("[^A-Z]", ""):gsub("^SCOURGE$", "UNDEAD")
s.Spam = {}
s.UpdatedVariables = {}
local OtherAurasFunctions = {}
local OtherAurasFromSpell = {}
local OtherAurasSpellFromAura = {}
local SPELLDELAY = {}
local MODIFIEDCLICKFOCUSCAST = nil
local CHANGEDMODIFIEDCLICKFOCUSCAST = nil
local OUTSIDEMELEESPELL = nil
local NPC_HIT_SPELLS = {}
local DISABLE_DEBUFF_OWNER_CHECKING = nil
local VARIABLES_CHECKED = nil
local TALENTRANK = {}
local TALENTTREEPOINTS = {}
local TALENTMASTERY = nil
local CLASSMODULES = {}
local CLASSMODULES_ADDONNAMES = {}
local GLOBAL_COOLDOWN_SPELL = nil
local CURRENTFORM = nil
local SHOOT = nil
local SERVER = nil
local REALM = nil
local PLAYER = nil
local LOADING = true

--[[
s.PRIEST
s.ROGUE
s.PALADIN
s.WARLOCK
s.WARRIOR
s.HUNTER
s.MAGE
s.SHAMAN
s.DRUID
s.DEATHKNIGHT
]]
s[CLASS] = {}

--[[
s.HUMAN
s.DWARF
s.GNOME
s.NIGHTELF
s.BLOODELF
s.ORC
s.UNDEAD
s.TAUREN
s.TROLL
s.DRAENEI
]]
s[RACE] = {}

local function DecodeItemLink(link)
	if type(link) == "string" then
		local id, name = link:match("item:(%d+):.*%[(.*)%]")
		if id then
			return name, tonumber(id)
		end
	end
	return nil
end

local function ItemIDFromItemName(ItemName)
	if type(ItemName) == "string" then
		return ( select(2, DecodeItemLink(select(2, GetItemInfo(ItemName)))) )
	end
	return nil
end

local function ItemSubType(ItemID)
	if ItemID then
		return ( select(7, GetItemInfo(ItemID)) )
	end
	return nil
end

local function CopyTable(Table)
	local t = {}
	if type(Table) == "table" then
		for k,v in pairs(Table) do
			t[k] = v
		end
	end
	return t
end

local function UnitIsDummy(unit)
	local Type, ID = s.UnitInfo(unit)
	if Type == "npc" then
		return AddonTable.DummyIDNumbers[tostring(ID)]
	end
	return nil
end

local function VehicleSlot(SpellName)
	if UnitHasVehicleUI("player") then
		local SpellName = s.SpellName(SpellName)
		if SpellName then
			for i=121,126 do
				local name = s.SpellName((select(2, GetActionInfo(i))))
				if name and name == SpellName then
					return i
				end
			end
		end
	end
	return nil
end

local function TargetOrFocus(unit)
	if unit then
		return unit
	elseif IsModifiedClick("FOCUSCAST") then
		return "focus"
	end
	return "target"
end

local function CheckVariables()
	PLAYER = UnitName("player")
	if not PLAYER then
		--Character name not available yet
		AddonTable:ReplaceTimer("CheckVariables", 1)
		return
	end
	REALM = GetRealmName()
	SERVER = GetCVar("realmList"):lower()
	if not SpellFlashAddonConfig then
		SpellFlashAddonConfig = {}
	end
	if not SpellFlashAddonConfig.SERVER then
		SpellFlashAddonConfig.SERVER = {}
	end
	if not SpellFlashAddonConfig.SERVER[SERVER] then
		SpellFlashAddonConfig.SERVER[SERVER] = {}
	end
	if not SpellFlashAddonConfig.SERVER[SERVER].REALM then
		SpellFlashAddonConfig.SERVER[SERVER].REALM = {}
	end
	if not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM] then
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM] = {}
	end
	if not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER then
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER = {}
	end
	if not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER] then
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER] = {}
	end
	if not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].MODULE then
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].MODULE = {}
	end
	if not SpellFlashAddonConfig.SERVER[SERVER].Immune then
		SpellFlashAddonConfig.SERVER[SERVER].Immune = {}
	end
	if not SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS] then
		SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS] = {}
	end
	if not SpellFlashAddonConfig.SERVER[SERVER].ImmuneIgnore then
		SpellFlashAddonConfig.SERVER[SERVER].ImmuneIgnore = {}
	end
	if not SERVER:match("%.worldofwarcraft%.com$") and not SERVER:match("%.battle%.net$") then
		DISABLE_DEBUFF_OWNER_CHECKING = not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].debuff_owner_checking
	end
	FLASH_SIZE_PERCENT = SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].flash_size_percent or DEFAULT_FLASH_SIZE_PERCENT
	FLASH_BRIGHTNESS_PERCENT = SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].flash_brightness_percent or DEFAULT_FLASH_BRIGHTNESS_PERCENT
	DISABLE_MACRO_FLASHING = SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].disable_macro_flashing
	SUPPRESS_RANGE_CHECK = SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].suppress_range_check
	SUPPRESS_SPEED_CHECK = SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].suppress_speed_check
	ENABLE_BLINKING = SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].enable_blinking
	VARIABLES_CHECKED = 1
end

local function LoadAddOns()
	local Loaded, Error
	for i = 1, GetNumAddOns() do
		local name, title, notes, enabled = GetAddOnInfo(i)
		if enabled and not name:lower():match("^spellflash_templateaddon$") then
			local Metadata = GetAddOnMetadata(name, "X-SpellFlashAddon-LoadWith") or ""
			if Metadata:match("%w") then
				local LoadWith = ","..Metadata:upper():gsub("[^A-Z,%+]", ""):gsub("%+", "++")..","
				if LoadWith:match(",ANY,")
				or LoadWith:match(","..CLASS..",")
				or LoadWith:match(","..RACE..",")
				or LoadWith:match("[,%+]"..CLASS.."%+".."[^,]*".."%+"..RACE.."[,%+]")
				or LoadWith:match("[,%+]"..RACE.."%+".."[^,]*".."%+"..CLASS.."[,%+]")
				or LoadWith:match("[,%+]"..CLASS.."%+".."[^,]*".."%+ANY[,%+]")
				or LoadWith:match("[,%+]"..RACE.."%+".."[^,]*".."%+ANY[,%+]")
				or LoadWith:match("[,%+]ANY%+".."[^,]*".."%+"..CLASS.."[,%+]")
				or LoadWith:match("[,%+]ANY%+".."[^,]*".."%+"..RACE.."[,%+]")
				then
					Loaded = IsAddOnLoaded(i)
					if not Loaded and IsAddOnLoadOnDemand(i) then
						Loaded, Error = LoadAddOn(name)
						if not Loaded then
							print("Error loading: "..name.." ("..Error..")")
						end
					end
					if Loaded and LoadWith:match(","..CLASS..",") then
						CLASSMODULES[name] = (title or "").."   "..GRAY_FONT_COLOR_CODE.."("..name..")"..FONT_COLOR_CODE_CLOSE
						CLASSMODULES_ADDONNAMES[CLASSMODULES[name]] = name
					end
				end
			end
		end
	end
	if not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].selected_class_module or not CLASSMODULES[SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].selected_class_module] then
		local name = next(CLASSMODULES)
		if tostring(name):lower():match("^spellflash_x$") and next(CLASSMODULES, name) then
			name = next(CLASSMODULES, name)
		end
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].selected_class_module = name
	end
	UIDropDownMenu_Initialize(SpellFlashAddonOptionsFrame_ClassModulesList, function(parent)
		for _, v in pairs(CLASSMODULES) do
			local info = {}
			info.text = v
			info.func = function(self)
				UIDropDownMenu_SetSelectedID(parent, self:GetID())
			end
			UIDropDownMenu_AddButton(info)
		end
	end)
end

local function RunSpam()
	local x = s.UpdatedVariables
	x.ActiveEnemy = s.ActiveEnemy()
	x.Enemy = x.ActiveEnemy or s.Enemy()
	x.NoCC = x.ActiveEnemy or not s.NoDamageCC()
	x.PetAlive = UnitHealth("pet") > 0
	x.PetActiveEnemy = x.PetAlive and s.ActiveEnemy("pettarget")
	x.PetNoCC = not x.PetAlive or x.PetActiveEnemy or not s.BreakOnDamageCC("pettarget")
	x.InInstance, x.InstanceType = IsInInstance()
	x.Lag = select(3, GetNetStats()) / 1000
	x.DoubleLag = x.Lag * 2
	x.ThreatPercent = select(3, UnitDetailedThreatSituation("player", TargetOrFocus())) or 0
	for n,v in pairs(s.Spam) do
		if type(v) == "function" and ( not CLASSMODULES[n] or SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].selected_class_module == n or SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].use_all_class_modules ) then
			v(x)
		end
	end
end

local function SetSpam()
	if not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].spell_flashing_off then
		if not AddonTable:IsTimer("Spam-repeat") then
			AddonTable:SetTimer("Spam-repeat", 0, 0.2, RunSpam)
		end
	else
		AddonTable:ClearTimer("Spam-repeat")
	end
end

local function RegisterOtherAuras()
	OtherAurasFromSpell = {}
	for _,v in ipairs(OtherAurasFunctions) do
		if type(v) == "function" then
			v()
		end
	end
	OtherAurasSpellFromAura = {}
	for Spell,t in pairs(OtherAurasFromSpell) do
		for Aura in pairs(t) do
			if not OtherAurasSpellFromAura[Aura] then
				OtherAurasSpellFromAura[Aura] = {}
			end
			OtherAurasSpellFromAura[Aura][Spell] = 1
		end
	end
end

-- Registers the current Form or Stance
local function RegisterForm()
	local n = GetShapeshiftForm()
	if not n or n == 0 then
		CURRENTFORM = nil
	else
		CURRENTFORM = select(2,GetShapeshiftFormInfo(n))
	end
	SpellFlashCore.debug("Now in "..( CURRENTFORM or "Caster Form" ).."!")
end

local function RegisterTalents()
	TALENTMASTERY = nil
	local HighestTreeFound = 0
	for Tab=1,GetNumTalentTabs() do
		TALENTTREEPOINTS[Tab] = 0
		for Tal=1,GetNumTalents(Tab) do
			local name, icon, tier, column, rank = GetTalentInfo(Tab, Tal)
			if name then
				TALENTRANK[name] = rank
				TALENTTREEPOINTS[Tab] = TALENTTREEPOINTS[Tab] + rank
			end
		end
		if TALENTTREEPOINTS[Tab] > 0 and TALENTTREEPOINTS[Tab] > HighestTreeFound then
			HighestTreeFound = TALENTTREEPOINTS[Tab]
			TALENTMASTERY = Tab
		end
	end
end

local function RegisterOutsideMeleeDistanceSpell()
	if not s.HasSpell(MELEESPELL[CLASS]) then
		OUTSIDEMELEESPELL = nil
		local i = 1
		local skillType, spellId = GetSpellBookItemInfo(i, "player")
		while skillType do
			if skillType == "SPELL" and s.SpellHasRange(spellId) and select(8,GetSpellInfo(spellId)) == 5 and select(9,GetSpellInfo(spellId)) >= 10 then
				OUTSIDEMELEESPELL = spellId
				break
			end
			i = i + 1
			skillType, spellId = GetSpellBookItemInfo(i, "player")
		end
	end
end

function SpellFlashAddon.OpenToClassCategory()
	local AddonName = CLASSMODULES_ADDONNAMES[UIDropDownMenu_GetText(SpellFlashAddonOptionsFrame_ClassModulesList)]
	if AddonName then
		if _G[AddonName.."_SpellFlashAddonOptionsFrame"] then
			InterfaceOptionsFrame_OpenToCategory(_G[AddonName.."_SpellFlashAddonOptionsFrame"])
		else -- this part is added for backward compatibility for malformed modules that do not use a correctly named options frame
			if AddonName:lower():match("^spellflash_.") then
				InterfaceOptionsFrame_OpenToCategory(AddonName:gsub("^.........._", ""))
			end
			InterfaceOptionsFrame_OpenToCategory(GetAddOnMetadata(AddonName, "Title"))
			InterfaceOptionsFrame_OpenToCategory(select(2, GetAddOnInfo(AddonName)))
			InterfaceOptionsFrame_OpenToCategory(AddonName)
		end
	end
end

function SpellFlashAddon.TestFlashSettings()
	local sizepercent = SpellFlashAddonOptionsFrame_FlashSizePercent:GetNumber()
	if sizepercent > 0 then
		FLASH_SIZE_PERCENT = sizepercent
	else
		FLASH_SIZE_PERCENT = DEFAULT_FLASH_SIZE_PERCENT
	end
	local brightnesspercent = SpellFlashAddonOptionsFrame_FlashBrightnessPercent:GetNumber()
	if brightnesspercent > 0 and brightnesspercent < 100 then
		FLASH_BRIGHTNESS_PERCENT = brightnesspercent
	else
		FLASH_BRIGHTNESS_PERCENT = DEFAULT_FLASH_BRIGHTNESS_PERCENT
	end
end

local function ResetFlashSettings()
	FLASH_SIZE_PERCENT = SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].flash_size_percent or DEFAULT_FLASH_SIZE_PERCENT
	FLASH_BRIGHTNESS_PERCENT = SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].flash_brightness_percent or DEFAULT_FLASH_BRIGHTNESS_PERCENT
end

local function ResetDefaults()
	SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].spell_flashing_off = nil
	SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].flash_size_percent = nil
	SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].flash_brightness_percent = nil
	SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].auto_mob_immune_detection_off = nil
	SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].use_all_class_modules = nil
	SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].disable_macro_flashing = nil
	SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].suppress_speed_check = nil
	SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].suppress_range_check = nil
	SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].enable_blinking = nil
	SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].debuff_owner_checking = SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].debuff_owner_found
	CheckVariables()
	SetSpam()
end

local function LoadOptionsFrameSettings()
	if next(CLASSMODULES) then
		UIDropDownMenu_SetSelectedValue(SpellFlashAddonOptionsFrame_ClassModulesList, CLASSMODULES[SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].selected_class_module])
		UIDropDownMenu_SetText(SpellFlashAddonOptionsFrame_ClassModulesList, CLASSMODULES[SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].selected_class_module])
	end
	SpellFlashAddonOptionsFrame_SpellFlashing:SetChecked(not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].spell_flashing_off)
	SpellFlashAddonOptionsFrame_disable_macro_flashing:SetChecked(not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].disable_macro_flashing)
	SpellFlashAddonOptionsFrame_suppress_range_check:SetChecked(not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].suppress_range_check)
	SpellFlashAddonOptionsFrame_suppress_speed_check:SetChecked(not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].suppress_speed_check)
	SpellFlashAddonOptionsFrame_UseAllClassModules:SetChecked(not not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].use_all_class_modules)
	SpellFlashAddonOptionsFrame_BlinkSpells:SetChecked(not not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].enable_blinking)
	SpellFlashAddonOptionsFrame_FlashSizePercent:SetNumber(SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].flash_size_percent or DEFAULT_FLASH_SIZE_PERCENT)
	SpellFlashAddonOptionsFrame_FlashBrightnessPercent:SetNumber(SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].flash_brightness_percent or DEFAULT_FLASH_BRIGHTNESS_PERCENT)
	SpellFlashAddonOptionsFrame_AutoMobImmunityDetection:SetChecked(not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].auto_mob_immune_detection_off)
	SpellFlashAddonOptionsFrame_ClearImmuneDatabase:SetChecked(false)
	if not SERVER:match("%.worldofwarcraft%.com$") and not SERVER:match("%.battle%.net$") then
		SpellFlashAddonOptionsFrame_debuff_owner_checking:Show()
		SpellFlashAddonOptionsFrame_debuff_owner_checking:SetChecked(not DISABLE_DEBUFF_OWNER_CHECKING)
	end
end

local function SaveOptionsFrameSettings()
	if next(CLASSMODULES) then
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].selected_class_module = CLASSMODULES_ADDONNAMES[UIDropDownMenu_GetText(SpellFlashAddonOptionsFrame_ClassModulesList)]
	end
	if SpellFlashAddonOptionsFrame_ClearImmuneDatabase:GetChecked() then
		SpellFlashAddonConfig.SERVER[SERVER].Immune = {}
		SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS] = {}
		SpellFlashAddonConfig.SERVER[SERVER].ImmuneIgnore = {}
	end
	if SpellFlashAddonOptionsFrame_AutoMobImmunityDetection:GetChecked() then
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].auto_mob_immune_detection_off = nil
	else
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].auto_mob_immune_detection_off = true
	end
	if SpellFlashAddonOptionsFrame_SpellFlashing:GetChecked() then
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].spell_flashing_off = nil
	else
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].spell_flashing_off = true
	end
	if SpellFlashAddonOptionsFrame_disable_macro_flashing:GetChecked() then
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].disable_macro_flashing = nil
	else
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].disable_macro_flashing = true
	end
	if SpellFlashAddonOptionsFrame_suppress_range_check:GetChecked() then
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].suppress_range_check = nil
	else
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].suppress_range_check = true
	end
	if SpellFlashAddonOptionsFrame_suppress_speed_check:GetChecked() then
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].suppress_speed_check = nil
	else
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].suppress_speed_check = true
	end
	if SpellFlashAddonOptionsFrame_UseAllClassModules:GetChecked() then
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].use_all_class_modules = true
	else
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].use_all_class_modules = nil
	end
	if SpellFlashAddonOptionsFrame_BlinkSpells:GetChecked() then
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].enable_blinking = true
	else
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].enable_blinking = nil
	end
	local sizepercent = SpellFlashAddonOptionsFrame_FlashSizePercent:GetNumber()
	if sizepercent > 0 and sizepercent ~= DEFAULT_FLASH_SIZE_PERCENT then
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].flash_size_percent = sizepercent
	else
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].flash_size_percent = nil
	end
	local brightnesspercent = SpellFlashAddonOptionsFrame_FlashBrightnessPercent:GetNumber()
	if brightnesspercent > 0 and brightnesspercent < 100 then
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].flash_brightness_percent = brightnesspercent
	else
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].flash_brightness_percent = nil
	end
	if not SERVER:match("%.worldofwarcraft%.com$") and not SERVER:match("%.battle%.net$") then
		if SpellFlashAddonOptionsFrame_debuff_owner_checking:GetChecked() then
			SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].debuff_owner_checking = true
		else
			SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].debuff_owner_checking = nil
		end
	end
	CheckVariables()
	SetSpam()
end

function SpellFlashAddon.OptionsFrame_OnLoad(self)
	
	for _, Frame in next,{self:GetChildren()} do
		if Frame:GetObjectType() == "FontString" then
			local text = Frame:GetText()
			if text and text ~= "" then
				Frame:SetText(L[text])
			end
		else
			for _, Frame in next,{Frame:GetRegions()} do
				if Frame:GetObjectType() == "FontString" then
					local text = Frame:GetText()
					if text and text ~= "" then
						Frame:SetText(L[text])
					end
				end
			end
		end
	end
	
	_G[self:GetName().."TitleString"]:SetText(select(2,GetAddOnInfo(AddonName)).." "..GetAddOnMetadata(AddonName, "Version"))
	
	-- Set the name for the Category for the Panel
	self.name = select(2,GetAddOnInfo(AddonName))
	
	-- When the player clicks okay, run this function.
	self.okay = SaveOptionsFrameSettings
	
	-- When the player clicks cancel, run this function.
	self.cancel = ResetFlashSettings
	
	-- This is a function that is called when the player presses the Default Button.
	self.default = ResetDefaults
	
	-- This will run whenever the options frame is loaded or after defaults are loaded.
	self.refresh = LoadOptionsFrameSettings
	
	-- Add the panel to the Interface Options
	InterfaceOptions_AddCategory(self)
	
end

local function AutoAddToImmuneIgnoreList(NPC)
	SpellFlashAddonConfig.SERVER[SERVER].ImmuneIgnore[NPC] = true
	for SpellName in pairs(SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS]) do
		SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS][SpellName][NPC] = nil
		if not next(SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS][SpellName]) then
			SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS][SpellName] = nil
		end
	end
end

local function OnEvent(self, event, ...)
	local arg = {...}

	if event == "START_AUTOREPEAT_SPELL" then
			
			SHOOT = 1
			
	elseif event == "STOP_AUTOREPEAT_SPELL" then
			
			SHOOT = nil
			
	elseif event == "UPDATE_SHAPESHIFT_FORM" then
			
			RegisterForm()
			
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
			
			local sourceGUID = arg[3]
			local GUID = arg[6]
			local Type, ID = s.GUIDInfo(GUID)
			local SpellName = arg[10]
			local Event = arg[2]
			local EventType = arg[12]
			if EventType == "IMMUNE" and Event ~= "SWING_DAMAGE" and Event ~= "RANGE_DAMAGE" then
				if s.HasSpell(SpellName) then
					AddonTable:SetTimer(SpellName.."TempImmune"..GUID, 5)
				end
				if VARIABLES_CHECKED and ( Type == "npc" or Type == "vehicle" ) and not SpellFlashAddonConfig.SERVER[SERVER].ImmuneIgnore[Type..ID] and not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].auto_mob_immune_detection_off and not s.Debuff(AddonTable.ImmunityDebuffs) then
					if NPC_HIT_SPELLS[Type..ID] and NPC_HIT_SPELLS[Type..ID][SpellName] then
						AutoAddToImmuneIgnoreList(Type..ID)
					elseif s.HasSpell(SpellName) then
						if not SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS][SpellName] then
							SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS][SpellName] = {}
						end
						SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS][SpellName][Type..ID] = true
					end
				end
			end
			if Event == "SPELL_MISS" or Event == "SPELL_MISSED" or Event == "SPELL_DAMAGE" or Event == "SPELL_HEAL" or Event == "SPELL_AURA_REFRESH" or Event == "SPELL_AURA_APPLIED" or Event == "SPELL_AURA_APPLIED_DOSE" then
				if not Event:match("MISS") and Event ~= "SPELL_HEAL" and EventType ~= "BUFF" then
					AddonTable:ClearTimer(SpellName.."TempImmune"..GUID)
					if ( Type == "npc" or Type == "vehicle" ) then
						if not NPC_HIT_SPELLS[Type..ID] then
							NPC_HIT_SPELLS[Type..ID] = {}
						end
						NPC_HIT_SPELLS[Type..ID][SpellName] = 1
						if VARIABLES_CHECKED and not SpellFlashAddonConfig.SERVER[SERVER].ImmuneIgnore[Type..ID] and not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].auto_mob_immune_detection_off and SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS][SpellName] and SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS][SpellName][Type..ID] then
							AutoAddToImmuneIgnoreList(Type..ID)
						end
					end
				end
				if sourceGUID == UnitGUID("player") or ( DISABLE_DEBUFF_OWNER_CHECKING and EventType == "DEBUFF" ) then
					local Lag = select(3, GetNetStats()) / 1000
					if OtherAurasFromSpell[SpellName] and not Event:match("MISS") and (SPELLDELAY[SpellName] or 0) > 0 then
						for n in pairs(OtherAurasFromSpell[SpellName]) do
							AddonTable:SetTimer(n.."AuraDelay"..GUID, math.max(1, Lag))
						end
					end
					if not tostring(EventType):match("BUFF") and ( Event == "SPELL_DAMAGE" or Event == "SPELL_HEAL" ) then
						if (SPELLDELAY[SpellName] or 0) > 0 then
							AddonTable:SetTimer(SpellName.."AuraDelay"..GUID, math.max(1, Lag))
						end
					else
						AddonTable:ClearTimer(SpellName.."AuraDelay"..GUID)
					end
					if (SPELLDELAY[SpellName] or 0) > 0 then
						SPELLDELAY[SpellName] = SPELLDELAY[SpellName] - 1
					end
					if EventType == "DEBUFF" and VARIABLES_CHECKED and sourceGUID == UnitGUID("player") and not SERVER:match("%.worldofwarcraft%.com$") and not SERVER:match("%.battle%.net$") and not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].debuff_owner_found then
						SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].debuff_owner_found = true
						SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].debuff_owner_checking = true
						CheckVariables()
						LoadOptionsFrameSettings()
						print(L["SpellFlash: Enabled checking to see if debuffs are from you."])
					end
				end
			end
			
	elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
			
			if arg[1] == "player" then
				local SpellName = arg[2]
				AddonTable:SetTimer(SpellName.."ClearSpellDelay", 5, 0,
					function()
						SPELLDELAY[SpellName] = nil
					end
				)
				SPELLDELAY[SpellName] = (SPELLDELAY[SpellName] or 0) + 1
			end
			
	elseif event == "PLAYER_TARGET_CHANGED" then
			
			if UnitExists("target") then
				if IsModifiedClick("FOCUSCAST") then
					CHANGEDMODIFIEDCLICKFOCUSCAST = 1
				else
					SPELLDELAY = {}
				end
			end
			
	elseif event == "PLAYER_FOCUS_CHANGED" then
			
			if UnitExists("focus") then
				if IsModifiedClick("FOCUSCAST") then
					SPELLDELAY = {}
				else
					CHANGEDMODIFIEDCLICKFOCUSCAST = 1
				end
			end
			
	elseif event == "MODIFIER_STATE_CHANGED" then
			
			if MODIFIEDCLICKFOCUSCAST ~= IsModifiedClick("FOCUSCAST") then
				if CHANGEDMODIFIEDCLICKFOCUSCAST then
					CHANGEDMODIFIEDCLICKFOCUSCAST = nil
					SPELLDELAY = {}
				elseif IsModifiedClick("FOCUSCAST") then
					if UnitExists("focus") then
						SPELLDELAY = {}
					end
				elseif UnitExists("target") then
					SPELLDELAY = {}
				end
				MODIFIEDCLICKFOCUSCAST = IsModifiedClick("FOCUSCAST")
			end
			
	elseif event == "ACTIONBAR_HIDEGRID" or event == "LEARNED_SPELL_IN_TAB" or event == "CHARACTER_POINTS_CHANGED" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "UPDATE_MACROS" then
			
			SPELLDELAY = {}
			RegisterTalents()
			RegisterOtherAuras()
			AddonTable:SetTimer("RegisterOutsideMeleeDistanceSpell", 0.5, 0, RegisterOutsideMeleeDistanceSpell)
			if not GLOBAL_COOLDOWN_SPELL and s.HasSpell(GLOBALCOOLDOWNSPELL[CLASS]) then
				GLOBAL_COOLDOWN_SPELL = GLOBALCOOLDOWNSPELL[CLASS]
			end
			
	elseif event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_ALIVE" then
			
			if LOADING then
				AddonTable:SetTimer("RegisterFunctions", 2, 0,
					function()
						if LOADING then
							if VARIABLES_CHECKED then
								LoadAddOns()
								RegisterTalents()
								RegisterOtherAuras()
								RegisterOutsideMeleeDistanceSpell()
								if not GLOBAL_COOLDOWN_SPELL and s.HasSpell(GLOBALCOOLDOWNSPELL[CLASS]) then
									GLOBAL_COOLDOWN_SPELL = GLOBALCOOLDOWNSPELL[CLASS]
								end
								RegisterForm()
								SetSpam()
								LOADING = nil
							else
								AddonTable:ReplaceTimer("RegisterFunctions", 2)
							end
						end
					end
				)
			end
			SPELLDELAY = {}
			
	elseif event == "ADDON_LOADED" then
			
			if arg[1] == AddonName then
				AddonTable:SetTimer("CheckVariables", 0, 0, CheckVariables)
			end
			
	end
end
local Frame = CreateFrame("Frame")
Frame:RegisterEvent("START_AUTOREPEAT_SPELL")
Frame:RegisterEvent("STOP_AUTOREPEAT_SPELL")
Frame:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
Frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
Frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
Frame:RegisterEvent("PLAYER_TARGET_CHANGED")
Frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
Frame:RegisterEvent("MODIFIER_STATE_CHANGED")
Frame:RegisterEvent("ACTIONBAR_HIDEGRID")
Frame:RegisterEvent("LEARNED_SPELL_IN_TAB")
Frame:RegisterEvent("CHARACTER_POINTS_CHANGED")
Frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
Frame:RegisterEvent("UPDATE_MACROS")
Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
Frame:RegisterEvent("PLAYER_ALIVE")
Frame:RegisterEvent("ADDON_LOADED")
Frame:SetScript("OnEvent", OnEvent)

local function SlashHandler(msg)
	local msg = msg:lower()
	if msg:match("reset") or msg:match("clear") or msg:match("wipe") or msg:match("erase") or msg:match("default") then
		VARIABLES_CHECKED = nil
		SpellFlashAddonConfig = nil
		CheckVariables()
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].selected_class_module = next(CLASSMODULES)
		SetSpam()
		LoadOptionsFrameSettings()
		print(L["SpellFlash settings have been reset for all players"])
	elseif msg:match("debuff") then
		s.ShowDebuffs()
	elseif msg:match("buff") then
		s.ShowBuffs()
	else
		InterfaceOptionsFrame_OpenToCategory(SpellFlashAddonOptionsFrame)
	end
end
SlashCmdList.SpellFlashAddon = SlashHandler
SLASH_SpellFlashAddon1 = "/spellflash"
SLASH_SpellFlashAddon2 = "/sflash"
SLASH_SpellFlashAddon3 = "/sf"

CreateFrame("GameTooltip", "SpellFlashAddon_Tooltip", nil, "GameTooltipTemplate")
SpellFlashAddon_Tooltip:SetOwner(UIParent, "ANCHOR_NONE")
SpellFlashAddon_Tooltip:Hide()

local function Immune(SpellName, unit)
	local SpellName = s.SpellName(SpellName, 1)
	local GUID = UnitGUID(TargetOrFocus(unit))
	local Type, ID = s.GUIDInfo(GUID)
	return SpellName and SpellName ~= "" and (
		(
			VARIABLES_CHECKED
			and ( Type == "npc" or Type == "vehicle" )
			and not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].auto_mob_immune_detection_off
			and ( not SpellFlashAddonConfig.SERVER[SERVER].ImmuneIgnore or not SpellFlashAddonConfig.SERVER[SERVER].ImmuneIgnore[Type..ID] )
			and SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS][SpellName] and SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS][SpellName][Type..ID]
		)
		or
		( GUID and AddonTable:IsTimer(SpellName.."TempImmune"..GUID) )
	)
end

-- This is used for testing purposes only
function SpellFlashAddon.ShowBuffs(unit, Debuff)
	local unit = unit
	if not unit then
		if UnitExists("target") then
			unit = "target"
		else
			unit = "player"
		end
	end
	local Debuff = Debuff
	local msg
	if Debuff then
		Debuff = "HARMFUL"
		msg = UnitName(unit).."'s Debuff Slot"
	else
		Debuff = "HELPFUL"
		msg = UnitName(unit).."'s Buff Slot"
	end
	local c = 1
	local name, _, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitAura(unit, c, Debuff)
	if name then
		while name do
			local caster = ""
			if type(unitCaster) == "string" and unitCaster ~= "" and UnitExists(unitCaster) then
				caster = "     From: \""..unitCaster.."\" = "..UnitName(unitCaster)
			end
			print(msg.." "..c..": "..name..caster)
			c = c + 1
			name, _, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitAura(unit, c, Debuff)
		end
	else
		print("All "..msg.."'s are empty.")
	end
end

-- This is used for testing purposes only
function SpellFlashAddon.ShowDebuffs(unit)
	SpellFlashAddon.ShowBuffs(unit, 1)
end

-- This is a test function
function SpellFlashAddon.ShowOffHandType()
	print(ItemSubType(GetInventoryItemLink("player",GetInventorySlotInfo("SecondaryHandSlot"))) or "You do not have a off hand item equipped.")
end






function s.GetModuleConfig(AddonName, config)
	if VARIABLES_CHECKED and type(AddonName) == "string" and AddonName ~= "" and SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].MODULE[AddonName:lower()] then
		return SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].MODULE[AddonName:lower()][config]
	end
	return nil
end

function s.SetModuleConfig(AddonName, config, value)
	if VARIABLES_CHECKED and type(AddonName) == "string" and AddonName ~= "" then
		if not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].MODULE[AddonName:lower()] then
			SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].MODULE[AddonName:lower()] = {}
		end
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].MODULE[AddonName:lower()][config] = value
	end
end

function s.ClearAllModuleConfigs(AddonName)
	if VARIABLES_CHECKED and type(AddonName) == "string" and AddonName ~= "" then
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].MODULE[AddonName:lower()] = {}
	end
end

function s.RegisterOtherAurasFunction(Function)
	tinsert(OtherAurasFunctions, Function)
end

function s.SetOtherAuras(Spell, Aura, Delete)
	local Spell = s.SpellName(Spell, 1)
	if Spell then
		local Aura = s.SpellName(Aura, 1)
		if Aura then
			if Delete then
				if OtherAurasFromSpell[Spell] then
					OtherAurasFromSpell[Spell][Aura] = nil
					if next(OtherAurasFromSpell[Spell]) == nil then
						OtherAurasFromSpell[Spell] = nil
					end
				end
			else
				if not OtherAurasFromSpell[Spell] then
					OtherAurasFromSpell[Spell] = {}
				end
				OtherAurasFromSpell[Spell][Aura] = 1
			end
		end
	end
end

function s.SpellDelay(SpellName)
	local count = 0
	if type(SpellName) == "table" then
		for _, value in ipairs(SpellName) do
			count = count + (s.SpellDelay(value) or 0)
		end
	else
		local SpellName = s.SpellName(SpellName, 1)
		if SpellName then
			if OtherAurasSpellFromAura[SpellName] then
				for spell in pairs(OtherAurasSpellFromAura[SpellName]) do
					count = count + (s.SpellDelay(spell) or 0)
				end
			else
				count = count + (SPELLDELAY[SpellName] or 0)
			end
		end
	end
	if count > 0 then
		return count
	end
	return nil
end

function s.AuraDelay(SpellName, unit)
	if type(SpellName) == "table" then
		for _, value in ipairs(SpellName) do
			if s.AuraDelay(value, unit) then
				return true
			end
		end
		return false
	end
	local SpellName = s.SpellName(SpellName, 1)
	return SpellName and UnitExists(TargetOrFocus(unit)) and AddonTable:IsTimer(SpellName.."AuraDelay"..UnitGUID(TargetOrFocus(unit)))
end

function s.SpellOrAuraDelay(SpellName, unit)
	return not not ( s.AuraDelay(SpellName, unit) or s.SpellDelay(SpellName) )
end

function s.GUIDInfo(GUID)
	if type(GUID) == "string" and GUID ~= "" then
		local Type = ({[0]="player", [3]="npc", [4]="pet", [5]="vehicle"})[tonumber(GUID:sub(5, 5), 16) % 8]
		if Type then
			local ID = tonumber(GUID:sub(unpack(({["player"]={6}, ["npc"]={7, 10}, ["pet"]={6, 12}, ["vehicle"]={7, 10}})[Type])), 16)
			return Type, ID
		end
		return "unknown"
	end
	return nil
end

function s.UnitInfo(unit)
	return s.GUIDInfo(UnitGUID(TargetOrFocus(unit)))
end

function s.Form(form)
	local form = s.SpellName(form, 1)
	if form and CURRENTFORM then
		if form == CURRENTFORM or ALTERNATEFORM[form] == CURRENTFORM then
			return CURRENTFORM
		end
		return nil
	end
	return CURRENTFORM
end

function s.HasTalent(TalentName)
	local TalentName = s.SpellName(TalentName, 1)
	return TalentName and (TALENTRANK[TalentName] or 0) > 0
end

function s.TalentRank(TalentName)
	local TalentName = s.SpellName(TalentName, 1)
	if TalentName then
		return TALENTRANK[TalentName] or 0
	end
	return 0
end

-- this may be used to determine what talent tree has the most points in it
function s.TalentMastery(TreeTabNumber)
	if TreeTabNumber then
		if TreeTabNumber == TALENTMASTERY then
			return TALENTMASTERY
		end
		return nil
	end
	return TALENTMASTERY
end

-- This also works for pet spells.
function s.HasSpell(SpellName)
	local SpellName = s.SpellName(SpellName)
	return type(SpellName) == "string" and SpellName ~= "" and GetSpellInfo(SpellName)
end

function s.HasItem(ItemName)
	local ItemName = s.ItemName(ItemName)
	return type(ItemName) == "string" and ItemName ~= "" and GetItemCount(ItemName) > 0
end


function s.SpellCooldown(SpellName)
	if SpellName then
		local start, duration = GetSpellCooldown(SpellName)
		local TimeLeft = (start or 0) + (duration or 0) - GetTime()
		if TimeLeft > 0 then
			return TimeLeft, duration
		end
	else
		return nil
	end
	return 0, 0
end

function s.ItemCooldown(ItemName)
	if ItemName then
		local ItemID = ItemName
		if type(ItemID) ~= "number" then
			ItemID = ItemIDFromItemName(ItemName)
		end
		if ItemID then
			local start, duration = GetItemCooldown(ItemID)
			local TimeLeft = (start or 0) + (duration or 0) - GetTime()
			if TimeLeft > 0 then
				return TimeLeft, duration
			end
		end
	end
	return 0, 0
end

function s.ActionCooldown(ActionID)
	if type(ActionID) == "number" then
		local start, duration = GetActionCooldown(ActionID)
		local TimeLeft = (start or 0) + (duration or 0) - GetTime()
		if TimeLeft > 0 then
			return TimeLeft, duration
		end
	else
		return nil
	end
	return 0, 0
end

function s.PetActionCooldown(PetActionID)
	if type(PetActionID) == "number" then
		local start, duration = GetPetActionCooldown(PetActionID)
		local TimeLeft = (start or 0) + (duration or 0) - GetTime()
		if TimeLeft > 0 then
			return TimeLeft, duration
		end
	else
		return nil
	end
	return 0, 0
end

function s.Autocast(SpellName)
	local SpellName = s.SpellName(SpellName)
	if SpellName then
		return not not ( select(2, GetSpellAutocast(SpellName)) )
	end
	return false
end

function s.CastTime(SpellName)
	if SpellName then
		return (select(7,GetSpellInfo(SpellName)) or 0) / 1000
	end
	return 0
end

function s.SpellCost(SpellName, PowerType)
	if SpellName then
		local name, rank, icon, cost, isFunnel, powerType = GetSpellInfo(SpellName)
		if not PowerType or PowerType == powerType then
			return cost or 0
		end
	end
	return 0
end


function s.HasGlyph(GlyphName)
	local GlyphName = s.SpellName(GlyphName, 1)
	if GlyphName then
		for i=1,GetNumGlyphSockets() do
			if s.SpellName((select(4, GetGlyphSocketInfo(i))), 1) == GlyphName then
				return true
			end
		end
	end
	return false
end

function s.MeleeDistance(unit)
	if s.HasSpell(MELEESPELL[CLASS]) then
		return s.SpellInRange(MELEESPELL[CLASS], unit)
	end
	return CheckInteractDistance(TargetOrFocus(unit), 3) and ( not OUTSIDEMELEESPELL or not s.SpellInRange(OUTSIDEMELEESPELL, unit) )
end


--Example: s.Class("target", "Death Knight")
--The example above will return true if your target is a Death Knight.
--This function has been made so that english class names must be used with this function even if you are not using an english game client.
--Spaces are allowed in the class name and the class name may also be in upper or lower case when using this function.
function s.Class(unit, class)
	local unit = TargetOrFocus(unit)
	if UnitIsPlayer(unit) then
		local C = select(2, UnitClass(unit))
		if type(class) == "table" then
			for _, v in ipairs(class) do
				if tostring(v):upper():gsub("[^A-Z]", "") == C then
					return C
				end
			end
		elseif type(class) ~= "string" or class:upper():gsub("[^A-Z]", "") == C then
			return C
		end
	end
	return nil
end

--Example: s.Race("target", "Night Elf")
--The example above will return true if your target is a Night Elf.
--This function has been made so that english race names must be used with this function even if you are not using an english game client.
--Spaces are allowed in the race name and the race name may also be in upper or lower case when using this function.
function s.Race(unit, race)
	local unit = TargetOrFocus(unit)
	if UnitIsPlayer(unit) then
		local R = select(2, UnitRace(unit)):upper():gsub("[^A-Z]", ""):gsub("^SCOURGE$", "UNDEAD")
		if type(race) == "table" then
			for _, v in ipairs(race) do
				if tostring(v):upper():gsub("[^A-Z]", ""):gsub("^SCOURGE$", "UNDEAD") == R then
					return R
				end
			end
		elseif type(race) ~= "string" or race:upper():gsub("[^A-Z]", ""):gsub("^SCOURGE$", "UNDEAD") == R then
			return R
		end
	end
	return nil
end

function s.SpellInRange(SpellName, unit)
	return IsSpellInRange(s.SpellName(SpellName), TargetOrFocus(unit)) == 1
end


function s.SpellHasRange(SpellName)
	return SpellHasRange(s.SpellName(SpellName))
end


function s.UsableSpell(SpellName)
	return IsUsableSpell(s.SpellName(SpellName))
end


function s.CurrentSpell(SpellName)
	return IsCurrentSpell(s.SpellName(SpellName))
end

function s.Casting(SpellName, unit, interruptible, NoSubName)
	local name, subtext, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo(TargetOrFocus(unit))
	if name and ( not interruptible or not notInterruptible ) then
		if not SpellName then
			return (endTime / 1000) - GetTime()
		end
		if not NoSubName and subtext and subtext ~= "" then
			name = name.."("..subtext..")"
		end
		if type(SpellName) == "table" then
			for _, SpellName in ipairs(SpellName) do
				if ( s.SpellName(SpellName, NoSubName) or SpellName ) == name then
					return (endTime / 1000) - GetTime()
				end
			end
		elseif ( s.SpellName(SpellName, NoSubName) or SpellName ) == name then
			return (endTime / 1000) - GetTime()
		end
	end
	return nil
end

function s.Channeling(SpellName, unit, interruptible, NoSubName)
	local name, subtext, text, texture, startTime, endTime, isTradeSkill, notInterruptible = UnitChannelInfo(TargetOrFocus(unit))
	if name and ( not interruptible or not notInterruptible ) then
		if not SpellName then
			return (endTime / 1000) - GetTime()
		end
		if not NoSubName and subtext and subtext ~= "" then
			name = name.."("..subtext..")"
		end
		if type(SpellName) == "table" then
			for _, SpellName in ipairs(SpellName) do
				if ( s.SpellName(SpellName, NoSubName) or SpellName ) == name then
					return (endTime / 1000) - GetTime()
				end
			end
		elseif ( s.SpellName(SpellName, NoSubName) or SpellName ) == name then
			return (endTime / 1000) - GetTime()
		end
	end
	return nil
end

function s.CastingOrChanneling(SpellName, unit, interruptible, NoSubName)
	return s.Casting(SpellName, unit, interruptible, NoSubName) or s.Channeling(SpellName, unit, interruptible, NoSubName)
end

function s.GetCasting(SpellName, unit, interruptible, NoSubName)
	return s.Casting(SpellName, unit, interruptible, NoSubName) or 0
end

function s.GetChanneling(SpellName, unit, interruptible, NoSubName)
	return s.Channeling(SpellName, unit, interruptible, NoSubName) or 0
end

function s.GetCastingOrChanneling(SpellName, unit, interruptible, NoSubName)
	return s.CastingOrChanneling(SpellName, unit, interruptible, NoSubName) or 0
end

function s.CastingName(SpellName, unit, interruptible, NoSubName)
	local name, subtext, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo(TargetOrFocus(unit))
	if name and ( not interruptible or not notInterruptible ) then
		if not NoSubName and subtext and subtext ~= "" then
			name = name.."("..subtext..")"
		end
		if not SpellName then
			return name
		end
		if type(SpellName) == "table" then
			for _, SpellName in ipairs(SpellName) do
				if ( s.SpellName(SpellName, NoSubName) or SpellName ) == name then
					return name
				end
			end
		elseif ( s.SpellName(SpellName, NoSubName) or SpellName ) == name then
			return name
		end
	end
	return nil
end

function s.ChannelingName(SpellName, unit, interruptible, NoSubName)
	local name, subtext, text, texture, startTime, endTime, isTradeSkill, notInterruptible = UnitChannelInfo(TargetOrFocus(unit))
	if name and ( not interruptible or not notInterruptible ) then
		if not NoSubName and subtext and subtext ~= "" then
			name = name.."("..subtext..")"
		end
		if not SpellName then
			return name
		end
		if type(SpellName) == "table" then
			for _, SpellName in ipairs(SpellName) do
				if ( s.SpellName(SpellName, NoSubName) or SpellName ) == name then
					return name
				end
			end
		elseif ( s.SpellName(SpellName, NoSubName) or SpellName ) == name then
			return name
		end
	end
	return nil
end

function s.CastingOrChannelingName(SpellName, unit, interruptible, NoSubName)
	return s.CastingName(SpellName, unit, interruptible, NoSubName) or s.ChannelingName(SpellName, unit, interruptible, NoSubName)
end

--Since the PlayerFrame combat variable can be wrong, The same information
--can be accessed here.	Returns true if you are in combat
function s.InCombat()
	return not not InCombatLockdown()
end

function s.Health(unit)
	return UnitHealth(TargetOrFocus(unit)) or 0
end

function s.MaxHealth(unit)
	return UnitHealthMax(TargetOrFocus(unit)) or 0
end

function s.HealthPercent(unit)
	if type(unit) == "string" then
		local group = "|"..unit.."|"
		if group:lower():match("|raid|") or group:lower():match("|party|") then
			local u = "player"
			local r = GetNumRaidMembers()
			local p = GetNumPartyMembers()
			local remaining = 100
			local result
			if not UnitIsDeadOrGhost(u) then
				if not group:lower():match("|notself|") and ( not group:lower():match("|healer|") or HEALERCLASS[CLASS] ) then
					result = ( s.Health(u) / s.MaxHealth(u) ) * 100
					if result < remaining then
						remaining = result
					end
				end
				if group:lower():match("|raid|") and r > 1 then
					for i = 1, r do
						u = "raid"..i
						if not UnitIsUnit(u, "player") and UnitIsVisible(u) and UnitIsConnected(u) and not UnitIsDeadOrGhost(u) and ( not group:lower():match("|afk|") or not UnitIsAFK(u) ) and ( not group:lower():match("|range|") or UnitInRange(u) ) and ( not group:lower():match("|healer|") or HEALERCLASS[s.Class(u)] ) then
							result = ( s.Health(u) / s.MaxHealth(u) ) * 100
							if result < remaining then
								remaining = result
							end
						end
					end
				elseif p > 0 then
					for i = 1, p do
						u = "party"..i
						if UnitIsVisible(u) and UnitIsConnected(u) and not UnitIsDeadOrGhost(u) and ( not group:lower():match("|afk|") or not UnitIsAFK(u) ) and ( not group:lower():match("|range|") or UnitInRange(u) ) and ( not group:lower():match("|healer|") or HEALERCLASS[s.Class(u)] ) then
							result = ( s.Health(u) / s.MaxHealth(u) ) * 100
							if result < remaining then
								remaining = result
							end
						end
					end
				end
			end
			return remaining
		end
	end
	return ( s.Health(unit) / s.MaxHealth(unit) ) * 100
end

function s.HealthDamage(unit)
	return s.MaxHealth(unit) - s.Health(unit)
end

function s.HealthDamagePercent(unit)
	return 100 - s.HealthPercent(unit)
end

function s.Power(unit, PowerType)
	return UnitPower(TargetOrFocus(unit), PowerType) or 0
end

function s.MaxPower(unit, PowerType)
	return UnitPowerMax(TargetOrFocus(unit), PowerType) or 0
end

function s.PowerPercent(unit, PowerType)
	if type(unit) == "string" then
		local group = "|"..unit.."|"
		if group:lower():match("|raid|") or group:lower():match("|party|") then
			local u = "player"
			local r = GetNumRaidMembers()
			local p = GetNumPartyMembers()
			local remaining = 100
			local result
			if not UnitIsDeadOrGhost(u) then
				if not group:lower():match("|notself|") and ( not group:lower():match("|healer|") or HEALERCLASS[CLASS] ) then
					result = ( s.Power(u, PowerType) / s.MaxPower(u, PowerType) ) * 100
					if result < remaining then
						remaining = result
					end
				end
				if group:lower():match("|raid|") and r > 1 then
					for i = 1, r do
						u = "raid"..i
						if not UnitIsUnit(u, "player") and UnitIsVisible(u) and UnitIsConnected(u) and not UnitIsDeadOrGhost(u) and ( not group:lower():match("|afk|") or not UnitIsAFK(u) ) and ( not group:lower():match("|range|") or UnitInRange(u) ) and ( not group:lower():match("|healer|") or HEALERCLASS[s.Class(u)] ) then
							result = ( s.Power(u, PowerType) / s.MaxPower(u, PowerType) ) * 100
							if result < remaining then
								remaining = result
							end
						end
					end
				elseif p > 0 then
					for i = 1, p do
						u = "party"..i
						if UnitIsVisible(u) and UnitIsConnected(u) and not UnitIsDeadOrGhost(u) and ( not group:lower():match("|afk|") or not UnitIsAFK(u) ) and ( not group:lower():match("|range|") or UnitInRange(u) ) and ( not group:lower():match("|healer|") or HEALERCLASS[s.Class(u)] ) then
							result = ( s.Power(u, PowerType) / s.MaxPower(u, PowerType) ) * 100
							if result < remaining then
								remaining = result
							end
						end
					end
				end
			end
			return remaining
		end
	end
	return ( s.Power(unit, PowerType) / s.MaxPower(unit, PowerType) ) * 100
end

function s.PowerMissing(unit, PowerType)
	return s.MaxPower(unit, PowerType) - s.Power(unit, PowerType)
end

function s.PowerMissingPercent(unit, PowerType)
	return 100 - s.PowerPercent(unit, PowerType)
end

function s.UsesMana(unit)
	return UnitPowerType(TargetOrFocus(unit)) == SPELL_POWER_MANA or UnitPowerMax(TargetOrFocus(unit), SPELL_POWER_MANA) > 0
end

function s.HasMana(unit)
	return UnitPower(TargetOrFocus(unit), SPELL_POWER_MANA) > 0
end



function s.Healer(unit)
	if type(unit) == "string" then
		local group = "|"..unit.."|"
		if group:lower():match("|raid|") or group:lower():match("|party|") then
			local u = "player"
			local r = GetNumRaidMembers()
			local p = GetNumPartyMembers()
			if not UnitIsDeadOrGhost(u) then
				if not group:lower():match("|notself|") then
					if HEALERCLASS[CLASS] then
						return u
					end
				end
				if group:lower():match("|raid|") and r > 1 then
					for i = 1, r do
						u = "raid"..i
						if not UnitIsUnit(u, "player") and UnitIsVisible(u) and UnitIsConnected(u) and not UnitIsDeadOrGhost(u) and ( not group:lower():match("|afk|") or not UnitIsAFK(u) ) and ( not group:lower():match("|range|") or UnitInRange(u) ) and HEALERCLASS[s.Class(u)] then
							return u
						end
					end
				elseif p > 0 then
					for i = 1, p do
						u = "party"..i
						if UnitIsVisible(u) and UnitIsConnected(u) and not UnitIsDeadOrGhost(u) and ( not group:lower():match("|afk|") or not UnitIsAFK(u) ) and ( not group:lower():match("|range|") or UnitInRange(u) ) and HEALERCLASS[s.Class(u)] then
							return u
						end
					end
				end
			end
			return nil
		end
	end
	local u = TargetOrFocus(unit)
	if UnitIsUnit(u, "player") then
		if not UnitIsDeadOrGhost(u) and HEALERCLASS[CLASS] then
			return u
		end
	elseif UnitIsPlayer(u) and UnitIsVisible(u) and UnitIsConnected(u) and not UnitIsDeadOrGhost(u) and HEALERCLASS[s.Class(u)] then
		return u
	end
	return nil
end


--returns true if all of the debuff slots are used
function s.AllDebuffSlotsUsed(unit)
	return not not UnitAura(TargetOrFocus(unit), MAXDEBUFFSLOTS, "HARMFUL")
end


--Looks through all buffs looking for a match
function s.Buff(SpellName, unit, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo, Type, owner, GiveExpirationTime, GiveApplications, Debuff)
	if type(unit) == "string" then
		local group = "|"..unit.."|"
		if group:lower():match("|raid|") or group:lower():match("|party|") then
			local u = "player"
			local r = GetNumRaidMembers()
			local p = GetNumPartyMembers()
			if group:lower():match("|all|") then
				if GiveApplications or GiveExpirationTime then
					return 0
				end
				if not UnitIsDeadOrGhost(u) then
					if not group:lower():match("|notself|") and ( not group:lower():match("|healer|") or HEALERCLASS[CLASS] ) then
						if not s.Buff(SpellName, u, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo, Type, owner, GiveExpirationTime, GiveApplications, Debuff) then
							return false
						end
					end
					if group:lower():match("|raid|") and r > 1 then
						for i = 1, r do
							u = "raid"..i
							if not UnitIsUnit(u, "player") and UnitIsVisible(u) and UnitIsConnected(u) and not UnitIsDeadOrGhost(u) and ( not group:lower():match("|afk|") or not UnitIsAFK(u) ) and ( not group:lower():match("|range|") or UnitInRange(u) ) and ( not group:lower():match("|healer|") or HEALERCLASS[s.Class(u)] ) then
								if not s.Buff(SpellName, u, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo, Type, owner, GiveExpirationTime, GiveApplications, Debuff) then
									return false
								end
							end
						end
					elseif p > 0 then
						for i = 1, p do
							u = "party"..i
							if UnitIsVisible(u) and UnitIsConnected(u) and not UnitIsDeadOrGhost(u) and ( not group:lower():match("|afk|") or not UnitIsAFK(u) ) and ( not group:lower():match("|range|") or UnitInRange(u) ) and ( not group:lower():match("|healer|") or HEALERCLASS[s.Class(u)] ) then
								if not s.Buff(SpellName, u, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo, Type, owner, GiveExpirationTime, GiveApplications, Debuff) then
									return false
								end
							end
						end
					end
				end
				return true
			else
				local remaining = 0
				local result
				if not UnitIsDeadOrGhost(u) then
					if not group:lower():match("|notself|") and ( not group:lower():match("|healer|") or HEALERCLASS[CLASS] ) then
						result = s.Buff(SpellName, u, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo, Type, owner, GiveExpirationTime, GiveApplications, Debuff)
						if result then
							if not GiveExpirationTime then
								return result
							elseif result > remaining then
								remaining = result
							end
						end
					end
					if group:lower():match("|raid|") and r > 1 then
						for i = 1, r do
							u = "raid"..i
							if not UnitIsUnit(u, "player") and UnitIsVisible(u) and UnitIsConnected(u) and not UnitIsDeadOrGhost(u) and ( not group:lower():match("|afk|") or not UnitIsAFK(u) ) and ( not group:lower():match("|range|") or UnitInRange(u) ) and ( not group:lower():match("|healer|") or HEALERCLASS[s.Class(u)] ) then
								result = s.Buff(SpellName, u, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo, Type, owner, GiveExpirationTime, GiveApplications, Debuff)
								if result then
									if not GiveExpirationTime then
										return result
									elseif result > remaining then
										remaining = result
									end
								end
							end
						end
					elseif p > 0 then
						for i = 1, p do
							u = "party"..i
							if UnitIsVisible(u) and UnitIsConnected(u) and not UnitIsDeadOrGhost(u) and ( not group:lower():match("|afk|") or not UnitIsAFK(u) ) and ( not group:lower():match("|range|") or UnitInRange(u) ) and ( not group:lower():match("|healer|") or HEALERCLASS[s.Class(u)] ) then
								result = s.Buff(SpellName, u, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo, Type, owner, GiveExpirationTime, GiveApplications, Debuff)
								if result then
									if not GiveExpirationTime then
										return result
									elseif result > remaining then
										remaining = result
									end
								end
							end
						end
					end
				end
				if GiveApplications or GiveExpirationTime then
					return remaining
				end
				return false
			end
		elseif unit:lower() == "mainhandslot" or unit:lower() == "secondaryhandslot" then
			if GiveApplications or GiveExpirationTime then
				return 0
			end
			local slot = GetInventorySlotInfo(unit)
			if SpellName and GetInventoryItemLink("player", slot) then
				SpellFlashAddon_Tooltip:SetInventoryItem("player", slot)
				for i=1,SpellFlashAddon_Tooltip:NumLines() do
					local line = _G["SpellFlashAddon_TooltipTextLeft"..i]:GetText()
					if line then
						if line:match(SpellName) then
							return true
						end
					end
				end
			end
			return false
		end
	end
	if type(SpellName) == "table" then
		local remaining = 0
		for _, v in ipairs(SpellName) do
			local result = s.Buff(v, unit, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo, Type, owner, GiveExpirationTime, GiveApplications, Debuff)
			if result then
				if not GiveExpirationTime then
					return result
				elseif result > remaining then
					remaining = result
				end
			end
		end
		if GiveApplications or GiveExpirationTime then
			return remaining
		end
		return false
	end
	local SpellName = s.SpellName(SpellName, 1)
	local d = "HELPFUL"
	local u = TargetOrFocus(unit)
	if Debuff then
		d = "HARMFUL"
	end
	if UnitExists(u) then
		local m = ""
		if owner == 1 and ( not Debuff or not DISABLE_DEBUFF_OWNER_CHECKING ) then
			m = "|PLAYER"
		end
		local c = ""
		if Castable then
			c = "|RAID"
		end
		local t = SpellToolTipLineTwo
		if SpellName and not t then
			local name, _, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitAura(u, SpellName, nil, d..m..c)
			if name
			and ( not Type or Type:lower() == tostring(debuffType):lower() )
			and ( not Stealable or isStealable )
			and ( not GiveExpirationTime or expirationTime ~= 0 )
			and ( owner ~= 2 or ( type(unitCaster) == "string" and unitCaster ~= "" and UnitIsUnit(unitCaster, u) ) )
			and ( type(DurationRemainingGreaterThan) ~= "number" or DurationRemainingGreaterThan <= 0 or expirationTime == 0 or ( expirationTime - GetTime() ) > DurationRemainingGreaterThan ) then
				if GiveApplications then
					if count == 0 then
						return 1
					end
					return count
				elseif GiveExpirationTime then
					return expirationTime - GetTime()
				end
				return true
			end
		elseif not SpellName or UnitAura(u, SpellName, nil, d..m..c) then
			local i = 1
			while UnitAura(u, i, d) do
				local name, _, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitAura(u, i, d..m..c)
				if name
				and ( not SpellName or SpellName == name )
				and ( not Type or Type:lower() == tostring(debuffType):lower() )
				and ( not Stealable or isStealable )
				and ( not GiveExpirationTime or expirationTime ~= 0 )
				and ( owner ~= 2 or ( type(unitCaster) == "string" and unitCaster ~= "" and UnitIsUnit(unitCaster, u) ) )
				and ( type(DurationRemainingGreaterThan) ~= "number" or DurationRemainingGreaterThan <= 0 or expirationTime == 0 or ( expirationTime - GetTime() ) > DurationRemainingGreaterThan ) then
					if t then
						SpellFlashAddon_Tooltip:SetUnitAura(u, i, d)
						if tostring(SpellFlashAddon_TooltipTextLeft2:GetText()):match(t) then
							t = nil
						end
					end
					if not t then
						if GiveApplications then
							if count == 0 then
								return 1
							end
							return count
						elseif GiveExpirationTime then
							return expirationTime - GetTime()
						end
						return true
					end
				end
				i = i + 1
			end
		end
	end
	if GiveApplications or GiveExpirationTime then
		return 0
	end
	return false
end

function s.BuffStack(SpellName, unit, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo)
	return s.Buff(SpellName, unit, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo, nil, nil, nil, 1)
end

function s.BuffDuration(SpellName, unit, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo)
	return s.Buff(SpellName, unit, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo, nil, nil, 1)
end

function s.MyBuff(SpellName, unit, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo)
	return s.Buff(SpellName, unit, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo, nil, 1)
end

function s.MyBuffStack(SpellName, unit, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo)
	return s.Buff(SpellName, unit, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo, nil, 1, nil, 1)
end

function s.MyBuffDuration(SpellName, unit, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo)
	return s.Buff(SpellName, unit, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo, nil, 1, 1)
end

function s.SelfBuff(SpellName, unit, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo)
	return s.Buff(SpellName, unit, DurationRemainingGreaterThan, Stealable, Castable, SpellToolTipLineTwo, nil, 2)
end

function s.Debuff(SpellName, unit, DurationRemainingGreaterThan, Stealable, Dispelable, SpellToolTipLineTwo, Type)
	return s.Buff(SpellName, unit, DurationRemainingGreaterThan, Stealable, Dispelable, SpellToolTipLineTwo, Type, nil, nil, nil, 1)
end

function s.DebuffStack(SpellName, unit, DurationRemainingGreaterThan, Stealable, Dispelable, SpellToolTipLineTwo, Type)
	return s.Buff(SpellName, unit, DurationRemainingGreaterThan, Stealable, Dispelable, SpellToolTipLineTwo, Type, nil, nil, 1, 1)
end

function s.DebuffDuration(SpellName, unit, DurationRemainingGreaterThan, Stealable, Dispelable, SpellToolTipLineTwo, Type)
	return s.Buff(SpellName, unit, DurationRemainingGreaterThan, Stealable, Dispelable, SpellToolTipLineTwo, Type, nil, 1, nil, 1)
end

function s.MyDebuff(SpellName, unit, DurationRemainingGreaterThan, Stealable, Dispelable, SpellToolTipLineTwo, Type)
	return s.Buff(SpellName, unit, DurationRemainingGreaterThan, Stealable, Dispelable, SpellToolTipLineTwo, Type, 1, nil, nil, 1)
end

function s.MyDebuffStack(SpellName, unit, DurationRemainingGreaterThan, Stealable, Dispelable, SpellToolTipLineTwo, Type)
	return s.Buff(SpellName, unit, DurationRemainingGreaterThan, Stealable, Dispelable, SpellToolTipLineTwo, Type, 1, nil, 1, 1)
end

function s.MyDebuffDuration(SpellName, unit, DurationRemainingGreaterThan, Stealable, Dispelable, SpellToolTipLineTwo, Type)
	return s.Buff(SpellName, unit, DurationRemainingGreaterThan, Stealable, Dispelable, SpellToolTipLineTwo, Type, 1, 1, nil, 1)
end


function s.MainHandItemBuff(SpellName)
	return s.Buff(SpellName, "MainHandSlot")
end

function s.OffHandItemBuff(SpellName)
	return s.Buff(SpellName, "SecondaryHandSlot")
end


function s.Enemy(unit)
	local unit = TargetOrFocus(unit)
	return UnitExists(unit) and UnitCanAttack("player", unit) and ( not UnitIsDeadOrGhost(unit) or UnitExists(unit.."target") or UnitAffectingCombat(unit) )
end

function s.ActiveEnemy(unit)
	local unit = TargetOrFocus(unit)
	return s.Enemy(unit) and ( UnitAffectingCombat(unit) or UnitIsPlayer(unit) or UnitIsDummy(unit) ) and not UnitIsDeadOrGhost(unit) and not s.NoDamageCC(unit)
end

function s.GivesXP(unit)
	local unit = TargetOrFocus(unit)
	return s.Enemy(unit) and not UnitIsTrivial(unit) and UnitFactionGroup(unit) ~= UnitFactionGroup("player") and ( not UnitPlayerControlled(unit) or UnitIsPlayer(unit) ) and ( UnitIsPlayer(unit) or not UnitIsTapped(unit) or UnitIsTappedByPlayer(unit) or UnitIsTappedByAllThreatList(unit) )
end

function s.Boss(unit)
	local unit = TargetOrFocus(unit)
	return UnitExists(unit) and ( tostring(UnitClassification(unit)):lower():match("boss") or ( UnitLevel(unit) == -1 and not UnitPlayerControlled(unit) ) )
end

function s.EnemyTargetingYourFriend(unit)
	local unit = TargetOrFocus(unit)
	return s.Enemy(unit) and not UnitIsUnit(unit.."target", "player") and UnitIsFriend("player", unit.."target")
end

function s.EnemyTargetingYou(unit)
	local unit = TargetOrFocus(unit)
	return s.Enemy(unit) and UnitIsUnit(unit.."target", "player")
end

function s.SameTargetAsPet(unit)
	local unit = TargetOrFocus(unit)
	return UnitExists("pettarget") and UnitIsUnit(unit, "pettarget")
end


-- 15590--[[Fist Weapons]]
-- 227--[[Staves]]
-- 200--[[Polearms]]
-- 198--[[One-Handed Maces]]
-- 199--[[Two-Handed Maces]]
-- 196--[[One-Handed Axes]]
-- 197--[[Two-Handed Axes]]
-- 201--[[One-Handed Swords]]
-- 202--[[Two-Handed Swords]]
-- 1180--[[Daggers]]

-- checks to see if a fist weapon is equipped in the main hand
function s.MainHand(ItemType)
	if type(ItemType) == "table" then
		for _, v in ipairs(ItemType) do
			local result = s.MainHand(v)
			if result then
				return result
			end
		end
	else
		local ItemType = ItemType
		if type(ItemType) == "number" then
			ItemType = s.SpellName(ItemType, 1)
			if not ItemType then
				return nil
			end
		end
		local slot = GetInventorySlotInfo("MainHandSlot")
		local Type = ItemSubType(GetInventoryItemLink("player", slot))
		if Type and not GetInventoryItemBroken("player", slot) and ( not ItemType or Type == ItemType ) then
			return Type
		end
	end
	return nil
end

-- checks to see if a fist weapon is equipped in the main hand
function s.OffHand(ItemType)
	if type(ItemType) == "table" then
		for _, v in ipairs(ItemType) do
			local result = s.MainHand(v)
			if result then
				return result
			end
		end
	else
		local ItemType = ItemType
		if type(ItemType) == "number" then
			ItemType = s.SpellName(ItemType, 1)
			if not ItemType then
				return nil
			end
		end
		local slot = GetInventorySlotInfo("SecondaryHandSlot")
		local Type = ItemSubType(GetInventoryItemLink("player", slot))
		if Type and not GetInventoryItemBroken("player", slot) and ( not ItemType or Type == ItemType ) then
			return Type
		end
	end
	return nil
end


-- checks to see if a shield is equipped
function s.ShieldEquipped()
	return s.OffHand(L["Shields"])
end


function s.Equipped(ItemName, Slot)
	if type(ItemName) == "table" then
		for _, v in ipairs(ItemName) do
			local result = s.Equipped(v, Slot)
			if result then
				return result
			end
		end
	else
		local ItemName = s.ItemName(ItemName)
		if Slot then
			local Slot = Slot
			if type(Slot) == "string" then
				Slot = GetInventorySlotInfo(Slot)
			end
			if type(Slot) == "number" then
				local link = GetInventoryItemLink("player", Slot)
				if link and not GetInventoryItemBroken("player", Slot) and ( not ItemName or ItemName == DecodeItemLink(link) ) then
					return Slot
				end
			end
		elseif ItemName then
			for i=0,19 do
				if DecodeItemLink(GetInventoryItemLink("player", i)) == ItemName and not GetInventoryItemBroken("player", i) then
					return i
				end
			end
		end
	end
	return nil
end


function s.Shooting()
	return not not SHOOT
end

function s.PetCastable(SpellName, PetFrameNeeded, PetHealthNotNeeded, GlobalCooldownSpell, EvenIfNotUsable)
	local SpellName = s.SpellName(SpellName)
	if type(SpellName) == "string" and SpellName ~= "" and ( AddonTable.PetActions[SpellName] or s.HasSpell(SpellName) ) and not s.CastingOrChanneling(SpellName, "pet") and ( PetHealthNotNeeded or UnitHealth("pet") > 0 ) and ( not PetFrameNeeded or UnitExists("pet") ) then
		for n = 1, NUM_PET_ACTION_SLOTS do
			local name, subtext, texture, isToken, isActive = GetPetActionInfo(n)
			if subtext and subtext ~= "" then
				name = name.."("..subtext..")"
			end
			if ( AddonTable.PetActions[SpellName] or SpellName ) == name then
				local globalcooldown = nil
				local GlobalCooldownSpell = s.SpellName(GlobalCooldownSpell)
				if s.HasSpell(GlobalCooldownSpell) then
					globalcooldown = s.SpellCooldown(GlobalCooldownSpell)
				end
				local Lag = select(3, GetNetStats()) / 1000
				local cooldown, duration = s.PetActionCooldown(n)
				return not isActive and ( EvenIfNotUsable or GetPetActionSlotUsable(n) ) and ( duration <= 1.5 or cooldown <= Lag or ( globalcooldown and cooldown <= 1.5 and cooldown <= globalcooldown ) )
			end
		end
	end
	return false
end


function s.CheckIfSpellCastable(InfoArray)
	local z = InfoArray
	if type(z.SpellID) == "number" then
		z.SpellName = s.SpellName(z.SpellID)
	elseif type(z.SpellName) == "number" then
		z.SpellID = z.SpellName
		z.SpellName = s.SpellName(z.SpellID)
	end
	if not z.SpellName or not s.HasSpell(z.SpellName) then
		return false
	end
	z.Unit = TargetOrFocus(z.Unit)
	if z.EnemyTargetNeeded and Immune(z.SpellID, z.Unit) then
		return false
	end
	local Lag = select(3, GetNetStats()) / 1000
	local CastingTimeLeft = s.GetCasting(nil, "player")
	local CastingOrChanneling = s.CastingOrChanneling(z.SpellName, "player")
	local isUsable, notEnoughPower = s.UsableSpell(z.SpellName)
	local name, rank, icon, cost, isFunnel, powerType, castTime = GetSpellInfo(z.SpellID)
	local SpellCastPower = s.SpellCost(s.CastingName(nil, "player"), powerType)
	local globalcooldown = s.SpellCooldown(GLOBAL_COOLDOWN_SPELL)
	local cooldown, duration = s.SpellCooldown(z.SpellID)
	local Aura = z.Debuff or z.Buff or z.MyDebuff or z.MyBuff
	z.CastTime = z.CastTime or (castTime or 0) / 1000
	return (( z.EvenIfNotUsable or isUsable ) and not notEnoughPower
		and ( SUPPRESS_SPEED_CHECK or not z.NotWhileMoving or GetUnitSpeed("player") == 0 )
		and ( SpellCastPower == 0 or UnitPower("player", powerType) >= (cost or 0) + SpellCastPower )
		and ( cooldown <= Lag + CastingTimeLeft or ( not globalcooldown and duration <= 1.5 ) or ( globalcooldown and cooldown <= globalcooldown ) )
		and ( ( not z.NotIfActive and not Aura ) or ( not s.CurrentSpell(z.SpellName) and not CastingOrChanneling ) or ( not Aura and CastingOrChanneling and CastingOrChanneling <= Lag ) )
		and ( SUPPRESS_RANGE_CHECK or z.NoRangeCheck or UnitIsUnit(z.Unit, "player") or UnitIsUnit(z.Unit, "vehicle") or not s.SpellHasRange(z.SpellName) or s.SpellInRange(z.SpellName, z.Unit) )
		and ( not z.EnemyTargetNeeded or s.Enemy(z.Unit) )
		and ( not z.TargetThatUsesManaNeeded or s.UsesMana(z.Unit) )
		and ( not z.DebuffSlotNeeded or not s.AllDebuffSlotsUsed(z.Unit) )
		and ( not z.Debuff or ( not s.SpellOrAuraDelay(z.Debuff, z.Unit) and not s.Debuff(z.Debuff, z.BuffUnit or z.Unit, z.CastTime + CastingTimeLeft + cooldown + (Lag * 2)) ) )
		and ( not z.Buff or ( not s.SpellOrAuraDelay(z.Buff, z.Unit) and not s.Buff(z.Buff, z.BuffUnit or z.Unit, z.CastTime + CastingTimeLeft + cooldown + (Lag * 2)) ) )
		and ( not z.MyDebuff or ( not s.SpellOrAuraDelay(z.MyDebuff, z.Unit) and not s.MyDebuff(z.MyDebuff, z.BuffUnit or z.Unit, z.CastTime + CastingTimeLeft + cooldown + (Lag * 2)) ) )
		and ( not z.MyBuff or ( not s.SpellOrAuraDelay(z.MyBuff, z.Unit) and not s.MyBuff(z.MyBuff, z.BuffUnit or z.Unit, z.CastTime + CastingTimeLeft + cooldown + (Lag * 2)) ) )
	)
end


function s.CheckIfItemCastable(InfoArray)
	local z = InfoArray
	if type(z.ItemID) == "number" then
		z.ItemName = s.ItemName(z.ItemID)
	elseif type(z.ItemName) == "number" then
		z.ItemID = z.ItemName
		z.ItemName = s.ItemName(z.ItemID)
	else
		z.ItemID = ItemIDFromItemName(z.ItemName)
	end
	if not z.ItemName or not s.HasItem(z.ItemName) then
		return false
	end
	z.Unit = TargetOrFocus(z.Unit)
	if z.EnemyTargetNeeded and Immune(z.ItemName, z.Unit) then
		return false
	end
	local Lag = select(3, GetNetStats()) / 1000
	local CastingTimeLeft = s.GetCasting(nil, "player")
	local CastingOrChanneling = s.CastingOrChanneling(z.ItemName, "player")
	local isUsable, notEnoughPower = IsUsableItem(z.ItemID)
	local globalcooldown = s.SpellCooldown(GLOBAL_COOLDOWN_SPELL)
	local cooldown, duration = s.ItemCooldown(z.ItemID)
	local Aura = z.Debuff or z.Buff or z.MyDebuff or z.MyBuff
	z.CastTime = z.CastTime or 0
	return (( z.EvenIfNotUsable or isUsable ) and not notEnoughPower
		and ( SUPPRESS_SPEED_CHECK or not z.NotWhileMoving or GetUnitSpeed("player") == 0 )
		and ( not IsEquippableItem(z.ItemID) or IsEquippedItem(z.ItemID) )
		and ( cooldown <= Lag + CastingTimeLeft or ( not globalcooldown and duration <= 1.5 ) or ( globalcooldown and cooldown <= globalcooldown ) )
		and ( ( not z.NotIfActive and not Aura ) or ( not IsCurrentItem(z.ItemID) and not CastingOrChanneling ) or ( not Aura and CastingOrChanneling and CastingOrChanneling <= Lag ) )
		and ( SUPPRESS_RANGE_CHECK or z.NoRangeCheck or UnitIsUnit(z.Unit, "player") or UnitIsUnit(z.Unit, "vehicle") or not ItemHasRange(z.ItemID) or IsItemInRange(z.ItemID, z.Unit) == 1 )
		and ( not z.EnemyTargetNeeded or s.Enemy(z.Unit) )
		and ( not z.TargetThatUsesManaNeeded or s.UsesMana(z.Unit) )
		and ( not z.DebuffSlotNeeded or not s.AllDebuffSlotsUsed(z.Unit) )
		and ( not z.Debuff or ( not s.SpellOrAuraDelay(z.Debuff, z.Unit) and not s.Debuff(z.Debuff, z.BuffUnit or z.Unit, z.CastTime + CastingTimeLeft + cooldown + (Lag * 2)) ) )
		and ( not z.Buff or ( not s.SpellOrAuraDelay(z.Buff, z.Unit) and not s.Buff(z.Buff, z.BuffUnit or z.Unit, z.CastTime + CastingTimeLeft + cooldown + (Lag * 2)) ) )
		and ( not z.MyDebuff or ( not s.SpellOrAuraDelay(z.MyDebuff, z.Unit) and not s.MyDebuff(z.MyDebuff, z.BuffUnit or z.Unit, z.CastTime + CastingTimeLeft + cooldown + (Lag * 2)) ) )
		and ( not z.MyBuff or ( not s.SpellOrAuraDelay(z.MyBuff, z.Unit) and not s.MyBuff(z.MyBuff, z.BuffUnit or z.Unit, z.CastTime + CastingTimeLeft + cooldown + (Lag * 2)) ) )
	)
end


function s.CheckIfVehicleSpellCastable(InfoArray)
	if not UnitHasVehicleUI("player") then return false end
	local z = InfoArray
	if type(z.SpellID) == "number" then
		z.SpellName = s.SpellName(z.SpellID)
	elseif type(z.SpellName) == "number" then
		z.SpellID = z.SpellName
		z.SpellName = s.SpellName(z.SpellID)
	end
	if not z.SpellName then
		return false
	end
	z.Unit = TargetOrFocus(z.Unit)
	if z.EnemyTargetNeeded and Immune(z.SpellID, z.Unit) then
		return false
	end
	local slot = VehicleSlot(z.SpellName)
	if not slot then
		return false
	end
	local Lag = select(3, GetNetStats()) / 1000
	local CastingTimeLeft = s.GetCasting(nil, "vehicle")
	local CastingOrChanneling = s.CastingOrChanneling(z.SpellName, "vehicle")
	local isUsable, notEnoughPower = IsUsableAction(slot)
	local globalcooldown = s.ActionCooldown(VehicleSlot(z.GlobalVehicleCooldownSpell))
	local cooldown, duration = s.ActionCooldown(slot)
	local Aura = z.Debuff or z.Buff or z.MyDebuff or z.MyBuff
	z.CastTime = z.CastTime or 0
	return (( z.EvenIfNotUsable or isUsable ) and not notEnoughPower
		and ( SUPPRESS_SPEED_CHECK or not z.NotWhileMoving or GetUnitSpeed("player") == 0 )
		and ( duration <= 1.5 or cooldown <= Lag + CastingTimeLeft or ( globalcooldown and cooldown <= 1.5 and cooldown <= globalcooldown ) )
		and ( ( not z.NotIfActive and not Aura ) or ( not IsCurrentAction(slot) and not CastingOrChanneling ) or ( not Aura and CastingOrChanneling and CastingOrChanneling <= Lag ) )
		and ( SUPPRESS_RANGE_CHECK or z.NoRangeCheck or UnitIsUnit(z.Unit, "player") or UnitIsUnit(z.Unit, "vehicle") or not ActionHasRange(slot) or IsActionInRange(slot, z.Unit) == 1 )
		and ( not z.EnemyTargetNeeded or s.Enemy(z.Unit) )
		and ( not z.TargetThatUsesManaNeeded or s.UsesMana(z.Unit) )
		and ( not z.DebuffSlotNeeded or not s.AllDebuffSlotsUsed(z.Unit) )
		and ( not z.Debuff or ( not s.SpellOrAuraDelay(z.Debuff, z.Unit) and not s.Debuff(z.Debuff, z.BuffUnit or z.Unit, z.CastTime + CastingTimeLeft + cooldown + (Lag * 2)) ) )
		and ( not z.Buff or ( not s.SpellOrAuraDelay(z.Buff, z.Unit) and not s.Buff(z.Buff, z.BuffUnit or z.Unit, z.CastTime + CastingTimeLeft + cooldown + (Lag * 2)) ) )
		and ( not z.MyDebuff or ( not s.SpellOrAuraDelay(z.MyDebuff, z.Unit) and not s.MyDebuff(z.MyDebuff, z.BuffUnit or z.Unit, z.CastTime + CastingTimeLeft + cooldown + (Lag * 2)) ) )
		and ( not z.MyBuff or ( not s.SpellOrAuraDelay(z.MyBuff, z.Unit) and not s.MyBuff(z.MyBuff, z.BuffUnit or z.Unit, z.CastTime + CastingTimeLeft + cooldown + (Lag * 2)) ) )
	)
end



function s.BreakOnDamageCC(unit, DurationRemainingGreaterThan, Stealable, Dispelable)
	return s.Debuff(AddonTable.BreakOnDamage, unit, DurationRemainingGreaterThan, Stealable, Dispelable)
		or s.Debuff(19386--[[Wyvern Sting]], unit, DurationRemainingGreaterThan, Stealable, Dispelable, L["Asleep"])
end


function s.ImmunityDebuff(unit, DurationRemainingGreaterThan, Stealable, Dispelable)
	return s.Debuff(AddonTable.ImmunityDebuffs, unit, DurationRemainingGreaterThan, Stealable, Dispelable)
end


--all forms of fear and movement impairing affects are not included since they do not prevent the target from being damaged
--Mind Control is no longer included as a CC in this function
function s.NoDamageCC(unit, DurationRemainingGreaterThan, Stealable, Dispelable)
	return s.BreakOnDamageCC(unit, DurationRemainingGreaterThan, Stealable, Dispelable)
	or s.ImmunityDebuff(unit, DurationRemainingGreaterThan, Stealable, Dispelable)
end


--movement impairing affects are not included since the target could still attack
function s.CrowedControlled(unit, DurationRemainingGreaterThan, Stealable, Dispelable)
	return s.NoDamageCC(unit, DurationRemainingGreaterThan, Stealable, Dispelable)
	or s.Feared(unit, DurationRemainingGreaterThan, Stealable, Dispelable)
end


--movement impairing affects are not included since the target could still attack
function s.Feared(unit, DurationRemainingGreaterThan, Stealable, Dispelable)
	return s.Debuff(AddonTable.Fear, unit, DurationRemainingGreaterThan, Stealable, Dispelable)
end


function s.Rooted(unit, DurationRemainingGreaterThan, Stealable, Dispelable)
	return s.Debuff(AddonTable.Root, unit, DurationRemainingGreaterThan, Stealable, Dispelable)
end


function s.MovementImpaired(unit, DurationRemainingGreaterThan, Stealable, Dispelable)
	return s.Rooted(unit, DurationRemainingGreaterThan, Stealable, Dispelable)
	or s.Debuff(AddonTable.MovementImpairing, unit, DurationRemainingGreaterThan, Stealable, Dispelable)
end


function s.Poisoned(unit, DurationRemainingGreaterThan, Stealable, Dispelable)
	return s.Debuff(nil, unit, DurationRemainingGreaterThan, Stealable, Dispelable, nil, "Poison")
end

function s.Diseased(unit, DurationRemainingGreaterThan, Stealable, Dispelable)
	return s.Debuff(nil, unit, DurationRemainingGreaterThan, Stealable, Dispelable, nil, "Disease")
end



function s.FlashSizePercent()
	return FLASH_SIZE_PERCENT or DEFAULT_FLASH_SIZE_PERCENT
end

function s.FlashBrightnessPercent()
	return FLASH_BRIGHTNESS_PERCENT or DEFAULT_FLASH_BRIGHTNESS_PERCENT
end

function s.Flashable(SpellName, NoMacros)
	return SpellFlashCore.Flashable(SpellName, NoMacros or DISABLE_MACRO_FLASHING)
end

function s.Flash(SpellName, color, size, brightness, blink, NoMacros)
	SpellFlashCore.FlashAction(SpellName, color, size or FLASH_SIZE_PERCENT or DEFAULT_FLASH_SIZE_PERCENT, brightness or FLASH_BRIGHTNESS_PERCENT or DEFAULT_FLASH_BRIGHTNESS_PERCENT, blink or ENABLE_BLINKING, NoMacros or DISABLE_MACRO_FLASHING)
end

function s.VehicleFlashable(SpellName)
	return not not VehicleSlot(SpellName)
end

function s.FlashVehicle(SpellName, color, size, brightness, blink)
	SpellFlashCore.FlashVehicle(SpellName, color, size or FLASH_SIZE_PERCENT or DEFAULT_FLASH_SIZE_PERCENT, brightness or FLASH_BRIGHTNESS_PERCENT or DEFAULT_FLASH_BRIGHTNESS_PERCENT, blink or ENABLE_BLINKING)
end

function s.FlashPet(SpellName, color, size, brightness, blink)
	SpellFlashCore.FlashPet(SpellName, color, size or FLASH_SIZE_PERCENT or DEFAULT_FLASH_SIZE_PERCENT, brightness or FLASH_BRIGHTNESS_PERCENT or DEFAULT_FLASH_BRIGHTNESS_PERCENT, blink or ENABLE_BLINKING)
end

function s.FlashForm(SpellName, color, size, brightness, blink)
	SpellFlashCore.FlashForm(SpellName, color, size or FLASH_SIZE_PERCENT or DEFAULT_FLASH_SIZE_PERCENT, brightness or FLASH_BRIGHTNESS_PERCENT or DEFAULT_FLASH_BRIGHTNESS_PERCENT, blink or ENABLE_BLINKING)
end

