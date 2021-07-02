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
		
		-- Place script here
		
	end
end


-- Use this multiple spam table, or remove this table and use the single spam function above.
AddonTable.Spam = {
	
	
	-- Default script
	{Title = L["Retribution"], -- Place script title here
	--Description = L["Script Description"], -- Place optional script description here or comment out or remove this line
	Function = function(NoCC, ActiveEnemy, PetAlive, PetActiveEnemy, instanceType, PetNoCC)
		
		if Flashable(SpellName(24275--[[Hammer of Wrath]])) and NoCC and Castable("Hammer of Wrath") then
			Flash(SpellName(24275--[[Hammer of Wrath]]), SetColor(ActiveEnemy, "Orange"))
			
		elseif Flashable(SpellName(31884--[[Avenging Wrath]])) and InCombat() and ActiveEnemy and Castable("Avenging Wrath") then
			Flash(SpellName(31884--[[Avenging Wrath]]), "Green")
			
		elseif Flashable(SpellName(54428--[[Divine Plea]])) and InCombat() and ActiveEnemy and Castable("Divine Plea") then
			Flash(SpellName(54428--[[Divine Plea]]), "Green")
			
		elseif Flashable(SpellName(53601--[[Sacred Shield]])) and InCombat() and ActiveEnemy and Castable("Sacred Shield") then
			Flash(SpellName(53601--[[Sacred Shield]]), "Green")
			
		end
		
		if Flashable(SpellName(53408--[[Judgement of Wisdom]])) and NoCC and Castable("Judgement of Wisdom") then
			Flash(SpellName(53408--[[Judgement of Wisdom]]), SetColor(ActiveEnemy))
			
		elseif Flashable(SpellName(35395--[[Crusader Strike]])) and NoCC and Castable("Crusader Strike") then
			Flash(SpellName(35395--[[Crusader Strike]]), SetColor(ActiveEnemy))
			
		else
		
			if Flashable(SpellName(53385--[[Divine Storm]])) and ActiveEnemy and Castable("Divine Storm") then
				Flash(SpellName(53385--[[Divine Storm]]), "Purple")
				
			elseif Flashable(SpellName(26573--[[Consecration]])) and ActiveEnemy and Castable("Consecration") then
				Flash(SpellName(26573--[[Consecration]]), "Purple")
				
			end
			
			if Flashable(SpellName(879--[[Exorcism]])) and NoCC and Castable("Exorcism") then
				Flash(SpellName(879--[[Exorcism]]), SetColor(ActiveEnemy))
				
			end
			
		end
		
	end},
	
	
}

