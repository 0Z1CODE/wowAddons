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
	if not IsMounted() or s.InCombat() then
		if s.Flashable(588--[[Inner Fire]]) and Castable("Inner Fire") then
			s.Flash(588--[[Inner Fire]], "Green")
		end
		if s.Flashable(73413--[[Inner Will]]) and Castable("Inner Will") then
			s.Flash(73413--[[Inner Will]], "Green")
		end
		if s.Flashable(21562--[[Power Word: Fortitude]]) and Castable("Power Word: Fortitude") then
			s.Flash(21562--[[Power Word: Fortitude]], "Green")
		end
		if s.Flashable(27683--[[Shadow Protection]]) and Castable("Shadow Protection") then
			s.Flash(27683--[[Shadow Protection]], "Green")
		end
		if s.Flashable(15286--[[Vampiric Embrace]]) and Castable("Vampiric Embrace") then
			s.Flash(15286--[[Vampiric Embrace]], "Green")
		end
		if s.Flashable(47585--[[Dispersion]]) and not s.InCombat() and s.PowerPercent("player") < 60 and Castable("Dispersion")then
			s.Flash(47585--[[Dispersion]], "Green")
		end
	end
end

-- Use this single spam function and remove the multiple spam table below, or just use the multiple spam table below and leave this function in place.
s.Spam[AddonName] = function()
	if s.GetModuleConfig(AddonName, "spell_flashing_off") then return elseif AddonTable.Spam then RunSpamTable() else
		-- x.Enemy, x.ActiveEnemy, x.NoCC, x.InInstance, x.InstanceType, x.PetAlive, x.PetActiveEnemy, x.PetNoCC, x.Lag, x.DoubleLag, x.ThreatPercent
		
		-- Place script here
		
	end
end


