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


-- Use this single spam function and remove the multiple spam table below, or just use the multiple spam table below and leave this function in place.
SpellFlashAddon.Spam[AddonName] = function(NoCC, ActiveEnemy, PetAlive, PetActiveEnemy, instanceType, PetNoCC)
	if GetConfig("spell_flashing_off") then return elseif AddonTable.Spam then RunSpamTable(NoCC, ActiveEnemy, PetAlive, PetActiveEnemy, instanceType, PetNoCC) else
		
		if Flashable(SpellName(168--[[Frost Armor]])) and Castable("Frost Armor") then
			Flash(SpellName(168--[[Frost Armor]]), "Green")
		end
		if Flashable(SpellName(30482--[[Molten Armor]])) and Castable("Molten Armor") then
			Flash(SpellName(30482--[[Molten Armor]]), "Green")
		end
		if Flashable(SpellName(6117--[[Mage Armor]])) and Castable("Mage Armor") then
			Flash(SpellName(6117--[[Mage Armor]]), "Green")
		end
		if Flashable(SpellName(23028--[[Arcane Brilliance]])) and Castable("Arcane Brilliance") then
			Flash(SpellName(23028--[[Arcane Brilliance]]), "Green")
		end
		if Flashable(SpellName(1459--[[Arcane Intellect]])) and Castable("Arcane Intellect") then
			Flash(SpellName(1459--[[Arcane Intellect]]), "Green")
		end

		if Buff(SpellName(48108--[[Hot Streak]])) and Flashable(SpellName(11366--[[Pyroblast]])) and NoCC and Castable("Pyroblast") then
			Flash(SpellName(11366--[[Pyroblast]]), SetColor(ActiveEnemy, "Yellow"))
		end
		if Buff(SpellName(54741--[[Firestarter]])) and Flashable(SpellName(2120--[[Flamestrike]])) and NoCC and Castable("Flamestrike") then
			Flash(SpellName(2120--[[Flamestrike]]), SetColor(ActiveEnemy, "Yellow"))
		end	
		if Buff(SpellName(64343--[[Impact]])) and Flashable(SpellName(2136--[[Fire Blast]])) and NoCC and Castable("Fire Blast") then
			Flash(SpellName(2136--[[Fire Blast]]), SetColor(ActiveEnemy, "Yellow"))
		end	
		if Buff(SpellName(44401--[[Missile Barrage]])) and Flashable(SpellName(5143--[[Arcane Missiles]])) and NoCC and Castable("Arcane Missiles") then
			Flash(SpellName(5143--[[Arcane Missiles]]), SetColor(ActiveEnemy, "Yellow"))
		end	
		
		if Buff(SpellName(44544--[[Fingers of Frost]])) then
			if Flashable(SpellName(44572--[[Deep Freeze]])) and NoCC and Castable("Deep Freeze") then
			Flash(SpellName(44572--[[Deep Freeze]]), SetColor(ActiveEnemy, "Yellow"))
			end	
			if Flashable(SpellName(116--[[Frostbolt]])) and NoCC and Castable("Frostbolt") then
			Flash(SpellName(116--[[Frostbolt]]), SetColor(ActiveEnemy, "Yellow"))
			end	
		end
		if Buff(SpellName(54741--[[Fireball!]])) then
			if Flashable(SpellName(133--[[Fireball]])) and NoCC and Castable("Fireball") then
			Flash(SpellName(133--[[Fireball]]), SetColor(ActiveEnemy, "Yellow"))
			end	
			if Flashable(SpellName(44614--[[Frostfire Bolt]])) and NoCC and Castable("Frostfire Bolt") then
			Flash(SpellName(44614--[[Frostfire Bolt]]), SetColor(ActiveEnemy, "Yellow"))
			end	
		end
		
		if Flashable(SpellName(12051--[[Evocation]])) and NoCC and PowerPercent("player") < 20 and Castable("Evocation") then
			Flash(SpellName(12051--[[Evocation]]), SetColor(ActiveEnemy, "Aqua"))
		end
		
		if Buff(SpellName(32182--[[Heroism]])) or Buff(SpellName(2825--[[Bloodlust]])) then
			if Flashable(SpellName(55342--[[Mirror Image]])) and NoCC and Castable("Mirror Image") then
				Flash(SpellName(55342--[[Mirror Image]]), SetColor(ActiveEnemy, "Purple"))
			end
		end
		
		
	end
end
