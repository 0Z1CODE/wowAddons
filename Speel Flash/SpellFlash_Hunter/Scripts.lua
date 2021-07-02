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

local function EnoughForKillCommand(SpellName)
	return not s.TalentMastery(1) or not UnitExists("pettarget") or not s.Flashable(34026--[[Kill Command]]) or s.Power("player") >= (s.SpellCost(34026--[[Kill Command]]) + s.SpellCost(SpellName))
end

-- Use this single spam function and remove the multiple spam table below, or just use the multiple spam table below and leave this function in place.
s.Spam[AddonName] = function()
	if s.GetModuleConfig(AddonName, "spell_flashing_off") then return elseif AddonTable.Spam then RunSpamTable() else
		-- x.Enemy, x.ActiveEnemy, x.NoCC, x.InInstance, x.InstanceType, x.PetAlive, x.PetActiveEnemy, x.PetNoCC, x.Lag, x.DoubleLag, x.ThreatPercent
		
		if x.PetAlive then
			
			if x.InstanceType == "party" or x.InstanceType == "raid" then
				if ( GetNumRaidMembers() > 1 or GetNumPartyMembers() > 0 ) and s.PetCastable("Passive") then
					s.FlashPet("Passive", "Pink")
				end
			elseif x.InstanceType == "pvp" or x.InstanceType == "arena" then
				if s.PetCastable("Aggressive") then
					s.FlashPet("Aggressive", "Pink")
				end
			elseif s.PetCastable("Defensive") and s.PetCastable("Passive") then
				s.FlashPet("Defensive", "Pink")
			end
			if x.ActiveEnemy and not x.PetActiveEnemy then
				s.FlashPet("Attack", "Pink")
			elseif x.PetActiveEnemy and not UnitPlayerControlled("pettarget") and not UnitExists("pettargettarget") and s.HealthPercent("pettarget") <= 25 then
				s.FlashPet("Follow")
			elseif not x.PetNoCC then
				s.FlashPet("Stay")
			end
			
			if s.Flashable(136--[[Mend Pet]]) and Castable("Mend Pet") then
				s.Flash(136--[[Mend Pet]], SetColor(s.InCombat() or UnitExists("pettarget"), "Yellow", "Green"))
			end
			if x.PetActiveEnemy and s.Flashable(19574--[[Bestial Wrath]]) and Castable("Bestial Wrath") then
				s.Flash(19574--[[Bestial Wrath]], "Green")
			end
			if x.PetActiveEnemy and s.Flashable(19577--[[Intimidation]]) and Castable("Intimidation") then
				s.Flash(19577--[[Intimidation]], SetColor(s.GetCastingOrChanneling(nil, "pettarget", 1) > (s.SpellCooldown(19577--[[Intimidation]]) + x.DoubleLag), "Aqua"))
			end
			
		end
		
		if x.ActiveEnemy and s.Flashable(3045--[[Rapid Fire]]) and Castable("Rapid Fire") then
			s.Flash(3045--[[Rapid Fire]], "Green")
		end
		if s.Flashable(82692--[[Focus Fire]]) and Castable("Focus Fire") then
			s.Flash(82692--[[Focus Fire]], "Yellow")
		end
		if x.ActiveEnemy and s.Flashable(82726--[[Fervor]]) and Castable("Fervor") then
			s.Flash(82726--[[Fervor]], "Yellow")
		end
		if x.ActiveEnemy and s.Form(13165--[[Aspect of the Hawk]]) and Castable("Aspect of the Fox") then
			if s.Flashable(82661--[[Aspect of the Fox]]) then
				s.Flash(82661--[[Aspect of the Fox]], "Pink")
			end
			s.FlashForm(82661--[[Aspect of the Fox]], "Pink")
		elseif ( not s.Form() or ( x.ActiveEnemy and s.Form(82661--[[Aspect of the Fox]]) ) ) and Castable("Aspect of the Hawk") then
			if s.Flashable(13165--[[Aspect of the Hawk]]) then
				s.Flash(13165--[[Aspect of the Hawk]], SetColor(not s.Form(), "Green"))
			end
			s.FlashForm(13165--[[Aspect of the Hawk]], SetColor(not s.Form(), "Green"))
		end
		
		if s.Flashable(34490--[[Silencing Shot]]) and Castable("Silencing Shot") then
			s.Flash(34490--[[Silencing Shot]], "Aqua")
		elseif x.ActiveEnemy and s.Flashable(19503--[[Scatter Shot]]) and Castable("Scatter Shot") then
			if s.GetCastingOrChanneling(nil, nil, 1) > (s.SpellCooldown(19503--[[Scatter Shot]]) + x.DoubleLag) then
				s.Flash(19503--[[Scatter Shot]], "Aqua")
			elseif s.MeleeDistance() and not s.Feared() and not s.Rooted() then
				s.Flash(19503--[[Scatter Shot]], "Yellow")
			end
		end
		
		if x.NoCC and s.Flashable(56641--[[Steady Shot]]) and AddonTable.SecondSteadyShotReady() and Castable("Steady Shot") then
			s.Flash(56641--[[Steady Shot]], SetColor(x.ActiveEnemy, "Yellow"))
		end
		
		if ( not x.NoCC or not UnitIsPlayer("target") ) and not s.InCombat() and s.Flashable(1130--[[Hunter's Mark]]) and Castable("Hunter's Mark") then
			s.Flash(1130--[[Hunter's Mark]])
		elseif s.Flashable(19434--[[Aimed Shot]]) and Castable("Aimed Shot") then
			s.Flash(19434--[[Aimed Shot]], SetColor(x.ActiveEnemy))
		elseif x.NoCC and s.Flashable(5116--[[Concussive Shot]]) and Castable("Concussive Shot") then
			s.Flash(5116--[[Concussive Shot]], SetColor(x.ActiveEnemy))
		elseif x.NoCC and s.Flashable(53209--[[Chimera Shot]]) and Castable("Chimera Shot") then
			s.Flash(53209--[[Chimera Shot]], SetColor(x.ActiveEnemy))
		elseif x.NoCC and s.Flashable(53351--[[Kill Shot]]) and Castable("Kill Shot") then
			s.Flash(53351--[[Kill Shot]], SetColor(x.ActiveEnemy))
		elseif x.NoCC and s.Flashable(53301--[[Explosive Shot]]) and Castable("Explosive Shot") then
			s.Flash(53301--[[Explosive Shot]], SetColor(x.ActiveEnemy))
		else
			if s.Flashable(34026--[[Kill Command]]) and x.PetNoCC and Castable("Kill Command") then
				if s.TalentMastery(1) then
					s.Flash(34026--[[Kill Command]], SetColor(x.PetActiveEnemy, "Yellow"))
				else
					s.Flash(34026--[[Kill Command]], SetColor(x.PetActiveEnemy))
				end
			end
			if x.NoCC and s.Flashable(19306--[[Counterattack]]) and Castable("Counterattack") then
				s.Flash(19306--[[Counterattack]], SetColor(x.ActiveEnemy))
			elseif x.NoCC and s.Flashable(2974--[[Wing Clip]]) and Castable("Wing Clip") then
				s.Flash(2974--[[Wing Clip]], SetColor(x.ActiveEnemy))
			else
				if x.ActiveEnemy and s.Flashable(781--[[Disengage]]) and Castable("Disengage") then
					s.Flash(781--[[Disengage]], "Red")
				end
				if x.NoCC and s.Flashable(2973--[[Raptor Strike]]) and Castable("Raptor Strike") then
					s.Flash(2973--[[Raptor Strike]], SetColor(x.ActiveEnemy))
				elseif x.NoCC and s.Flashable(1978--[[Serpent Sting]]) and Castable("Serpent Sting") then
					s.Flash(1978--[[Serpent Sting]], SetColor(x.ActiveEnemy))
				elseif x.NoCC and s.Flashable(3674--[[Black Arrow]]) and Castable("Black Arrow") then
					s.Flash(3674--[[Black Arrow]], SetColor(x.ActiveEnemy))
				elseif x.NoCC and s.TalentRank(53241--[[Marked for Death]]) == 2 and s.Flashable(3044--[[Arcane Shot]]) and EnoughForKillCommand(3044--[[Arcane Shot]]) and Castable("Arcane Shot") and not s.Debuff({1130--[[Hunter's Mark]],53241--[[Marked for Death]]}) then
					s.Flash(3044--[[Arcane Shot]], SetColor(x.ActiveEnemy))
				elseif s.Flashable(1130--[[Hunter's Mark]]) and Castable("Hunter's Mark") then
					s.Flash(1130--[[Hunter's Mark]], SetColor(x.ActiveEnemy))
				else
					if x.ActiveEnemy and s.Flashable(82654--[[Widow Venom]]) and Castable("Widow Venom") then
						if s.Class(nil, {"Druid", "Paladin", "Priest", "Shaman"}) then
							s.Flash(82654--[[Widow Venom]], "Yellow")
							return
						else
							s.Flash(82654--[[Widow Venom]], "Pink")
						end
					end
					if x.NoCC and s.Flashable(2643--[[Multi-Shot]]) and EnoughForKillCommand(2643--[[Multi-Shot]]) and Castable("Multi-Shot") then
						s.Flash(2643--[[Multi-Shot]], SetColor(x.ActiveEnemy, "Purple"))
					end
					if x.NoCC and s.Flashable(3044--[[Arcane Shot]]) and EnoughForKillCommand(3044--[[Arcane Shot]]) and Castable("Arcane Shot") then
						s.Flash(3044--[[Arcane Shot]], SetColor(x.ActiveEnemy))
					else
						if s.TalentRank(53221--[[Improved Steady Shot]]) < 2 and x.NoCC and s.Flashable(77767--[[Cobra Shot]]) and Castable("Cobra Shot") then
							s.Flash(77767--[[Cobra Shot]], SetColor(x.ActiveEnemy))
						end
						if x.NoCC and s.Flashable(56641--[[Steady Shot]]) and Castable("Steady Shot") then
							s.Flash(56641--[[Steady Shot]], SetColor(x.ActiveEnemy))
						elseif x.ActiveEnemy and not s.Shooting() and not s.CurrentSpell(6603--[[Auto Attack]]) then
							if s.MeleeDistance() then
								if Castable("Auto Attack") then
									s.Flash(6603--[[Auto Attack]])
								end
							elseif Castable("Auto Shot") then
								s.Flash(75--[[Auto Shot]])
							end
						end
					end
				end
			end
		end
		
	end
end

