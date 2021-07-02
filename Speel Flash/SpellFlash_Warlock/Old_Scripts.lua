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
		
		local DrainSoulForShard = ( Flashable(SpellName(1120--[[Drain Soul]])) and ActiveEnemy and not tostring(UnitClassification("target")):lower():match("boss") and ( UnitLevel("target") ~= -1 or UnitPlayerControlled("target") ) and HealthPercent("target") <= 25 and SpellFlashAddon.GivesXP() and not Debuff(SpellName(17877--[[Shadowburn]]),nil,1) and Castable("Drain Soul") and ( GetItemCount(6265--[[Soul Shard]]) < AddonTable.ShardBagSize or ( HasTalent(SpellName(18213--[[Improved Drain Soul]])) and ( UnitIsUnit("targettarget", "player") or UnitIsUnit("targettarget", "pet") ) and GetItemCount(6265--[[Soul Shard]]) <= AddonTable.ShardBagSize ) ) )
		local CONFLAGRATE = ( Flashable(SpellName(17962--[[Conflagrate]])) and NoCC and ( HasTalent(SpellName(47258--[[Backdraft]])) or HasGlyph(SpellName(56235--[[Glyph of Conflagrate]])) or Debuff({SpellName(348--[[Immolate]]),SpellName(47897--[[Shadowflame]])},nil,1,nil,nil,nil,3) ) and Castable("Conflagrate") )
		local ShadowBoltFlashed = nil
		local IncinerateFlashed = nil
		
		if PetAlive then
			
			if instanceType == "party" or instanceType == "raid" then
				if PetCastable("Passive") then
					FlashPet("Passive")
				end
				if IsAutocastOn(SpellName(33698--[[Anguish]])) then
					FlashPet(SpellName(33698--[[Anguish]]), "Red")
				elseif IsAutocastOn(SpellName(3716--[[Torment]])) then
					FlashPet(SpellName(3716--[[Torment]]), "Red")
					if IsAutocastOn(SpellName(17735--[[Suffering]])) then
						FlashPet(SpellName(17735--[[Suffering]]), "Red")
					end
				elseif IsAutocastOn(SpellName(17735--[[Suffering]])) then
					FlashPet(SpellName(17735--[[Suffering]]), "Red")
				elseif SpellKnown(SpellName(6360--[[Soothing Kiss]])) and not IsAutocastOn(SpellName(6360--[[Soothing Kiss]])) then
					FlashPet(SpellName(6360--[[Soothing Kiss]]), "Green")
				end
				
			elseif instanceType == "pvp" or instanceType == "arena" then
				if ( HasTalent(SpellName(47220--[[Empowered Imp]])) or ( not IsAutocastOn(SpellName(4511--[[Phase Shift]])) and not Buff(SpellName(4511--[[Phase Shift]]), "pet") ) ) and PetCastable("Aggressive") then
					FlashPet("Aggressive", "Pink")
				end
				
			else
				if PetCastable("Defensive") and PetCastable("Passive") then
					FlashPet("Defensive", "Pink")
				end
				
			end
			
			if ActiveEnemy and not PetActiveEnemy and ( HasTalent(SpellName(47220--[[Empowered Imp]])) or not Buff(SpellName(4511--[[Phase Shift]]), "pet") ) then
				FlashPet("Attack", "Pink")
				
			elseif PetActiveEnemy and not UnitPlayerControlled("pettarget") and not UnitExists("pettargettarget") and HealthPercent("pettarget") <= 35 then
				FlashPet("Follow")
				
			elseif not PetNoCC then
				FlashPet("Stay")
				
			end
			
		end
		
		if Flashable(SpellName(755--[[Health Funnel]])) and Castable("Health Funnel") then
			Flash(SpellName(755--[[Health Funnel]]))
			
		end
		
		if ( Flashable(SpellName(28176--[[Fel Armor]])) or Flashable(SpellName(SpellName(706--[[Demon Armor]])) or SpellName(687--[[Demon Skin]])) ) and ( not IsResting() or InCombat() or SpellFlashAddon.IsEnemy() ) and not IsMounted() and not AddonTable.IsArmorActive() then
			if Flashable(SpellName(28176--[[Fel Armor]])) and Castable("Fel Armor") then
				Flash(SpellName(28176--[[Fel Armor]]), "Green")
			end
			if SpellKnown(SpellName(706--[[Demon Armor]])) then
				if Flashable(SpellName(706--[[Demon Armor]])) and Castable("Demon Armor") then
					Flash(SpellName(706--[[Demon Armor]]), "Green")
				end
			elseif Flashable(SpellName(687--[[Demon Skin]])) and Castable("Demon Skin") then
				Flash(SpellName(687--[[Demon Skin]]), "Green")
			end
			
		end
		
		if Flashable(SpellName(5697--[[Unending Breath]])) and Castable("Unending Breath") then
			Flash(SpellName(5697--[[Unending Breath]]), "Green")
			
		end
		
		if Flashable(SpellName(19028--[[Soul Link]])) and not IsMounted() and Castable("Soul Link") then
			Flash(SpellName(19028--[[Soul Link]]), "Green")
			
		end
		
		if DrainSoulForShard then
			Flash(SpellName(1120--[[Drain Soul]]), "Orange")
			
		elseif Flashable(SpellName(17877--[[Shadowburn]])) and ActiveEnemy and ( SpellFlashAddon.IsDieingEnemy() or tostring(UnitClassification("target")):lower():match("boss") or ( UnitLevel("target") == -1 and not UnitPlayerControlled("target") ) ) and Castable("Shadowburn") and GetItemCount(6265--[[Soul Shard]]) >= AddonTable.ShardBagSize then
			Flash(SpellName(17877--[[Shadowburn]]), "Orange")
			
		elseif not AddonTable:IsTimer("TapDelay") and not IsMounted() and ( Flashable(SpellName(18220--[[Dark Pact]])) or Flashable(SpellName(1454--[[Life Tap]])) ) then
			if PowerPercent("player") < 90 then
				if Flashable(SpellName(1454--[[Life Tap]])) and not IsCurrentSpell(SpellName(18220--[[Dark Pact]])) and HasGlyph(SpellName(63320--[[Glyph of Life Tap]])) and not Buff(SpellName(1454--[[Life Tap]])) and not (SpellFlashAddon.IsEnemyTargetingYou() and InCombat()) and HealthPercent("player") >= 90 and Castable("Life Tap") then
					Flash(SpellName(1454--[[Life Tap]]), "Green")
				elseif Flashable(SpellName(18220--[[Dark Pact]])) and not IsCurrentSpell(SpellName(1454--[[Life Tap]])) and ( PowerPercent("pet") == 100 or ( PowerPercent("pet") >= 99 and ( HealthPercent("player") < 100 or not Flashable(SpellName(1454--[[Life Tap]])) ) ) ) and Castable("Dark Pact") then
					Flash(SpellName(18220--[[Dark Pact]]))
				elseif Flashable(SpellName(1454--[[Life Tap]])) and not IsCurrentSpell(SpellName(18220--[[Dark Pact]])) and not (SpellFlashAddon.IsEnemyTargetingYou() and InCombat()) and ( ( PowerPercent("player") >= 80 and HealthPercent("player") >= 98 ) or ( PowerPercent("player") < 80 and HealthPercent("player") >= 95 ) ) and Castable("Life Tap") then
					Flash(SpellName(1454--[[Life Tap]]))
				end
			end
			
		end
		
		if Buff(SpellName(34936--[[Backlash]])) and NoCC then
			if ( Buff(SpellName(17941--[[Shadow Trance]])) or not Flashable(SpellName(686--[[Shadow Bolt]])) ) and Flashable(SpellName(29722--[[Incinerate]])) and Castable("Incinerate") then
				if not CONFLAGRATE or not HasGlyph(SpellName(56235--[[Glyph of Conflagrate]])) then
					Flash(SpellName(29722--[[Incinerate]]), SetColor(ActiveEnemy, "Yellow"))
				end
				IncinerateFlashed = 1
				ShadowBoltFlashed = 1
				
			elseif Flashable(SpellName(686--[[Shadow Bolt]])) and
				(
					(
						HasTalent(SpellName(17793--[[Improved Shadow Bolt]])) and not AuraDelay(SpellName(17800--[[Shadow Mastery]])) and not Casting(SpellName(686--[[Shadow Bolt]])) and not Debuff(SpellName(17800--[[Shadow Mastery]]),nil,nil,nil,nil,2)
					)
					
					or
					
					(
						HasTalent(SpellName(32385--[[Shadow Embrace]])) and not AuraDelay(SpellName(32385--[[Shadow Embrace]])) and not Debuff(SpellName(32385--[[Shadow Embrace]]),nil,1,nil,2,2)
						and
						(
							(
								not SpellDelay(SpellName(686--[[Shadow Bolt]])) and not SpellDelay(SpellName(48181--[[Haunt]])) and not Casting(SpellName(686--[[Shadow Bolt]]))
							)
							or
							not Debuff(SpellName(32385--[[Shadow Embrace]]),nil,1,nil,nil,2)
						)
					)
				)
				and Castable("Shadow Bolt") then
					if not CONFLAGRATE then
						Flash(SpellName(686--[[Shadow Bolt]]), SetColor(ActiveEnemy, "Yellow"))
					end
					ShadowBoltFlashed = 1
					
			elseif Flashable(SpellName(29722--[[Incinerate]])) and ( AuraDelay(SpellName(348--[[Immolate]])) or IsCurrentSpell(SpellName(348--[[Immolate]])) or Casting(SpellName(348--[[Immolate]])) or Debuff(SpellName(348--[[Immolate]]),nil,1,nil,nil,2) ) and Castable("Incinerate") then
				if not CONFLAGRATE or not HasGlyph(SpellName(56235--[[Glyph of Conflagrate]])) then
					Flash(SpellName(29722--[[Incinerate]]), SetColor(ActiveEnemy, "Yellow"))
				end
				IncinerateFlashed = 1
				
			elseif Flashable(SpellName(686--[[Shadow Bolt]])) and Castable("Shadow Bolt") then
				if not CONFLAGRATE then
					Flash(SpellName(686--[[Shadow Bolt]]), SetColor(ActiveEnemy, "Yellow"))
				end
				ShadowBoltFlashed = 1
				
			elseif Flashable(SpellName(29722--[[Incinerate]])) and Castable("Incinerate") then
				if not CONFLAGRATE or not HasGlyph(SpellName(56235--[[Glyph of Conflagrate]])) then
					Flash(SpellName(29722--[[Incinerate]]), SetColor(ActiveEnemy, "Yellow"))
				end
				IncinerateFlashed = 1
				
			end
		
		elseif Buff(SpellName(17941--[[Shadow Trance]])) and Flashable(SpellName(686--[[Shadow Bolt]])) and NoCC and Castable("Shadow Bolt") then
			if not CONFLAGRATE then
				Flash(SpellName(686--[[Shadow Bolt]]), SetColor(ActiveEnemy, "Yellow"))
			end
			ShadowBoltFlashed = 1
			
		end
		
		if NoCC and not AddonTable.IsCursePushed() and ( not AddonTable.IsCursed() or ( ( Debuff(SpellName(51726--[[Ebon Plague]])) or Debuff(SpellName(48506--[[Earth and Moon]])) ) and Debuff(SpellName(1490--[[Curse of the Elements]]),nil,1) ) ) then
			if Flashable(SpellName(1490--[[Curse of the Elements]])) and not Debuff(SpellName(51726--[[Ebon Plague]])) and not Debuff(SpellName(48506--[[Earth and Moon]])) and ( tostring(UnitClassification("target")):lower():match("boss") or tostring(UnitClassification("target")):lower():match("elite") or ( UnitLevel("target") == -1 and not UnitPlayerControlled("target") ) ) and Castable("Curse of the Elements") then
				Flash(SpellName(1490--[[Curse of the Elements]]), SetColor(ActiveEnemy))
				
			elseif Flashable(SpellName(603--[[Curse of Doom]])) and ( tostring(UnitClassification("target")):lower():match("boss") or ( UnitLevel("target") == -1 and not UnitPlayerControlled("target") ) ) and HealthPercent("target") >= 30 and Castable("Curse of Doom") then
				Flash(SpellName(603--[[Curse of Doom]]), SetColor(ActiveEnemy))
				
			elseif Flashable(SpellName(980--[[Curse of Agony]])) and Castable("Curse of Agony") then
				Flash(SpellName(980--[[Curse of Agony]]), SetColor(ActiveEnemy))
				
			end
			
		end
		
		local CORRUPTION = Flashable(SpellName(172--[[Corruption]])) and NoCC and Castable("Corruption")
		if CORRUPTION then
			Flash(SpellName(172--[[Corruption]]), SetColor(ActiveEnemy))
			
		end
		
		if CONFLAGRATE then
			if not IncinerateFlashed or HasGlyph(SpellName(56235--[[Glyph of Conflagrate]])) then
				Flash(SpellName(17962--[[Conflagrate]]), SetColor(ActiveEnemy, "Yellow"))
			end
			
		elseif Flashable(SpellName(6353--[[Soul Fire]])) and NoCC and Buff(SpellName(63156--[[Decimation]])) and Castable("Soul Fire") then
			if not IncinerateFlashed and not ShadowBoltFlashed then
				Flash(SpellName(6353--[[Soul Fire]]), SetColor(ActiveEnemy, "Yellow"))
			end
			
		elseif Flashable(SpellName(29722--[[Incinerate]])) and NoCC and Buff(SpellName(47245--[[Molten Core]])) and Castable("Incinerate") then
			if not IncinerateFlashed and not ShadowBoltFlashed then
				Flash(SpellName(29722--[[Incinerate]]), SetColor(ActiveEnemy, "Yellow"))
			end
		
		elseif CORRUPTION and Flashable(SpellName(29722--[[Incinerate]])) and Buff(SpellName(47245--[[Molten Core]])) then
			
			
		elseif Flashable(SpellName(348--[[Immolate]])) and NoCC and ( HasTalent(SpellName(47258--[[Backdraft]])) or HasTalent(SpellName(47266--[[Fire and Brimstone]])) ) and Castable("Immolate") then
			Flash(SpellName(348--[[Immolate]]), SetColor(ActiveEnemy))
			
		elseif Flashable(SpellName(48181--[[Haunt]])) and NoCC and Castable("Haunt") then
			Flash(SpellName(48181--[[Haunt]]), SetColor(ActiveEnemy))
			
		elseif Flashable(SpellName(30108--[[Unstable Affliction]])) and NoCC and Castable("Unstable Affliction") then
			Flash(SpellName(30108--[[Unstable Affliction]]), SetColor(ActiveEnemy))
			
		elseif UnitPlayerControlled("target") and Flashable(SpellName(50796--[[Chaos Bolt]])) and NoCC and ( SpellFlashAddon.IsImmune(SpellName(348--[[Immolate]])) or not HasTalent(SpellName(47266--[[Fire and Brimstone]])) or AuraDelay(SpellName(348--[[Immolate]])) or IsCurrentSpell(SpellName(348--[[Immolate]])) or Casting(SpellName(348--[[Immolate]])) or Debuff(SpellName(348--[[Immolate]]),nil,1,nil,nil,CastTime(SpellName(50796--[[Chaos Bolt]]))+2) ) and Castable("Chaos Bolt") then
			Flash(SpellName(50796--[[Chaos Bolt]]), SetColor(ActiveEnemy))
			
		elseif Flashable(SpellName(686--[[Shadow Bolt]])) and NoCC and
				(
					(
						TalentRank(SpellName(17793--[[Improved Shadow Bolt]])) >= 4 and not AuraDelay(SpellName(17800--[[Shadow Mastery]])) and not Casting(SpellName(686--[[Shadow Bolt]])) and not Debuff(SpellName(17800--[[Shadow Mastery]]),nil,nil,nil,nil,CastTime(SpellName(686--[[Shadow Bolt]]))+2)
					)
					
					or
					
					(
						HasTalent(SpellName(32385--[[Shadow Embrace]])) and not AuraDelay(SpellName(32385--[[Shadow Embrace]]))
						and
						(
							not Flashable(SpellName(48181--[[Haunt]])) or CastTime(SpellName(686--[[Shadow Bolt]])) < ( CastTime(SpellName(48181--[[Haunt]])) + select(2,GetSpellCooldown(SpellName(48181--[[Haunt]]))) )
						)
						and
						not Debuff(SpellName(32385--[[Shadow Embrace]]),nil,1,nil,2,CastTime(SpellName(686--[[Shadow Bolt]]))+2)
						and
						(
							(
								not SpellDelay(SpellName(686--[[Shadow Bolt]])) and not SpellDelay(SpellName(48181--[[Haunt]])) and not Casting(SpellName(686--[[Shadow Bolt]]))
							)
							or
							not Debuff(SpellName(32385--[[Shadow Embrace]]),nil,1,nil,nil,CastTime(SpellName(686--[[Shadow Bolt]]))+2)
						)
					)
				)
				and Castable("Shadow Bolt") then
					if not ShadowBoltFlashed then
						Flash(SpellName(686--[[Shadow Bolt]]), SetColor(ActiveEnemy))
					end
					
		elseif Flashable(SpellName(50796--[[Chaos Bolt]])) and NoCC and ( SpellFlashAddon.IsImmune(SpellName(348--[[Immolate]])) or not HasTalent(SpellName(47266--[[Fire and Brimstone]])) or AuraDelay(SpellName(348--[[Immolate]])) or IsCurrentSpell(SpellName(348--[[Immolate]])) or Casting(SpellName(348--[[Immolate]])) or Debuff(SpellName(348--[[Immolate]]),nil,1,nil,nil,CastTime(SpellName(50796--[[Chaos Bolt]]))+2) ) and Castable("Chaos Bolt") then
			Flash(SpellName(50796--[[Chaos Bolt]]), SetColor(ActiveEnemy))
			
		elseif Flashable(SpellName(348--[[Immolate]])) and NoCC and Castable("Immolate") then
			Flash(SpellName(348--[[Immolate]]), SetColor(ActiveEnemy))
			
		elseif Flashable(SpellName(689--[[Drain Life]])) and ActiveEnemy and ( HealthPercent("player") <= 65 or SpellFlashAddon.IsEnemyTargetingYou() ) and ( HasTalent(SpellName(17783--[[Fel Concentration]])) or not SpellFlashAddon.MeleeDistance() ) and Castable("Drain Life") then
			Flash(SpellName(689--[[Drain Life]]))
			
		elseif Flashable(SpellName(1120--[[Drain Soul]])) and NoCC and HealthPercent("target") <= 25 and HasTalent(SpellName(18271--[[Shadow Mastery]])) and Castable("Drain Soul") then
			if not DrainSoulForShard then
				Flash(SpellName(1120--[[Drain Soul]]), SetColor(ActiveEnemy))
			end
			
		elseif Flashable(SpellName(689--[[Drain Life]])) and NoCC and ( not HasTalent(SpellName(17959--[[Ruin]])) or not Flashable(SpellName(686--[[Shadow Bolt]])) ) and not Buff(SpellName(17941--[[Shadow Trance]])) and HasTalent(SpellName(18094--[[Nightfall]])) and HasTalent(SpellName(17804--[[Soul Siphon]])) and Castable("Drain Life") then
			Flash(SpellName(689--[[Drain Life]]), SetColor(ActiveEnemy))
			
		elseif Flashable(SpellName(29722--[[Incinerate]])) and NoCC and ( AuraDelay(SpellName(348--[[Immolate]])) or IsCurrentSpell(SpellName(348--[[Immolate]])) or Casting(SpellName(348--[[Immolate]])) or Debuff(SpellName(348--[[Immolate]]),nil,1,nil,nil,CastTime(SpellName(29722--[[Incinerate]]))+2) ) and Castable("Incinerate") then
			if not IncinerateFlashed then
				Flash(SpellName(29722--[[Incinerate]]), SetColor(ActiveEnemy))
			end
			
		elseif Flashable(SpellName(686--[[Shadow Bolt]])) and NoCC and Castable("Shadow Bolt") then
			if not ShadowBoltFlashed then
				Flash(SpellName(686--[[Shadow Bolt]]), SetColor(ActiveEnemy))
			end
			
		elseif Flashable(SpellName(689--[[Drain Life]])) and NoCC and Castable("Drain Life") then
			Flash(SpellName(689--[[Drain Life]]), SetColor(ActiveEnemy))
			
		end
		
	end
end

