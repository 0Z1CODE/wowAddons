local AddonName, AddonTable = ...
if not AddonTable.OldBuild then return end
local L = AddonTable.Localize
LibStub:GetLibrary("BigLibTimer3"):Register(AddonTable)
SpellFlashAddon = {}
local function SpellName(GlobalSpellID)
	return (GetSpellInfo(GlobalSpellID))
end
local function ItemName(GlobalItemID)
	return (GetItemInfo(GlobalItemID))
end


local MAXDEBUFFSLOTS = 40

local MELEESPELL = {
	DEATHKNIGHT = SpellName(45902--[[Blood Strike]]),
	DRUID = SpellName(1082--[[Claw]]),
	HUNTER = SpellName(2974--[[Wing Clip]]),
	ROGUE = SpellName(1752--[[Sinister Strike]]),
	WARRIOR = SpellName(772--[[Rend]]),
}

local GLOBALCOOLDOWNSPELL = {
	DEATHKNIGHT = SpellName(45902--[[Blood Strike]]),
	DRUID = SpellName(5176--[[Wrath]]),
	HUNTER = SpellName(1978--[[Serpent Sting]]),
	MAGE = SpellName(133--[[Fireball]]),
	PALADIN = SpellName(635--[[Holy Light]]),
	PRIEST = SpellName(585--[[Smite]]),
	ROGUE = SpellName(1752--[[Sinister Strike]]),
	SHAMAN = SpellName(403--[[Lightning Bolt]]),
	WARLOCK = SpellName(686--[[Shadow Bolt]]),
	WARRIOR = SpellName(6673--[[Battle Shout]]),
}

AddonTable.ImmunityDebuffs = {
	SpellName(710--[[Banish]]),
	SpellName(33786--[[Cyclone]]),
}

local ALTERNATEFORM = {
	[SpellName(33943--[[Flight Form]])] = SpellName(40120--[[Swift Flight Form]]),
	[SpellName(40120--[[Swift Flight Form]])] = SpellName(33943--[[Flight Form]]),
	[SpellName(5487--[[Bear Form]])] = SpellName(9634--[[Dire Bear Form]]),
	[SpellName(9634--[[Dire Bear Form]])] = SpellName(5487--[[Bear Form]]),
}

AddonTable.PetActions = {
	Attack = "PET_ACTION_ATTACK",
	Follow = "PET_ACTION_FOLLOW",
	Stay = "PET_ACTION_WAIT",
	Aggressive = "PET_MODE_AGGRESSIVE",
	Defensive = "PET_MODE_DEFENSIVE",
	Passive = "PET_MODE_PASSIVE",
	PET_ACTION_ATTACK = "PET_ACTION_ATTACK",
	PET_ACTION_FOLLOW = "PET_ACTION_FOLLOW",
	PET_ACTION_WAIT = "PET_ACTION_WAIT",
	PET_MODE_AGGRESSIVE = "PET_MODE_AGGRESSIVE",
	PET_MODE_DEFENSIVE = "PET_MODE_DEFENSIVE",
	PET_MODE_PASSIVE = "PET_MODE_PASSIVE",
	[PET_ACTION_ATTACK or "PET_ACTION_ATTACK"] = "PET_ACTION_ATTACK",
	[PET_ACTION_FOLLOW or "PET_ACTION_FOLLOW"] = "PET_ACTION_FOLLOW",
	[PET_ACTION_WAIT or "PET_ACTION_WAIT"] = "PET_ACTION_WAIT",
	[PET_MODE_AGGRESSIVE or "PET_MODE_AGGRESSIVE"] = "PET_MODE_AGGRESSIVE",
	[PET_MODE_DEFENSIVE or "PET_MODE_DEFENSIVE"] = "PET_MODE_DEFENSIVE",
	[PET_MODE_PASSIVE or "PET_MODE_PASSIVE"] = "PET_MODE_PASSIVE",
}


local DEFAULT_FLASH_SIZE_PERCENT = 240
local DEFAULT_FLASH_BRIGHTNESS_PERCENT = 100
local FLASH_SIZE_PERCENT = DEFAULT_FLASH_SIZE_PERCENT
local FLASH_BRIGHTNESS_PERCENT = DEFAULT_FLASH_BRIGHTNESS_PERCENT
local ENABLE_BLINKING = nil
local DISABLE_MACRO_FLASHING = nil
local CLASS = select(2, UnitClass("player"))
local RACE = select(2, UnitRace("player")):upper():gsub("[^A-Z]", ""):gsub("SCOURGE", "UNDEAD")
SpellFlashAddon.CLASS = CLASS
SpellFlashAddon.RACE = RACE
SpellFlashAddon.Castable = {}
SpellFlashAddon.VehicleCastable = {}
SpellFlashAddon.ItemCastable = {}
SpellFlashAddon.OtherAurasFunctions = {}
SpellFlashAddon.Spam = {}
local OtherAurasFromSpell = {}
local OtherAurasSpellFromAura = {}
local SPELLDELAY = {}
local OUTSIDEMELEESPELL = nil
local NPC_HIT_SPELLS = {}
local DISABLE_DEBUFF_OWNER_CHECKING = nil
local VARIABLES_CHECKED = nil
local TALENTRANK = {}
local TALENTTREEPOINTS = {}
local IMMUNEIGNORELIST = {}
local CLASSMODULES = {}
local CLASSMODULES_ADDONNAMES = {}
local GLOBAL_COOLDOWN_SPELL = nil
local CURRENTFORM = nil
local COMBAT = nil
local SERVER = nil
local REALM = nil
local PLAYER = nil
local LOADING = true

function SpellFlashAddon.FlashSizePercent()
	return FLASH_SIZE_PERCENT or DEFAULT_FLASH_SIZE_PERCENT
end

function SpellFlashAddon.FlashBrightnessPercent()
	return FLASH_BRIGHTNESS_PERCENT or DEFAULT_FLASH_BRIGHTNESS_PERCENT
end

--[[
SpellFlashAddon.PRIEST
SpellFlashAddon.ROGUE
SpellFlashAddon.PALADIN
SpellFlashAddon.WARLOCK
SpellFlashAddon.WARRIOR
SpellFlashAddon.HUNTER
SpellFlashAddon.MAGE
SpellFlashAddon.SHAMAN
SpellFlashAddon.DRUID
SpellFlashAddon.DEATHKNIGHT
]]
SpellFlashAddon[CLASS] = {}

--[[
SpellFlashAddon.HUMAN
SpellFlashAddon.DWARF
SpellFlashAddon.GNOME
SpellFlashAddon.NIGHTELF
SpellFlashAddon.BLOODELF
SpellFlashAddon.ORC
SpellFlashAddon.UNDEAD
SpellFlashAddon.TAUREN
SpellFlashAddon.TROLL
SpellFlashAddon.DRAENEI
]]
SpellFlashAddon[RACE] = {}

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
	if not (SERVER:match("%.worldofwarcraft%.com$") or SERVER:match("%.battle%.net$")) then
		DISABLE_DEBUFF_OWNER_CHECKING = not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].debuff_owner_checking
	end
	FLASH_SIZE_PERCENT = SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].flash_size_percent or DEFAULT_FLASH_SIZE_PERCENT
	FLASH_BRIGHTNESS_PERCENT = SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].flash_brightness_percent or DEFAULT_FLASH_BRIGHTNESS_PERCENT
	DISABLE_MACRO_FLASHING = SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].disable_macro_flashing
	ENABLE_BLINKING = SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].enable_blinking
	VARIABLES_CHECKED = 1
end

function SpellFlashAddon.GetModuleConfig(AddonName, config)
	if VARIABLES_CHECKED and SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].MODULE[AddonName] then
		return SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].MODULE[AddonName][config]
	end
	return nil
end

function SpellFlashAddon.SetModuleConfig(AddonName, config, value)
	if VARIABLES_CHECKED then
		if not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].MODULE[AddonName] then
			SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].MODULE[AddonName] = {}
		end
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].MODULE[AddonName][config] = value
	end
end

function SpellFlashAddon.ClearAllModuleConfigs(AddonName)
	if VARIABLES_CHECKED then
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].MODULE[AddonName] = {}
	end
end

local function RunSpam()
	local ActiveEnemy = SpellFlashAddon.IsActiveEnemy()
	local NoCC = ActiveEnemy or not SpellFlashAddon.IsNoDamageCC()
	local PetAlive = UnitHealth("pet") > 0
	local PetActiveEnemy = PetAlive and SpellFlashAddon.IsActiveEnemy("pettarget")
	local PetNoCC = not PetAlive or PetActiveEnemy or not SpellFlashAddon.IsBreakOnDamageCC("pettarget")
	local inInstance, instanceType = IsInInstance()
	for n,v in pairs(SpellFlashAddon.Spam) do
		if type(v) == "function" and ( not CLASSMODULES[n] or SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].selected_class_module == n or SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].use_all_class_modules ) then
			v(NoCC, ActiveEnemy, PetAlive, PetActiveEnemy, instanceType, PetNoCC)
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
	for i,v in ipairs(SpellFlashAddon.OtherAurasFunctions) do
		v()
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

function SpellFlashAddon.SetOtherAuras(Spell, Aura, Delete)
	if Spell and Aura then
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
	for Tab=1,GetNumTalentTabs() do
		TALENTTREEPOINTS[Tab] = 0
		for Tal=1,GetNumTalents(Tab) do
			local name, icon, tier, column, rank = GetTalentInfo(Tab, Tal)
			if name then
				TALENTRANK[name] = rank
				TALENTTREEPOINTS[Tab] = TALENTTREEPOINTS[Tab] + rank
			end
		end
	end
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

local function RegisterOutsideMeleeDistanceSpell()
	if not SpellFlashAddon.IsSpellKnown(MELEESPELL[CLASS]) then
		OUTSIDEMELEESPELL = nil
		local i = 1
		while true do
			local name = GetSpellName(i, BOOKTYPE_SPELL)
			if not name then break end
			if SpellHasRange(name) then
				if select(8,GetSpellInfo(name)) == 5 and select(9,GetSpellInfo(name)) >= 10 then
					OUTSIDEMELEESPELL = name
					break
				end
			end
			i = i + 1
		end
	end
end


