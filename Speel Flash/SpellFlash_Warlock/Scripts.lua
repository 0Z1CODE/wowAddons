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


local function ShadowEmbrace()
	if s.HasTalent(32385--[[Shadow Embrace]]) and ( s.CurrentSpell(48181--[[Haunt]]) or s.Casting(48181--[[Haunt]], "player") or (s.SpellCooldown(686--[[Shadow Bolt]]) + s.CastTime(686--[[Shadow Bolt]]) + s.GetCasting(686--[[Shadow Bolt]], "player")) < (s.SpellCooldown(48181--[[Haunt]]) + s.CastTime(48181--[[Haunt]])) or not s.Flashable(48181--[[Haunt]]) ) then
		local cast = x.Lag + 2
		if not s.SpellOrAuraDelay(32385--[[Shadow Embrace]]) then
			cast = ( s.Casting(686--[[Shadow Bolt]], "player") or s.Casting(48181--[[Haunt]], "player") or s.CastTime(686--[[Shadow Bolt]]) ) + x.DoubleLag + 2
		end
		local stack = s.MyDebuffStack(32385--[[Shadow Embrace]], nil, cast)
		if s.AuraDelay(32385--[[Shadow Embrace]]) then
			stack = stack + 1
		end
		if s.CurrentSpell(686--[[Shadow Bolt]]) or s.Casting(686--[[Shadow Bolt]], "player") or s.CurrentSpell(48181--[[Haunt]]) or s.Casting(48181--[[Haunt]], "player") then
			stack = stack + 1
		end
		stack = stack + (s.SpellDelay(32385--[[Shadow Embrace]]) or 0)
		return stack < 3
	end
	return false
end

local function ShadowMastery()
	return s.TalentRank(17793--[[Shadow and Flame]]) >= 2 and not s.SpellOrAuraDelay(17800--[[Shadow Mastery]]) and not s.CurrentSpell(686--[[Shadow Bolt]]) and not s.Casting(686--[[Shadow Bolt]], "player") and not s.Debuff(17800--[[Shadow Mastery]], nil, s.CastTime(686--[[Shadow Bolt]]) + s.SpellCooldown(686--[[Shadow Bolt]]) + x.DoubleLag + 2)
end

