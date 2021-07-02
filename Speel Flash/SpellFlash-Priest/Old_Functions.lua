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









function AddonTable.IsFortActive()
	return Buff({
		SpellName(1243--[[Power Word: Fortitude]]),
		SpellName(21562--[[Prayer of Fortitude]]),
	})
end

function AddonTable.IsSpiritActive()
	return Buff({
		SpellName(14752--[[Divine Spirit]]),
		SpellName(27681--[[Prayer of Spirit]]),
	})
end

function AddonTable.IsShadowActive()
	return Buff({
		SpellName(976--[[Shadow Protection]]),
		SpellName(27683--[[Prayer of Shadow Protection]]),
	})
end




AddonTable.Castable["Power Word: Fortitude"] = function()
	local z = {}
	z.SpellName = SpellName(1243--[[Power Word: Fortitude]])
	z.Buff = z.SpellName
	return SpellFlashAddon.CheckIfSpellCastable(z)
end


AddonTable.Castable["Prayer of Fortitude"] = function()
	local z = {}
	z.SpellName = SpellName(21562--[[Prayer of Fortitude]])
	z.Buff = z.SpellName
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Divine Spirit"] = function()
	local z = {}
	z.SpellName = SpellName(14752--[[Divine Spirit]])
	z.Buff = z.SpellName
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shadowform"] = function()
	local z = {}
	z.SpellName = SpellName(15473--[[Shadowform]])
	if Form(z.SpellName) or not SpellKnown(z.SpellName) then
		return false
	end
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Prayer of Spirit"] = function()
	local z = {}
	z.SpellName = SpellName(27681--[[Prayer of Spirit]])
	z.Buff = z.SpellName
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shadow Protection"] = function()
	local z = {}
	z.SpellName = SpellName(976--[[Shadow Protection]])
	z.Buff = z.SpellName
	return SpellFlashAddon.CheckIfSpellCastable(z)
end


AddonTable.Castable["Prayer of Shadow Protection"] = function()
	local z = {}
	z.SpellName = SpellName(27683--[[Prayer of Shadow Protection]])
	z.Buff = z.SpellName
	return SpellFlashAddon.CheckIfSpellCastable(z)
end


AddonTable.Castable["Inner Fire"] = function()
	local z = {}
	z.SpellName = SpellName(48168--[[Inner Fire]])
	z.Buff = z.SpellName
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Vampiric Embrace"] = function()
	local z = {}
	z.SpellName = SpellName(15286--[[Vampiric Embrace]])
	z.Buff = z.SpellName
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Power Word: Shield"] = function()
	local z = {}
	z.SpellName = SpellName(17--[[Power Word: Shield]])
	z.Buff = z.SpellName
	return SpellFlashAddon.CheckIfSpellCastable(z)
end


AddonTable.Castable["Vampiric Touch"] = function()
	local z = {}
	z.SpellName = SpellName(48160--[[Vampiric Touch]])
	z.MyDebuff = {
		z.SpellName,
		SpellName(53023--[[Mind Sear]]),
	}
	z.NotWhileMoving = 1
	z.DebuffSlotNeeded = 1
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end


AddonTable.Castable["Mind Sear"] = function()
	local z = {}
	z.SpellName = SpellName(53023--[[Mind Sear]])
	z.MyDebuff = z.SpellName
	z.NotWhileMoving = 1
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Devouring Plague"] = function()
	local z = {}
	z.SpellName = SpellName(48300--[[Devouring Plague]])
	z.MyDebuff = z.SpellName
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shadow Word: Pain"] = function()
	local z = {}
	z.SpellName = SpellName(48125--[[Shadow Word: Pain]])
	z.MyDebuff = z.SpellName
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Mind Blast"] = function()
	local z = {}
	z.SpellName = SpellName(48127--[[Mind Blast]])
	z.MyDebuff = z.SpellName
	z.NotWhileMoving = 1
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Mind Flay"] = function()
	local z = {}
	z.SpellName = SpellName(48156--[[Mind Flay]])
	z.MyDebuff = z.SpellName
	z.NotWhileMoving = 1
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shadowfiend"] = function()
	local z = {}
	z.SpellName = SpellName(34433--[[Shadowfiend]])
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end


AddonTable.Castable["Dispersion"] = function()
	local z = {}
	z.SpellName = SpellName(47585--[[Dispersion]])
	z.NoRangeCheck = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Desperate Prayer"] = function()
	local z = {}
	z.SpellName = SpellName(19236--[[Desperate Prayer]])
	z.NoRangeCheck = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Guardian Spirit"] = function()
	local z = {}
	z.SpellName = SpellName(47788--[[Guardian Spirit]])
	z.Buff = z.SpellName
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Divine Hymn"] = function()
	local z = {}
	z.SpellName = SpellName(64843--[[Divine Hymn]])
	z.NotWhileMoving = 1
	z.NoRangeCheck = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Prayer of Mending"] = function()
	local z = {}
	z.SpellName = SpellName(33076--[[Prayer of Mending]])
	z.NoRangeCheck = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end


