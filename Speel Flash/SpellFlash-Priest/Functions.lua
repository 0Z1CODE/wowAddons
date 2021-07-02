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



--Buffs
AddonTable.Castable["Power Word: Fortitude"] = function()
	local z = {}
	z.SpellID = 21562--[[Power Word: Fortitude]]
	z.Buff = {
		21562--[[Power Word: Fortitude]],
		6307--[[Blood Pact]],
	}
	z.BuffUnit = "player"
	return not IsMounted() and ( not IsResting() or s.InCombat() or s.Enemy("target") or s.Enemy("focus") ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shadow Protection"] = function()
	local z = {}
	z.SpellID = 27683--[[Shadow Protection]]
	z.Buff = z.SpellID
	z.BuffUnit = "player"
	return not IsMounted() and ( not IsResting() or s.InCombat() or s.Enemy("target") or s.Enemy("focus") ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Inner Fire"] = function()
	local z = {}
	z.SpellID = 588--[[Inner Fire]]
	z.Buff = {
		588--[[Inner Fire]],
		73413--[[Inner Will]],
	}
	z.BuffUnit = "player"
	return not IsMounted() and ( not IsResting() or s.InCombat() or s.Enemy("target") or s.Enemy("focus") ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Inner Will"] = function()
	local z = {}
	z.SpellID = 73413--[[Inner Will]]
	z.Buff = {
		73413--[[Inner Will]],
		588--[[Inner Fire]],
	}
	z.BuffUnit = "player"
	return not IsMounted() and ( not IsResting() or s.InCombat() or s.Enemy("target") or s.Enemy("focus") ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Vampiric Embrace"] = function()
	local z = {}
	z.SpellID = 15286--[[Vampiric Embrace]]
	z.Buff = z.SpellID
	z.BuffUnit = "player"
	return not IsMounted() and ( not IsResting() or s.InCombat() or s.Enemy("target") or s.Enemy("focus") ) and s.CheckIfSpellCastable(z)
end

--General Spells

AddonTable.Castable["Power Word: Shield"] = function()
	local z = {}
	z.SpellID = 17--[[Power Word: Shield]]
	z.Buff = z.SpellID
	z.BuffUnit = "player"
	return not IsMounted() and ( not IsResting() or s.InCombat() or s.Enemy("target") or s.Enemy("focus") ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shadowfiend"] = function()
	local z = {}
	z.SpellID = 34433--[[Shadowfiend]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Dispersion"] = function()
	local z = {}
	z.SpellID = 47585--[[Dispersion]]
	z.NoRangeCheck = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Fade"] = function()
	local z = {}
	z.SpellID = 586--[[Fade]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

--Shadow Spells

AddonTable.Castable["Shadowform"] = function()
	local z = {}
	z.SpellID = 15473--[[Shadowform]]
	if s.Form(z.SpellID) then
		return false
	end
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Vampiric Touch"] = function(EarlyRefreshSeconds)
	local z = {}
	z.SpellID = 34914--[[Vampiric Touch]]
	z.MyDebuff = z.SpellID
	z.CastTime = s.CastTime(z.SpellID) + (EarlyRefreshSeconds or 3)
	z.NotWhileMoving = 1
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Mind Sear"] = function()
	local z = {}
	z.SpellID = 53023--[[Mind Sear]]
	z.MyDebuff = z.SpellID
	z.NotWhileMoving = 1
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Devouring Plague"] = function(EarlyRefreshSeconds)
	local z = {}
	z.SpellID = 2944--[[Devouring Plague]]
	z.MyDebuff = z.SpellID
	z.CastTime = s.CastTime(z.SpellID) + (EarlyRefreshSeconds or 3)
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Mind Spike"] = function()
	local z = {}
	z.SpellID = 73510--[[Mind Spike]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shackle Undead"] = function()
	local z = {}
	z.SpellID = 9484--[[Shackle Undead]]
	if UnitExists("focus") and not s.Boss("focus") and ( not s.Debuff(nil, "focus") or s.NoDamageCC("focus") ) then
		z.Unit = "focus"
	end
	--z.NotWhileMoving = 1
	z.EnemyTargetNeeded = 1
	local seconds = s.CastTime(z.SpellID) + s.SpellCooldown(z.SpellID) + x.DoubleLag
	return not s.Boss(z.Unit) and s.CheckIfSpellCastable(z) and ( not s.Debuff(nil, z.Unit) or ( s.NoDamageCC(z.Unit) and not s.ImmunityDebuff(z.Unit, seconds) and not s.BreakOnDamageCC(z.Unit, seconds + 5) ) )
end

AddonTable.Castable["Shadow Word: Pain"] = function(EarlyRefreshSeconds)
	local z = {}
	z.SpellID = 589--[[Shadow Word: Pain]]
	z.MyDebuff = z.SpellID
	z.CastTime = s.CastTime(z.SpellID) + (EarlyRefreshSeconds or 3)
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shadow Word: Death"] = function()
	local z = {}
	z.SpellID = 32379--[[Shadow Word: Death]]
	z.MyDebuff = z.SpellID
	if s.HealthPercent("target") >= 25 then
		return false
	end
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Mind Blast"] = function()
	local z = {}
	z.SpellID = 8092--[[Mind Blast]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Mind Flay"] = function()
	local z = {}
	z.SpellID = 15407--[[Mind Flay]]
	z.MyDebuff = z.SpellID
	z.NotWhileMoving = 1
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

--Healing Abilities

AddonTable.Castable["Desperate Prayer"] = function()
	local z = {}
	z.SpellID = 19236--[[Desperate Prayer]]
	z.NoRangeCheck = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Guardian Spirit"] = function()
	local z = {}
	z.SpellID = 47788--[[Guardian Spirit]]
	z.Buff = z.SpellID
	z.BuffUnit = "player"
	return not IsMounted() and ( not IsResting() or s.InCombat() or s.Enemy("target") or s.Enemy("focus") ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Divine Hymn"] = function()
	local z = {}
	z.SpellID = 64843--[[Divine Hymn]]
	z.NotWhileMoving = 1
	z.NoRangeCheck = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Prayer of Mending"] = function()
	local z = {}
	z.SpellID = 33076--[[Prayer of Mending]]
	z.NoRangeCheck = 1
	return s.CheckIfSpellCastable(z)
end