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


local function Buffs(NoCC, ActiveEnemy, PetAlive, PetActiveEnemy, instanceType, PetNoCC)
	if not IsMounted() and ( not IsResting() or InCombat() or SpellFlashAddon.IsEnemy()  ) then
		if Castable("Inner Fire") then
			Flash(SpellName(48168--[[Inner Fire]]), "Green")
		end
		if Flashable(SpellName(15286--[[Vampiric Embrace]])) and Castable("Vampiric Embrace") then
			Flash(SpellName(15286--[[Vampiric Embrace]]), "Green")
		end

		if Flashable(SpellName(1243--[[Power Word: Fortitude]])) and not AddonTable.IsFortActive() and Castable("Power Word: Fortitude") then
			Flash(SpellName(1243--[[Power Word: Fortitude]]), "Green")
		end
		if Flashable(SpellName(14752--[[Divine Spirit]])) and not AddonTable.IsSpiritActive() and Castable("Divine Spirit") then
			Flash(SpellName(14752--[[Divine Spirit]]), "Green")
		end
		if Flashable(SpellName(976--[[Shadow Protection]])) and not AddonTable.IsShadowActive() and Castable("Shadow Protection") then
			Flash(SpellName(976--[[Shadow Protection]]), "Green")
		end
	


		if instanceType == "party" or instanceType == "raid" then
			if Flashable(SpellName(21562--[[Prayer of Fortitude]])) and not AddonTable.IsFortActive() and Castable("Prayer of Fortitude") then
				Flash(SpellName(21562--[[Prayer of Fortitude]]), "Green")
			end
			if Flashable(SpellName(27681--[[Prayer of Spirit]])) and not AddonTable.IsSpiritActive() and Castable("Prayer of Spirit") then
				Flash(SpellName(27681--[[Prayer of Spirit]]), "Green")
			end
			if Flashable(SpellName(27683--[[Prayer of Shadow Protection]])) and not AddonTable.IsShadowActive() and Castable("Prayer of Shadow Protection") then
				Flash(SpellName(27683--[[Prayer of Shadow Protection]]), "Green")
			end
		end
	end
end


-- Use this single spam function and remove the multiple spam table below, or just use the multiple spam table below and leave this function in place.
SpellFlashAddon.Spam[AddonName] = function(NoCC, ActiveEnemy, PetAlive, PetActiveEnemy, instanceType, PetNoCC)
	if GetConfig("spell_flashing_off") then return elseif AddonTable.Spam then RunSpamTable(NoCC, ActiveEnemy, PetAlive, PetActiveEnemy, instanceType, PetNoCC) else
	
		if Castable("Shadowform") then
			FlashForm(SpellName(15473--[[Shadowform]]), "White")
		elseif Form(SpellName(15473--[[Shadowform]])) then
			if Flashable(SpellName(48160--[[Vampiric Touch]])) and NoCC and Castable("Vampiric Touch") then
				Flash(SpellName(48160--[[Vampiric Touch]]), SetColor(ActiveEnemy))				
			elseif Flashable(SpellName(48300--[[Devouring Plague]])) and NoCC and Castable("Devouring Plague") then
				Flash(SpellName(48300--[[Devouring Plague]]), SetColor(ActiveEnemy))	
			elseif Flashable(SpellName(48125--[[Shadow Word: Pain]])) and NoCC and Castable("Shadow Word: Pain") then
				Flash(SpellName(48125--[[Shadow Word: Pain]]), SetColor(ActiveEnemy))	
			elseif Flashable(SpellName(48127--[[Mind Blast]])) and NoCC and Castable("Mind Blast") then
				Flash(SpellName(48127--[[Mind Blast]]), SetColor(ActiveEnemy))	
			elseif Flashable(SpellName(48156--[[Mind Flay]])) and NoCC and Castable("Mind Flay") then
				Flash(SpellName(48156--[[Mind Flay]]), SetColor(ActiveEnemy))	
			end
			if Flashable(SpellName(17--[[Power Word: Shield]])) and HealthPercent("player") < 50 and Castable("Power Word: Shield") then
				Flash(SpellName(17--[[Power Word: Shield]]), SetColor(ActiveEnemy, "Red"))
			end
		end
		
		if HasTalent(SpellName(47788--[[Guardian Spirit]])) then
			if Flashable(SpellName(33076--[[Prayer of Mending]])) and NoCC and Castable("Prayer of Mending") then
				Flash(SpellName(33076--[[Prayer of Mending]]), SetColor(ActiveEnemy, "Purple"))
			elseif Flashable(SpellName(47788--[[Guardian Spirit]])) and NoCC and Castable("Guardian Spirit") then
				Flash(SpellName(47788--[[Guardian Spirit]]), SetColor(ActiveEnemy))
			elseif Flashable(SpellName(64843--[[Divine Hymn]])) and NoCC and Castable("Divine Hymn") then
				Flash(SpellName(64843--[[Divine Hymn]]), SetColor(ActiveEnemy))
			end
			if Flashable(SpellName(19236--[[Desperate Prayer]])) and HealthPercent("player") < 50 and Castable("Desperate Prayer") then
				Flash(SpellName(19236--[[Desperate Prayer]]), SetColor(ActiveEnemy, "Red"))
			end	
		end
		
		if Flashable(SpellName(17--[[Power Word: Shield]])) and HealthPercent("player") < 50 and Castable("Power Word: Shield") then
			Flash(SpellName(17--[[Power Word: Shield]]), SetColor(ActiveEnemy, "Red"))
		end
		
		if Flashable(SpellName(34433--[[Shadowfiend]])) and NoCC and PowerPercent("player") < 20 and Castable("Shadowfiend") then
			Flash(SpellName(34433--[[Shadowfiend]]), SetColor(ActiveEnemy, "Green"))
		elseif Flashable(SpellName(47585--[[Dispersion]])) and PowerPercent("player") < 20 and Castable("Dispersion")then
			Flash(SpellName(47585--[[Dispersion]]), SetColor(ActiveEnemy, "Green"))
		end
		
		if Flashable(SpellName(47585--[[Dispersion]])) and PowerPercent("player") < 60 and ( SpellFlashAddon.IsCrowedControlled("player") or SpellFlashAddon.IsMovementImpaired("player") or Debuff(SpellName(15487--[[Silence]]), "player") ) and Castable("Dispersion") then
			Flash(SpellName(47585--[[Dispersion]]), SetColor(ActiveEnemy, "Red"))				
		end
		
		if Flashable(SpellName(17--[[Power Word: Shield]])) and HealthPercent("target") < 50 and Castable("Power Word: Shield") then
			Flash(SpellName(17--[[Power Word: Shield]]), SetColor(ActiveEnemy, "Red"))
		end
		
		if Flashable(SpellName(47585--[[Dispersion]])) and PowerPercent("player") < 50 and HealthPercent("player") < 20 and Castable("Dispersion") then
			Flash(SpellName(47585--[[Dispersion]]), SetColor(ActiveEnemy, "Red"))				
		end
		
		Buffs(NoCC, ActiveEnemy, PetAlive, PetActiveEnemy, instanceType, PetNoCC)
		
	end
end

