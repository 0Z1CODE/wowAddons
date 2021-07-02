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




function AddonTable.IsArmorActive()
	return s.Buff({
		30482--[[Molten Armor]],
		7302--[[Frost Armor]],
		6117--[[Mage Armor]],
	}, "player")
end

function AddonTable.IsIntelActive()
	return s.Buff({
		23028--[[Arcane Brilliance]],
		1459--[[Arcane Intellect]],
	}, "player")
end

--Mage Functions
--Buffs
AddonTable.Castable["Molten Armor"] = function()
	local z = {}
	z.SpellID = 30482--[[Molten Armor]]
	z.Buff = {
		30482--[[Molten Armor]],
		7302--[[Frost Armor]],
		6117--[[Mage Armor]],
	}
	z.BuffUnit = "player"
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Frost Armor"] = function()
	local z = {}
	z.SpellID = 7302--[[Frost Armor]]
	z.Buff = {
		30482--[[Molten Armor]],
		7302--[[Frost Armor]],
		6117--[[Mage Armor]],
	}
	z.BuffUnit = "player"
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Mage Armor"] = function()
	local z = {}
	z.SpellID = 6117--[[Mage Armor]]
	z.Buff = {
		30482--[[Molten Armor]],
		7302--[[Frost Armor]],
		6117--[[Mage Armor]],
	}
	z.BuffUnit = "player"
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Arcane Brilliance"] = function()
	local z = {}
	z.SpellID = 23028--[[Arcane Brilliance]]
	z.Buff = {
		23028--[[Arcane Brilliance]],
		1459--[[Arcane Intellect]],
	}
	z.BuffUnit = "player"
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Arcane Intellect"] = function()
	local z = {}
	z.SpellID = 1459--[[Arcane Intellect]]
	z.Buff = {
		23028--[[Arcane Brilliance]],
		1459--[[Arcane Intellect]],
	}
	z.BuffUnit = "player"
	return s.CheckIfSpellCastable(z)
end

--General

AddonTable.Castable["Ice Block"] = function()
	if not s.MeleeDistance() then
		return false
	end
	local z = {}
	z.SpellID = 45438--[[Ice Block]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Mage ward"] = function()
	local z = {}
	z.SpellID = 543--[[Mage ward]]
	z.Buff = z.SpellID
	z.BuffUnit = "player"
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Time Warp"] = function()
	local z = {}
	z.SpellID = 80353--[[Time Warp]]
	z.Buff = z.SpellID
	z.BuffUnit = "player"
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Evocation"] = function()
	local z = {}
	z.SpellID = 12051--[[Evocation]]
	z.Buff = z.SpellID
	z.BuffUnit = "player"
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Mirror Image"] = function()
	local z = {}
	z.SpellID = 55342--[[Mirror Image]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Invisibility"] = function()
	local z = {}
	z.SpellID = 66--[[Invisibility]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Spellsteal"] = function()
	if not Casting(nil,"target",1) then
		return false
	end
	local z = {}
	z.SpellID = 30449--[[Spellsteal]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

--Frost Functions

AddonTable.Castable["Frostbolt"] = function()
	local z = {}
	z.SpellID = 116--[[Frostbolt]]
	z.MyDebuff = z.SpellID
	z.NotWhileMoving = 1
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Frostfire Orb"] = function()
	local z = {}
	z.SpellID = 92283--[[Frostfire Orb]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Summon Water Elemental"] = function()
	local z = {}
	z.SpellID = 31687--[[Summon Water Elemental]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Freeze"] = function()
	local z = {}
	z.SpellID = 33395--[[Freeze]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Deep Freeze"] = function()
	local z = {}
	z.SpellID = 71757--[[Deep Freeze]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Frostfire Bolt"] = function()
	local z = {}
	z.SpellID = 69987--[[Frostfire Bolt]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Ice Lance"] = function()
	local z = {}
	z.SpellID = 30455--[[Ice Lance]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Deep Freeze"] = function()
	local z = {}
	z.SpellID = 71757--[[Deep Freeze]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end


--Fire Functions
AddonTable.Castable["Fireball"] = function()
	local z = {}
	z.SpellID = 133--[[Fireball]]
	z.NotWhileMoving = 1
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Pyroblast"] = function()
	local z = {}
	z.SpellID = 92315--[[Pyroblast]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Flame Orb"] = function()
	local z = {}
	z.SpellID = 82731--[[Flame Orb]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Combustion"] = function()
	local z = {}
	z.SpellID = 11129--[[Combustion]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Living Bomb"] = function()
	local z = {}
	z.SpellID = 44457--[[Living Bomb]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Scorch"] = function()
	local z = {}
	z.SpellID = 2948--[[Scorch]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

--Arcane Functions

AddonTable.Castable["Arcane Blast"] = function()
	local z = {}
	z.SpellID = 30451--[[Arcane Blast]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Arcane Power"] = function()
	local z = {}
	z.SpellID = 12042--[[Arcane Power]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Mana Gem"] = function()
	local z = {}
	z.SpellID = 36799--[[Mana Gem]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Clearcasting"] = function()
	local z = {}
	z.SpellID = 12536--[[Clearcasting]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end
AddonTable.Castable["Arcane Missiles"] = function()
	local z = {}
	z.SpellID = 5143--[[Arcane Missiles]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end
AddonTable.Castable["Arcane Barrage"] = function()
	local z = {}
	z.SpellID = 44425--[[Arcane Barrage]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end
AddonTable.Castable["Presence of Mind"] = function()
	local z = {}
	z.SpellID = 12043--[[Presence of Mind]]
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

