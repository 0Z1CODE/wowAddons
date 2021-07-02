local AddonName, AddonTable = ...
if AddonTable.OldBuild then return end
local L = AddonTable.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables


-- Example function:
AddonTable.Castable["English_Spell_Name"] = function()
	local z = {}
	z.SpellID = GlobalSpellID--[[English_Spell_Name]]   --this is for defining the correct name of the spell
	z.DebuffSlotNeeded = 1   --use this if you want to make sure that a debuff slot is free on the target so that you do not replace other debuffs
	z.Debuff = z.SpellID   --place debuff name or table of names here if the spell has a debuff that may only be on a target once in total from everyone and has a cooldown shorter than the debuff duration
	z.MyDebuff = z.SpellID   --place debuff name or table of names here if the spell has a debuff that may be on the target multiple times by many people and has a cooldown shorter than the debuff duration
	z.Buff = z.SpellID   --place buff name or table of names here if the spell has a buff that may only be on yourself once in total from everyone and has a cooldown shorter than the buff duration
	z.MyBuff = z.SpellID   --place buff name or table of names here if the spell has a buff that may be on the target multiple times by many people and has a cooldown shorter than the buff duration
	z.BuffUnit = "player"   --you will need to use this if the buff or debuff is not applied to your target
	z.CastTime = s.CastTime(z.SpellID)   --use this only if you want to replace the spell cast time used for early indication of a buff or debuff
	z.EnemyTargetNeeded = 1   --use this if the spell should have an enemy targeted
	z.TargetThatUsesManaNeeded = 1   --use this if the spell is only useful on a target that uses mana such as mana draining spells
	z.NoRangeCheck = 1   --use this to disable range detection if the spell has a limited range but the detection in this function is not working correctly for the particular spell
	z.NotIfActive = 1   --use this if the spell may be toggled on such as auto attack or on next swing spells, or to disable when casting or channeling, or if the spell has a cooldown
	z.NotWhileMoving = 1   --use this if the spell is not able to be cast while moving
	z.EvenIfNotUsable = 1   --use this to disable the usability checking in this function and may be used if currently in the process of completing a prerequisite that will make the spell usable
	z.Unit = "target"   --this should not be used unless the spell is not to be cast on the target
	return s.CheckIfSpellCastable(z)
end

-- Example function:
AddonTable.ItemCastable["English_Item_Name"] = function()
	local z = {}
	z.ItemID = ItemID--[[English_Item_Name]]   --this is for defining the correct name of the item
	z.DebuffSlotNeeded = 1   --use this if you want to make sure that a debuff slot is free on the target so that you do not replace other debuffs
	z.Debuff = GlobalSpellID   --place debuff name or table of names here if the item has a debuff that may only be on a target once in total from everyone and has a cooldown shorter than the debuff duration
	z.MyDebuff = GlobalSpellID   --place debuff name or table of names here if the item has a debuff that may be on the target multiple times by many people and has a cooldown shorter than the debuff duration
	z.Buff = GlobalSpellID   --place buff name or table of names here if the item has a buff that may only be on yourself once in total from everyone and has a cooldown shorter than the buff duration
	z.MyBuff = GlobalSpellID   --place buff name or table of names here if the item has a buff that may be on the target multiple times by many people and has a cooldown shorter than the buff duration
	z.BuffUnit = "player"   --you will need to use this if the buff or debuff is not applied to your target
	z.CastTime = 0   --use this if the item has a cast time for indication of a buff or debuff early
	z.EnemyTargetNeeded = 1   --use this if the item should have an enemy targeted
	z.TargetThatUsesManaNeeded = 1   --use this if the item is only useful on a target that uses mana such as mana draining items
	z.NoRangeCheck = 1   --use this to disable range detection if the item has a limited range but the detection in this function is not working correctly for the particular item
	z.NotIfActive = 1   --use this if the item may be toggled on such as auto attack or on next swing spells, or to disable when casting or channeling, or if the item has a cooldown
	z.NotWhileMoving = 1   --use this if the item is not able to be used while moving
	z.EvenIfNotUsable = 1   --use this to disable the usability checking in this function and may be used if currently in the process of completing a prerequisite that will make the item usable
	z.Unit = "target"   --this should not be used unless the item is not to be cast on the target
	return s.CheckIfItemCastable(z)
