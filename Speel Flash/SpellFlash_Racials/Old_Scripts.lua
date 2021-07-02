local AddonName, AddonTable = ...
if not AddonTable.OldBuild then return end
local L = AddonTable.Localize
local function Castable(English_Spell_Name, ...)
	if type(AddonTable.Castable[English_Spell_Name]) == "function" then
		return AddonTable.Castable[English_Spell_Name](...)
	end
	print(English_Spell_Name, ": has not been defined in a function!")
	return false
end
local function VehicleCastable(English_Spell_Name, ...)
	if type(AddonTable.VehicleCastable[English_Spell_Name]) == "function" then
		return AddonTable.VehicleCastable[English_Spell_Name](...)
	end
	print(English_Spell_Name, ": has not been defined in a function!")
	return false
end
local function ItemCastable(English_Item_Name, ...)
	if type(AddonTable.ItemCastable[English_Item_Name]) == "function" then
		return AddonTable.ItemCastable[English_Item_Name](...)
	end
	print(English_Item_Name, ": has not been defined in a function!")
	return false
end
local function SpellName(GlobalSpellID)
	return (GetSpellInfo(GlobalSpellID))
end
local function ItemName(GlobalItemID)
	return (GetItemInfo(GlobalItemID))
end
local PetCastable = SpellFlashAddon.PetCastable
local Flash = SpellFlashAddon.FlashAction
local FlashPet = SpellFlashAddon.FlashPet
local FlashForm = SpellFlashAddon.FlashForm
local FlashVehicle = SpellFlashAddon.FlashVehicle
local Flashable = SpellFlashAddon.Flashable
local VehicleFlashable = SpellFlashAddon.VehicleSlot
local IsAutocastOn = SpellFlashAddon.IsSpellAutocastOn
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
local function GetConfig(config)
	return SpellFlashAddon.GetModuleConfig(AddonName, config)
end
local function SetConfig(config, value)
	SpellFlashAddon.SetModuleConfig(AddonName, config, value)
end
local function ClearAllConfigs()
	SpellFlashAddon.ClearAllModuleConfigs(AddonName)
end
local function RunSpamTable(...)
	local i = GetConfig("script_number") or 1
	if type(AddonTable.Spam[i]) == "table" and type(AddonTable.Spam[i].Function) == "function" then
		AddonTable.Spam[i].Function(...)
	elseif type(AddonTable.Spam[1]) == "table" and type(AddonTable.Spam[1].Function) == "function" then
		SetConfig("script_number", nil)
		AddonTable.Spam[1].Function(...)
	end
end

local function SetColor(UseColor, Color, ElseColor)
	if UseColor then
		return Color
	end
	return ElseColor or "Pink"
end

--[[
	White - Default
	Yellow - Limited Time or No Global Cooldown
	Purple - AOE or Positional Damage
	Blue - AOE Debuff
	Orange - Finishing Move
	Aqua - Spell Interrupt, Reflect or Dispel
	Green - Self Buff or Turn Autocast On
	Red - Emergency Mitigation Cooldowns or Turn Autocast Off
	Pink - Optional
]]



SpellFlashAddon.Spam[AddonName] = function(NoCC, ActiveEnemy, PetAlive, PetActiveEnemy, instanceType, PetNoCC)
	if GetConfig("spell_flashing_off") then return elseif AddonTable.Spam then RunSpamTable(NoCC, ActiveEnemy, PetAlive, PetActiveEnemy, instanceType, PetNoCC) else
		
		if SpellFlashAddon.HUMAN then
			if Flashable(SpellName(59752--[[Every Man for Himself]])) and Castable("Every Man for Himself") then
				Flash(SpellName(59752--[[Every Man for Himself]]), "Aqua")
			end
		elseif SpellFlashAddon.UNDEAD then
			if Flashable(SpellName(7744--[[Will of the Forsaken]])) and Castable("Will of the Forsaken") then
				Flash(SpellName(7744--[[Will of the Forsaken]]), "Aqua")
			end
		elseif SpellFlashAddon.DWARF then
			if Flashable(SpellName(20594--[[Stoneform]])) and Castable("Stoneform") then
				Flash(SpellName(20594--[[Stoneform]]), "Aqua")
			end
		elseif SpellFlashAddon.BLOODELF then
			if Flashable(SpellName(28734--[[Mana Tap]])) and ActiveEnemy and Castable("Mana Tap") then
				Flash(SpellName(28734--[[Mana Tap]]), "Yellow")
			end
			if Flashable(SpellName(28730--[[Arcane Torrent]])) and Castable("Arcane Torrent") then
				Flash(SpellName(28730--[[Arcane Torrent]]), "Aqua")
			end
		elseif SpellFlashAddon.TROLL then
			if Flashable(SpellName(26297--[[Berserking]])) and ActiveEnemy and InCombat() and ( UnitIsPlayer("target") or string.find(string.lower(UnitClassification("target") or ""), "boss") or ( UnitLevel("target") == -1 and not UnitPlayerControlled("target") ) ) and Castable("Berserking") then
				Flash(SpellName(26297--[[Berserking ]]), "Green")
			end
		elseif SpellFlashAddon.ORC then
			if Flashable(SpellName(20572--[[Blood Fury]])) and ActiveEnemy and InCombat() and ( UnitIsPlayer("target") or string.find(string.lower(UnitClassification("target") or ""), "boss") or ( UnitLevel("target") == -1 and not UnitPlayerControlled("target") ) ) and Castable("Blood Fury") then
				Flash(SpellName(20572--[[Blood Fury ]]), "Green")
			end
		elseif SpellFlashAddon.GNOME then
			if Flashable(SpellName(20589--[[Escape Artist]])) and Castable("Escape Artist") then
				Flash(SpellName(20589--[[Escape Artist]]), "Aqua")
			end
		end
		
	end
end

