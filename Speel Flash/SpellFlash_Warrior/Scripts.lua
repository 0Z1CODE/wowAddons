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
		
		if s.MeleeDistance() then AddonTable:ClearTimer("Charge") end
		
		if s.Flashable(6673--[[Battle Shout]]) and Castable("Battle Shout") then
			s.Flash(6673--[[Battle Shout]], SetColor(x.ActiveEnemy and s.PowerMissing("player") >= 20, "Yellow", "Green"))
		end
		if s.Flashable(469--[[Commanding Shout]]) and Castable("Commanding Shout") then
			s.Flash(469--[[Commanding Shout]], SetColor(x.ActiveEnemy and s.PowerMissing("player") >= 20, "Yellow", "Green"))
		end
		
		if x.ActiveEnemy and s.Flashable(85730--[[Deadly Calm]]) and Castable("Deadly Calm") then
			s.Flash(85730--[[Deadly Calm]], "Green")
		end
		if x.ActiveEnemy and s.Flashable(1134--[[Inner Rage]]) and Castable("Inner Rage") then
			s.Flash(1134--[[Inner Rage]], "Green")
		end
		if x.ActiveEnemy and s.Flashable(12292--[[Death Wish]]) and Castable("Death Wish") then
			s.Flash(12292--[[Death Wish]], "Green")
		elseif x.ActiveEnemy and s.Flashable(20230--[[Retaliation]]) and Castable("Retaliation") then
			s.Flash(20230--[[Retaliation]], "Pink")
		elseif x.ActiveEnemy and s.Flashable(1719--[[Recklessness]]) and Castable("Recklessness") then
			s.Flash(1719--[[Recklessness]], "Pink")
		end
		
		if s.Flashable(12975--[[Last Stand]]) and Castable("Last Stand") then
			s.Flash(12975--[[Last Stand]], "Red")
		elseif s.Flashable(55694--[[Enraged Regeneration]]) and Castable("Enraged Regeneration") then
			s.Flash(55694--[[Enraged Regeneration]], "Red")
		elseif s.Flashable(871--[[Shield Wall]]) and Castable("Shield Wall") then
			s.Flash(871--[[Shield Wall]], "Red")
		end
		
		if s.Flashable(18499--[[Berserker Rage]]) and Castable("Berserker Rage") and s.CrowedControlled("player") then
			s.Flash(18499--[[Berserker Rage]], "Aqua")
		elseif s.Flashable(6552--[[Pummel]]) and Castable("Pummel") then
			s.Flash(6552--[[Pummel]], "Aqua")
		elseif s.Flashable(72--[[Shield Bash]]) and Castable("Shield Bash") then
			s.Flash(72--[[Shield Bash]], "Aqua")
		elseif s.Flashable(12809--[[Concussion Blow]]) and Castable("Concussion Blow") then
			s.Flash(12809--[[Concussion Blow]], "Aqua")
		elseif s.Flashable(85388--[[Throwdown]]) and Castable("Throwdown") then
			s.Flash(85388--[[Throwdown]], "Aqua")
		elseif s.Flashable(23920--[[Spell Reflection]]) and Castable("Spell Reflection") then
			s.Flash(23920--[[Spell Reflection]], "Aqua")
		elseif s.Flashable(60970--[[Heroic Fury]]) and Castable("Heroic Fury") then
			s.Flash(60970--[[Heroic Fury]], "Aqua")
		end
		
		if x.NoCC and not x.ActiveEnemy and s.Flashable(57755--[[Heroic Throw]]) and Castable("Heroic Throw") then
			s.Flash(57755--[[Heroic Throw]], "Pink")
		end
		
		if s.Flashable(3411--[[Intervene]]) and Castable("Intervene") then
			s.Flash(3411--[[Intervene]], SetColor(s.ActiveEnemy("targettarget") and UnitIsUnit("targettargettarget", "target")))
		elseif x.NoCC and s.Flashable(100--[[Charge]]) and Castable("Charge") then
			s.Flash(100--[[Charge]], SetColor(x.ActiveEnemy))
		elseif x.NoCC and s.Flashable(20252--[[Intercept]]) and Castable("Intercept") then
			s.Flash(20252--[[Intercept]], SetColor(x.ActiveEnemy))
		elseif x.NoCC and s.Flashable(57755--[[Heroic Throw]]) and Castable("Heroic Throw") then
			s.Flash(57755--[[Heroic Throw]], SetColor(x.ActiveEnemy))
		else
			
			if s.Flashable(355--[[Taunt]]) and Castable("Taunt") then
				s.Flash(355--[[Taunt]], "Pink")
			end
			
			if x.ActiveEnemy and s.Flashable(1160--[[Demoralizing Shout]]) and Castable("Demoralizing Shout") then
				s.Flash(1160--[[Demoralizing Shout]], "Blue")
			end
			
			if x.ActiveEnemy and s.Flashable(2565--[[Shield Block]]) and Castable("Shield Block") then
				s.Flash(2565--[[Shield Block]], "Pink")
			end
			
			if x.ActiveEnemy then
				if s.Flashable(845--[[Cleave]]) and Castable("Cleave") then
					s.Flash(845--[[Cleave]], "Purple")
				elseif s.HasTalent(84614--[[Blood and Thunder]]) and s.Flashable(772--[[Rend]]) and Castable("Rend") then
					s.Flash(772--[[Rend]], "Purple")
				elseif s.Flashable(6343--[[Thunder Clap]]) and Castable("Thunder Clap") then
					s.Flash(6343--[[Thunder Clap]], "Purple")
				elseif s.Flashable(46968--[[Shockwave]]) and Castable("Shockwave") then
					s.Flash(46968--[[Shockwave]], "Purple")
				elseif s.Flashable(1680--[[Whirlwind]]) and Castable("Whirlwind") then
					s.Flash(1680--[[Whirlwind]], "Purple")
				elseif s.Flashable(12328--[[Sweeping Strikes]]) and Castable("Sweeping Strikes") then
					s.Flash(12328--[[Sweeping Strikes]], "Purple")
				elseif s.Flashable(46924--[[Bladestorm]]) and Castable("Bladestorm") then
					s.Flash(46924--[[Bladestorm]], "Purple")
				end
			end
			
			if x.NoCC and s.SpellCooldown(23922--[[Shield Slam]]) > s.SpellCooldown(78--[[Heroic Strike]]) and s.Flashable(78--[[Heroic Strike]]) and Castable("Heroic Strike") then
				s.Flash(78--[[Heroic Strike]], SetColor(x.ActiveEnemy, "Yellow"))
			elseif x.NoCC and s.Flashable(23922--[[Shield Slam]]) and s.HasTalent(86894--[[Heavy Repercussions]]) and ( s.CurrentSpell(2565--[[Shield Block]]) or s.SpellDelay(2565--[[Shield Block]]) or s.Buff(2565--[[Shield Block]], "player") ) and Castable("Shield Slam") then
				s.Flash(23922--[[Shield Slam]], SetColor(x.ActiveEnemy, "Yellow"))
			elseif x.NoCC and s.Flashable(78--[[Heroic Strike]]) and Castable("Heroic Strike") then
				s.Flash(78--[[Heroic Strike]], SetColor(x.ActiveEnemy, "Yellow"))
			elseif s.Flashable(1715--[[Hamstring]]) and x.ActiveEnemy and Castable("Hamstring") then
				s.Flash(1715--[[Hamstring]], "Yellow")
			elseif x.NoCC and s.HasTalent(46913--[[Bloodsurge]]) and s.Buff(46916--[[Bloodsurge]], "player") and s.Flashable(1464--[[Slam]]) and Castable("Slam") then
				s.Flash(1464--[[Slam]], SetColor(x.ActiveEnemy, "Yellow"))
			elseif x.NoCC and s.Flashable(34428--[[Victory Rush]]) and Castable("Victory Rush") then
				s.Flash(34428--[[Victory Rush]], SetColor(x.ActiveEnemy, "Yellow"))
			elseif x.NoCC and s.HasTalent(84583--[[Lambs to the Slaughter]]) and s.Flashable(12294--[[Mortal Strike]]) and Castable("Mortal Strike") then
				s.Flash(12294--[[Mortal Strike]], SetColor(x.ActiveEnemy))
			elseif x.NoCC and s.Flashable(7384--[[Overpower]]) and Castable("Overpower") then
				s.Flash(7384--[[Overpower]], SetColor(x.ActiveEnemy, "Yellow"))
			elseif x.NoCC and s.Flashable(5308--[[Execute]]) and Castable("Execute") then
				s.Flash(5308--[[Execute]], SetColor(x.ActiveEnemy, "Yellow"))
			elseif x.NoCC and ( s.HasTalent(56636--[[Taste for Blood]]) or s.HasTalent(29836--[[Blood Frenzy]]) ) and s.Flashable(772--[[Rend]]) and ( s.HealthPercent() > 25 or UnitIsPlayer("target") or s.Boss() ) and Castable("Rend") then
					s.Flash(772--[[Rend]], SetColor(x.ActiveEnemy, "Yellow"))
			elseif s.HasTalent(86894--[[Heavy Repercussions]]) and x.ActiveEnemy and s.Flashable(2565--[[Shield Block]]) and Castable("Shield Block") then
				s.Flash(2565--[[Shield Block]], "Yellow")
			elseif x.NoCC and s.Flashable(23922--[[Shield Slam]]) and Castable("Shield Slam") then
				s.Flash(23922--[[Shield Slam]], SetColor(x.ActiveEnemy))
			elseif x.NoCC and s.Flashable(6572--[[Revenge]]) and Castable("Revenge") then
				s.Flash(6572--[[Revenge]], SetColor(x.ActiveEnemy, "Yellow"))
			elseif x.NoCC and s.Flashable(23881--[[Bloodthirst]]) and Castable("Bloodthirst") then
				s.Flash(23881--[[Bloodthirst]], SetColor(x.ActiveEnemy))
			elseif x.NoCC and s.Flashable(12294--[[Mortal Strike]]) and Castable("Mortal Strike") then
				s.Flash(12294--[[Mortal Strike]], SetColor(x.ActiveEnemy))
			elseif x.NoCC and s.Flashable(88161--[[Strike]]) and Castable("Strike") then
				s.Flash(88161--[[Strike]], SetColor(x.ActiveEnemy))
			elseif x.NoCC and s.Flashable(85288--[[Raging Blow]]) and Castable("Raging Blow") then
				s.Flash(85288--[[Raging Blow]], SetColor(x.ActiveEnemy, "Yellow"))
			elseif x.ActiveEnemy and s.Flashable(85288--[[Raging Blow]]) and s.Flashable(18499--[[Berserker Rage]]) and Castable("Raging Blow", 1) and Castable("Berserker Rage") then
				s.Flash(18499--[[Berserker Rage]], "Yellow")
			elseif x.NoCC and s.Flashable(86346--[[Colossus Smash]]) and Castable("Colossus Smash") then
				s.Flash(86346--[[Colossus Smash]], SetColor(x.ActiveEnemy))
			else
				
				if x.ActiveEnemy and s.Flashable(676--[[Disarm]]) and Castable("Disarm") then
					if not UnitIsPlayer("target") then
						s.Flash(676--[[Disarm]], "Pink")
					elseif s.Class(nil, {"Death Knight", "Hunter", "Paladin", "Rogue", "Shaman", "Warrior"}) then
						s.Flash(676--[[Disarm]], "Aqua")
					end
				end
				
				if x.ActiveEnemy and s.Flashable(6343--[[Thunder Clap]]) and Castable("Thunder Clap") then
					if not s.Debuff({
						6343--[[Thunder Clap]],
						8042--[[Earth Shock]],
						59921--[[Frost Fever]],
						53695--[[Judgements of the Just]],
						50285--[[Dust Cloud]],
						90314--[[Tailspin]],
					}, nil, s.SpellCooldown(6343--[[Thunder Clap]]) + x.DoubleLag) then
						s.Flash(6343--[[Thunder Clap]], "Blue")
					end
				end
				
				if x.ActiveEnemy and s.Flashable(64382--[[Shattering Throw]]) and Castable("Shattering Throw") then
					s.Flash(64382--[[Shattering Throw]], "Pink")
				end
				
				if x.NoCC and s.Flashable(772--[[Rend]]) and ( s.HealthPercent() > 25 or UnitIsPlayer("target") or s.Boss() ) and Castable("Rend") then
					s.Flash(772--[[Rend]], SetColor(x.ActiveEnemy))
				elseif x.NoCC and s.Flashable(20243--[[Devastate]]) and Castable("Devastate") then
					s.Flash(20243--[[Devastate]], SetColor(x.ActiveEnemy))
				else
					
					if x.NoCC and s.Flashable(1464--[[Slam]]) and Castable("Slam") then
						s.Flash(1464--[[Slam]], SetColor(x.ActiveEnemy))
					end
					
					if x.ActiveEnemy then
						if Castable("Auto Attack") then
							s.Flash(6603--[[Auto Attack]])
						end
						if Castable("Attack") then
							s.Flash(88163--[[Attack]])
						end
						if s.Flashable(7386--[[Sunder Armor]]) and not s.Flashable(20243--[[Devastate]]) and Castable("Sunder Armor") then
							s.Flash(7386--[[Sunder Armor]], "Pink")
						end
					end
				end
			end
		end
		
		
	end
end