local function PopulateImmuneIgnoreListDropDownMenu()
	UIDropDownMenu_ClearAll(SpellFlashAddonOptionsFrame_ImmuneIgnoreList)
	UIDropDownMenu_Initialize(SpellFlashAddonOptionsFrame_ImmuneIgnoreList, function(parent)
		for name,value in pairs(IMMUNEIGNORELIST) do
			local info = {}
			info.text = name
			info.func = function(self)
				UIDropDownMenu_SetSelectedID(parent, self:GetID())
			end
			UIDropDownMenu_AddButton(info)
		end
	end)
end

function SpellFlashAddon.AddToImmuneIgnoreList(TargetName)
	local name = SpellFlashAddonOptionsFrame_AddImmuneIgnore:GetText()
	if not name or name == "" then
		name = TargetName
	end
	if name and name ~= "" then
		IMMUNEIGNORELIST[name] = true
		PopulateImmuneIgnoreListDropDownMenu()
		SpellFlashAddonOptionsFrame_ImmuneIgnoreRemoveButton:Show()
		UIDropDownMenu_SetSelectedValue(SpellFlashAddonOptionsFrame_ImmuneIgnoreList, name)
		SpellFlashAddonOptionsFrame_AddImmuneIgnore:SetText("")
	end
end

function SpellFlashAddon.RemoveFromImmuneIgnoreList()
	local name = UIDropDownMenu_GetText(SpellFlashAddonOptionsFrame_ImmuneIgnoreList)
	if name and name ~= "" then
		IMMUNEIGNORELIST[name] = nil
	end
	if not next(IMMUNEIGNORELIST) then
		SpellFlashAddonOptionsFrame_ImmuneIgnoreRemoveButton:Hide()
	end
	PopulateImmuneIgnoreListDropDownMenu()
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
	IMMUNEIGNORELIST = SpellFlashAddon.CopyTable(SpellFlashAddonConfig.SERVER[SERVER].ImmuneIgnore)
	PopulateImmuneIgnoreListDropDownMenu()
	local found = next(IMMUNEIGNORELIST)
	if found then
		SpellFlashAddonOptionsFrame_ImmuneIgnoreRemoveButton:Show()
		UIDropDownMenu_SetSelectedValue(SpellFlashAddonOptionsFrame_ImmuneIgnoreList, found)
		UIDropDownMenu_SetText(SpellFlashAddonOptionsFrame_ImmuneIgnoreList, found)
	else
		SpellFlashAddonOptionsFrame_ImmuneIgnoreRemoveButton:Hide()
	end
	SpellFlashAddonOptionsFrame_AddImmuneIgnore:SetText("")
	SpellFlashAddonOptionsFrame_SpellFlashing:SetChecked(not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].spell_flashing_off)
	SpellFlashAddonOptionsFrame_disable_macro_flashing:SetChecked(not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].disable_macro_flashing)
	SpellFlashAddonOptionsFrame_UseAllClassModules:SetChecked(not not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].use_all_class_modules)
	SpellFlashAddonOptionsFrame_BlinkSpells:SetChecked(not not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].enable_blinking)
	SpellFlashAddonOptionsFrame_FlashSizePercent:SetNumber(SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].flash_size_percent or DEFAULT_FLASH_SIZE_PERCENT)
	SpellFlashAddonOptionsFrame_FlashBrightnessPercent:SetNumber(SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].flash_brightness_percent or DEFAULT_FLASH_BRIGHTNESS_PERCENT)
	SpellFlashAddonOptionsFrame_AutoMobImmunityDetection:SetChecked(not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].auto_mob_immune_detection_off)
	SpellFlashAddonOptionsFrame_ClearImmuneDatabase:SetChecked(false)
	if not (SERVER:match("%.worldofwarcraft%.com$") or SERVER:match("%.battle%.net$")) then
		SpellFlashAddonOptionsFrame_debuff_owner_checking:Show()
		SpellFlashAddonOptionsFrame_debuff_owner_checking:SetChecked(not DISABLE_DEBUFF_OWNER_CHECKING)
	end
end

local function SaveOptionsFrameSettings()
	if next(CLASSMODULES) then
		SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].selected_class_module = CLASSMODULES_ADDONNAMES[UIDropDownMenu_GetText(SpellFlashAddonOptionsFrame_ClassModulesList)]
	end
	SpellFlashAddonConfig.SERVER[SERVER].ImmuneIgnore = SpellFlashAddon.CopyTable(IMMUNEIGNORELIST)
	if SpellFlashAddonOptionsFrame_ClearImmuneDatabase:GetChecked() then
		SpellFlashAddonConfig.SERVER[SERVER].Immune = {}
		SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS] = {}
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
	if not (SERVER:match("%.worldofwarcraft%.com$") or SERVER:match("%.battle%.net$")) then
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

-- This is used for testing purposes only
function SpellFlashAddon.ShowBuffs(unit, Debuff)
	local unit = unit
	local msg
	if not unit then
		if UnitExists("target") then
			unit = "target"
		else
			unit = "player"
		end
	end
	local Debuff = Debuff
	if Debuff then
		Debuff = "HARMFUL"
		msg = UnitName(unit).."'s Debuff Slot"
	else
		Debuff = "HELPFUL"
		msg = UnitName(unit).."'s Buff Slot"
	end
	local c = 1
	if UnitAura(unit, c, Debuff) then
		while UnitAura(unit, c, Debuff) do
			print(msg.." "..c..": "..(UnitAura(unit, c, Debuff)))
			c = c + 1
		end
	else
		print("All "..msg.."'s are empty.")
	end
end

-- This is used for testing purposes only
function SpellFlashAddon.ShowDebuffs(unit)
	SpellFlashAddon.ShowBuffs(unit, 1)
end


local function AutoAddToImmuneIgnoreList(NPC)
	SpellFlashAddonConfig.SERVER[SERVER].ImmuneIgnore[NPC] = true
	if SpellFlashAddonOptionsFrame:IsVisible() then
		local name = UIDropDownMenu_GetText(SpellFlashAddonOptionsFrame_ImmuneIgnoreList)
		IMMUNEIGNORELIST[NPC] = true
		PopulateImmuneIgnoreListDropDownMenu()
		SpellFlashAddonOptionsFrame_ImmuneIgnoreRemoveButton:Show()
		if name and name ~= "" then
			UIDropDownMenu_SetSelectedValue(SpellFlashAddonOptionsFrame_ImmuneIgnoreList, name)
		end
	else
		LoadOptionsFrameSettings()
	end
	for SpellName,v in pairs(SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS]) do
		SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS][SpellName][NPC] = nil
	end
end

local function OnEvent(self, event, ...)
	local arg = {...}

	if event == "PLAYER_REGEN_DISABLED" then
			
			COMBAT = 1
			
	elseif event == "PLAYER_REGEN_ENABLED" then
			
			COMBAT = nil
			
	elseif event == "START_AUTOREPEAT_SPELL" then
			
			SpellFlashAddon.AutoShoot = 1
			
	elseif event == "STOP_AUTOREPEAT_SPELL" then
			
			SpellFlashAddon.AutoShoot = nil
			
	elseif event == "UPDATE_SHAPESHIFT_FORM" then
			
			RegisterForm()
			
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
			
			if arg[12] == "IMMUNE" and arg[2] ~= "SWING_DAMAGE" and arg[2] ~= "RANGE_DAMAGE" then
				if SpellFlashAddon.IsSpellKnown(arg[10]) then
					AddonTable:SetTimer(arg[10].."TempImmune"..arg[6], 5)
				end
				if VARIABLES_CHECKED and not SpellFlashAddonConfig.SERVER[SERVER].ImmuneIgnore[arg[7]] and not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].auto_mob_immune_detection_off and arg[6] == UnitGUID("target") and SpellFlashAddon.GiveUnitTypeByGUID(arg[6]) == "npc" and not SpellFlashAddon.CheckDebuff(AddonTable.ImmunityDebuffs) then
					if NPC_HIT_SPELLS[arg[7]] and NPC_HIT_SPELLS[arg[7]][arg[10]] then
						AutoAddToImmuneIgnoreList(arg[7])
					elseif SpellFlashAddon.IsSpellKnown(arg[10]) then
						if not SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS][arg[10]] then
							SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS][arg[10]] = {}
						end
						SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS][arg[10]][arg[7]] = true
					end
				end
			end
			if arg[2] == "SPELL_MISS" or arg[2] == "SPELL_MISSED" or arg[2] == "SPELL_DAMAGE" or arg[2] == "SPELL_HEAL" or arg[2] == "SPELL_AURA_REFRESH" or arg[2] == "SPELL_AURA_APPLIED" or arg[2] == "SPELL_AURA_APPLIED_DOSE" then
				if not arg[2]:match("MISS") and arg[2] ~= "SPELL_HEAL" and arg[12] ~= "BUFF" then
					AddonTable:ClearTimer(arg[10].."TempImmune"..arg[6])
					if SpellFlashAddon.GiveUnitTypeByGUID(arg[6]) == "npc" then
						if not NPC_HIT_SPELLS[arg[7]] then
							NPC_HIT_SPELLS[arg[7]] = {}
						end
						NPC_HIT_SPELLS[arg[7]][arg[10]] = 1
						if VARIABLES_CHECKED and not SpellFlashAddonConfig.SERVER[SERVER].ImmuneIgnore[arg[7]] and not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].auto_mob_immune_detection_off and SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS][arg[10]] and SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS][arg[10]][arg[7]] then
							AutoAddToImmuneIgnoreList(arg[7])
						end
					end
				end
				if arg[3] == UnitGUID("player") or ( DISABLE_DEBUFF_OWNER_CHECKING and arg[12] == "DEBUFF" ) then
					if OtherAurasFromSpell[arg[10]] and not arg[2]:match("MISS") and SPELLDELAY[arg[10]] then
						for n,v in pairs(OtherAurasFromSpell[arg[10]]) do
							AddonTable:SetTimer(n.."AuraDelay"..arg[6], 1)
						end
					end
					if not tostring(arg[12]):match("BUFF") and ( arg[2] == "SPELL_DAMAGE" or arg[2] == "SPELL_HEAL" ) then
						if SPELLDELAY[arg[10]] then
							AddonTable:SetTimer(arg[10].."AuraDelay"..arg[6], 1)
						end
					else
						AddonTable:ClearTimer(arg[10].."AuraDelay"..arg[6])
					end
					AddonTable:ClearTimer(arg[10].."ClearSpellDelay")
					SPELLDELAY[arg[10]] = nil
					if arg[12] == "DEBUFF" and VARIABLES_CHECKED and arg[3] == UnitGUID("player") and not (SERVER:match("%.worldofwarcraft%.com$") or SERVER:match("%.battle%.net$")) and not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].debuff_owner_found then
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
				AddonTable:SetTimer(arg[2].."ClearSpellDelay", 5, 0,
					function()
						SPELLDELAY[arg[2]] = nil
					end
				)
				SPELLDELAY[arg[2]] = 1
			end
			
	elseif event == "PLAYER_TARGET_CHANGED" then
			
			SPELLDELAY = {}
			
	elseif event == "ACTIONBAR_HIDEGRID" or event == "LEARNED_SPELL_IN_TAB" or event == "CHARACTER_POINTS_CHANGED" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "UPDATE_MACROS" then
			
			SPELLDELAY = {}
			RegisterTalents()
			RegisterOtherAuras()
			AddonTable:SetTimer("RegisterOutsideMeleeDistanceSpell", 0.5, 0, RegisterOutsideMeleeDistanceSpell)
			if not GLOBAL_COOLDOWN_SPELL and SpellFlashAddon.IsSpellKnown(GLOBALCOOLDOWNSPELL[CLASS]) then
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
								if not GLOBAL_COOLDOWN_SPELL and SpellFlashAddon.IsSpellKnown(GLOBALCOOLDOWNSPELL[CLASS]) then
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
Frame:RegisterEvent("PLAYER_REGEN_DISABLED")
Frame:RegisterEvent("PLAYER_REGEN_ENABLED")
Frame:RegisterEvent("START_AUTOREPEAT_SPELL")
Frame:RegisterEvent("STOP_AUTOREPEAT_SPELL")
Frame:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
Frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
Frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
Frame:RegisterEvent("PLAYER_TARGET_CHANGED")
Frame:RegisterEvent("ACTIONBAR_HIDEGRID")
Frame:RegisterEvent("LEARNED_SPELL_IN_TAB")
Frame:RegisterEvent("CHARACTER_POINTS_CHANGED")
Frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
Frame:RegisterEvent("UPDATE_MACROS")
Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
Frame:RegisterEvent("PLAYER_ALIVE")
Frame:RegisterEvent("ADDON_LOADED")
Frame:SetScript("OnEvent", OnEvent)



