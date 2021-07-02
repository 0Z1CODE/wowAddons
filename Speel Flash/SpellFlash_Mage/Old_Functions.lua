local AddonName, AddonTable = ...
if not AddonTable.OldBuild then return end
local L = AddonTable.Localize
AddonTable.Castable = SpellFlashAddon.CopyTable(SpellFlashAddon.Castable)
AddonTable.VehicleCastable = SpellFlashAddon.CopyTable(SpellFlashAddon.VehicleCastable)
AddonTable.ItemCastable = SpellFlashAddon.CopyTable(SpellFlashAddon.ItemCastable)
local function SpellName(GlobalSpellID)
	return (GetSpellInfo(GlobalSpellID))
end
local function ItemName(GlobalItemID)
	return (GetItemInfo(GlobalItemID))
end
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


-- Example function:
AddonTable.Castable["English_Spell_Name"] = function()
	local z = {}
	z.SpellName = SpellName(GlobalSpellID--[[English_Spell_Name]])   --this is for defining the correct name of the spell
	z.DebuffSlotNeeded = 1   --use this if you want to make sure that a debuff slot is free on the target so that you do not replace other debuffs
	z.Debuff = z.SpellName   --place debuff name or table of names here if the spell has a debuff that may only be on a target once in total from everyone and has a cooldown shorter than the debuff duration
	z.MyDebuff = z.SpellName   --place debuff name or table of names here if the spell has a debuff that may be on the target multiple times by many people and has a cooldown shorter than the debuff duration
	z.Buff = z.SpellName   --place buff name or table of names here if the spell has a buff that may only be on yourself once in total from everyone and has a cooldown shorter than the buff duration
	z.MyBuff = z.SpellName   --place buff name or table of names here if the spell has a buff that may be on the target multiple times by many people and has a cooldown shorter than the buff duration
	z.BuffUnit = "player"   --you may change this if the target of a buff is different than yourself
	z.CastTime = CastTime(z.SpellName)   --use this only if you want to replace the spell cast time used for early indication of a buff or debuff
	z.EnemyTargetNeeded = 1   --use this if the spell should have an enemy targeted
	z.TargetThatUsesManaNeeded = 1   --use this if the spell is only useful on a target that uses mana such as mana draining spells
	z.NoRangeCheck = 1   --use this to disable range detection if the spell has a limited range but the detection in this function is not working correctly for the particular spell
	z.NotIfActive = 1   --use this if the spell may be toggled on such as auto attack or on next swing spells, or to disable when casting or channeling, or if the spell has a cooldown
	z.NotWhileMoving = 1   --use this if the spell is not able to be cast while moving
	z.EvenIfNotUsable = 1   --use this to disable the usability checking in this function and may be used if currently in the process of completing a prerequisite that will make the spell usable
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

-- Example function:
AddonTable.VehicleCastable["English_Spell_Name"] = function()
	local z = {}
	z.SpellName = SpellName(GlobalSpellID--[[English_Spell_Name]])   --this is for defining the correct name of the spell
	z.DebuffSlotNeeded = 1   --use this if you want to make sure that a debuff slot is free on the target so that you do not replace other debuffs
	z.Debuff = z.SpellName   --place debuff name or table of names here if the spell has a debuff that may only be on a target once in total from everyone and has a cooldown shorter than the debuff duration
	z.MyDebuff = z.SpellName   --place debuff name or table of names here if the spell has a debuff that may be on the target multiple times by many people and has a cooldown shorter than the debuff duration
	z.Buff = z.SpellName   --place buff name or table of names here if the spell has a buff that may only be on yourself once in total from everyone and has a cooldown shorter than the buff duration
	z.MyBuff = z.SpellName   --place buff name or table of names here if the spell has a buff that may be on the target multiple times by many people and has a cooldown shorter than the buff duration
	z.BuffUnit = "player"   --you may change this if the target of a buff is different than yourself
	z.CastTime = 0   --use this if the spell has a cast time and change the number to indication a buff or debuff early
	z.EnemyTargetNeeded = 1   --use this if the spell should have an enemy targeted
	z.TargetThatUsesManaNeeded = 1   --use this if the spell is only useful on a target that uses mana such as mana draining spells
	z.NoRangeCheck = 1   --use this to disable range detection if the spell has a limited range but the detection in this function is not working correctly for the particular spell
	z.NotIfActive = 1   --use this if the spell may be toggled on such as auto attack or on next swing spells, or to disable when casting or channeling, or if the spell has a cooldown
	z.NotWhileMoving = 1   --use this if the spell is not able to be cast while moving
	z.EvenIfNotUsable = 1   --use this to disable the usability checking in this function and may be used if currently in the process of completing a prerequisite that will make the spell usable
	z.GlobalVehicleCooldownSpell = SpellName(GlobalSpellID--[[English_Spell_Name]])   -- use this if spell has more than a global cooldown
	return SpellFlashAddon.CheckIfVehicleSpellCastable(z)
end

