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
	z.Unit = "player"   --you may add and change this as needed if the spell is not to be cast on the target
	z.CastTime = s.CastTime(z.SpellID)   --use this only if you want to replace the spell cast time used for early indication of a buff or debuff
	z.EnemyTargetNeeded = 1   --use this if the spell should have an enemy targeted
	z.TargetThatUsesManaNeeded = 1   --use this if the spell is only useful on a target that uses mana such as mana draining spells
	z.NoRangeCheck = 1   --use this to disable range detection if the spell has a limited range but the detection in this function is not working correctly for the particular spell
	z.NotIfActive = 1   --use this if the spell may be toggled on such as auto attack or on next swing spells, or to disable when casting or channeling, or if the spell has a cooldown
	z.NotWhileMoving = 1   --use this if the spell is not able to be cast while moving
	z.EvenIfNotUsable = 1   --use this to disable the usability checking in this function and may be used if currently in the process of completing a prerequisite that will make the spell usable
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
	z.Unit = "player"   --you may add and change this as needed if the item is not to be cast on the target
	z.CastTime = 0   --use this if the item has a cast time for indication of a buff or debuff early
	z.EnemyTargetNeeded = 1   --use this if the item should have an enemy targeted
	z.TargetThatUsesManaNeeded = 1   --use this if the item is only useful on a target that uses mana such as mana draining items
	z.NoRangeCheck = 1   --use this to disable range detection if the item has a limited range but the detection in this function is not working correctly for the particular item
	z.NotIfActive = 1   --use this if the item may be toggled on such as auto attack or on next swing spells, or to disable when casting or channeling, or if the item has a cooldown
	z.NotWhileMoving = 1   --use this if the item is not able to be used while moving
	z.EvenIfNotUsable = 1   --use this to disable the usability checking in this function and may be used if currently in the process of completing a prerequisite that will make the item usable
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
	z.Unit = "vehicle"   --you may add and change this as needed if the spell is not to be cast on the target
	z.CastTime = 0   --use this if the spell has a cast time for indication of a buff or debuff early
	z.EnemyTargetNeeded = 1   --use this if the spell should have an enemy targeted
	z.TargetThatUsesManaNeeded = 1   --use this if the spell is only useful on a target that uses mana such as mana draining spells
	z.NoRangeCheck = 1   --use this to disable range detection if the spell has a limited range but the detection in this function is not working correctly for the particular spell
	z.NotIfActive = 1   --use this if the spell may be toggled on such as auto attack or on next swing spells, or to disable when casting or channeling, or if the spell has a cooldown
	z.NotWhileMoving = 1   --use this if the spell is not able to be cast while moving
	z.EvenIfNotUsable = 1   --use this to disable the usability checking in this function and may be used if currently in the process of completing a prerequisite that will make the spell usable
	z.GlobalVehicleCooldownSpell = GlobalSpellID--[[English_Spell_Name]]   -- use this if spell has more than a global cooldown
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



AddonTable.Castable["Every Man for Himself"] = function()
	local z = {}
	z.SpellID = 59752--[[Every Man for Himself]]
	return ( s.CrowedControlled("player") or s.MovementImpaired("player") ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Will of the Forsaken"] = function()
	local z = {}
	z.SpellID = 7744--[[Will of the Forsaken]]
	return s.CrowedControlled("player") and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Stoneform"] = function()
	local z = {}
	z.SpellID = 20594--[[Stoneform]]
	return ( s.Diseased("player") or s.Poisoned("player") ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Arcane Torrent"] = function()
	local z = {}
	z.SpellID = 28730--[[Arcane Torrent]]
	z.EnemyTargetNeeded = 1
	return s.GetCastingOrChanneling(nil, nil, 1) > (s.SpellCooldown(28730--[[Arcane Torrent]]) + x.DoubleLag) and s.MeleeDistance() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Berserking"] = function()
	local z = {}
	z.SpellID = 26297--[[Berserking]]
	z.EnemyTargetNeeded = 1
	return x.ActiveEnemy and s.InCombat() and ( s.HealthPercent() > 25 or UnitIsPlayer("target") or s.Boss() ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Blood Fury"] = function()
	local z = {}
	z.SpellID = 20572--[[Blood Fury]]
	z.EnemyTargetNeeded = 1
	return x.ActiveEnemy and s.InCombat() and ( s.HealthPercent() > 25 or UnitIsPlayer("target") or s.Boss() ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Escape Artist"] = function()
	local z = {}
	z.SpellID = 20589--[[Escape Artist]]
	return s.MovementImpaired("player") and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["War Stomp"] = function()
	local z = {}
	z.SpellID = 20549--[[War Stomp]]
	z.EnemyTargetNeeded = 1
	local CastTime = s.SpellCooldown(20549--[[War Stomp]]) + ( s.Casting(20549--[[War Stomp]], "player") or s.CastTime(20549--[[War Stomp]]) ) + x.DoubleLag
	return s.MeleeDistance() and ( s.GetCasting(nil, nil, 1) > CastTime or s.GetChanneling(nil, nil, 1) > (CastTime + 5) ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Rocket Barrage"] = function()
	local z = {}
	z.SpellID = 69041--[[Rocket Barrage]]
	z.EnemyTargetNeeded = 1
	return ( s.HealthPercent() > 25 or UnitIsPlayer("target") or s.Boss() ) and s.CheckIfSpellCastable(z)
end