-- Use this multiple spam table, or remove this table and use the single spam function above.
AddonTable.Spam = {
	
	
	-- Default script
	{Title = L["Oxie's Defualt"], -- Place script title here
	Description = L["This is the full mod.  It will flash everything you need for shadow priests!"], -- Place optional script description here or comment out or remove this line
	Function = function()
		-- x.Enemy, x.ActiveEnemy, x.NoCC, x.InInstance, x.InstanceType, x.PetAlive, x.PetActiveEnemy, x.PetNoCC, x.Lag, x.DoubleLag, x.ThreatPercent
		
		if x.ThreatPercent >= 95 and ( GetNumRaidMembers() > 1 or GetNumPartyMembers() > 0 ) then
			if s.Flashable(586--[[Fade]]) and x.NoCC and Castable("Fade") then
				s.Flash(586--[[Fade]], SetColor(x.ActiveEnemy, "Purple"))
			end
		end
		if x.ThreatPercent >= 95 then
			if s.Flashable(17--[[Power Word: Shield]]) and Castable("Power Word: Shield") then
			s.Flash(17--[[Power Word: Shield]], SetColor(x.ActiveEnemy, "Purple"))
			end
		end
		if s.Flashable(17--[[Power Word: Shield]]) and s.HealthPercent("player") < 50 and Castable("Power Word: Shield") then
			s.Flash(17--[[Power Word: Shield]], SetColor(x.ActiveEnemy, "Red"))
		end
		
		if s.Flashable(9484--[[Shackle Undead]]) and Castable("Shackle Undead") then
			s.Flash(9484--[[Shackle Undead]], SetColor(x.ActiveEnemy, "Purple"))
		end
		
		if s.Flashable(34433--[[Shadowfiend]]) and x.NoCC and s.PowerPercent("player") < 20 and Castable("Shadowfiend") then
			s.Flash(34433--[[Shadowfiend]], SetColor(x.ActiveEnemy, "Green"))
		elseif s.Flashable(47585--[[Dispersion]]) and s.PowerPercent("player") < 20 and Castable("Dispersion")then
			s.Flash(47585--[[Dispersion]], "Green")
		elseif s.Flashable(47585--[[Dispersion]]) and s.PowerPercent("player") < 50 and s.HealthPercent("player") < 20 and Castable("Dispersion") then
			s.Flash(47585--[[Dispersion]], "Red")
		end
		
		if s.Flashable(19236--[[Desperate Prayer]]) and s.HealthPercent("player") < 50 and Castable("Desperate Prayer") then
			s.Flash(19236--[[Desperate Prayer]], SetColor(x.ActiveEnemy, "Red"))
		end	
		
		if s.Flashable(47585--[[Dispersion]]) and s.CrowedControlled("player") or s.MovementImpaired("player") or s.Debuff(15487--[[Silence]], "player") and Castable("Dispersion") then
			s.Flash(47585--[[Dispersion]], "Purple")
		end
		
		
		
		if s.TalentMastery(3) then
			if Castable("Shadowform") then
				if s.Flashable(15473--[[Shadowform]]) then
					s.Flash(15473--[[Shadowform]])
				end
				s.FlashForm(15473--[[Shadowform]])
			end
			
			if s.Boss("target") and s.Debuff(34914--[[Vampiric Touch]]) then
				if s.Flashable(34433--[[Shadowfiend]]) and x.NoCC and Castable("Shadowfiend") then
			s.Flash(34433--[[Shadowfiend]], SetColor(x.ActiveEnemy, "Yellow"))
			end
				end
				
				if s.Flashable(8092--[[Mind Blast]]) and x.NoCC and s.HasTalent(14910--[[Mind Melt]]) and s.BuffStack(81292--[[Mind Melt]], "player") == 2 and Castable("Mind Blast") then
					s.Flash(8092--[[Mind Blast]], SetColor(x.ActiveEnemy))
				end
				
				
				if s.Flashable(34914--[[Vampiric Touch]]) and x.NoCC and s.MyDebuffDuration(34914--[[Vampiric Touch]], nil, 3) and Castable("Vampiric Touch") then
					s.Flash(34914--[[Vampiric Touch]], SetColor(x.ActiveEnemy))
				elseif s.Flashable(589--[[Shadow Word: Pain]]) and x.NoCC and Castable("Shadow Word: Pain") then
					s.Flash(589--[[Shadow Word: Pain]], SetColor(x.ActiveEnemy))
				elseif s.Flashable(2944--[[Devouring Plague]]) and x.NoCC and Castable("Devouring Plague") then
					s.Flash(2944--[[Devouring Plague]], SetColor(x.ActiveEnemy))
				elseif s.Flashable(32379--[[Shadow Word: Death]]) and s.HasTalent(14910--[[Mind Melt]]) and x.NoCC and Castable("Shadow Word: Death") then
					s.Flash(32379--[[Shadow Word: Death]], SetColor(x.ActiveEnemy, "Yellow"))
				elseif s.Flashable(8092--[[Mind Blast]]) and s.BuffStack(77487--[[Shadow Orb]], "player") >= 2 and x.NoCC and Castable("Mind Blast") then
					s.Flash(8092--[[Mind Blast]], SetColor(x.ActiveEnemy, "Yellow"))
				elseif s.Flashable(8092--[[Mind Blast]]) and x.NoCC and Castable("Mind Blast") then
					s.Flash(8092--[[Mind Blast]], SetColor(x.ActiveEnemy))
				elseif s.Flashable(15407--[[Mind Flay]]) and x.NoCC and Castable("Mind Flay") then
					s.Flash(15407--[[Mind Flay]], SetColor(x.ActiveEnemy))
				elseif s.Flashable(73510--[[Mind Spike]]) and x.NoCC and Castable("Mind Spike") then
					s.Flash(73510--[[Mind Spike]], SetColor(x.ActiveEnemy))
				end
			end
		
		
		if s.TalentMastery(2) then

		end
			

	
		Buffs()
		
	end},
	
	
	-- Add and remove as many of these table sections ass needed
	{Title = L["No Priority"], -- Place script title here
	Description = L["This removes the priority Flashing.  You will still have these Abilities listed below, plus some.. \n \n All Buffs Available \n Power Word: Shield - Below 50% Health \n Shadowfiend - Below 20% Mana \n Dispersion - Various Functions \n Fade - 95% Threat, While in group"], -- Place optional script description here or comment out or remove this line
	Function = function()
		-- x.Enemy, x.ActiveEnemy, x.NoCC, x.InInstance, x.InstanceType, x.PetAlive, x.PetActiveEnemy, x.PetNoCC, x.Lag, x.DoubleLag, x.ThreatPercent
		
		if x.ThreatPercent >= 95 and ( GetNumRaidMembers() > 1 or GetNumPartyMembers() > 0 ) then
			if s.Flashable(586--[[Fade]]) and x.NoCC and Castable("Fade") then
				s.Flash(586--[[Fade]], SetColor(x.ActiveEnemy, "Purple"))
			end
		end
		
		if s.Flashable(17--[[Power Word: Shield]]) and s.HealthPercent("player") < 50 and Castable("Power Word: Shield") then
			s.Flash(17--[[Power Word: Shield]], SetColor(x.ActiveEnemy, "Red"))
		end
		
		if s.Flashable(34433--[[Shadowfiend]]) and x.NoCC and s.PowerPercent("player") < 20 and Castable("Shadowfiend") then
			s.Flash(34433--[[Shadowfiend]], SetColor(x.ActiveEnemy, "Green"))
		elseif s.Flashable(47585--[[Dispersion]]) and s.PowerPercent("player") < 20 and Castable("Dispersion")then
			s.Flash(47585--[[Dispersion]], "Green")
		elseif s.Flashable(47585--[[Dispersion]]) and s.PowerPercent("player") < 50 and s.HealthPercent("player") < 20 and Castable("Dispersion") then
			s.Flash(47585--[[Dispersion]], "Red")
		end
		
		if s.Flashable(19236--[[Desperate Prayer]]) and s.HealthPercent("player") < 50 and Castable("Desperate Prayer") then
			s.Flash(19236--[[Desperate Prayer]], SetColor(x.ActiveEnemy, "Red"))
		end	
		
		if s.Flashable(47585--[[Dispersion]]) and s.CrowedControlled("player") or s.MovementImpaired("player") or s.Debuff(15487--[[Silence]], "player") and Castable("Dispersion") then
			s.Flash(47585--[[Dispersion]], "Purple")
		end
		
		
		
		if s.TalentMastery(3) then
			if Castable("Shadowform") then
				if s.Flashable(15473--[[Shadowform]]) then
					s.Flash(15473--[[Shadowform]])
				end
				s.FlashForm(15473--[[Shadowform]])
			end
			
			if s.Boss("target") and s.Debuff(34914--[[Vampiric Touch]]) then
				if s.Flashable(34433--[[Shadowfiend]]) and x.NoCC and Castable("Shadowfiend") then
			s.Flash(34433--[[Shadowfiend]], SetColor(x.ActiveEnemy, "Yellow"))
			end
				end
				
				
		end
		
		
		if s.TalentMastery(2) then

		end
			

	
		Buffs()
		
	end},
	
		-- Default script
	{Title = L["ZAFIRAH Test"], -- Place script title here
	Description = L["Testing code for guildies!"], -- Place optional script description here or comment out or remove this line
	Function = function()
		-- x.Enemy, x.ActiveEnemy, x.NoCC, x.InInstance, x.InstanceType, x.PetAlive, x.PetActiveEnemy, x.PetNoCC, x.Lag, x.DoubleLag, x.ThreatPercent
		
		if x.ThreatPercent >= 95 and ( GetNumRaidMembers() > 1 or GetNumPartyMembers() > 0 ) then
			if s.Flashable(586--[[Fade]]) and x.NoCC and Castable("Fade") then
				s.Flash(586--[[Fade]], SetColor(x.ActiveEnemy, "Purple"))
			end
		end
		if x.ThreatPercent >= 95 then
			if s.Flashable(17--[[Power Word: Shield]]) and Castable("Power Word: Shield") then
			s.Flash(17--[[Power Word: Shield]], SetColor(x.ActiveEnemy, "Purple"))
			end
		end
		if s.Flashable(17--[[Power Word: Shield]]) and s.HealthPercent("player") < 50 and Castable("Power Word: Shield") then
			s.Flash(17--[[Power Word: Shield]], SetColor(x.ActiveEnemy, "Red"))
		end
		
		if s.Flashable(9484--[[Shackle Undead]]) and Castable("Shackle Undead") then
			s.Flash(9484--[[Shackle Undead]], SetColor(x.ActiveEnemy, "Purple"))
		end
		
		if s.Flashable(34433--[[Shadowfiend]]) and x.NoCC and s.PowerPercent("player") < 20 and Castable("Shadowfiend") then
			s.Flash(34433--[[Shadowfiend]], SetColor(x.ActiveEnemy, "Green"))
		elseif s.Flashable(47585--[[Dispersion]]) and s.PowerPercent("player") < 20 and Castable("Dispersion")then
			s.Flash(47585--[[Dispersion]], "Green")
		elseif s.Flashable(47585--[[Dispersion]]) and s.PowerPercent("player") < 50 and s.HealthPercent("player") < 20 and Castable("Dispersion") then
			s.Flash(47585--[[Dispersion]], "Red")
		end
		
		if s.Flashable(19236--[[Desperate Prayer]]) and s.HealthPercent("player") < 50 and Castable("Desperate Prayer") then
			s.Flash(19236--[[Desperate Prayer]], SetColor(x.ActiveEnemy, "Red"))
		end	
		
		if s.Flashable(47585--[[Dispersion]]) and s.CrowedControlled("player") or s.MovementImpaired("player") or s.Debuff(15487--[[Silence]], "player") and Castable("Dispersion") then
			s.Flash(47585--[[Dispersion]], "Purple")
		end
		
		
		
		if s.TalentMastery(3) then
			if Castable("Shadowform") then
				if s.Flashable(15473--[[Shadowform]]) then
					s.Flash(15473--[[Shadowform]])
				end
				s.FlashForm(15473--[[Shadowform]])
			end
			
			if s.Boss("target") and s.Debuff(34914--[[Vampiric Touch]]) then
				if s.Flashable(34433--[[Shadowfiend]]) and x.NoCC and Castable("Shadowfiend") then
			s.Flash(34433--[[Shadowfiend]], SetColor(x.ActiveEnemy, "Yellow"))
			end
				end
				
				if s.Flashable(8092--[[Mind Blast]]) and x.NoCC and s.HasTalent(14910--[[Mind Melt]]) and s.BuffStack(81292--[[Mind Melt]], "player") == 2 and Castable("Mind Blast") then
					s.Flash(8092--[[Mind Blast]], SetColor(x.ActiveEnemy))
				end

				if s.Flashable(34914--[[Vampiric Touch]]) and x.NoCC and s.GetChanneling(15407--[[Mind Flay]], "player") <= 1 and s.MyDebuffDuration(34914--[[Vampiric Touch]], nil, 3) and Castable("Vampiric Touch") then
					s.Flash(34914--[[Vampiric Touch]], SetColor(x.ActiveEnemy))
				elseif s.Flashable(589--[[Shadow Word: Pain]]) and x.NoCC and Castable("Shadow Word: Pain") then
					s.Flash(589--[[Shadow Word: Pain]], SetColor(x.ActiveEnemy))
				elseif s.Flashable(2944--[[Devouring Plague]]) and x.NoCC and s.GetChanneling(15407--[[Mind Flay]], "player") <= 1 and Castable("Devouring Plague") then
					s.Flash(2944--[[Devouring Plague]], SetColor(x.ActiveEnemy))
				elseif s.Flashable(32379--[[Shadow Word: Death]]) and s.HasTalent(14910--[[Mind Melt]]) and x.NoCC and s.GetChanneling(15407--[[Mind Flay]], "player") <= 1 and Castable("Shadow Word: Death") then
					s.Flash(32379--[[Shadow Word: Death]], SetColor(x.ActiveEnemy, "Yellow"))
				elseif s.Flashable(8092--[[Mind Blast]]) and s.BuffStack(77487--[[Shadow Orb]], "player") >= 2 and x.NoCC and s.GetChanneling(15407--[[Mind Flay]], "player") <= 1 and Castable("Mind Blast") then
					s.Flash(8092--[[Mind Blast]], SetColor(x.ActiveEnemy, "Yellow"))
				elseif s.Flashable(8092--[[Mind Blast]]) and s.BuffStack(77487--[[Shadow Orb]], "player") == 1 and x.NoCC and s.GetChanneling(15407--[[Mind Flay]], "player") <= 1 and Castable("Mind Blast") then
					s.Flash(8092--[[Mind Blast]], SetColor(x.ActiveEnemy))
				elseif s.Flashable(15407--[[Mind Flay]]) and x.NoCC and Castable("Mind Flay") then
					s.Flash(15407--[[Mind Flay]], SetColor(x.ActiveEnemy))
				elseif s.Flashable(73510--[[Mind Spike]]) and x.NoCC and Castable("Mind Spike") then
					s.Flash(73510--[[Mind Spike]], SetColor(x.ActiveEnemy))
				end
			end
		
		
		if s.TalentMastery(2) then

		end
			

	
		Buffs()
		
	end},
	
	
}