end

-- Example function:
AddonTable.VehicleCastable["English_Spell_Name"] = function()
	local z = {}
	z.SpellID = GlobalSpellID--[[English_Spell_Name]]   --this is for defining the correct name of the spell
	z.DebuffSlotNeeded = 1   --use this if you want to make sure that a debuff slot is free on the target so that you do not replace other debuffs
	z.Debuff = z.SpellID   --place debuff name or table of names here if the spell has a debuff that may only be on a target once in total from everyone and has a cooldown shorter than the debuff duration
	z.MyDebuff = z.SpellID   --place debuff name or table of names here if the spell has a debuff that may be on the target multiple times by many people and has a cooldown shorter than the debuff duration
	z.Buff = z.SpellID   --place buff name or table of names here if the spell has a buff that may only be on yourself once in total from everyone and has a cooldown shorter than the buff duration
	z.MyBuff = z.SpellID   --place buff name or table of names here if the spell has a buff that may be on the target multiple times by many people and has a cooldown shorter than the buff duration
	z.BuffUnit = "vehicle"   --you will need to use this if the buff or debuff is not applied to your target
	z.CastTime = 0   --use this if the spell has a cast time for indication of a buff or debuff early
	z.EnemyTargetNeeded = 1   --use this if the spell should have an enemy targeted
	z.TargetThatUsesManaNeeded = 1   --use this if the spell is only useful on a target that uses mana such as mana draining spells
	z.NoRangeCheck = 1   --use this to disable range detection if the spell has a limited range but the detection in this function is not working correctly for the particular spell
	z.NotIfActive = 1   --use this if the spell may be toggled on such as auto attack or on next swing spells, or to disable when casting or channeling, or if the spell has a cooldown
	z.NotWhileMoving = 1   --use this if the spell is not able to be cast while moving
	z.EvenIfNotUsable = 1   --use this to disable the usability checking in this function and may be used if currently in the process of completing a prerequisite that will make the spell usable
	z.GlobalVehicleCooldownSpell = GlobalSpellID--[[English_Spell_Name]]   -- use this if spell has more than a global cooldown
	z.Unit = "target"   --this should not be used unless the spell is not to be cast on the target
	return s.CheckIfVehicleSpellCastable(z)
end



AddonTable.Castable["Auto Attack"] = function()
	local z = {}
	z.SpellID = 6603--[[Auto Attack]]
	z.EnemyTargetNeeded = 1
	z.NotIfActive = 1
	return s.MeleeDistance() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shoot"] = function()
	local z = {}
	z.SpellID = 3018--[[Shoot]]
	z.EnemyTargetNeeded = 1
	z.NotIfActive = 1
	return not s.Shooting() and s.CheckIfSpellCastable(z)
end


s.RegisterOtherAurasFunction(function()
	if s.HasTalent(17793--[[Shadow and Flame]]) then
		s.SetOtherAuras(686--[[Shadow Bolt]], 17800--[[Shadow Mastery]])
	end
	if s.HasTalent(32385--[[Shadow Embrace]]) then
		s.SetOtherAuras(686--[[Shadow Bolt]], 32385--[[Shadow Embrace]])
		s.SetOtherAuras(48181--[[Haunt]], 32385--[[Shadow Embrace]])
	end
end)

local function OnEvent(self, event, ...)
	local arg = {...}
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		if arg[2] == "SPELL_CAST_SUCCESS" and arg[3] == UnitGUID("player") and arg[10] == s.SpellName(86121--[[Soul Swap]]) then
			AddonTable.LastSoulSwap = arg[6]
		end
	end
end
local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
EventFrame:SetScript("OnEvent", OnEvent)


function AddonTable.CursePushed(unit)
	return s.SpellOrAuraDelay({
		1490--[[Curse of the Elements]],
		1714--[[Curse of Tongues]],
		702--[[Curse of Weakness]],
		18223--[[Curse of Exhaustion]],
	}, unit)
	or s.CurrentSpell(1490--[[Curse of the Elements]])
	or s.CurrentSpell(1714--[[Curse of Tongues]])
	or s.CurrentSpell(702--[[Curse of Weakness]])
	or s.CurrentSpell(18223--[[Curse of Exhaustion]])