function SpellFlashAddon.SpellDelay(spell, unit)
	return spell and SPELLDELAY[spell]
end

function SpellFlashAddon.AuraDelay(aura, unit)
	if type(aura) == "string" then
		if UnitExists(unit or "target") and AddonTable:IsTimer(aura.."AuraDelay"..UnitGUID(unit or "target")) then
			return true
		elseif SPELLDELAY[aura] then
			return true
		end
		if OtherAurasSpellFromAura[aura] then
			for spell, v in pairs(OtherAurasSpellFromAura[aura]) do
				if SPELLDELAY[spell] then
					return true
				end
			end
		end
	elseif type(aura) == "table" then
		for _, v in ipairs(aura) do
			if SpellFlashAddon.AuraDelay(v, unit) then
				return true
			end
		end
	end
	return false
end

function SpellFlashAddon.Form(form)
	if form then
		return form == CURRENTFORM or ( ALTERNATEFORM[form] and ALTERNATEFORM[form] == CURRENTFORM )
	end
	return CURRENTFORM
end
SpellFlashAddon.IsForm = SpellFlashAddon.Form
SpellFlashAddon.GiveForm = SpellFlashAddon.Form

function SpellFlashAddon.GiveUnitTypeByGUID(GUID)
	if GUID then
		local first3 = tonumber("0x"..strsub(GUID, 3,5))
		local unitType = bit.band(first3,0x00f)
		if unitType == 0x000 then
			--print("Player, ID #", strsub(GUID,6))
			return "player"
		elseif unitType == 0x003 then
			--local creatureID = tonumber("0x"..strsub(GUID,9,12))
			--local spawnCounter = tonumber("0x"..strsub(GUID,13)) 
			--print("NPC, ID #",creatureID,"spawn #",spawnCounter)
			return "npc"
		elseif unitType == 0x004 then
			--local petID = tonumber("0x"..strsub(GUID,6,12))
			--local spawnCounter = tonumber("0x"..strsub(GUID,13)) 
			--print("Pet, ID #",petID,"spawn #",spawnCounter)
			return "pet"
		elseif unitType == 0x005 then
			--local creatureID = tonumber("0x"..strsub(GUID,9,12))
			--local spawnCounter = tonumber("0x"..strsub(GUID,13)) 
			--print("Vehicle, ID #",creatureID,"spawn #",spawnCounter)
			return "vehicle"
		end
	end
	return nil
end

function SpellFlashAddon.HasTalent(TalentName)
	return TalentName and ( TALENTRANK[TalentName] or 0 ) > 0
end

function SpellFlashAddon.GetTalentRank(TalentName)
	if TalentName then
		return TALENTRANK[TalentName] or 0
	end
	return 0
end

-- This also works for pet spells.
function SpellFlashAddon.IsSpellKnown(SpellName)
	return type(SpellName) == "string" and SpellName ~= "" and GetSpellInfo(SpellName)
end

function SpellFlashAddon.HasItem(ItemName)
	return type(ItemName) == "string" and ItemName ~= "" and GetItemCount(ItemName) > 0
end
SpellFlashAddon.IsItemKnown = SpellFlashAddon.HasItem

-- This also works for pet spells.
function SpellFlashAddon.GetSpellRank(SpellName)
	if type(SpellName) == "string" then
		local name, rank = GetSpellInfo(SpellName)
		if name then
			return tonumber(tostring(rank):match("(%d+)")) or 1
		end
	end
	return 0
end


function SpellFlashAddon.OnCooldown(SpellNameOrActionID)
	if type(SpellNameOrActionID) == "number" then
		return ( select(2, GetActionCooldown(SpellNameOrActionID)) ~= 0 )
	end
	return SpellNameOrActionID and select(2,GetSpellCooldown(SpellNameOrActionID)) ~= 0
end

function SpellFlashAddon.GetSpellCooldown(SpellName)
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

function SpellFlashAddon.GetItemCooldown(ItemName)
	if ItemName then
		local start, duration = GetItemCooldown(ItemName)
		local TimeLeft = (start or 0) + (duration or 0) - GetTime()
		if TimeLeft > 0 then
			return TimeLeft, duration
		end
	else
		return nil
	end
	return 0, 0
end

function SpellFlashAddon.GetActionCooldown(ActionID)
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

function SpellFlashAddon.GetPetActionCooldown(PetActionID)
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

function SpellFlashAddon.IsSpellAutocastOn(SpellName)
	if SpellName then
		return ( select(2, GetSpellAutocast(SpellName)) )
	end
	return nil
end

function SpellFlashAddon.GetSpellCastTime(SpellName)
	if SpellName then
		return (select(7,GetSpellInfo(SpellName)) or 0) / 1000
	end
	return 0
end

function SpellFlashAddon.GetSpellCost(SpellName, PowerType)
	if SpellName then
		local name, rank, icon, cost, isFunnel, powerType = GetSpellInfo(SpellName)
		if not PowerType or PowerType == powerType then
			return cost or 0
		end
	end
	return 0
end



function SpellFlashAddon.VehicleSlot(SpellName)
	if SpellName and UnitHasVehicleUI("player") then
		for n=121,126 do
			local Type, id, subType, globalID = GetActionInfo(n)
			if globalID then
				local name = GetSpellInfo(globalID)
				if name then
					if name == SpellName then
						return n
					end
				else
					return nil
				end
			end
		end
	end
	return nil
end



function SpellFlashAddon.HasGlyph(GlyphName)
	for i=1,GetNumGlyphSockets() do
		local glyphSpellID = select(3,GetGlyphSocketInfo(i))
		if glyphSpellID and GlyphName == SpellName(glyphSpellID) then
			return true
		end
	end
	return false
end

function SpellFlashAddon.MeleeDistance(unit)
	if SpellFlashAddon.IsSpellKnown(MELEESPELL[CLASS]) then
		if IsSpellInRange(MELEESPELL[CLASS],unit or "target") ~= 1 then
			return false
		end
	elseif not CheckInteractDistance(unit or "target", 3) then
		return false
	elseif OUTSIDEMELEESPELL and IsSpellInRange(OUTSIDEMELEESPELL,unit or "target") == 1 then
		return false
	end
	return true
end


function SpellFlashAddon.IsImmune(SpellName)
	return ( VARIABLES_CHECKED
		and not SpellFlashAddonConfig.SERVER[SERVER].REALM[REALM].PLAYER[PLAYER].auto_mob_immune_detection_off
		and not UnitPlayerControlled("target")
		and SpellName and SpellName ~= ""
		and UnitName("target")
		and ( not SpellFlashAddonConfig.SERVER[SERVER].ImmuneIgnore or not SpellFlashAddonConfig.SERVER[SERVER].ImmuneIgnore[UnitName("target")] )
		and SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS][SpellName] and SpellFlashAddonConfig.SERVER[SERVER].Immune[CLASS][SpellName][UnitName("target")]
	) or AddonTable:IsTimer(SpellName.."TempImmune"..(UnitGUID("target") or ""))
end



--Example: SpellFlashAddon.IsClass("DeathKnight")
--The example above will return true if your target is a Death Knight.
--This function has been made so that english class names must be used with this function even if you are not using an english game client.
--Spaces are allowed in the class name and the class name may also be in upper or lower case when using this function.
function SpellFlashAddon.IsClass(class, unit)
	return UnitIsPlayer(unit or "target") and type(class) == "string" and select(2,UnitClass(unit or "target")):upper():gsub("[^A-Z]","") == class:upper():gsub("[^A-Z]","")
end


function SpellFlashAddon.Casting(SpellName, unit, interruptible)
	local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo(unit or "player")
	if name and ( not interruptible or not notInterruptible ) and ( not SpellName or SpellName == name ) then
		return (endTime / 1000) - GetTime()
	end
	return nil
end
SpellFlashAddon.IsCasting = SpellFlashAddon.Casting

function SpellFlashAddon.Channeling(SpellName, unit, interruptible)
	local name, nameSubtext, text, texture, startTime, endTime, isTradeSkill, notInterruptible = UnitChannelInfo(unit or "player")
	if name and ( not interruptible or not notInterruptible ) and ( not SpellName or SpellName == name ) then
		return (endTime / 1000) - GetTime()
	end
	return nil
end
SpellFlashAddon.IsChanneling = SpellFlashAddon.Channeling

