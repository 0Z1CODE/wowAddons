local AddonName, AddonTable = ...
if AddonTable.OldBuild then return end
local L = AddonTable.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local function RunSpamTable(...)
	local i = s.GetModuleConfig(AddonName, "script_number") or 1
	if type(AddonTable.Spam[i]) == "table" and type(AddonTable.Spam[i].Function) == "function" then
		AddonTable.Spam[i].Function(...)
	elseif type(AddonTable.Spam[1]) == "table" and type(AddonTable.Spam[1].Function) == "function" then
		s.SetModuleConfig(AddonName, "script_number", nil)
		AddonTable.Spam[1].Function(...)
	end
end

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
s.Spam[AddonName] = function()
	if s.GetModuleConfig(AddonName, "spell_flashing_off") then return elseif AddonTable.Spam then RunSpamTable() else
		-- x.Enemy, x.ActiveEnemy, x.NoCC, x.InInstance, x.InstanceType, x.PetAlive, x.PetActiveEnemy, x.PetNoCC, x.Lag, x.DoubleLag, x.ThreatPercent
		
		if not UnitHasVehicleUI("player") or not AddonTable.LanceEquippedWhenMounting then return end
		
		if s.VehicleFlashable(62552--[[Defend]]) and s.BuffStack(62552--[[Defend]], "vehicle", 15) < 3 and VehicleCastable("Defend") then
			if s.InCombat() or ( s.Buff(62552--[[Defend]], "vehicle") and not s.Buff(62552--[[Defend]], "vehicle", 15) ) then
				s.FlashVehicle(62552--[[Defend]], "Yellow")
			else
				s.FlashVehicle(62552--[[Defend]], "Green")
			end
			
		elseif s.VehicleFlashable(62960--[[Charge]]) and x.NoCC and ( s.BuffStack(62552--[[Defend]]) <= 1 or s.EnemyTargetingYou() ) and VehicleCastable("Charge") then
			s.FlashVehicle(62960--[[Charge]], SetColor(x.ActiveEnemy))
		
		elseif s.VehicleFlashable(62575--[[Shield-Breaker]]) and x.NoCC and VehicleCastable("Shield-Breaker") then
			s.FlashVehicle(62575--[[Shield-Breaker]], SetColor(x.ActiveEnemy))
			
		elseif s.VehicleFlashable(62544--[[Thrust]]) and x.NoCC and VehicleCastable("Thrust") then
			s.FlashVehicle(62544--[[Thrust]], SetColor(x.ActiveEnemy))
			
		end
		
	end
end
