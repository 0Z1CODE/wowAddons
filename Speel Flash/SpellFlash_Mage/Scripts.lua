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

local function Buffs()
	if not IsMounted() and ( not IsResting() or s.InCombat() or x.Enemy  ) then
		if s.Flashable(30482--[[Molten Armor]]) and Castable("Molten Armor") then
			s.Flash(30482--[[Molten Armor]], "Green")
		end
		if s.Flashable(7302--[[Frost Armor]]) and Castable("Frost Armor") then
			s.Flash(7302--[[Frost Armor]], "Green")
		end
		if s.Flashable(6117--[[Mage Armor]]) and Castable("Mage Armor") then
			s.Flash(6117--[[Mage Armor]], "Green")
		end
		if s.Flashable(23028--[[Arcane Brilliance]]) and Castable("Arcane Brilliance") then
			Flash(23028--[[Arcane Brilliance]], "Green")
		end
		if s.Flashable(1459--[[Arcane Intellect]]) and Castable("Arcane Intellect") then
			s.Flash(1459--[[Arcane Intellect]], "Green")
		end
	end
end


-- Use this single spam function and remove the multiple spam table below, or just use the multiple spam table below and leave this function in place.
s.Spam[AddonName] = function()
	if s.GetModuleConfig(AddonName, "spell_flashing_off") then return elseif AddonTable.Spam then RunSpamTable() else
		-- x.Enemy, x.ActiveEnemy, x.NoCC, x.InInstance, x.InstanceType, x.PetAlive, x.PetActiveEnemy, x.PetNoCC, x.Lag, x.DoubleLag, x.ThreatPercent
		
		Buffs()
		
		--Aggro dump
		if x.ThreatPercent >= 90 then
			if s.Flashable(66--[[Invisibility]]) and x.NoCC and Castable("Invisibility") then
				s.Flash(66--[[Invisibility]], SetColor(x.ActiveEnemy, "Purple"))
			end
			if s.Flashable(45438--[[Ice Block]]) and x.NoCC and Castable("Ice Block") then
				s.Flash(45438--[[Ice Block]], SetColor(x.ActiveEnemy, "Purple"))
			end
		end
		
		if s.Flashable(30449--[[Spellsteal]]) and x.NoCC and Castable("Ice Block") then
			s.Flash(30449--[[Spellsteal]], SetColor(x.ActiveEnemy, "Aqua"))
		end
		
		if s.Flashable(12051--[[Evocation]]) and x.NoCC and s.PowerPercent("player") < 20 and Castable("Evocation") then
			s.Flash(12051--[[Evocation]], SetColor(x.ActiveEnemy, "Aqua"))
		end
		
		if s.Buff(80353--[[Time Warp]], "player") or s.Buff(32182--[[Heroism]], "player") or s.Buff(2825--[[Bloodlust]], "player") then
			if s.Flashable(55342--[[Mirror Image]]) and x.NoCC and Castable("Mirror Image") then
				s.Flash(55342--[[Mirror Image]], SetColor(x.ActiveEnemy, "Purple"))
			end
		end
		
		--Frost Rotation
		if s.TalentMastery(3) then
			
			if s.Flashable(92283--[[Frostfire Orb]]) and x.NoCC and Castable("Frostfire Orb") then
				s.Flash(92283--[[Frostfire Orb]], SetColor(x.ActiveEnemy))				
			elseif s.Flashable(33395--[[Freeze]]) and s.Flashable(71757--[[Deep Freeze]]) and not s.Buff(44544--[[Fingers of Frost]], "player") and x.NoCC and Castable("Freeze") then
				s.Flash(33395--[[Freeze]], SetColor(x.ActiveEnemy, "Yellow"))	
			elseif s.Flashable(71757--[[Deep Freeze]]) and s.Buff(44544--[[Fingers of Frost]], "player") and x.NoCC and Castable("Deep Freeze") then
				s.Flash(71757--[[Deep Freeze]], SetColor(x.ActiveEnemy, "Yellow"))	
			elseif s.Flashable(69987--[[Frostfire Bolt]]) and s.Buff(9178--[[Brain Freeze]], "player") and x.NoCC and Castable("Frostfire Bolt") then
				s.Flash(69987--[[Frostfire Bolt]], SetColor(x.ActiveEnemy, "Yellow"))	
			elseif s.Flashable(30455--[[Ice Lance]]) and s.Buff(44544--[[Fingers of Frost]], "player") and x.NoCC and Castable("Ice Lance") then
				s.Flash(30455--[[Ice Lance]], SetColor(x.ActiveEnemy, "Yellow"))	
			elseif s.Flashable(116--[[Frostbolt]]) and x.NoCC and Castable("Frostbolt") then
				s.Flash(116--[[Frostbolt]], SetColor(x.ActiveEnemy))
			end
			
		--Fire Rotation
		elseif s.TalentMastery(2) then
			
			if s.Flashable(82731--[[Flame Orb]]) and x.NoCC and Castable("Flame Orb") then
				s.Flash(82731--[[Flame Orb]], SetColor(x.ActiveEnemy))				
			elseif s.Flashable(92315--[[Pyroblast]]) and s.Buff(48108--[[Hot Streak]], "player") and x.NoCC and Castable("Pyroblast") then
				s.Flash(92315--[[Pyroblast]], SetColor(x.ActiveEnemy, "Yellow"))	
			elseif s.Flashable(11129--[[Combustion]]) and s.Debuff(92315--[[Pyroblast]]) and s.Debuff(11119--[[Ignite]]) and s.Debuff(44457--[[Living Bomb]]) and x.NoCC and Castable("Combustion") then
				s.Flash(11129--[[Combustion]], SetColor(x.ActiveEnemy, "Yellow"))	
			elseif s.Flashable(44457--[[Living Bomb]]) and x.NoCC and Castable("Living Bomb") then
				s.Flash(44457--[[Living Bomb]], SetColor(x.ActiveEnemy))	
			elseif s.Flashable(133--[[Fireball]]) and x.NoCC and Castable("Fireball") then
				s.Flash(133--[[Fireball]], SetColor(x.ActiveEnemy))	
			elseif s.Flashable(2948--[[Scorch]]) and x.NoCC and Castable("Scorch") then
				if s.Buff(11095--[[Critical Mass]], "player") then
					s.Flash(2948--[[Scorch]], SetColor(x.ActiveEnemy, "Yellow"))
				else
					s.Flash(2948--[[Scorch]], SetColor(x.ActiveEnemy))
				end
			end
			
		--Arcane Rotation
		elseif s.TalentMastery(1) then
			
			if s.Flashable(6117--[[Mage Armor]]) and Castable("Mage Armor") then
				s.Flash(6117--[[Mage Armor]], "Yellow")
			end
			
			if s.Flashable(30451--[[Arcane Blast]]) and s.MyBuffStack(30451--[[Arcane Blast]], "player") <= 2 and Castable("Arcane Blast") then
				s.Flash(30451--[[Arcane Blast]], SetColor(x.ActiveEnemy, "White"))
			elseif Castable("Arcane Power") then
				if s.Flashable(30451--[[Arcane Blast]]) and s.MyBuffStack(30451--[[Arcane Blast]], "player") >= 3 and Castable("Arcane Blast") then
					s.Flash(30451--[[Arcane Blast]], SetColor(x.ActiveEnemy, "White"))
				elseif s.Flashable(12042--[[Arcane Power]]) and s.MyBuffStack(30451--[[Arcane Blast]], "player") >= 3 and Castable("Arcane Power") then
					s.Flash(12042--[[Arcane Power]], SetColor(x.ActiveEnemy, "Yellow"))
				end
			elseif s.Buff(12042--[[Arcane Power]], "player") then
				if s.Flashable(36799--[[Mana Gem]]) and Castable("Mana Gem") then
					s.Flash(36799--[[Mana Gem]], SetColor(x.ActiveEnemy, "Yellow"))
				elseif s.Flashable(30451--[[Arcane Blast]]) and Castable("Arcane Blast") then
					s.Flash(30451--[[Arcane Blast]], SetColor(x.ActiveEnemy, "Yellow"))
				end
			end
			
			if s.Flashable(12051--[[Evocation]]) and x.NoCC and s.PowerPercent("player") < 40 and not s.Buff(12042--[[Arcane Power]], "player") and Castable("Evocation") then
				s.Flash(12051--[[Evocation]], SetColor(x.ActiveEnemy, "Yellow"))
			end
			
			if not Castable("Arcane Power") and s.Buff(12536--[[Clearcasting]], "player") then
				if s.Flashable(5143--[[Arcane Missiles]]) and Castable("Arcane Missiles") then
					s.Flash(5143--[[Arcane Missiles]], SetColor(x.ActiveEnemy, "Yellow"))
				elseif s.Flashable(30451--[[Arcane Blast]]) and Castable("Arcane Blast") then
					s.Flash(30451--[[Arcane Blast]], SetColor(x.ActiveEnemy, "Yellow"))
				end
			end
			
			if not Castable("Arcane Power") then
				if s.Flashable(30451--[[Arcane Blast]]) and s.MyBuffStack(30451--[[Arcane Blast]], "player") >= 2 and Castable("Arcane Blast") then
					s.Flash(30451--[[Arcane Blast]], SetColor(x.ActiveEnemy, "White"))
				elseif s.Flashable(44425--[[Arcane Barrage]]) and s.MyBuffStack(30451--[[Arcane Blast]], "player") >= 2 and Castable("Arcane Barrage") then
					s.Flash(44425--[[Arcane Barrage]], SetColor(x.ActiveEnemy, "White"))
				end
			end
			
		end
		
		
	end
end