end

function AddonTable.BanePushed(unit)
	return s.SpellOrAuraDelay({
		980--[[Bane of Agony]],
		603--[[Bane of Doom]],
		80240--[[Bane of Havoc]],
	}, unit)
	or s.CurrentSpell(980--[[Bane of Agony]])
	or s.CurrentSpell(603--[[Bane of Doom]])
	or s.CurrentSpell(80240--[[Bane of Havoc]])
end


AddonTable.ItemCastable["Healthstone"] = function()
	local z = {}
	z.ItemName = 5512--[[Healthstone]]
	return ( x.ActiveEnemy or s.InCombat() ) and s.HealthPercent("player") <= 35 and s.CheckIfItemCastable(z)
end

AddonTable.ItemCastable["Soulstone"] = function()
	local z = {}
	z.ItemName = 5232--[[Soulstone]]
	z.CastTime = s.CastTime(20707--[[Soulstone Resurrection]])
	z.NoRangeCheck = 1
	z.NotIfActive = 1
	--z.NotWhileMoving = 1
	if not IsMounted() and ( not IsResting() or s.InCombat() or s.Enemy("target") or s.Enemy("focus") ) and s.CheckIfItemCastable(z) then
		if x.InstanceType == "arena" then
			return not s.Buff(20707--[[Soulstone Resurrection]], "raid|range", z.CastTime + x.DoubleLag + 20)
		elseif x.InstanceType ~= "pvp" and ( GetNumRaidMembers() > 1 or GetNumPartyMembers() > 0 ) and s.Healer("raid|afk|notself") then
			return not s.Buff(20707--[[Soulstone Resurrection]], "raid|healer|afk|notself", z.CastTime + x.DoubleLag + 20)
		end
		return not s.Buff(20707--[[Soulstone Resurrection]], "player", z.CastTime + x.DoubleLag + 20)
	end
	return false
end