function SpellFlashAddon.CastingOrChanneling(SpellName, unit, interruptible)
	return SpellFlashAddon.Casting(SpellName, unit, interruptible) or SpellFlashAddon.Channeling(SpellName, unit, interruptible)
end
SpellFlashAddon.IsCastingOrChanneling = SpellFlashAddon.CastingOrChanneling

--Since the PlayerFrame combat variable can be wrong, The same information
--can be accessed here.	Returns true if you are in combat
function SpellFlashAddon.InCombat()
	return COMBAT
end

-- Returns true if you are not in combat, and may use abilitys that can only be used out of combat
function SpellFlashAddon.NotInCombat()
	return not COMBAT
end

function SpellFlashAddon.HealthPercent(unit)
	return ( UnitHealth(unit or "target") / UnitHealthMax(unit or "target") ) * 100
end

function SpellFlashAddon.HealthDamage(unit)
	return UnitHealthMax(unit or "target") - UnitHealth(unit or "target")
end

function SpellFlashAddon.HealthDamagePercent(unit)
	return 100 - SpellFlashAddon.HealthPercent(unit)
end

function SpellFlashAddon.PowerPercent(unit, PowerType)
	return ( UnitPower(unit or "target", PowerType) / UnitPowerMax(unit or "target", PowerType) ) * 100
end
SpellFlashAddon.ManaPercent = SpellFlashAddon.PowerPercent

function SpellFlashAddon.PowerMissing(unit, PowerType)
	return UnitPowerMax(unit or "target", PowerType) - UnitPower(unit or "target", PowerType)
end
SpellFlashAddon.ManaMissing = SpellFlashAddon.PowerMissing

function SpellFlashAddon.UsesMana(unit)
	return UnitPowerType(unit or "target") == SPELL_POWER_MANA or UnitPowerMax(unit or "target", SPELL_POWER_MANA) > 0
end

function SpellFlashAddon.HasMana(unit)
	return UnitPower(unit or "target", SPELL_POWER_MANA) > 0
end


--returns true if all of the debuff slots are used
function SpellFlashAddon.AllDebuffSlotsUsed(unit)
	return not not UnitAura(unit or "target", MAXDEBUFFSLOTS, "HARMFUL")
end


function SpellFlashAddon.CancelBuff(SpellName, icon_texture)
	local SpellName = SpellName or SpellFlashAddon.CheckBuff(nil,nil,nil,nil,nil,nil,nil,nil,nil,icon_texture,nil,nil,nil,1)
	if SpellName then
		CancelUnitBuff("player", SpellName)
	end
end


--Looks through all buffs looking for a match
function SpellFlashAddon.CheckBuff(SpellName, unit, mine, CheckRank, applications, isExpirationTimeGreater, isExpirationTimeOrLess, Stealable, castable, icon_texture, SpellToolTipLineTwo, Type, giveapplications, giveindex, Debuff)
	if unit == "MainHandSlot" or unit == "SecondaryHandSlot" then
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
	local d = Debuff
	local u = unit
	if d then
		d = "HARMFUL"
		u = u or "target"
	else
		d = "HELPFUL"
		u = u or "player"
	end
	if not UnitExists(u) then
		if giveapplications then
			return 0
		elseif giveindex then
			return nil
		end
		return false
	end
	if type(SpellName) == "table" then
		local result = nil
		for _, v in ipairs(SpellName) do
			result = SpellFlashAddon.CheckBuff(v, unit, mine, CheckRank, applications, isExpirationTimeGreater, isExpirationTimeOrLess, Stealable, castable, icon_texture, SpellToolTipLineTwo, Type, giveapplications, giveindex, Debuff)
			if result then
				return result
			end
		end
		return result
	end
	local m = mine
	if m and ( not Debuff or not DISABLE_DEBUFF_OWNER_CHECKING ) then
		m = "|PLAYER"
	else
		m = ""
	end
	local c = castable
	if c then
		c = "|RAID"
	else
		c = ""
	end
	local t = SpellToolTipLineTwo
	local r = CheckRank
	if SpellName and not giveindex and not t then
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitAura(u, SpellName, nil, d..m..c)
		if name and ( not Type or Type:lower() == (debuffType or ""):lower() ) and ( not Stealable or isStealable ) then
			if r then
				rank = tonumber(tostring(rank):match("(%d+)")) or 1
				if type(r) ~= "number" then
					r = SpellFlashAddon.GetSpellRank(name)
				end
			end
			if ( r and rank > r and type(CheckRank) ~= "number" ) or (
					( not r or rank >= r )
				and ( not applications or applications == count )
				and ( not isExpirationTimeGreater or isExpirationTimeGreater <= 0 or expirationTime == 0 or ( expirationTime - GetTime() ) > isExpirationTimeGreater )
				and ( not isExpirationTimeOrLess or isExpirationTimeOrLess <= 0 or ( expirationTime ~= 0 and ( expirationTime - GetTime() ) <= isExpirationTimeOrLess ) )
			) then
				if giveapplications then
					if count == 0 then
						return 1
					end
					return count
				end
				return true
			end
		end
	elseif not SpellName or UnitAura(u, SpellName, nil, d..m..c) then
		local i = 1
		while UnitAura(u, i, d) do
			local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitAura(u, i, d..m..c)
			if name and ( not SpellName or SpellName == name ) and ( not icon_texture or (icon or ""):match(icon_texture) ) and ( not Type or Type:lower() == (debuffType or ""):lower() ) and ( not Stealable or isStealable ) then
				if r then
					rank = tonumber(tostring(rank):match("(%d+)")) or 1
					if type(r) ~= "number" then
						r = SpellFlashAddon.GetSpellRank(name)
					end
				end
				if ( r and rank > r and type(CheckRank) ~= "number" ) or (
						( not r or rank >= r )
					and ( not applications or applications == count )
					and ( not isExpirationTimeGreater or isExpirationTimeGreater <= 0 or expirationTime == 0 or ( expirationTime - GetTime() ) > isExpirationTimeGreater )
					and ( not isExpirationTimeOrLess or isExpirationTimeOrLess <= 0 or ( expirationTime ~= 0 and ( expirationTime - GetTime() ) <= isExpirationTimeOrLess ) )
				) then
					if t then
						SpellFlashAddon_Tooltip:SetUnitAura(u, i, d)
						if (SpellFlashAddon_TooltipTextLeft2:GetText() or ""):match(t) then
							t = nil
						end
					end
					if not t then
						if giveapplications then
							if count == 0 then
								return 1
							end
							return count
						elseif giveindex then
							return i
						end
						return true
					end
				end
			end
			i = i + 1
		end
	end
	if giveapplications then
		return 0
	elseif giveindex then
		return nil
	end
	return false
end


--Looks through all debuffs looking for a match
function SpellFlashAddon.CheckDebuff(SpellName, unit, mine, CheckRank, applications, isExpirationTimeGreater, isExpirationTimeOrLess, Stealable, dispelable, icon_texture, SpellToolTipLineTwo, Type, giveapplications, giveindex)
	return SpellFlashAddon.CheckBuff(SpellName, unit, mine, CheckRank, applications, isExpirationTimeGreater, isExpirationTimeOrLess, Stealable, dispelable, icon_texture, SpellToolTipLineTwo, Type, giveapplications, giveindex, 1)
end


--Loops through all buffs looking for a match and returns the index number
function SpellFlashAddon.GiveBuffIndex(SpellName, unit, mine, CheckRank, applications, isExpirationTimeGreater, isExpirationTimeOrLess, Stealable, castable, icon_texture, SpellToolTipLineTwo, Type)
	return SpellFlashAddon.CheckBuff(SpellName, unit, mine, CheckRank, applications, isExpirationTimeGreater, isExpirationTimeOrLess, Stealable, castable, icon_texture, SpellToolTipLineTwo, Type, nil, 1)
end

--Loops through all buffs looking for a match and returns the index number
function SpellFlashAddon.GiveDebuffIndex(SpellName, unit, mine, CheckRank, applications, isExpirationTimeGreater, isExpirationTimeOrLess, Stealable, dispelable, icon_texture, SpellToolTipLineTwo, Type)
	return SpellFlashAddon.CheckBuff(SpellName, unit, mine, CheckRank, applications, isExpirationTimeGreater, isExpirationTimeOrLess, Stealable, dispelable, icon_texture, SpellToolTipLineTwo, Type, nil, 1, 1)
end


-- Returns the amount of times a debuff is stacked on the target, and returns 0 if the debuff is not on the target.
function SpellFlashAddon.GetDebuffStack(SpellName, unit, mine, CheckRank, applications, isExpirationTimeGreater, isExpirationTimeOrLess, Stealable, castable, icon_texture, SpellToolTipLineTwo, Type, giveindex)
	return SpellFlashAddon.CheckBuff(SpellName, unit, mine, CheckRank, applications, isExpirationTimeGreater, isExpirationTimeOrLess, Stealable, castable, icon_texture, SpellToolTipLineTwo, Type, 1, giveindex, 1)
end

-- Returns the amount of times a buff is stacked on the target, and returns 0 if the buff is not on the target.
function SpellFlashAddon.GetBuffStack(SpellName, unit, mine, CheckRank, applications, isExpirationTimeGreater, isExpirationTimeOrLess, Stealable, castable, icon_texture, SpellToolTipLineTwo, Type, giveindex, Debuff)
	return SpellFlashAddon.CheckBuff(SpellName, unit, mine, CheckRank, applications, isExpirationTimeGreater, isExpirationTimeOrLess, Stealable, castable, icon_texture, SpellToolTipLineTwo, Type, 1, giveindex, Debuff)
end


function SpellFlashAddon.CheckMainHandItemBuff(SpellName)
	return SpellFlashAddon.CheckBuff(SpellName, "MainHandSlot")
end

function SpellFlashAddon.CheckOffHandItemBuff(SpellName)
	return SpellFlashAddon.CheckBuff(SpellName, "SecondaryHandSlot")
end

function SpellFlashAddon.CheckHandItemBuff(SpellName, hand)
	if hand then
		local hand = hand:lower()
		if hand == "main" or hand == 1 or hand == "1" or hand == "mainhandslot" then
			return SpellFlashAddon.CheckBuff(SpellName, "MainHandSlot")
		elseif hand == "off" or hand == 2 or hand == "2" or hand == "secondaryhandslot" then
			return SpellFlashAddon.CheckBuff(SpellName, "SecondaryHandSlot")
		end
		SpellFlashCore.debug("Valid arguments for SpellFlashAddon.CheckHandItemBuff() are: \"main\", \"off\", 1, 2 and nil")
	else
		return SpellFlashAddon.CheckBuff(SpellName, "MainHandSlot") or SpellFlashAddon.CheckBuff(SpellName, "SecondaryHandSlot")
	end
	return false
