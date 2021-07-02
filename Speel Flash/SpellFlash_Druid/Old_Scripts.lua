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


local function Buffs()
	if not IsMounted() and ( not IsResting() or InCombat() or SpellFlashAddon.IsEnemy()  ) then
		if Flashable(SpellName(21849--[[Gift of the Wild]])) and not AddonTable.IsBuffActive() and Castable("Gift of the Wild") then
			Flash(SpellName(21849--[[Gift of the Wild]]), "Green")
		end
		if Flashable(SpellName(1126--[[Mark of the Wild]])) and not AddonTable.IsBuffActive() and Castable("Mark of the Wild") then
			Flash(SpellName(1126--[[Mark of the Wild]]), "Green")
		end
	end
end

-- Use this single spam function and remove the multiple spam table below, or just use the multiple spam table below and leave this function in place.
SpellFlashAddon.Spam[AddonName] = function(NoCC, ActiveEnemy, PetAlive, PetActiveEnemy, instanceType, PetNoCC)
	if GetConfig("spell_flashing_off") then return elseif AddonTable.Spam then RunSpamTable(NoCC, ActiveEnemy, PetAlive, PetActiveEnemy, instanceType, PetNoCC) else
		
		if Form(SpellName(768--[[Cat Form]])) then
		
			local sr = Buff(SpellName(52610--[[Savage Roar]]))
			local ooc = Buff(SpellName(16864--[[Omen of Clarity]]))
			local Trauma = Debuff(SpellName(46854--[[Trauma]]))
			local MT = Trauma or Debuff(SpellName(33876--[[Mangle (Cat)]]))
			local MTRip = MT or Debuff(SpellName(1079--[[Rip]]))
			
			if Flashable(SpellName(467--[[Thorns]])) and not AddonTable.IsThornsActive() and Castable("Thorns") then
				Flash(SpellName(467--[[Thorns]]), "Green")
			end
			
			if Flashable(SpellName(50334--[[Berserk]])) and ActiveEnemy and UnitPower("player") >= 70 and Castable("Berserk") then
				Flash(SpellName(50334--[[Berserk]]), "Yellow")
			end
			
			if Flashable(SpellName(16857--[[Faerie Fire (Feral)]])) and Castable("Faerie Fire (Feral)") then
				Flash(SpellName(16857--[[Faerie Fire (Feral)]]), SetColor(ActiveEnemy))
			end
			
			if Flashable(SpellName(22842--[[Frenzied Regeneration]])) and InCombat() and HealthPercent("player") < 30 and Castable("Frenzied Regeneration") then
				Flash(SpellName(22842--[[Frenzied Regeneration]]), "Red")
			end
			
			if Flashable(SpellName(61336--[[Survival Instincts]])) and InCombat() and HealthPercent("player") < 20 and Castable("Survival Instincts") then
				Flash(SpellName(61336--[[Survival Instincts]]), "Red")
			end
			
			if MT and sr and Flashable(SpellName(59881--[[Rake]])) and NoCC and Castable("Rake", 2) then
				Flash(SpellName(59881--[[Rake]]), SetColor(ActiveEnemy))
			end
			
			if MT and sr and Flashable(SpellName(5221--[[Shred]])) and ActiveEnemy and Castable("Shred") then
				Flash(SpellName(5221--[[Shred]]), "White")
			end
			
			if occ and sr and Flashable(SpellName(5221--[[Shred]])) and ActiveEnemy and Castable("Shred") then
				Flash(SpellName(5221--[[Shred]]), "Yellow")
			end
			
			if Flashable(SpellName(52610--[[Savage Roar]])) and ActiveEnemy and GetComboPoints("player") > 0 and Castable("Savage Roar", 2) then
				Flash(SpellName(52610--[[Savage Roar]]), (({"White","Yellow","Orange","Orange","Red"})[GetComboPoints("player")]))
			end
			
			if MT and sr and Flashable(SpellName(1079--[[Rip]])) and ActiveEnemy and GetComboPoints("player") == 5 and Castable("Rip", 2) then
				Flash(SpellName(1079--[[Rip]]), "Orange")
			end
			
			if MTRip and sr and Flashable(SpellName(22568--[[Ferocious Bite]])) and ActiveEnemy and GetComboPoints("player") == 5 and Castable("Ferocious Bite") then
				Flash(SpellName(22568--[[Ferocious Bite]]), "Orange")
			end
			
			if not Trauma and Flashable(SpellName(33876--[[Mangle (Cat)]])) and NoCC and Castable("Mangle (Cat)", 2) then
				Flash(SpellName(33876--[[Mangle (Cat)]]), SetColor(ActiveEnemy))
			end
			
			if Flashable(SpellName(5217--[[Tiger's Fury]])) and ActiveEnemy and UnitPower("player") <= 30 and Castable("Tiger's Fury") then
				Flash(SpellName(5217--[[Tiger's Fury]]), "Red")
			end
		end
			
			--Tanks
		if Form(SpellName(5487--[[Bear Form]])) then
			if Flashable(SpellName(33878--[[Mangle (Bear)]])) and NoCC and Buff(SpellName(50334--[[Berserk]])) and Castable("Mangle (Bear)") then
				Flash(SpellName(33878--[[Mangle (Bear)]]), SetColor(ActiveEnemy, "Purple"))
			end
			
			if Flashable(SpellName(467--[[Thorns]])) and not AddonTable.IsThornsActive() and Castable("Thorns") then
				Flash(SpellName(467--[[Thorns]]), "Green")
			end
				
			if Flashable(SpellName(50334--[[Berserk]])) and ActiveEnemy and UnitPower("player") >= 70 and Castable("Berserk") then
				Flash(SpellName(50334--[[Berserk]]), "Pink")
			end
			
			if Flashable(SpellName(16857--[[Faerie Fire (Feral)]])) and Castable("Faerie Fire (Feral)") then
				Flash(SpellName(16857--[[Faerie Fire (Feral)]]), SetColor(ActiveEnemy))
			end
			
			if Flashable(SpellName(5211--[[Bash]])) and Castable("Bash") then
				Flash(SpellName(5211--[[Bash]]), SetColor(ActiveEnemy, "Blue"))	
			end
			
			if Flashable(SpellName(22842--[[Frenzied Regeneration]])) and InCombat() and HealthPercent("player") < 30 and Castable("Frenzied Regeneration") then
				Flash(SpellName(22842--[[Frenzied Regeneration]]), "Red")
			end
			
			if Flashable(SpellName(61336--[[Survival Instincts]])) and InCombat() and HealthPercent("player") < 20 and Castable("Survival Instincts") then
				Flash(SpellName(61336--[[Survival Instincts]]), "Red")
			end
			
			if Flashable(SpellName(16979--[[Feral Charge - Bear]])) and NoCC and Castable("Feral Charge - Bear") then
				Flash(SpellName(16979--[[Feral Charge - Bear]]), SetColor(ActiveEnemy and UnitIsUnit("targettarget", "player")))
			end
			
			if Flashable(SpellName(99--[[Demoralizing Roar]])) and ActiveEnemy and Castable("Demoralizing Roar") then
				Flash(SpellName(99--[[Demoralizing Roar]]), "Blue")
			end
		end
		
		--Boomkin Form
		if Castable("Moonkin Form") then
			FlashForm(SpellName(24858--[[Moonkin Form]]), "White")
		elseif Form(SpellName(24858--[[Moonkin Form]])) then
			
			if NoCC then
				
				if Flashable(SpellName(29166--[[Innervate]])) and PowerPercent("player") < 20 and Castable("Innervate") then
					Flash(SpellName(29166--[[Innervate]]), SetColor(ActiveEnemy, "Green"))				
				end

				if ( string.find(string.lower(UnitClassification("target") or ""), "boss") or ( UnitLevel("target") == -1 and not UnitPlayerControlled("target") ) ) then
					if Flashable(SpellName(770--[[Faerie Fire]])) and Castable("Faerie Fire") then
						Flash(SpellName(770--[[Faerie Fire]]), SetColor(ActiveEnemy))
					elseif Flashable(SpellName(33831--[[Force of Nature]])) and Castable("Force of Nature") then
						Flash(SpellName(33831--[[Force of Nature]]), SetColor(ActiveEnemy, "Purple"))
					end
				end
				
				
				if Flashable(SpellName(48468--[[Insect Swarm]])) and not Buff(SpellName(48518--[[Eclipse (Lunar)]])) and Castable("Insect Swarm") then
					Flash(SpellName(48468--[[Insect Swarm]]), SetColor(ActiveEnemy))
				elseif Flashable(SpellName(48463--[[Moonfire]])) and Castable("Moonfire") then
					Flash(SpellName(48463--[[Moonfire]]), SetColor(ActiveEnemy))
				else
				
					if Flashable(SpellName(53201--[[Starfall]])) and Buff(SpellName(48518--[[Eclipse (Lunar)]])) and ( string.find(string.lower(UnitClassification("target") or ""), "boss") or ( UnitLevel("target") == -1 and not UnitPlayerControlled("target") ) ) and Castable("Starfall") then
						Flash(SpellName(53201--[[Starfall]]), SetColor(ActiveEnemy, "Purple"))
					end
					
					--Start crazy script
					if Buff(SpellName(32182--[[Heroism]])) or Buff(SpellName(2825--[[Bloodlust]])) and Flashable(SpellName(33831--[[Force of Nature]])) and Castable("Force of Nature") then
						Flash(SpellName(33831--[[Force of Nature]]), SetColor(ActiveEnemy, "Red"))
					elseif HasTalent(SpellName(48516--[[Eclipse]])) then
						local Lag = select(3,GetNetStats()) / 1000
						local Lunar = AddonTable:GetTimer("Eclipse (Lunar)") - ( CastTime(SpellName(48465--[[Starfire]])) + (Lag * 2) )
						local Solar = AddonTable:GetTimer("Eclipse (Solar)") - ( CastTime(SpellName(48461--[[Wrath]])) + (Lag * 2) )
						if ( Solar > 0 or Lunar <= 0 ) and Flashable(SpellName(48461--[[Wrath]])) and Castable("Wrath") then
							if Buff(SpellName(48517--[[Eclipse (Solar)]])) then
								Flash(SpellName(48461--[[Wrath]]), SetColor(ActiveEnemy, "Yellow"))
							elseif Flashable(SpellName(48463--[[Moonfire]])) and Castable("Moonfire") then
								Flash(SpellName(48463--[[Moonfire]]), SetColor(ActiveEnemy))
							elseif Flashable(SpellName(48461--[[Wrath]])) and Castable("Wrath") then
								Flash(SpellName(48461--[[Wrath]]), SetColor(ActiveEnemy))									
							end
						elseif Lunar > 0 and Flashable(SpellName(48465--[[Starfire]])) and Castable("Starfire") then
							if Buff(SpellName(48518--[[Eclipse (Lunar)]])) then
								Flash(SpellName(48465--[[Starfire]]), SetColor(ActiveEnemy, "Yellow"))
							else
								Flash(SpellName(48465--[[Starfire]]), SetColor(ActiveEnemy))
							end
						end
					elseif Flashable(SpellName(48461--[[Wrath]])) and Castable("Wrath") then
						Flash(SpellName(48461--[[Wrath]]), SetColor(ActiveEnemy))
					end
					
				end
				
			end
			
		end
		
		if Castable("Tree of Life") then
			FlashForm(SpellName(65139--[[Tree of Life]]), "White")
		elseif Form(SpellName(65139--[[Tree of Life]])) then
			if Flashable(SpellName(17116--[[Nature's Swiftness]])) and Castable("Nature's Swiftness") then
				Flash(SpellName(17116--[[Nature's Swiftness]]), "Green")				
			end
			if Flashable(SpellName(29166--[[Innervate]])) and ActiveEnemy and NoCC and PowerPercent("player") < 20 and Castable("Innervate") then
				Flash(SpellName(29166--[[Innervate]]), SetColor(ActiveEnemy, "Green"))				
			end
		end
		
		Buffs()
		
	end
end