AddonTable.Castable["Metamorphosis"] = function()
	local z = {}
	z.SpellID = 47241--[[Metamorphosis]]
	z.EnemyTargetNeeded = 1
	return not IsMounted() and ( s.InCombat() or s.Enemy("target") or s.Enemy("focus") ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Demon Leap"] = function()
	local z = {}
	z.SpellID = 54785--[[Demon Leap]]
	z.EnemyTargetNeeded = 1
	return not CheckInteractDistance("target", 3) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Immolation Aura"] = function()
	local z = {}
	z.SpellID = 50589--[[Immolation Aura]]
	z.EnemyTargetNeeded = 1
	return s.MeleeDistance() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shadow Ward"] = function()
	local z = {}
	z.SpellID = 6229--[[Shadow Ward]]
	z.EnemyTargetNeeded = 1
	return not IsMounted() and ( s.InCombat() or s.Enemy("target") or s.Enemy("focus") ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Summon Imp"] = function()
	local z = {}
	z.SpellID = 688--[[Summon Imp]]
	--z.NotWhileMoving = not s.Buff(74434--[[Soulburn]], "player")
	return not x.PetAlive and HasFullControl() and not IsMounted() and not UnitOnTaxi("player") and not UnitInVehicle("player") and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Summon Succubus"] = function()
	local z = {}
	z.SpellID = 712--[[Summon Succubus]]
	--z.NotWhileMoving = not s.Buff(74434--[[Soulburn]], "player")
	return not x.PetAlive and HasFullControl() and not IsMounted() and not UnitOnTaxi("player") and not UnitInVehicle("player") and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Summon Voidwalker"] = function()
	local z = {}
	z.SpellID = 697--[[Summon Voidwalker]]
	--z.NotWhileMoving = not s.Buff(74434--[[Soulburn]], "player")
	return not x.PetAlive and HasFullControl() and not IsMounted() and not UnitOnTaxi("player") and not UnitInVehicle("player") and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Summon Felhunter"] = function()
	local z = {}
	z.SpellID = 691--[[Summon Felhunter]]
	--z.NotWhileMoving = not s.Buff(74434--[[Soulburn]], "player")
	return not x.PetAlive and HasFullControl() and not IsMounted() and not UnitOnTaxi("player") and not UnitInVehicle("player") and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Summon Felguard"] = function()
	local z = {}
	z.SpellID = 30146--[[Summon Felguard]]
	--z.NotWhileMoving = not s.Buff(74434--[[Soulburn]], "player")
	return not x.PetAlive and HasFullControl() and not IsMounted() and not UnitOnTaxi("player") and not UnitInVehicle("player") and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Soul Link"] = function()
	local z = {}
	z.SpellID = 19028--[[Soul Link]]
	z.Buff = z.SpellID
	z.BuffUnit = "pet"
	z.NoRangeCheck = 1
	return x.PetAlive and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Demonic Empowerment"] = function()
	local z = {}
	z.SpellID = 47193--[[Demonic Empowerment]]
	return UnitExists("pettarget") and not s.Debuff(1098--[[Enslave Demon]], "pet") and ( s.HealthPercent("pettarget") > 25 or UnitIsPlayer("pettarget") or s.Boss("pettarget") ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Demon Soul"] = function()
	local z = {}
	z.SpellID = 77801--[[Demon Soul]]
	z.EnemyTargetNeeded = 1
	return x.PetAlive and not s.Debuff(1098--[[Enslave Demon]], "pet") and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Summon Doomguard"] = function()
	local z = {}
	z.SpellID = 18540--[[Summon Doomguard]]
	z.EnemyTargetNeeded = 1
	return s.MyDebuff({980--[[Bane of Agony]],603--[[Bane of Doom]],80240--[[Bane of Havoc]]}) and ( s.HealthPercent() > 25 or UnitIsPlayer("target") or s.Boss() ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Summon Infernal"] = function()
	local z = {}
	z.SpellID = 1122--[[Summon Infernal]]
	z.EnemyTargetNeeded = 1
	z.NoRangeCheck = 1
	z.NotWhileMoving = 1
	return s.MyDebuff({980--[[Bane of Agony]],603--[[Bane of Doom]],80240--[[Bane of Havoc]]}) and ( s.HealthPercent() > 25 or UnitIsPlayer("target") or s.Boss() ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Bane of Agony"] = function()
	local z = {}
	z.SpellID = 980--[[Bane of Agony]]
	z.DebuffSlotNeeded = 1
	z.MyDebuff = {
		z.SpellID,
		603--[[Bane of Doom]],
		80240--[[Bane of Havoc]],
	}
	z.EnemyTargetNeeded = 1
	return not s.Buff(86121--[[Soul Swap]], "player") and not AddonTable.BanePushed() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Bane of Doom"] = function()
	local z = {}
	z.SpellID = 603--[[Bane of Doom]]
	z.DebuffSlotNeeded = 1
	z.MyDebuff = {
		z.SpellID,
		980--[[Bane of Agony]],
		80240--[[Bane of Havoc]],
	}
	z.EnemyTargetNeeded = 1
	return not s.Buff(86121--[[Soul Swap]], "player") and s.HealthPercent() > 25 and s.Boss() and not AddonTable.BanePushed() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Bane of Havoc"] = function()
	local z = {}
	z.SpellID = 80240--[[Bane of Havoc]]
	z.DebuffSlotNeeded = 1
	z.MyDebuff = {
		z.SpellID,
		980--[[Bane of Agony]],
		603--[[Bane of Doom]],
	}
	z.EnemyTargetNeeded = 1
	return not AddonTable.BanePushed() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Curse of the Elements"] = function()
	local z = {}
	z.SpellID = 1490--[[Curse of the Elements]]
	z.Debuff = {
		z.SpellID,
		85547--[[Jinx: Curse of the Elements]],
	}
	z.MyDebuff = {
		702--[[Curse of Weakness]],
		1714--[[Curse of Tongues]],
		18223--[[Curse of Exhaustion]],
	}
	z.EnemyTargetNeeded = 1
	return not AddonTable.CursePushed() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Curse of Tongues"] = function()
	local z = {}
	z.SpellID = 1714--[[Curse of Tongues]]
	z.Debuff = z.SpellID
	z.MyDebuff = {
		85547--[[Jinx: Curse of the Elements]],
		1490--[[Curse of the Elements]],
		702--[[Curse of Weakness]],
		18223--[[Curse of Exhaustion]],
	}
	z.EnemyTargetNeeded = 1
	return not AddonTable.CursePushed() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Curse of Weakness"] = function()
	local z = {}
	z.SpellID = 702--[[Curse of Weakness]]
	z.Debuff = {
		z.SpellID,
		1160--[[Demoralizing Shout]],
		99--[[Demoralizing Roar]],
		24423--[[Demoralizing Screech]],
		26016--[[Vindication]],
	}
	z.MyDebuff = {
		85547--[[Jinx: Curse of the Elements]],
		1490--[[Curse of the Elements]],
		1714--[[Curse of Tongues]],
		18223--[[Curse of Exhaustion]],
	}
	z.EnemyTargetNeeded = 1
	return not AddonTable.CursePushed() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Curse of Exhaustion"] = function()
	local z = {}
	z.SpellID = 18223--[[Curse of Exhaustion]]
	z.Debuff = z.SpellID
	z.MyDebuff = {
		85547--[[Jinx: Curse of the Elements]],
		1490--[[Curse of the Elements]],
		702--[[Curse of Weakness]],
		1714--[[Curse of Tongues]],
	}
	z.EnemyTargetNeeded = 1
	return UnitIsPlayer("target") and not AddonTable.CursePushed() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Immolate"] = function()
	local z = {}
	z.SpellID = 348--[[Immolate]]
	z.DebuffSlotNeeded = 1
	z.MyDebuff = {
		z.SpellID,
		30108--[[Unstable Affliction]],
	}
	z.EnemyTargetNeeded = 1
	z.NotWhileMoving = 1
	return not s.Buff(86121--[[Soul Swap]], "player") and not s.SpellOrAuraDelay(30108--[[Unstable Affliction]]) and not s.CurrentSpell(30108--[[Unstable Affliction]]) and not s.Casting(30108--[[Unstable Affliction]], "player") and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Unstable Affliction"] = function()
	local z = {}
	z.SpellID = 30108--[[Unstable Affliction]]
	z.DebuffSlotNeeded = 1
	z.MyDebuff = {
		z.SpellID,
		348--[[Immolate]],
	}
	z.EnemyTargetNeeded = 1
	z.NotWhileMoving = 1
	return not s.Buff(86121--[[Soul Swap]], "player") and not s.SpellOrAuraDelay(348--[[Immolate]]) and not s.CurrentSpell(348--[[Immolate]]) and not s.Casting(348--[[Immolate]], "player") and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Corruption"] = function()
	local z = {}
	z.SpellID = 172--[[Corruption]]
	z.DebuffSlotNeeded = 1
	z.MyDebuff = {
		z.SpellID,
		27243--[[Seed of Corruption]],
	}
	z.EnemyTargetNeeded = 1
	return not s.Buff(86121--[[Soul Swap]], "player") and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Seed of Corruption"] = function()
	local z = {}
	z.SpellID = 27243--[[Seed of Corruption]]
	z.MyDebuff = {
		z.SpellID,
		172--[[Corruption]],
	}
	z.EnemyTargetNeeded = 1
	z.NotWhileMoving = 1
	return not s.Buff(86121--[[Soul Swap]], "player") and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Create Healthstone"] = function()
	local z = {}
	z.SpellID = 6201--[[Create Healthstone]]
	z.NotIfActive = 1
	--z.NotWhileMoving = 1
	return GetItemCount(5512--[[Healthstone]], true) == 0 and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Dark Intent"] = function()
	local z = {}
	z.SpellID = 80398--[[Dark Intent]]
	z.MyBuff = z.SpellID
	z.BuffUnit = "player"
	return not IsMounted() and ( not IsResting() or s.InCombat() or s.Enemy("target") or s.Enemy("focus") ) and ( GetNumRaidMembers() > 1 or GetNumPartyMembers() > 0 ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Death Coil"] = function()
	local z = {}
	z.SpellID = 6789--[[Death Coil]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Demon Armor"] = function()
	local z = {}
	z.SpellID = 687--[[Demon Armor]]
	z.Buff = {
		z.SpellID,
		28176--[[Fel Armor]],
	}
	z.BuffUnit = "player"
	return not IsMounted() and ( not IsResting() or s.InCombat() or s.Enemy("target") or s.Enemy("focus") ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Fel Armor"] = function()
	local z = {}
	z.SpellID = 28176--[[Fel Armor]]
	z.Buff = {
		z.SpellID,
		687--[[Demon Armor]],
	}
	z.BuffUnit = "player"
	return not IsMounted() and ( not IsResting() or s.InCombat() or s.Enemy("target") or s.Enemy("focus") ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Demonic Circle: Teleport"] = function()
	local z = {}
	z.SpellID = 48020--[[Demonic Circle: Teleport]]
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Demonic Circle: Summon"] = function()
	local z = {}
	z.SpellID = 48018--[[Demonic Circle: Summon]]
	z.NotWhileMoving = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Drain Life"] = function()
	local z = {}
	z.SpellID = 689--[[Drain Life]]
	z.EnemyTargetNeeded = 1
	z.NotWhileMoving = 1
	return s.HealthPercent("player") <= 70 and ( not s.MeleeDistance("target") or not s.EnemyTargetingYou("target") ) and ( not s.MeleeDistance("focus") or not s.EnemyTargetingYou("focus") ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Drain Mana"] = function()
	local z = {}
	z.SpellID = 5138--[[Drain Mana]]
	z.EnemyTargetNeeded = 1
	z.TargetThatUsesManaNeeded = 1
	z.NotWhileMoving = 1
	return s.HasMana("target") and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Drain Soul"] = function()
	local z = {}
	z.SpellID = 1120--[[Drain Soul]]
	z.EnemyTargetNeeded = 1
	z.NotWhileMoving = 1
	return s.HealthPercent() <= 25 and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Health Funnel"] = function()
	local z = {}
	z.SpellID = 755--[[Health Funnel]]
	z.NoRangeCheck = 1
	z.NotIfActive = 1
	--z.NotWhileMoving = 1
	return x.PetAlive and s.HealthPercent("pet") <= 90 and s.HealthPercent("player") >= 10 and not s.CastingOrChanneling(17767--[[Consume Shadows]], "pet") and ( not s.InCombat() or s.HealthPercent("pet") <= 70 ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Incinerate"] = function()
	local z = {}
	z.SpellID = 29722--[[Incinerate]]
	z.EnemyTargetNeeded = 1
	z.NotWhileMoving = 1
	return ( s.Buff(47245--[[Molten Core]], "player") or s.SpellOrAuraDelay(348--[[Immolate]]) or s.CurrentSpell(348--[[Immolate]]) or s.Casting(348--[[Immolate]], "player") or s.Debuff(348--[[Immolate]]) ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Life Tap"] = function()
	if IsMounted() or s.PowerPercent("player") > 90 then
		return false
	elseif s.Enemy("target") or s.Enemy("focus") or s.InCombat() or not s.HasSpell(79268--[[Soul Harvest]]) or s.SpellCooldown(79268--[[Soul Harvest]]) > s.SpellCooldown(1454--[[Life Tap]]) then
		if s.PowerPercent("player") >= 90
		or ( ( s.EnemyTargetingYou("target") or s.EnemyTargetingYou("focus") ) and s.InCombat() )
		or not ( ( s.PowerPercent("player") >= 80 and s.HealthPercent("player") >= 98 ) or ( s.PowerPercent("player") < 80 and s.HealthPercent("player") >= 95 ) ) then
			return false
		end
	elseif s.HealthPercent("player") < 30 then
		return false
	end
	local z = {}
	z.SpellID = 1454--[[Life Tap]]
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Searing Pain"] = function()
	local z = {}
	z.SpellID = 5676--[[Searing Pain]]
	z.EnemyTargetNeeded = 1
	z.NotWhileMoving = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shadow Bolt"] = function()
	local z = {}
	z.SpellID = 686--[[Shadow Bolt]]
	z.EnemyTargetNeeded = 1
	z.NotWhileMoving = not s.Buff(17941--[[Shadow Trance]], "player")
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shadowflame"] = function()
	local z = {}
	z.SpellID = 47897--[[Shadowflame]]
	z.EnemyTargetNeeded = 1
	return not s.Buff(86121--[[Soul Swap]], "player") and s.MeleeDistance() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Soul Fire"] = function()
	local z = {}
	z.SpellID = 6353--[[Soul Fire]]
	z.EnemyTargetNeeded = 1
	z.NotWhileMoving = not s.Buff(74434--[[Soulburn]], "player")
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Soul Harvest"] = function()
	local z = {}
	z.SpellID = 79268--[[Soul Harvest]]
	--z.NotWhileMoving = 1
	return not IsMounted() and ( s.HealthPercent("player") <= 90 or s.PowerPercent("player", SPELL_POWER_SOUL_SHARDS) < 100 ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Soulburn"] = function()
	local z = {}
	z.SpellID = 74434--[[Soulburn]]
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Soulshatter"] = function()
	local z = {}
	z.SpellID = 29858--[[Soulshatter]]
	z.EnemyTargetNeeded = 1
	return x.ThreatPercent >= 90 and not UnitPlayerControlled("target") and s.SpellInRange(686--[[Shadow Bolt]]) and ( GetNumRaidMembers() > 1 or GetNumPartyMembers() > 0 or ( s.SameTargetAsPet() and ( s.HasSpell(3716--[[Torment]]) or s.HasSpell(30213--[[Legion Strike]]) ) ) ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Conflagrate"] = function()
	local z = {}
	z.SpellID = 17962--[[Conflagrate]]
	z.EvenIfNotUsable = s.SpellOrAuraDelay(348--[[Immolate]]) or s.CurrentSpell(348--[[Immolate]]) or s.Casting(348--[[Immolate]], "player") or s.MyDebuff(348--[[Immolate]])
	return z.EvenIfNotUsable and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Unending Breath"] = function()
	local z = {}
	z.SpellID = 5697--[[Unending Breath]]
	z.Buff = z.SpellID
	z.BuffUnit = "player"
	return ( GetMirrorTimerProgress("BREATH") > 0 or ( IsSwimming() and s.HasGlyph(58336--[[Glyph of Unending Breath]]) ) ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Create Soulstone"] = function()
	local z = {}
	z.SpellID = 693--[[Create Soulstone]]
	z.NotIfActive = 1
	--z.NotWhileMoving = 1
	return GetItemCount(5232--[[Soulstone]], true) == 0 and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Chaos Bolt"] = function()
	local z = {}
	z.SpellID = 50796--[[Chaos Bolt]]
	z.EnemyTargetNeeded = 1
	z.NotWhileMoving = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Haunt"] = function()
	local z = {}
	z.SpellID = 48181--[[Haunt]]
	z.EnemyTargetNeeded = 1
	z.NotIfActive = 1
	z.NotWhileMoving = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shadowburn"] = function()
	local z = {}
	z.SpellID = 17877--[[Shadowburn]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Fel Flame"] = function()
	local z = {}
	z.SpellID = 77799--[[Fel Flame]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shadowfury"] = function()
	local z = {}
	z.SpellID = 30283--[[Shadowfury]]
	z.EnemyTargetNeeded = 1
	z.NoRangeCheck = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Hand of Gul'dan"] = function()
	local z = {}
	z.SpellID = 71521--[[Hand of Gul'dan]]
	z.EnemyTargetNeeded = 1
	z.NotWhileMoving = 1
	return s.SameTargetAsPet() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Soul Swap"] = function()
	if s.Buff(86121--[[Soul Swap]], "player") then
		if UnitGUID("target") == AddonTable.LastSoulSwap then
			return false
		end
	elseif s.HealthPercent() > 25 or s.Boss() or not s.MyDebuff({
		980--[[Bane of Agony]],
		603--[[Bane of Doom]],
		348--[[Immolate]],
		30108--[[Unstable Affliction]],
		172--[[Corruption]],
		27243--[[Seed of Corruption]],
		47897--[[Shadowflame]],
	}) then
		return false
	end
	local z = {}
	z.SpellID = 86121--[[Soul Swap]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Banish"] = function()
	local z = {}
	z.SpellID = 710--[[Banish]]
	if UnitExists("focus") and not s.Boss("focus") then
		z.Unit = "focus"
	end
	--z.NotWhileMoving = 1
	z.EnemyTargetNeeded = 1
	local seconds = s.CastTime(z.SpellID) + s.SpellCooldown(z.SpellID) + x.DoubleLag
	return not s.Boss(z.Unit) and s.CheckIfSpellCastable(z) and not s.ImmunityDebuff(z.Unit, seconds) and not s.BreakOnDamageCC(z.Unit, seconds + 5)
end