end




function SpellFlashAddon.IsUnit(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	local unit = unit or "target"
	return ( UnitExists(unit)
		and ( not enemy or ( UnitCanAttack("player", unit) and ( not UnitIsDeadOrGhost(unit) or UnitExists(unit.."target") or UnitAffectingCombat(unit) ) ) )
		and ( not active or ( ( UnitAffectingCombat(unit) or UnitExists(unit.."target") or UnitIsPlayer(unit) ) and not UnitIsDeadOrGhost(unit) and not SpellFlashAddon.IsNoDamageCC(unit) ) )
		and ( not player or UnitIsPlayer(unit) )
		and ( not mob or ( not UnitPlayerControlled(unit) and (enemy or UnitExists(unit)) ) )
		and ( not givesxp or ( (enemy or (UnitCanAttack("player", unit) and (not UnitIsDeadOrGhost(unit) or UnitExists(unit.."target") or UnitAffectingCombat(unit) or (UnitIsPlayer(unit) and SpellFlashAddon.IsClass("Hunter", unit))))) and not UnitIsTrivial(unit) and UnitFactionGroup(unit) ~= UnitFactionGroup("player") and not (UnitPlayerControlled(unit) and not UnitIsPlayer(unit)) and ( UnitIsPlayer(unit) or not UnitIsTapped(unit) or UnitIsTappedByPlayer(unit) or UnitIsTappedByAllThreatList(unit) ) ) )
		and ( not lessthenhealthpercent or SpellFlashAddon.HealthPercent(unit) <= lessthenhealthpercent )
		and ( not unithasnotarget or not UnitExists(unit.."target") )
		and ( not unitistargetingyou or UnitIsUnit(unit.."target", "player") )
		and ( not unitistargetingyourfriend or (not UnitIsUnit(unit.."target", "player") and UnitIsFriend("player", unit.."target")) )
		and ( not unitistargetingselforitsfriend or UnitCanAttack("player", unit.."target") )
		and ( not isboss or tostring(UnitClassification(unit)):lower():match("boss") or ( UnitLevel(unit) == -1 and not UnitPlayerControlled(unit) ) )
	)
end


function SpellFlashAddon.IsEnemy(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	return SpellFlashAddon.IsUnit(unit, 1, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
end

function SpellFlashAddon.IsActiveEnemy(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	return SpellFlashAddon.IsUnit(unit, 1, 1, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
end

function SpellFlashAddon.IsActiveEnemyThatGivesXP(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	return SpellFlashAddon.IsUnit(unit, 1, 1, player, mob, 1, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
end

function SpellFlashAddon.IsBoss(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	return SpellFlashAddon.IsUnit(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, 1)
end

function SpellFlashAddon.IsEnemyBoss(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	return SpellFlashAddon.IsUnit(unit, 1, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, 1)
end

function SpellFlashAddon.IsActiveEnemyBoss(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	return SpellFlashAddon.IsUnit(unit, 1, 1, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, 1)
end

function SpellFlashAddon.GivesXP(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	return SpellFlashAddon.IsUnit(unit, 1, active, player, mob, 1, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
end

function SpellFlashAddon.IsEnemyPlayer(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	return SpellFlashAddon.IsUnit(unit, 1, active, 1, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
end

function SpellFlashAddon.IsEnemyMob(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	return SpellFlashAddon.IsUnit(unit, 1, active, player, 1, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
end

function SpellFlashAddon.IsActiveEnemyMob(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	return SpellFlashAddon.IsUnit(unit, 1, 1, player, 1, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
end

function SpellFlashAddon.IsDieingEnemy(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	return SpellFlashAddon.IsUnit(unit, 1, active, player, mob, givesxp, 20, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
end

function SpellFlashAddon.IsDieingEnemyWithNoTarget(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	return SpellFlashAddon.IsUnit(unit, 1, active, player, mob, givesxp, 20, 1, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
end

function SpellFlashAddon.IsEnemyTargetingYou(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	return SpellFlashAddon.IsUnit(unit, 1, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, 1, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
end

function SpellFlashAddon.IsActiveEnemyTargetingYou(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	return SpellFlashAddon.IsUnit(unit, 1, 1, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, 1, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
end

function SpellFlashAddon.IsEnemyBossTargetingYou(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	return SpellFlashAddon.IsUnit(unit, 1, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, 1, unitistargetingyourfriend, unitistargetingselforitsfriend, 1)
end

function SpellFlashAddon.IsEnemyTargetingFriendButNotYou(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	return SpellFlashAddon.IsUnit(unit, 1, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, 1, unitistargetingselforitsfriend, isboss)
end

function SpellFlashAddon.IsEnemyTargetingEnemy(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	return SpellFlashAddon.IsUnit(unit, 1, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, 1)
end

function SpellFlashAddon.IsFriendTargetingEnemy(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	if UnitIsFriend("player", unit or "target") and SpellFlashAddon.IsEnemy(unit or "target".."target", enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss) then
		return true
	end
	return false
end

function SpellFlashAddon.IsFriendTargetingActiveEnemy(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss)
	if UnitIsFriend("player", unit or "target") and SpellFlashAddon.IsActiveEnemy(unit or "target".."target", enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend, isboss) then
		return true
	end
	return false
end







-- checks to see if a fist weapon is equipped in the main hand
function SpellFlashAddon.IsHandFistWeapon(offhand)
	local offhand = offhand
	if offhand then
		offhand = "SecondaryHandSlot"
	end
	local slot = GetInventorySlotInfo(offhand or "MainHandSlot")
	if SpellFlashAddon.GetItemSubType(GetInventoryItemLink("player", slot)) == SpellName(15590--[[Fist Weapons]]) then
		if GetInventoryItemBroken("player", slot) then
			--SpellFlashCore.debug("Your fist weapon in the main hand is broken.")
			return false
		end
		--SpellFlashCore.debug("You have a fist weapon equipped in the main hand.", 2)
		return true
	end
	--SpellFlashCore.debug("You do not have a fist weapon equipped in the main hand.", 2)
	return false
end

-- checks to see if a stave is equipped in the main hand
function SpellFlashAddon.IsHandStave(offhand)
	local offhand = offhand
	if offhand then
		offhand = "SecondaryHandSlot"
	end
	local slot = GetInventorySlotInfo(offhand or "MainHandSlot")
	if SpellFlashAddon.GetItemSubType(GetInventoryItemLink("player", slot)) == SpellName(227--[[Staves]]) then
		if GetInventoryItemBroken("player", slot) then
			--SpellFlashCore.debug("Your stave in the main hand is broken.")
			return false
		end
		--SpellFlashCore.debug("You have a stave equipped in the main hand.", 2)
		return true
	end
	--SpellFlashCore.debug("You do not have a stave equipped.", 2)
	return false
end

-- checks to see if a polearm is equipped in the main hand
function SpellFlashAddon.IsHandPolearm(offhand)
	local offhand = offhand
	if offhand then
		offhand = "SecondaryHandSlot"
	end
	local slot = GetInventorySlotInfo(offhand or "MainHandSlot")
	if SpellFlashAddon.GetItemSubType(GetInventoryItemLink("player", slot)) == SpellName(200--[[Polearms]]) then
		if GetInventoryItemBroken("player", slot) then
			--SpellFlashCore.debug("Your polearm in the main hand is broken.")
			return false
		end
		--SpellFlashCore.debug("You have a polearm equipped in the main hand.", 2)
		return true
	end
	--SpellFlashCore.debug("You do not have a polearm equipped.", 2)
	return false
end

-- checks to see if a one or two handed mace is equipped in the main hand
function SpellFlashAddon.IsHandMace(offhand)
	local offhand = offhand
	if offhand then
		offhand = "SecondaryHandSlot"
	end
	local slot = GetInventorySlotInfo(offhand or "MainHandSlot")
	local itemType = SpellFlashAddon.GetItemSubType(GetInventoryItemLink("player", slot))
	if itemType == SpellName(198--[[One-Handed Maces]]) or itemType == SpellName(199--[[Two-Handed Maces]]) then
		if GetInventoryItemBroken("player", slot) then
			--SpellFlashCore.debug("Your mace in the main hand is broken.")
			return false
		end
		--SpellFlashCore.debug("You have a mace equipped in the main hand.", 2)
		return true
	end
	--SpellFlashCore.debug("You do not have a mace equipped in the main hand.", 2)
	return false
end

-- checks to see if a one or two handed axe is equipped in the main hand
function SpellFlashAddon.IsHandAxe(offhand)
	local offhand = offhand
	if offhand then
		offhand = "SecondaryHandSlot"
	end
	local slot = GetInventorySlotInfo(offhand or "MainHandSlot")
	local itemType = SpellFlashAddon.GetItemSubType(GetInventoryItemLink("player", slot))
	if itemType == SpellName(196--[[One-Handed Axes]]) or itemType == SpellName(197--[[Two-Handed Axes]]) then
		if GetInventoryItemBroken("player", slot) then
			--SpellFlashCore.debug("Your axe in the main hand is broken.")
			return false
		end
		--SpellFlashCore.debug("You have a axe equipped in the main hand.", 2)
		return true
	end
	--SpellFlashCore.debug("You do not have a axe equipped in the main hand.", 2)
	return false
end

-- checks to see if a one or two handed sword is equipped in the main hand
function SpellFlashAddon.IsHandSword(offhand)
	local offhand = offhand
	if offhand then
		offhand = "SecondaryHandSlot"
	end
	local slot = GetInventorySlotInfo(offhand or "MainHandSlot")
	local itemType = SpellFlashAddon.GetItemSubType(GetInventoryItemLink("player", slot))
	if itemType == SpellName(201--[[One-Handed Swords]]) or itemType == SpellName(202--[[Two-Handed Swords]]) then
		if GetInventoryItemBroken("player", slot) then
			--SpellFlashCore.debug("Your sword in the main hand is broken.")
			return false
		end
		--SpellFlashCore.debug("You have a sword equipped in the main hand.", 2)
		return true
	end
	--SpellFlashCore.debug("You do not have a sword equipped in the main hand.", 2)
	return false
end

-- checks to see if a dagger is equipped in the main hand
function SpellFlashAddon.IsHandDagger(offhand)
	local offhand = offhand
	if offhand then
		offhand = "SecondaryHandSlot"
	end
	local slot = GetInventorySlotInfo(offhand or "MainHandSlot")
	if SpellFlashAddon.GetItemSubType(GetInventoryItemLink("player", slot)) == SpellName(1180--[[Daggers]]) then
		if GetInventoryItemBroken("player", slot) then
			--SpellFlashCore.debug("Your dagger in the main hand is broken.")
			return false
		end
		--SpellFlashCore.debug("You have a dagger equipped in the main hand.", 2)
		return true
	end
	--SpellFlashCore.debug("You do not have a dagger equipped in the main hand.", 2)
	return false
end

-- checks to see if a dagger is equipped in the main hand
function SpellFlashAddon.IsShieldEquipped()
	local slot = GetInventorySlotInfo("SecondaryHandSlot")
	if SpellFlashAddon.GetItemSubType(GetInventoryItemLink("player", slot)) == L["Shields"] then
		if GetInventoryItemBroken("player", slot) then
			--SpellFlashCore.debug("Your shield in the main hand is broken.")
			return false
		end
		--SpellFlashCore.debug("You have a shield equipped in the main hand.", 2)
		return true
	end
	--SpellFlashCore.debug("You do not have a shield equipped in the main hand.", 2)
	return false
end


-- checks to see if a main hand item is equipped
function SpellFlashAddon.IsHandEquipped(offhand)
	local offhand = offhand
	if offhand then
		offhand = "SecondaryHandSlot"
	end
	local slot = GetInventorySlotInfo(offhand or "MainHandSlot")
	if (GetInventoryItemLink("player", slot)) then
		if GetInventoryItemBroken("player", slot) then
			--SpellFlashCore.debug("Your main hand item is broken.")
			return false
		end
		--SpellFlashCore.debug("You have a main hand item equipped.", 2)
		return true
	end
	--SpellFlashCore.debug("You do not have a main hand item equipped.", 2)
	return false
end

-- checks to see if a main hand item is equipped
function SpellFlashAddon.IsOffHandEquipped()
	return SpellFlashAddon.IsHandEquipped(1)
end


-- This is a test function
function SpellFlashAddon.ShowMainHandType()
	if (GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"))) then
		print(SpellFlashAddon.GetItemSubType(GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"))))
	else
		print("You do not have a main hand item equipped.")
	end
end

-- This is a test function
function SpellFlashAddon.ShowOffHandType()
	if (GetInventoryItemLink("player",GetInventorySlotInfo("SecondaryHandSlot"))) then
		print(SpellFlashAddon.GetItemSubType(GetInventoryItemLink("player",GetInventorySlotInfo("SecondaryHandSlot"))))
	else
		print("You do not have a off hand item equipped.")
	end
end






function SpellFlashAddon.IsTrinketByNameReady(name, find, id)
	if name or id then
		local n = SpellFlashAddon.GiveTrinketSlotNumberByName(name, find, id)
		if n then
			local s, d, e = GetInventoryItemCooldown("player", n)
			if e == 1 and s == 0 then
				return true
			end
		end
	end
	return false
end
function SpellFlashAddon.IsTrinketByItemIDReady(id, name, find)
	return SpellFlashAddon.IsTrinketByNameReady(name, find, id)
end


function SpellFlashAddon.IsTrinketByNameEquipped(name, find, id)
	if SpellFlashAddon.GiveTrinketSlotNumberByName(name, find, id) then
		return true
	end
	return false
end
function SpellFlashAddon.IsTrinketByItemIDEquipped(id, name, find)
	return SpellFlashAddon.IsTrinketByNameEquipped(name, find, id)
end


function SpellFlashAddon.GiveTrinketSlotNumberByName(name, find, id)
	if name or id then
		local id = SpellFlashAddon.GiveItemIDFromItemLink(id) or id
		for i=0,1 do
			local slot = GetInventorySlotInfo("Trinket"..i.."Slot")
			local link = GetInventoryItemLink("player", slot)
			local n, d = SpellFlashAddon.DecodeItemLink(link)
			if id then
				if d and (d == id or ""..d == id or "item:"..d..":0:0:0" == id or "item:"..d == id or d..":0:0:0" == id) then
					return slot
				end
			elseif name then
				if n then
					if ( find and n:match(name) ) or n == name then
						return slot
					end
				end
			end
		end
		if name then
			SpellFlashCore.debug("Trinket: ( "..name.." ) is not equipped!")
		else
			local N = GetItemInfo(id)
			if N then
				SpellFlashCore.debug("Trinket: ( "..N.." ) is not equipped!")
			end
		end
	else
		SpellFlashCore.debug("Trinket name and id not given!")
	end
	return nil
end
function SpellFlashAddon.GiveTrinketSlotNumberByItemID(id, name, find)
	return SpellFlashAddon.GiveTrinketSlotNumberByName(name, find, id)
end






function SpellFlashAddon.IsItemByNameEquipped(name, find, id)
	if SpellFlashAddon.GiveEquippedItemSlotNumberByName(name, find, id) then
		return true
	end
	return false
end
function SpellFlashAddon.IsItemByItemIDEquipped(id, name, find)
	return SpellFlashAddon.IsItemByNameEquipped(name, find, id)
end


function SpellFlashAddon.GiveEquippedItemSlotNumberByName(name, find, id)
	if name or id then
		local id = SpellFlashAddon.GiveItemIDFromItemLink(id) or id
		for slot=0,19 do
			local link = GetInventoryItemLink("player", slot)
			local n, d = SpellFlashAddon.DecodeItemLink(link)
			if id then
				if d and (d == id or ""..d == id or "item:"..d..":0:0:0" == id or "item:"..d == id or d..":0:0:0" == id) then
					return slot
				end
			elseif name then
				if n then
					if ( find and n:match(name) ) or n == name then
						return slot
					end
				end
			end
		end
		if name then
			SpellFlashCore.debug("Item: ( "..name.." ) is not equipped!")
		else
			local N = GetItemInfo(id)
			if N then
				SpellFlashCore.debug("Item: ( "..N.." ) is not equipped!")
			end
		end
	else
		SpellFlashCore.debug("Equipped Item name and id not given!")
	end
	return nil
end
function SpellFlashAddon.GiveEquippedItemSlotNumberByItemID(id, name, find)
	return SpellFlashAddon.GiveEquippedItemSlotNumberByName(name, find, id)
end


function SpellFlashAddon.DecodeItemLink(link)
	if type(link) == "string" then
		local id, name = link:match("item:(%d+):.*%[(.*)%]")
		if id then
			return name, tonumber(id)
		end
	end
	return nil
end

function SpellFlashAddon.GiveItemNameFromItemLink(link)
	return ( SpellFlashAddon.DecodeItemLink(link) )
end

function SpellFlashAddon.GiveItemIDFromItemLink(link)
	return ( select(2, SpellFlashAddon.DecodeItemLink(link)) )
end

function SpellFlashAddon.GiveItemIDFromItemName(ItemName)
	if type(ItemName) == "string" then
		return SpellFlashAddon.GiveItemIDFromItemLink(select(2, GetItemInfo(ItemName)))
	end
	return nil
end



function SpellFlashAddon.GetItemSubType(id)
	if id then
		return ( select(7, GetItemInfo(id)) )
	end
	return nil
end

function SpellFlashAddon.GetItemName(id)
	if id then
		return (GetItemInfo(id))
	end
	return nil
end


function SpellFlashAddon.CopyTable(Table)
	local t = {}
	if type(Table) == "table" then
		for k,v in pairs(Table) do
			t[k] = v
		end
	end
	return t
end


function SpellFlashAddon.PetCastable(SpellName, PetFrameNeeded, PetHealthNotNeeded, GlobalCooldownSpell, EvenIfNotUsable)
	if ( AddonTable.PetActions[SpellName] or SpellFlashAddon.IsSpellKnown(SpellName) ) and not SpellFlashAddon.CastingOrChanneling(SpellName, "pet") and ( PetHealthNotNeeded or UnitHealth("pet") > 0 ) and ( not PetFrameNeeded or UnitExists("pet") ) then
		for n = 1, NUM_PET_ACTION_SLOTS do
			local name, subtext, texture, isToken, isActive = GetPetActionInfo(n)
			if ( AddonTable.PetActions[SpellName] or SpellName ) == name then
				local globalcooldown = 1.5
				if SpellFlashAddon.IsSpellKnown(GlobalCooldownSpell) then
					globalcooldown = SpellFlashAddon.GetSpellCooldown(GlobalCooldownSpell)
				end
				local cooldown, duration = SpellFlashAddon.GetPetActionCooldown(n)
				return not isActive and ( EvenIfNotUsable or GetPetActionSlotUsable(n) ) and ( duration <= 1.5 or cooldown <= select(3,GetNetStats()) / 1000 or ( cooldown <= 1.5 and cooldown <= globalcooldown ) )
			end
		end
	end
	return false
end
SpellFlashAddon.PetBarActionCastable = SpellFlashAddon.PetCastable


function SpellFlashAddon.CheckIfSpellCastable(InfoArray)
	local z = InfoArray
	if type(z) ~= "table" then
		z = {SpellName = z}
	end
	if not z.SpellName or not SpellFlashAddon.IsSpellKnown(z.SpellName) then
		return false
	end
	if z.EnemyTargetNeeded and SpellFlashAddon.IsImmune(z.SpellName) then
		return false
	end
	local Lag = select(3,GetNetStats()) / 1000
	local SpellCast = SpellFlashAddon.Casting()
	local isUsable, notEnoughPower = IsUsableSpell(z.SpellName)
	local name, rank, icon, cost, isFunnel, powerType, castTime = GetSpellInfo(z.SpellName)
	local SpellCastPower = SpellFlashAddon.GetSpellCost(SpellCast, powerType)
	local globalcooldown = SpellFlashAddon.GetSpellCooldown(GLOBAL_COOLDOWN_SPELL) or 1.5
	local cooldown, duration = SpellFlashAddon.GetSpellCooldown(z.SpellName)
	z.CastTime = z.CastTime or (castTime or 0) / 1000
	return (( z.EvenIfNotUsable or isUsable ) and not notEnoughPower
		and ( not z.NotWhileMoving or GetUnitSpeed("player") == 0 )
		and ( not SpellCast or SpellCastPower == 0 or UnitPower("player", powerType) >= ( (cost or 0) + SpellCastPower ) )
		and ( cooldown <= Lag or cooldown <= globalcooldown )
		and ( ( not z.NotIfActive and not z.DebuffName and not z.BuffName and not z.Debuff and not z.Buff and not z.MyDebuff and not z.MyBuff ) or ( not IsCurrentSpell(z.SpellName) and not SpellFlashAddon.CastingOrChanneling(z.SpellName) ) )
		and ( z.NoRangeCheck or ( z.Buff and ( not z.BuffUnit or UnitIsUnit(z.BuffUnit, "player") ) ) or not SpellHasRange(z.SpellName) or IsSpellInRange(z.SpellName, z.BuffUnit) == 1 )
		and ( not z.EnemyTargetNeeded or SpellFlashAddon.IsEnemy() )
		and ( not z.TargetThatUsesManaNeeded or SpellFlashAddon.UsesMana("target") )
		and ( not z.DebuffSlotNeeded or not SpellFlashAddon.AllDebuffSlotsUsed() )
		and ( not z.DebuffName or ( not SpellFlashAddon.AuraDelay(z.DebuffName) and not SpellFlashAddon.CheckDebuff(z.DebuffName,nil,z.IsMine,true,nil,z.CastTime + (Lag * 2)) ) )
		and ( not z.BuffName or ( not SpellFlashAddon.AuraDelay(z.BuffName, z.BuffUnit) and not SpellFlashAddon.CheckBuff(z.BuffName,z.BuffUnit,z.IsMine,true,nil,z.CastTime + (Lag * 2)) ) )
		and ( not z.Debuff or ( not SpellFlashAddon.AuraDelay(z.Debuff) and not SpellFlashAddon.CheckDebuff(z.Debuff,nil,nil,true,nil,z.CastTime + (Lag * 2)) ) )
		and ( not z.Buff or ( not SpellFlashAddon.AuraDelay(z.Buff, z.BuffUnit) and not SpellFlashAddon.CheckBuff(z.Buff,z.BuffUnit,nil,true,nil,z.CastTime + (Lag * 2)) ) )
		and ( not z.MyDebuff or ( not SpellFlashAddon.AuraDelay(z.MyDebuff) and not SpellFlashAddon.CheckDebuff(z.MyDebuff,nil,1,true,nil,z.CastTime + (Lag * 2)) ) )
		and ( not z.MyBuff or ( not SpellFlashAddon.AuraDelay(z.MyBuff, z.BuffUnit) and not SpellFlashAddon.CheckBuff(z.MyBuff,z.BuffUnit,1,true,nil,z.CastTime + (Lag * 2)) ) )
	)
end


function SpellFlashAddon.CheckIfVehicleSpellCastable(InfoArray)
	if not UnitHasVehicleUI("player") then return false end
	local z = InfoArray
	if type(z) ~= "table" then
		z = {SpellName = z}
	end
	if not z.SpellName then
		return false
	end
	if z.EnemyTargetNeeded and SpellFlashAddon.IsImmune(z.SpellName) then
		return false
	end
	local slot = SpellFlashAddon.VehicleSlot(z.SpellName)
	if not slot then
		return false
	end
	local Lag = select(3,GetNetStats()) / 1000
	local isUsable, notEnoughPower = IsUsableAction(slot)
	local globalcooldown = SpellFlashAddon.GetActionCooldown(SpellFlashAddon.VehicleSlot(z.GlobalVehicleCooldownSpell)) or 1.5
	local cooldown, duration = SpellFlashAddon.GetActionCooldown(slot)
	z.CastTime = z.CastTime or 0
	return (( z.EvenIfNotUsable or isUsable ) and not notEnoughPower
		and ( not z.NotWhileMoving or GetUnitSpeed("player") == 0 )
		and ( duration <= 1.5 or cooldown <= Lag or ( cooldown <= 1.5 and cooldown <= globalcooldown ) )
		and ( ( not z.NotIfActive and not z.DebuffName and not z.BuffName and not z.Debuff and not z.Buff and not z.MyDebuff and not z.MyBuff ) or ( not IsCurrentAction(slot) and not SpellFlashAddon.CastingOrChanneling(z.SpellName, "vehicle") ) )
		and ( z.NoRangeCheck or ( z.Buff and ( not z.BuffUnit or UnitIsUnit(z.BuffUnit, "player") ) ) or not ActionHasRange(slot) or IsActionInRange(slot) == 1 )
		and ( not z.EnemyTargetNeeded or SpellFlashAddon.IsEnemy() )
		and ( not z.TargetThatUsesManaNeeded or SpellFlashAddon.UsesMana("target") )
		and ( not z.DebuffSlotNeeded or not SpellFlashAddon.AllDebuffSlotsUsed() )
		and ( not z.DebuffName or not SpellFlashAddon.CheckDebuff(z.DebuffName,nil,z.IsMine,nil,nil,z.CastTime + (Lag * 2)) )
		and ( not z.BuffName or not SpellFlashAddon.CheckBuff(z.BuffName,z.BuffUnit,z.IsMine,nil,nil,z.CastTime + (Lag * 2)) )
		and ( not z.Debuff or not SpellFlashAddon.CheckDebuff(z.Debuff,nil,nil,nil,nil,z.CastTime + (Lag * 2)) )
		and ( not z.Buff or not SpellFlashAddon.CheckBuff(z.Buff,z.BuffUnit,nil,nil,nil,z.CastTime + (Lag * 2)) )
		and ( not z.MyDebuff or not SpellFlashAddon.CheckDebuff(z.MyDebuff,nil,1,nil,nil,z.CastTime + (Lag * 2)) )
		and ( not z.MyBuff or not SpellFlashAddon.CheckBuff(z.MyBuff,z.BuffUnit,1,nil,nil,z.CastTime + (Lag * 2)) )
	)
end


function SpellFlashAddon.CheckIfItemCastable(InfoArray)
	local z = InfoArray
	if type(z) ~= "table" then
		z = {ItemName = z}
	end
	if not z.ItemName or not SpellFlashAddon.HasItem(z.ItemName) then
		return false
	end
	if z.EnemyTargetNeeded and SpellFlashAddon.IsImmune(z.ItemName) then
		return false
	end
	local Lag = select(3,GetNetStats()) / 1000
	local isUsable, notEnoughPower = IsUsableItem(z.ItemName)
	local globalcooldown = SpellFlashAddon.GetSpellCooldown(GLOBAL_COOLDOWN_SPELL) or 1.5
	local cooldown, duration = SpellFlashAddon.GetItemCooldown(z.ItemName)
	z.CastTime = z.CastTime or 0
	return (( z.EvenIfNotUsable or isUsable ) and not notEnoughPower
		and ( not z.NotWhileMoving or GetUnitSpeed("player") == 0 )
		and ( not IsEquippableItem(z.ItemName) or IsEquippedItem(z.ItemName) )
		and ( cooldown <= Lag or cooldown <= globalcooldown )
		and ( ( not z.NotIfActive and not z.DebuffName and not z.BuffName and not z.Debuff and not z.Buff and not z.MyDebuff and not z.MyBuff ) or ( not IsCurrentItem(z.ItemName) and not SpellFlashAddon.CastingOrChanneling(z.ItemName) ) )
		and ( z.NoRangeCheck or ( z.Buff and ( not z.BuffUnit or UnitIsUnit(z.BuffUnit, "player") ) ) or not ItemHasRange(z.ItemName) or IsItemInRange(z.ItemName, z.BuffUnit) == 1 )
		and ( not z.EnemyTargetNeeded or SpellFlashAddon.IsEnemy() )
		and ( not z.TargetThatUsesManaNeeded or SpellFlashAddon.UsesMana("target") )
		and ( not z.DebuffSlotNeeded or not SpellFlashAddon.AllDebuffSlotsUsed() )
		and ( not z.DebuffName or not SpellFlashAddon.CheckDebuff(z.DebuffName,nil,z.IsMine,nil,nil,z.CastTime + (Lag * 2)) )
		and ( not z.BuffName or not SpellFlashAddon.CheckBuff(z.BuffName,z.BuffUnit,z.IsMine,nil,nil,z.CastTime + (Lag * 2)) )
		and ( not z.Debuff or not SpellFlashAddon.CheckDebuff(z.Debuff,nil,nil,nil,nil,z.CastTime + (Lag * 2)) )
		and ( not z.Buff or not SpellFlashAddon.CheckBuff(z.Buff,z.BuffUnit,nil,nil,nil,z.CastTime + (Lag * 2)) )
		and ( not z.MyDebuff or not SpellFlashAddon.CheckDebuff(z.MyDebuff,nil,1,nil,nil,z.CastTime + (Lag * 2)) )
		and ( not z.MyBuff or not SpellFlashAddon.CheckBuff(z.MyBuff,z.BuffUnit,1,nil,nil,z.CastTime + (Lag * 2)) )
	)
end


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
		SpellFlashAddon.ShowDebuffs()
	elseif msg:match("buff") then
		SpellFlashAddon.ShowBuffs()
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


function SpellFlashAddon.Flashable(SpellName, NoMacros)
	return SpellFlashCore.Flashable(SpellName, NoMacros or DISABLE_MACRO_FLASHING)
end
SpellFlashAddon.FlashableButtonFound = SpellFlashAddon.Flashable

function SpellFlashAddon.FlashAction(SpellName, color, size, brightness, blink, NoMacros)
	SpellFlashCore.FlashAction(SpellName, color, size or FLASH_SIZE_PERCENT or DEFAULT_FLASH_SIZE_PERCENT, brightness or FLASH_BRIGHTNESS_PERCENT or DEFAULT_FLASH_BRIGHTNESS_PERCENT, blink or ENABLE_BLINKING, NoMacros or DISABLE_MACRO_FLASHING)
end
SpellFlashAddon.FlashActionButtonBySpellName = SpellFlashAddon.FlashAction

function SpellFlashAddon.FlashVehicle(SpellName, color, size, brightness, blink)
	SpellFlashCore.FlashVehicle(SpellName, color, size or FLASH_SIZE_PERCENT or DEFAULT_FLASH_SIZE_PERCENT, brightness or FLASH_BRIGHTNESS_PERCENT or DEFAULT_FLASH_BRIGHTNESS_PERCENT, blink or ENABLE_BLINKING)
end
SpellFlashAddon.FlashVehicleButtonBySpellName = SpellFlashAddon.FlashVehicle

function SpellFlashAddon.FlashPet(SpellName, color, size, brightness, blink)
	SpellFlashCore.FlashPet(SpellName, color, size or FLASH_SIZE_PERCENT or DEFAULT_FLASH_SIZE_PERCENT, brightness or FLASH_BRIGHTNESS_PERCENT or DEFAULT_FLASH_BRIGHTNESS_PERCENT, blink or ENABLE_BLINKING)
end
SpellFlashAddon.FlashPetButtonBySpellName = SpellFlashAddon.FlashPet

function SpellFlashAddon.FlashForm(SpellName, color, size, brightness, blink)
	SpellFlashCore.FlashForm(SpellName, color, size or FLASH_SIZE_PERCENT or DEFAULT_FLASH_SIZE_PERCENT, brightness or FLASH_BRIGHTNESS_PERCENT or DEFAULT_FLASH_BRIGHTNESS_PERCENT, blink or ENABLE_BLINKING)
end
SpellFlashAddon.FlashFormButtonBySpellName = SpellFlashAddon.FlashForm





local HasTalent = SpellFlashAddon.HasTalent
local TalentRank = SpellFlashAddon.GetTalentRank
local HasGlyph = SpellFlashAddon.HasGlyph
local Buff = SpellFlashAddon.CheckBuff
local Debuff = SpellFlashAddon.CheckDebuff
local HealthPercent = SpellFlashAddon.HealthPercent
local PowerPercent = SpellFlashAddon.PowerPercent
local InCombat = SpellFlashAddon.InCombat
local SpellDelay = SpellFlashAddon.SpellDelay
local AuraDelay = SpellFlashAddon.AuraDelay
local Form = SpellFlashAddon.Form
local SpellKnown = SpellFlashAddon.IsSpellKnown
local SpellRank = SpellFlashAddon.GetSpellRank
local SpellCost = SpellFlashAddon.GetSpellCost
local CastTime = SpellFlashAddon.GetSpellCastTime
local Casting = SpellFlashAddon.CastingOrChanneling


SpellFlashAddon.Castable["Auto Attack"] = function()
	if not SpellFlashAddon.MeleeDistance() then
		return false
	end
	local z = {}
	z.SpellName = SpellName(6603--[[Auto Attack]])
	z.EnemyTargetNeeded = 1
	z.NotIfActive = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end
SpellFlashAddon.Castable["Attack"] = SpellFlashAddon.Castable["Auto Attack"]


SpellFlashAddon.Castable["Shoot"] = function()
	if SpellFlashAddon.AutoShoot then
		return false
	end
	local z = {}
	z.SpellName = SpellName(3018--[[Shoot]])
	z.EnemyTargetNeeded = 1
	z.NotIfActive = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end


function SpellFlashAddon.IsBreakOnDamageCC(unit, isExpirationTimeOrLess)
	return Debuff(
		{
			SpellName(118--[[Polymorph]]),
			SpellName(2637--[[Hibernate]]),
			SpellName(9484--[[Shackle Undead]]),
			SpellName(6770--[[Sap]]),
			SpellName(6358--[[Seduction]]),
			SpellName(19503--[[Scatter Shot]]),
			SpellName(1499--[[Freezing Trap]]),
			SpellName(51514--[[Hex]]),
		},unit,nil,nil,nil,isExpirationTimeOrLess)
		or Debuff(SpellName(19386--[[Wyvern Sting]]),unit,nil,nil,nil,isExpirationTimeOrLess,nil,nil,nil,nil,L["Asleep"])
end


--all forms of fear and movement impairing affects are not included since they do not prevent the target from being damaged
--Mind Control is no longer included as a CC in this function
function SpellFlashAddon.IsNoDamageCC(unit, isExpirationTimeOrLess)
	return SpellFlashAddon.IsBreakOnDamageCC(unit, isExpirationTimeOrLess)
	or Debuff(
		{
			SpellName(710--[[Banish]]),
			SpellName(33786--[[Cyclone]]),
			SpellName(605--[[Mind Control]]),
		},unit,nil,nil,nil,isExpirationTimeOrLess)
end


--movement impairing affects are not included since the target could still attack
function SpellFlashAddon.IsCrowedControlled(unit, isExpirationTimeOrLess)
	return SpellFlashAddon.IsNoDamageCC(unit, isExpirationTimeOrLess)
	or SpellFlashAddon.IsFeared(unit, isExpirationTimeOrLess)
end


--movement impairing affects are not included since the target could still attack
function SpellFlashAddon.IsFeared(unit, isExpirationTimeOrLess)
	return Debuff(
		{
			SpellName(5782--[[Fear]]),
			SpellName(5484--[[Howl of Terror]]),
			SpellName(8122--[[Psychic Scream]]),
			SpellName(1513--[[Scare Beast]]),
		},unit,nil,nil,nil,isExpirationTimeOrLess)
end


function SpellFlashAddon.IsRooted(unit, isExpirationTimeOrLess)
	return Debuff(
		{
			SpellName(339--[[Entangling Roots]]),
			SpellName(122--[[Frost Nova]]),
			SpellName(45524--[[Chains of Ice]]),
			SpellName(16979--[[Feral Charge - Bear]]),
		},unit,nil,nil,nil,isExpirationTimeOrLess)
end


function SpellFlashAddon.IsMovementImpaired(unit, isExpirationTimeOrLess)
	return SpellFlashAddon.IsRooted(unit, isExpirationTimeOrLess)
	or Debuff(
		{
			SpellName(2974--[[Wing Clip]]),
			SpellName(5116--[[Concussive Shot]]),
			SpellName(13809--[[Frost Trap]]),
			SpellName(116--[[Frostbolt]]),
			SpellName(120--[[Cone of Cold]]),
			SpellName(11113--[[Blast Wave]]),
			SpellName(31589--[[Slow]]),
			SpellName(15407--[[Mind Flay]]),
			SpellName(3408--[[Crippling Poison]]),
			SpellName(26679--[[Deadly Throw]]),
			SpellName(8056--[[Frost Shock]]),
			SpellName(2484--[[Earthbind Totem]]),
			SpellName(18223--[[Curse of Exhaustion]]),
			SpellName(1715--[[Hamstring]]),
			SpellName(12323--[[Piercing Howl]]),
		},unit,nil,nil,nil,isExpirationTimeOrLess)
end


function SpellFlashAddon.IsPoisoned(unit)
	return Debuff(nil,unit,nil,nil,nil,nil,nil,nil,nil,nil,nil,"Poison")
end

function SpellFlashAddon.IsDiseased(unit)
	return Debuff(nil,unit,nil,nil,nil,nil,nil,nil,nil,nil,nil,"Disease")
end


function SpellFlashAddon.IsTracking(texture)
	return GetTrackingTexture() and ( not texture or GetTrackingTexture():match(texture) )
end
SpellFlashAddon.IsTrackingTexture = SpellFlashAddon.IsTracking
SpellFlashAddon.IsTrackingActive = SpellFlashAddon.IsTracking

function SpellFlashAddon.IsTrackHumanoidsActive()
	return SpellFlashAddon.IsTrackingTexture("Spell_Holy_PrayerOfHealing")
end

function SpellFlashAddon.IsTrackMineralsActive()
	return SpellFlashAddon.IsTrackingTexture("Spell_Nature_Earthquake")
end

function SpellFlashAddon.IsTrackBeastsActive()
	return SpellFlashAddon.IsTrackingTexture("Ability_Tracking")
end

function SpellFlashAddon.IsTrackDemonsActive()
	return SpellFlashAddon.IsTrackingTexture("Spell_Shadow_SummonFelHunter")
end

function SpellFlashAddon.IsTrackDragonsActive()
	return SpellFlashAddon.IsTrackingTexture("INV_Misc_Head_Dragon_01")
end

function SpellFlashAddon.IsTrackElementalsActive()
	return SpellFlashAddon.IsTrackingTexture("Spell_Frost_SummonWaterElemental")
end

function SpellFlashAddon.IsTrackGiantsActive()
	return SpellFlashAddon.IsTrackingTexture("Ability_Racial_Avatar")
end

function SpellFlashAddon.IsTrackHiddenActive()
	return SpellFlashAddon.IsTrackingTexture("Ability_Stealth")
end

function SpellFlashAddon.IsTrackUndeadActive()
	return SpellFlashAddon.IsTrackingTexture("Spell_Shadow_DarkSummoning")
end

function SpellFlashAddon.IsTrackHerbsActive()
	return SpellFlashAddon.IsTrackingTexture("INV_Misc_Flower_02")
end


SpellFlashAddon.Castable["Track Beasts"] = function()
	if SpellFlashAddon.IsTrackBeastsActive() then
		return false
	end
	local z = {}
	z.SpellName = SpellName(1494--[[Track Beasts]])
	return SpellFlashAddon.CheckIfSpellCastable(z)
end


SpellFlashAddon.Castable["Track Humanoids"] = function()
	if SpellFlashAddon.IsTrackHumanoidsActive() then
		return false
	end
	local z = {}
	z.SpellName = SpellName(19883--[[Track Humanoids]])
	return SpellFlashAddon.CheckIfSpellCastable(z)
end


SpellFlashAddon.Castable["Track Undead"] = function()
	if SpellFlashAddon.IsTrackUndeadActive() then
		return false
	end
	local z = {}
	z.SpellName = SpellName(19884--[[Track Undead]])
	return SpellFlashAddon.CheckIfSpellCastable(z)
end


SpellFlashAddon.Castable["Track Elementals"] = function()
	if SpellFlashAddon.IsTrackElementalsActive() then
		return false
	end
	local z = {}
	z.SpellName = SpellName(19880--[[Track Elementals]])
	return SpellFlashAddon.CheckIfSpellCastable(z)
end


SpellFlashAddon.Castable["Track Giants"] = function()
	if SpellFlashAddon.IsTrackGiantsActive() then
		return false
	end
	local z = {}
	z.SpellName = SpellName(19882--[[Track Giants]])
	return SpellFlashAddon.CheckIfSpellCastable(z)
end


SpellFlashAddon.Castable["Track Dragonkin"] = function()
	if SpellFlashAddon.IsTrackDragonkinActive() then
		return false
	end
	local z = {}
	z.SpellName = SpellName(19879--[[Track Dragonkin]])
	return SpellFlashAddon.CheckIfSpellCastable(z)
end