local function IdleTarget(SpellID)
	return not s.InCombat() and not s.SpellDelay(SpellID) and (
		not x.ActiveEnemy
		or
		(
			UnitIsPlayer("target")
			and
			(
				(
					x.NoCC and not s.EnemyTargetingYou()
				)
				or
				(
					not x.NoCC and s.DebuffDuration({710--[[Banish]], 33786--[[Cyclone]]}) <= s.CastTime(SpellID) + s.SpellCooldown(SpellID) + x.Lag
				)
			)
		)
	)
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
			if s.SpellCooldown(89766--[[Axe Toss]]) <= x.Lag and ( ( x.ActiveEnemy and not UnitExists("pettarget") and s.GetCastingOrChanneling(nil, nil, 1) > (s.SpellCooldown(89766--[[Axe Toss]]) + x.DoubleLag) ) or ( x.PetActiveEnemy and s.GetCastingOrChanneling(nil, "pettarget", 1) > (s.SpellCooldown(89766--[[Axe Toss]]) + x.DoubleLag) ) ) and s.PetCastable(89766--[[Axe Toss]]) then
				s.FlashPet(89766--[[Axe Toss]], "Aqua")
			end
			if x.InstanceType == "party" or x.InstanceType == "raid" then
				if s.Autocast(17735--[[Suffering]]) then
					s.FlashPet(17735--[[Suffering]], "Red")
				end
			end
			if not s.InCombat() and ( s.HealthPercent("pet") <= 99 or s.PowerPercent("pet") <= 99 ) and s.PetCastable(17767--[[Consume Shadows]]) then
				s.FlashPet(17767--[[Consume Shadows]], "Green")
			elseif s.Flashable(755--[[Health Funnel]]) and Castable("Health Funnel") then
				s.Flash(755--[[Health Funnel]], SetColor(s.InCombat(), "Red", "Green"))
			end
			if x.PetActiveEnemy and s.PetCastable(89751--[[Felstorm]]) then
				s.FlashPet(89751--[[Felstorm]], "Purple")
			elseif ( ( x.ActiveEnemy and not UnitExists("pettarget") and s.GetCastingOrChanneling(nil, nil, 1) > (s.SpellCooldown(19647--[[Spell Lock]]) + x.DoubleLag) ) or ( x.PetActiveEnemy and s.GetCastingOrChanneling(nil, "pettarget", 1) > (s.SpellCooldown(19647--[[Spell Lock]]) + x.DoubleLag) ) ) and s.PetCastable(19647--[[Spell Lock]]) then
				s.FlashPet(19647--[[Spell Lock]], "Aqua")
			elseif x.PetActiveEnemy and s.PetCastable(6360--[[Whiplash]]) then
				s.FlashPet(6360--[[Whiplash]], "Purple")
			elseif x.ActiveEnemy and ( s.EnemyTargetingYou() or s.Boss() or s.Boss("pettarget") ) and s.HealthPercent("pet") > 25 and s.PetCastable(7812--[[Sacrifice]]) then
				s.FlashPet(7812--[[Sacrifice]], "Green")
			elseif s.PetCastable(89792--[[Flee]]) and s.NoDamageCC("pet") then
				s.FlashPet(89792--[[Flee]], "Aqua")
			end
			if x.ActiveEnemy and not x.PetActiveEnemy then
				s.FlashPet("Attack", "Pink")
			elseif x.PetActiveEnemy and not UnitPlayerControlled("pettarget") and not UnitExists("pettargettarget") and s.HealthPercent("pettarget") <= 25 then
				s.FlashPet("Follow")
			elseif not x.PetNoCC then
				s.FlashPet("Stay")
			end
			
			if x.PetNoCC and s.Flashable(47193--[[Demonic Empowerment]]) and Castable("Demonic Empowerment") then
				s.Flash(47193--[[Demonic Empowerment]], "Green")
			end
			if x.ActiveEnemy and s.Flashable(77801--[[Demon Soul]]) and Castable("Demon Soul") then
				s.Flash(77801--[[Demon Soul]], "Green")
			end
			if x.PetNoCC and s.Flashable(71521--[[Hand of Gul'dan]]) and Castable("Hand of Gul'dan") then
				s.Flash(71521--[[Hand of Gul'dan]], "Purple")
			end
			
		else
			
			if s.Flashable(688--[[Summon Imp]]) and Castable("Summon Imp") then
				s.Flash(688--[[Summon Imp]], "Green")
			end
			if s.Flashable(712--[[Summon Succubus]]) and Castable("Summon Succubus") then
				s.Flash(712--[[Summon Succubus]], "Green")
			end
			if s.Flashable(697--[[Summon Voidwalker]]) and Castable("Summon Voidwalker") then
				s.Flash(697--[[Summon Voidwalker]], "Green")
			end
			if s.Flashable(691--[[Summon Felhunter]]) and Castable("Summon Felhunter") then
				s.Flash(691--[[Summon Felhunter]], "Green")
			end
			if s.Flashable(30146--[[Summon Felguard]]) and Castable("Summon Felguard") then
				s.Flash(30146--[[Summon Felguard]], "Green")
			end
			
		end
		
		if s.Flashable(710--[[Banish]]) and Castable("Banish") then
			s.Flash(710--[[Banish]], SetColor(x.ActiveEnemy, "Red"))
		end
		
		if s.Flashable(29858--[[Soulshatter]]) and Castable("Soulshatter") then
			s.Flash(29858--[[Soulshatter]], "Yellow")
		end
		if s.Flashable(s.ItemName(5512--[[Healthstone]])) and ItemCastable("Healthstone") then
			s.Flash(s.ItemName(5512--[[Healthstone]]), "Red")
		end
		if s.Flashable(s.ItemName(5232--[[Soulstone]])) and ItemCastable("Soulstone") then
			s.Flash(s.ItemName(5232--[[Soulstone]]), "Green")
		end
		
		if s.Flashable(6229--[[Shadow Ward]]) and Castable("Shadow Ward") then
			s.Flash(6229--[[Shadow Ward]], "Green")
		end
		if s.Flashable(19028--[[Soul Link]]) and Castable("Soul Link") then
			s.Flash(19028--[[Soul Link]], "Green")
		end
		if s.Flashable(6201--[[Create Healthstone]]) and Castable("Create Healthstone") then
			s.Flash(6201--[[Create Healthstone]], "Green")
		end
		if s.Flashable(693--[[Create Soulstone]]) and Castable("Create Soulstone") then
			s.Flash(693--[[Create Soulstone]], "Green")
		end
		if s.Flashable(28176--[[Fel Armor]]) and Castable("Fel Armor") then
			s.Flash(28176--[[Fel Armor]], "Green")
		end
		if s.Flashable(687--[[Demon Armor]]) and Castable("Demon Armor") then
			s.Flash(687--[[Demon Armor]], "Green")
		end
		if s.Flashable(5697--[[Unending Breath]]) and Castable("Unending Breath") then
			s.Flash(5697--[[Unending Breath]], "Green")
		end
		if s.Flashable(80398--[[Dark Intent]]) and Castable("Dark Intent") then
			s.Flash(80398--[[Dark Intent]], "Green")
		end
		if s.Flashable(1454--[[Life Tap]]) and Castable("Life Tap") then
			s.Flash(1454--[[Life Tap]], "Green")
		elseif s.Flashable(79268--[[Soul Harvest]]) and Castable("Soul Harvest") then
			s.Flash(79268--[[Soul Harvest]], "Green")
		end
		
		if s.Flashable(18540--[[Summon Doomguard]]) and Castable("Summon Doomguard") then
			s.Flash(18540--[[Summon Doomguard]], "Purple")
		end
		if s.Flashable(1122--[[Summon Infernal]]) and Castable("Summon Infernal") then
			s.Flash(1122--[[Summon Infernal]], "Purple")
		end
		
		if x.NoCC and s.Flashable(18223--[[Curse of Exhaustion]]) and Castable("Curse of Exhaustion") then
			s.Flash(18223--[[Curse of Exhaustion]], SetColor(x.ActiveEnemy))
		end
		if x.NoCC and s.Flashable(1490--[[Curse of the Elements]]) and Castable("Curse of the Elements") then
			s.Flash(1490--[[Curse of the Elements]], SetColor(x.ActiveEnemy))
		else
			if x.NoCC and s.Flashable(1714--[[Curse of Tongues]]) and Castable("Curse of Tongues") then
				s.Flash(1714--[[Curse of Tongues]], SetColor(x.ActiveEnemy))
			end
			if x.NoCC and s.Flashable(702--[[Curse of Weakness]]) and Castable("Curse of Weakness") then
				s.Flash(702--[[Curse of Weakness]], SetColor(x.ActiveEnemy))
			end
		end
		if x.NoCC and s.Flashable(603--[[Bane of Doom]]) and Castable("Bane of Doom") then
			s.Flash(603--[[Bane of Doom]], SetColor(x.ActiveEnemy))
		elseif x.NoCC and s.Flashable(980--[[Bane of Agony]]) and Castable("Bane of Agony") then
			s.Flash(980--[[Bane of Agony]], SetColor(x.ActiveEnemy))
		end
		if x.NoCC and s.Flashable(172--[[Corruption]]) and Castable("Corruption") then
			s.Flash(172--[[Corruption]], SetColor(x.ActiveEnemy))
		end
		if x.NoCC and s.Flashable(86121--[[Soul Swap]]) and Castable("Soul Swap") then
			s.Flash(86121--[[Soul Swap]], SetColor(x.ActiveEnemy and s.Buff(86121--[[Soul Swap]], "player")))
		end
		if x.NoCC and Castable("Metamorphosis") then
			if s.Flashable(47241--[[Metamorphosis]]) then
				s.Flash(47241--[[Metamorphosis]], SetColor(x.ActiveEnemy))
			end
			s.FlashForm(47241--[[Metamorphosis]], SetColor(x.ActiveEnemy))
		elseif x.NoCC and s.Flashable(50589--[[Immolation Aura]]) and Castable("Immolation Aura") then
			s.Flash(50589--[[Immolation Aura]], SetColor(x.ActiveEnemy, "Purple"))
		elseif x.NoCC and s.Flashable(54785--[[Demon Leap]]) and Castable("Demon Leap") then
			s.Flash(54785--[[Demon Leap]], SetColor(x.ActiveEnemy, "Purple"))
		end
		if s.Flashable(6353--[[Soul Fire]]) and IdleTarget(6353--[[Soul Fire]]) and Castable("Soul Fire") then
			s.Flash(6353--[[Soul Fire]], "Pink")
		end
		if x.NoCC and s.Flashable(17962--[[Conflagrate]]) and Castable("Conflagrate") then
			s.Flash(17962--[[Conflagrate]], SetColor(x.ActiveEnemy))
		elseif x.NoCC and s.Flashable(17877--[[Shadowburn]]) and Castable("Shadowburn") then
			s.Flash(17877--[[Shadowburn]], SetColor(x.ActiveEnemy))
		elseif x.NoCC and s.HasTalent(47245--[[Molten Core]]) and s.Flashable(29722--[[Incinerate]]) and s.Buff(47245--[[Molten Core]], "player") and ( not s.Casting(29722--[[Incinerate]], "player") or s.BuffStack(47245--[[Molten Core]], "player") > 1 ) and Castable("Incinerate") then
			s.Flash(29722--[[Incinerate]], SetColor(x.ActiveEnemy, "Yellow"))
		elseif x.NoCC and s.Flashable(50796--[[Chaos Bolt]]) and Castable("Chaos Bolt") then
			s.Flash(50796--[[Chaos Bolt]], SetColor(x.ActiveEnemy))
		elseif x.NoCC and s.Flashable(48181--[[Haunt]]) and Castable("Haunt") then
			s.Flash(48181--[[Haunt]], SetColor(x.ActiveEnemy))
		elseif x.NoCC and s.Flashable(6353--[[Soul Fire]]) and ( s.Buff(63156--[[Decimation]], "player") or ( s.HasTalent(85113--[[Improved Soul Fire]]) and not s.SpellDelay(6353--[[Soul Fire]]) and ( s.HealthPercent() > 25 or s.Boss() ) and not s.Buff({85383--[[Improved Soul Fire]], 10060--[[Power Infusion]], 2825--[[Bloodlust]], 90355--[[Ancient Hysteria]], 80353--[[Time Warp]], 32182--[[Heroism]]}, "player", s.CastTime(6353--[[Soul Fire]]) + s.SpellCooldown(6353--[[Soul Fire]]) + x.DoubleLag) ) ) and Castable("Soul Fire") then
			if s.Buff(63156--[[Decimation]], "player") then
				s.Flash(6353--[[Soul Fire]], SetColor(x.ActiveEnemy, "Yellow"))
			else
				s.Flash(6353--[[Soul Fire]], SetColor(x.ActiveEnemy))
			end
		elseif x.NoCC and s.Flashable(686--[[Shadow Bolt]]) and ( ShadowEmbrace() or ShadowMastery() ) and Castable("Shadow Bolt") then
			s.Flash(686--[[Shadow Bolt]], SetColor(x.ActiveEnemy))
		elseif x.NoCC and s.Flashable(30108--[[Unstable Affliction]]) and Castable("Unstable Affliction") then
			s.Flash(30108--[[Unstable Affliction]], SetColor(x.ActiveEnemy))
		elseif x.NoCC and s.Flashable(348--[[Immolate]]) and Castable("Immolate") then
			s.Flash(348--[[Immolate]], SetColor(x.ActiveEnemy))
		elseif x.NoCC and s.Flashable(1120--[[Drain Soul]]) and Castable("Drain Soul") then
			s.Flash(1120--[[Drain Soul]], SetColor(x.ActiveEnemy))
		elseif x.NoCC and s.Flashable(29722--[[Incinerate]]) and Castable("Incinerate") then
			s.Flash(29722--[[Incinerate]], SetColor(x.ActiveEnemy))
		elseif x.NoCC and s.Flashable(686--[[Shadow Bolt]]) and Castable("Shadow Bolt") then
			s.Flash(686--[[Shadow Bolt]], SetColor(x.ActiveEnemy))
		elseif x.NoCC and s.Flashable(77799--[[Fel Flame]]) and Castable("Fel Flame") then
			s.Flash(77799--[[Fel Flame]], SetColor(x.ActiveEnemy))
		end
		if x.NoCC and s.Flashable(689--[[Drain Life]]) and Castable("Drain Life") then
			s.Flash(689--[[Drain Life]], SetColor(x.ActiveEnemy))
		end
		
	end
end