-- Example function:
AddonTable.ItemCastable["English_Item_Name"] = function()
	local z = {}
	z.ItemName = ItemName(GlobalItemID--[[English_Item_Name]])   --this is for defining the correct name of the item
	z.DebuffSlotNeeded = 1   --use this if you want to make sure that a debuff slot is free on the target so that you do not replace other debuffs
	z.Debuff = z.ItemName   --place debuff name or table of names here if the item has a debuff that may only be on a target once in total from everyone and has a cooldown shorter than the debuff duration
	z.MyDebuff = z.ItemName   --place debuff name or table of names here if the item has a debuff that may be on the target multiple times by many people and has a cooldown shorter than the debuff duration
	z.Buff = z.ItemName   --place buff name or table of names here if the item has a buff that may only be on yourself once in total from everyone and has a cooldown shorter than the buff duration
	z.MyBuff = z.ItemName   --place buff name or table of names here if the item has a buff that may be on the target multiple times by many people and has a cooldown shorter than the buff duration
	z.BuffUnit = "player"   --you may change this if the target of a buff is different than yourself
	z.CastTime = 0   --use this if the item has a cast time and change the number to indication a buff or debuff early
	z.EnemyTargetNeeded = 1   --use this if the item should have an enemy targeted
	z.TargetThatUsesManaNeeded = 1   --use this if the item is only useful on a target that uses mana such as mana draining items
	z.NoRangeCheck = 1   --use this to disable range detection if the item has a limited range but the detection in this function is not working correctly for the particular item
	z.NotIfActive = 1   --use this if the item may be toggled on such as auto attack or on next swing spells, or to disable when casting or channeling, or if the item has a cooldown
	z.NotWhileMoving = 1   --use this if the item is not able to be used while moving
	z.EvenIfNotUsable = 1   --use this to disable the usability checking in this function and may be used if currently in the process of completing a prerequisite that will make the item usable
	return SpellFlashAddon.CheckIfItemCastable(z)
end

function AddonTable.IsArmorActive()
	return Buff({
		SpellName(30482--[[Molten Armor]]),
		SpellName(168--[[Frost Armor]]),
		SpellName(6117--[[Mage Armor]]),
	})
end

function AddonTable.IsIntelActive()
	return Buff({
		SpellName(23028--[[Arcane Brilliance]]),
		SpellName(1459--[[Arcane Intellect]]),
	})
end

--Mage Functions
--Buffs
AddonTable.Castable["Molten Armor"] = function()
	local z = {}
	z.SpellName = SpellName(30482--[[Molten Armor]])
	z.Buff = {
		SpellName(30482--[[Molten Armor]]),
		SpellName(168--[[Frost Armor]]),
		SpellName(6117--[[Mage Armor]]),
	}
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Frost Armor"] = function()
	local z = {}
	z.SpellName = SpellName(168--[[Frost Armor]])
	z.Buff = {
		SpellName(30482--[[Molten Armor]]),
		SpellName(168--[[Frost Armor]]),
		SpellName(6117--[[Mage Armor]]),
	}
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Mage Armor"] = function()
	local z = {}
	z.SpellName = SpellName(6117--[[Mage Armor]])
	z.Buff = {
		SpellName(30482--[[Molten Armor]]),
		SpellName(168--[[Frost Armor]]),
		SpellName(6117--[[Mage Armor]]),
	}
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Arcane Brilliance"] = function()
	local z = {}
	z.SpellName = SpellName(23028--[[Arcane Brilliance]])
	z.Buff = {
		SpellName(23028--[[Arcane Brilliance]]),
		SpellName(1459--[[Arcane Intellect]]),
	}
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Arcane Intellect"] = function()
	local z = {}
	z.SpellName = SpellName(1459--[[Arcane Intellect]])
	z.Buff = {
		SpellName(23028--[[Arcane Brilliance]]),
		SpellName(1459--[[Arcane Intellect]]),
	}
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

--General

AddonTable.Castable["Ice Block"] = function()
	if not SpellFlashAddon.MeleeDistance() then
		return false
	end
	local z = {}
	z.SpellName = SpellName(45438--[[Ice Block]])
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Mage ward"] = function()
	local z = {}
	z.SpellName = SpellName(543--[[Mage ward]])
	z.Buff = z.SpellName
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Time Warp"] = function()
	local z = {}
	z.SpellName = SpellName(80353--[[Time Warp]])
	z.Buff = z.SpellName
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Evocation"] = function()
	local z = {}
	z.SpellName = SpellName(12051--[[Evocation]])
	z.Buff = z.SpellName
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Mirror Image"] = function()
	local z = {}
	z.SpellName = SpellName(55342--[[Mirror Image]])
	z.MyDebuff = z.SpellName
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Invisibility"] = function()
	local z = {}
	z.SpellName = SpellName(66--[[Invisibility]])
	z.MyDebuff = z.SpellName
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Spellsteal"] = function()
	if not Casting(nil,"target",1) then
		return false
	end
	local z = {}
	z.SpellName = SpellName(30449--[[Spellsteal]])
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

--Spell Procs

AddonTable.Castable["Pyroblast"] = function()
	local z = {}
	z.SpellName = SpellName(11366--[[Pyroblast]])
	z.MyDebuff = z.SpellName
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Flamestrike"] = function()
	local z = {}
	z.SpellName = SpellName(2120--[[Flamestrike]])
	z.MyDebuff = z.SpellName
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Fire Blast"] = function()
	local z = {}
	z.SpellName = SpellName(2136--[[Fire Blast]])
	z.MyDebuff = z.SpellName
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Arcane Missiles"] = function()
	local z = {}
	z.SpellName = SpellName(5143--[[Arcane Missiles]])
	z.MyDebuff = z.SpellName
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Deep Freeze"] = function()
	local z = {}
	z.SpellName = SpellName(44572--[[Deep Freeze]])
	z.MyDebuff = z.SpellName
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Frostbolt"] = function()
	local z = {}
	z.SpellName = SpellName(116--[[Frostbolt]])
	z.MyDebuff = z.SpellName
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Fireball"] = function()
	local z = {}
	z.SpellName = SpellName(133--[[Fireball]])
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Frostfire Bolt"] = function()
	local z = {}
	z.SpellName = SpellName(44614--[[Frostfire Bolt]])
	z.MyDebuff = z.SpellName
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end
