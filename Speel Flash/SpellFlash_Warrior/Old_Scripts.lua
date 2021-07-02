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
		
		if Flashable(SpellName(78--[[Heroic Strike]])) and NoCC and ( UnitPower("player") >= 80 or Buff(SpellName(57165--[[Glyph of Revenge]])) or ( UnitLevel("player") < 40 and UnitPower("player") >= 20 ) ) and Castable("Heroic Strike") then
			Flash(SpellName(78--[[Heroic Strike]]), SetColor(ActiveEnemy, "Yellow"))
			
		end
		
		if Flashable(SpellName(5308--[[Execute]])) and ActiveEnemy and Castable("Execute") then
			Flash(SpellName(5308--[[Execute]]), "Orange")
			
		end
		
		if Flashable(SpellName(57755--[[Heroic Throw]])) and ActiveEnemy and Castable("Heroic Throw") then
			Flash(SpellName(57755--[[Heroic Throw]]), "Pink")
			
		end
		
		if Flashable(SpellName(12975--[[Last Stand]])) and InCombat() and HealthPercent("player") < 10 and Castable("Last Stand") then
			Flash(SpellName(12975--[[Last Stand]]), "Red")
			
		elseif Flashable(SpellName(55694--[[Enraged Regeneration]])) and InCombat() and HealthPercent("player") < 45 and Castable("Enraged Regeneration") then
			Flash(SpellName(55694--[[Enraged Regeneration]]), "Red")
			
		elseif Flashable(SpellName(871--[[Shield Wall]])) and HealthPercent("player") < 35 and Castable("Shield Wall") then
			Flash(SpellName(871--[[Shield Wall]]), "Red")
			
		end
		
		local InterceptFlashed = nil
		if Flashable(SpellName(18499--[[Berserker Rage]])) and SpellFlashAddon.IsCrowedControlled("player") and Castable("Berserker Rage") then
			Flash(SpellName(18499--[[Berserker Rage]]), "Aqua")
			
		elseif Flashable(SpellName(20252--[[Intercept]])) and Casting(nil,"target",1) and Castable("Intercept") then
			Flash(SpellName(20252--[[Intercept]]), "Aqua")
			InterceptFlashed = 1
			
		elseif Flashable(SpellName(72--[[Shield Bash]])) and Castable("Shield Bash") then
			Flash(SpellName(72--[[Shield Bash]]), "Aqua")
			
		elseif Flashable(SpellName(6552--[[Pummel]])) and Castable("Pummel") then
			Flash(SpellName(6552--[[Pummel]]), "Aqua")
			
		elseif Flashable(SpellName(12809--[[Concussion Blow]])) and Casting(nil,"target",1) and Castable("Concussion Blow") then
			Flash(SpellName(12809--[[Concussion Blow]]), "Aqua")
			
		elseif Flashable(SpellName(23920--[[Spell Reflection]])) and Castable("Spell Reflection") then
			Flash(SpellName(23920--[[Spell Reflection]]), "Aqua")
			
		end
		
		if Flashable(SpellName(6673--[[Battle Shout]])) and not IsMounted() and Castable("Battle Shout") then
			Flash(SpellName(6673--[[Battle Shout]]), "Green")
			
		end
		if Flashable(SpellName(469--[[Commanding Shout]])) and not IsMounted() and Castable("Commanding Shout") then
			Flash(SpellName(469--[[Commanding Shout]]), "Green")
			
		end
		
		if Flashable(SpellName(3411--[[Intervene]])) and Castable("Intervene") then
			Flash(SpellName(3411--[[Intervene]]), SetColor(SpellFlashAddon.IsActiveEnemy("targettarget") and UnitIsUnit("targettargettarget", "target")))
			
		elseif Flashable(SpellName(100--[[Charge]])) and NoCC and Castable("Charge") then
			if not InterceptFlashed then
				Flash(SpellName(100--[[Charge]]), SetColor(ActiveEnemy and UnitIsUnit("targettarget", "player")))
			end
			
		elseif Flashable(SpellName(20252--[[Intercept]])) and NoCC and Castable("Intercept") then
			if not InterceptFlashed then
				Flash(SpellName(20252--[[Intercept]]), SetColor(ActiveEnemy and UnitIsUnit("targettarget", "player")))
			end
			
		else
			
			if Flashable(SpellName(355--[[Taunt]])) and Castable("Taunt") then
				Flash(SpellName(355--[[Taunt]]), "Pink")
				
			elseif Flashable(SpellName(694--[[Mocking Blow]])) and Castable("Mocking Blow") then
				Flash(SpellName(694--[[Mocking Blow]]), "Pink")
				
			end
			
			if Flashable(SpellName(1715--[[Hamstring]])) and ActiveEnemy and ( UnitIsPlayer("target") or not UnitExists("targettarget") ) and not string.find(string.lower(UnitClassification("target") or ""), "boss") and ( UnitLevel("target") ~= -1 or UnitPlayerControlled("target") ) and Castable("Hamstring") then
				Flash(SpellName(1715--[[Hamstring]]))
				
			elseif Flashable(SpellName(34428--[[Victory Rush]])) and NoCC and Castable("Victory Rush") then
				Flash(SpellName(34428--[[Victory Rush]]), SetColor(ActiveEnemy, "Yellow"))
				
			elseif Flashable(SpellName(6572--[[Revenge]])) and NoCC and Castable("Revenge") then
				Flash(SpellName(6572--[[Revenge]]), SetColor(ActiveEnemy, "Yellow"))
				
			elseif Flashable(SpellName(7384--[[Overpower]])) and NoCC and Castable("Overpower") then
				Flash(SpellName(7384--[[Overpower]]), SetColor(ActiveEnemy, "Yellow"))
				
			elseif Flashable(SpellName(1464--[[Slam]])) and NoCC and Buff(SpellName(46916--[[Slam!]])) and Castable("Slam") then
				Flash(SpellName(1464--[[Slam]]), SetColor(ActiveEnemy, "Yellow"))
				
			elseif Flashable(SpellName(772--[[Rend]])) and NoCC and HealthPercent() > 75 and Castable("Rend") then
				Flash(SpellName(772--[[Rend]]), SetColor(ActiveEnemy))
				
			else
				
				if Flashable(SpellName(2565--[[Shield Block]])) and not SpellFlashAddon.OnCooldown(SpellName(6572--[[Revenge]])) and Castable("Shield Block") then
					Flash(SpellName(2565--[[Shield Block]]), "Pink")
					
				end
				
				if Flashable(SpellName(23881--[[Bloodthirst]])) and NoCC and Castable("Bloodthirst") then
					Flash(SpellName(23881--[[Bloodthirst]]), SetColor(ActiveEnemy))
					
				elseif Flashable(SpellName(12294--[[Mortal Strike]])) and NoCC and Castable("Mortal Strike") then
					Flash(SpellName(12294--[[Mortal Strike]]), SetColor(ActiveEnemy))
					
				elseif Flashable(SpellName(23922--[[Shield Slam]])) and NoCC and Castable("Shield Slam") then
					Flash(SpellName(23922--[[Shield Slam]]), SetColor(ActiveEnemy))
					
				else
					
					if Flashable(SpellName(1680--[[Whirlwind]])) and ActiveEnemy and SpellFlashAddon.IsOffHandEquipped() and not SpellFlashAddon.IsShieldEquipped() and Castable("Whirlwind") then
						Flash(SpellName(1680--[[Whirlwind]]), "Purple")
						
					end
					
					if Flashable(SpellName(46968--[[Shockwave]])) and ActiveEnemy and Castable("Shockwave") then
						Flash(SpellName(46968--[[Shockwave]]), "Purple")
						
					end
					
					if Flashable(SpellName(1160--[[Demoralizing Shout]])) and ActiveEnemy and Castable("Demoralizing Shout") then
						Flash(SpellName(1160--[[Demoralizing Shout]]), "Blue")
						
					elseif Flashable(SpellName(6343--[[Thunder Clap]])) and ActiveEnemy and ( not Castable("Whirlwind") or not SpellFlashAddon.IsOffHandEquipped() or SpellFlashAddon.IsShieldEquipped() ) and Castable("Thunder Clap") then
						Flash(SpellName(6343--[[Thunder Clap]]), "Purple")
						
					end
					
					if Flashable(SpellName(20243--[[Devastate]])) and NoCC and Castable("Devastate") then
						Flash(SpellName(20243--[[Devastate]]), SetColor(ActiveEnemy))
						
					else
						
						if ActiveEnemy and Castable("Attack") then
							Flash(SpellName(6603--[[Auto Attack]]))
						end
						
						if Flashable(SpellName(7386--[[Sunder Armor]])) and ActiveEnemy and not Flashable(SpellName(20243--[[Devastate]])) and Castable("Sunder Armor") then
							Flash(SpellName(7386--[[Sunder Armor]]), "Pink")
							
						end
						
					end
					
				end
				
			end
			
		end
		
	end
end

