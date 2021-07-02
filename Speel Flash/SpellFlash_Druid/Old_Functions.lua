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
	z.Debuff = z.SpellName   --place debuff name or table of names here if the spell has a debuff that may only be on a target once in total from everyone and has a cooldown shorter then the debuff duration
	z.MyDebuff = z.SpellName   --place debuff name or table of names here if the spell has a debuff that may be on the target multiple times by many people and has a cooldown shorter then the debuff duration, 
	z.Buff = z.SpellName   --place buff name or table of names here if the spell has a buff that may only be on yourself once in total from everyone and has a cooldown shorter then the buff duration
	z.MyBuff = z.SpellName   --place buff name or table of names here if the spell has a buff that may be on the target multiple times by many people and has a cooldown shorter then the buff duration
	z.BuffUnit = "player"   --you may change this if the target of a buff is different then yourself
	z.CastTime = CastTime(z.SpellName)   --use this only if you want to replace the spell cast time used for early indication of a buff or debuff
	z.EnemyTargetNeeded = 1   --use this if the spell should have an enemy targeted
	z.TargetThatUsesManaNeeded = 1   --use this if the spell is only useful on a target that uses mana such as mana draining spells
	z.NoRangeCheck = 1   --use this to disable range detection if the spell has a limited range but the detection in this function is not working correctly for the particular spell
	z.NotIfActive = 1   --use this if the spell may be toggled on such as auto attack or on next swing spells, or to disable when casting or channeling
	z.EvenIfNotUsable = 1   --use this to disable the usability checking in this function and may be used if currently in the process of completing a prerequisite that will make the spell usable
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

-- Example function:
AddonTable.ItemCastable["English_Item_Name"] = function()
	local z = {}
	z.ItemName = ItemName(GlobalItemID--[[English_Item_Name]])   --this is for defining the correct name of the item
	z.DebuffSlotNeeded = 1   --use this if you want to make sure that a debuff slot is free on the target so that you do not replace other debuffs
	z.Debuff = z.ItemName   --place debuff name or table of names here if the item has a debuff that may only be on a target once in total from everyone and has a cooldown shorter then the debuff duration
	z.MyDebuff = z.ItemName   --place debuff name or table of names here if the item has a debuff that may be on the target multiple times by many people and has a cooldown shorter then the debuff duration, 
	z.Buff = z.ItemName   --place buff name or table of names here if the item has a buff that may only be on yourself once in total from everyone and has a cooldown shorter then the buff duration
	z.MyBuff = z.ItemName   --place buff name or table of names here if the item has a buff that may be on the target multiple times by many people and has a cooldown shorter then the buff duration
	z.BuffUnit = "player"   --you may change this if the target of a buff is different then yourself
	z.CastTime = 0   --use this if the item has a cast time and change the number to indication a buff or debuff early
	z.EnemyTargetNeeded = 1   --use this if the item should have an enemy targeted
	z.TargetThatUsesManaNeeded = 1   --use this if the item is only useful on a target that uses mana such as mana draining items
	z.NoRangeCheck = 1   --use this to disable range detection if the item has a limited range but the detection in this function is not working correctly for the particular item
	z.NotIfActive = 1   --use this if the item may be toggled on such as auto attack or on next swing spells, or to disable when casting or channeling
	z.EvenIfNotUsable = 1   --use this to disable the usability checking in this function and may be used if currently in the process of completing a prerequisite that will make the item usable
	return SpellFlashAddon.CheckIfItemCastable(z)
end


BigLibTimer.Register(AddonTable)
local function OnEvent(self, event, ...)
	local arg = {...}
	if event == "COMBAT_LOG_EVENT_UNFILTERED" and arg[2] == "SPELL_AURA_APPLIED" and arg[6] == UnitGUID("player") and arg[12] == "BUFF" then
		if arg[10] == SpellName(48517--[[Eclipse (Solar)]]) then
			AddonTable:SetTimer("Eclipse (Solar)", 30)
		elseif arg[10] == SpellName(48518--[[Eclipse (Lunar)]]) then
			AddonTable:SetTimer("Eclipse (Lunar)", 30)
		end
	end
end
local Frame = CreateFrame("Frame")
Frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
Frame:SetScript("OnEvent", OnEvent)


-- Will return false if Combo Points are stacked less than 5 times on the target.
function AddonTable.IsComboFull(unit)
	return GetComboPoints() == 5
end

-- Will return false if Combo Points are stacked less than 4 times on a target.
function AddonTable.IsComboLessThanFour(unit)
	return GetComboPoints() < 4
end

function AddonTable.IsOOC(unit)
	return Buff(SpellName(16864--[[Omen of Clarity]]),unit)
end

function AddonTable.IsInfectedWounds(unit)
	return Debuff(SpellName(58181--[[Infected Wounds]]),unit)
end

function AddonTable.IsMangleBear(unit)
	return Debuff(SpellName(33878--[[Mangle (Bear)]]),unit)
end

function AddonTable.IsMangleCat(unit)
	return Debuff(SpellName(33876--[[Mangle (Cat)]]),unit)
end

function AddonTable.IsRip(unit)
	return Debuff(SpellName(1079--[[Rip]]),unit)
end

function AddonTable.IsPiercingHowl(unit)
	return Debuff(SpellName(12323--[[Piercing Howl]]),unit)
end

function AddonTable.IsDemoralizingRoar(unit)
	return Debuff(SpellName(99--[[Demoralizing Roar]]),unit)
end

function AddonTable.IsChallengingRoar(unit)
	return Debuff(SpellName(5209--[[Challenging Roar]]),unit)
end

function AddonTable.IsDisarm(unit)
	return Debuff(SpellName(676--[[Disarm]]),unit)
end

function AddonTable.IsThornsActive()
	return Buff({
		SpellName(467--[[Thorns]]),
	})
end

function AddonTable.IsBuffActive()
	return Buff({
		SpellName(1126--[[Mark of the Wild]]),
		SpellName(21849--[[Gift of the Wild]]),
	})
end



AddonTable.Castable["Cat Form"] = function()
	if IsMounted() or Form(SpellName(33943--[[Flight Form]])) or ( IsResting() and not InCombat() and not SpellFlashAddon.IsEnemy() ) then
		return false
	end
	local z = {}
	z.SpellName = SpellName(768--[[Cat Form]])
	if Form(z.SpellName) or not SpellKnown(z.SpellName) then
		return false
	end
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Bear Form"] = function()
	if IsMounted() or Form(SpellName(33943--[[Flight Form]])) or ( IsResting() and not InCombat() and not SpellFlashAddon.IsEnemy() ) then
		return false
	end
	local z = {}
	z.SpellName = SpellName(5487--[[Bear Form]])
	if SpellKnown(SpellName(9634--[[Dire Bear Form]])) then
		z.SpellName = SpellName(9634--[[Dire Bear Form]])
	end
	if Form(z.SpellName) or not SpellKnown(z.SpellName) then
		return false
	end
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Moonkin Form"] = function()
	if IsMounted() or Form(SpellName(33943--[[Flight Form]])) or ( IsResting() and not InCombat() and not SpellFlashAddon.IsEnemy() ) then
		return false
	end
	local z = {}
	z.SpellName = SpellName(24858--[[Moonkin Form]])
	if Form(z.SpellName) or not SpellKnown(z.SpellName) then
		return false
	end
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Tree of Life"] = function()
	if IsMounted() or Form(SpellName(33943--[[Flight Form]])) or ( IsResting() and not InCombat() and not SpellFlashAddon.IsEnemy() ) then
		return false
	end
	local z = {}
	z.SpellName = SpellName(65139--[[Tree of Life]])
	if Form(z.SpellName) or not SpellKnown(z.SpellName) then
		return false
	end
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Feral Charge - Cat"] = function()
	local z = {}
	z.SpellName = SpellName(49376--[[Feral Charge - Cat]])
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Feral Charge - Bear"] = function()
	local z = {}
	z.SpellName = SpellName(16979--[[Feral Charge - Bear]])
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Nature's Swiftness"] = function()
	local z = {}
	z.SpellName = SpellName(17116--[[Nature's Swiftness]])
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Swiftmend"] = function()
	local z = {}
	z.SpellName = SpellName(18562--[[Swiftmend]])
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Wrath"] = function()
	local z = {}
	z.SpellName = SpellName(48461--[[Wrath]])
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Starfire"] = function()
	local z = {}
	z.SpellName = SpellName(48465--[[Starfire]])
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Insect Swarm"] = function()
	local z = {}
	z.SpellName = SpellName(48468--[[Insect Swarm]])
	z.MyDebuff = z.SpellName
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Innervate"] = function()
	local z = {}
	z.SpellName = SpellName(29166--[[Innervate]])
	z.NoRangeCheck = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Moonfire"] = function()
	local z = {}
	z.SpellName = SpellName(48463--[[Moonfire]])
	z.MyDebuff = z.SpellName
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Typhoon"] = function()
	local z = {}
	z.SpellName = SpellName(61384--[[Typhoon]])
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Starfall"] = function()
	local z = {}
	z.SpellName = SpellName(53201--[[Starfall]])
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Force of Nature"] = function()
	local z = {}
	z.SpellName = SpellName(33831--[[Force of Nature]])
	z.NoRangeCheck = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Swipe (Cat)"] = function()
	if not SpellFlashAddon.MeleeDistance() then
		return false
	end
	local z = {}
	z.SpellName = SpellName(62078--[[Swipe (Cat)]])
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Lacerate"] = function(EarlyRefreshSeconds)
	if not SpellFlashAddon.MeleeDistance() then
		return false
	end
	local z = {}
	z.SpellName = SpellName(33745--[[Lacerate]])
	z.MyDebuff = z.SpellName
	z.CastTime = CastTime(z.SpellName) + (EarlyRefreshSeconds or 0)
	z.DebuffSlotNeeded = 1
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Rake"] = function(EarlyRefreshSeconds)
	if not SpellFlashAddon.MeleeDistance() then
		return false
	end
	local z = {}
	z.SpellName = SpellName(59881--[[Rake]])
	z.MyDebuff = z.SpellName
	z.CastTime = CastTime(z.SpellName) + (EarlyRefreshSeconds or 0)
	z.DebuffSlotNeeded = 1
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Rip"] = function(EarlyRefreshSeconds)
	if not SpellFlashAddon.MeleeDistance() then
		return false
	end
	local z = {}
	z.SpellName = SpellName(1079--[[Rip]])
	z.MyDebuff = z.SpellName
	z.CastTime = CastTime(z.SpellName) + (EarlyRefreshSeconds or 0)
	z.DebuffSlotNeeded = 1
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shred"] = function()
	if not SpellFlashAddon.MeleeDistance() then
		return false
	end
	local z = {}
	z.SpellName = SpellName(5221--[[Shred]])
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Healing Touch"] = function()
    local z = {}
    z.SpellName = SpellName(5185--[[Healing Touch]])
    z.Buff = z.SpellName
    return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Savage Roar"] = function(EarlyRefreshSeconds)
    local z = {}
    z.SpellName = SpellName(52610--[[Savage Roar]])
    z.Buff = z.SpellName
	z.CastTime = CastTime(z.SpellName) + (EarlyRefreshSeconds or 0)
    return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Mark of the Wild"] = function()
    local z = {}
    z.SpellName = SpellName(1126--[[Mark of the Wild]])
    z.Buff = {
        z.SpellName,
        SpellName(21849--[[Gift of the Wild]]),
    }
    return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Gift of the Wild"] = function()
    local z = {}
    z.SpellName = SpellName(21849--[[Gift of the Wild]])
    z.Buff = {
        z.SpellName,
        SpellName(1126--[[Mark of the Wild]]),
    }
    return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Thorns"] = function()
    local z = {}
    z.SpellName = SpellName(467--[[Thorns]])
    z.Buff = z.SpellName
    return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Bash"] = function()
    if not Casting(nil,"target",1) then
        return false
    end
    local z = {}
    z.SpellName = SpellName(5211--[[Bash]])
    z.EnemyTargetNeeded = 1
    return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Mangle (Bear)"] = function()
	if not SpellFlashAddon.MeleeDistance() then
		return false
	end
	local z = {}
	z.SpellName = SpellName(33878--[[Mangle (Bear)]])
	z.EnemyTargetNeeded = 1
	z.NotIfActive = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Mangle (Cat)"] = function(EarlyRefreshSeconds)
	if not SpellFlashAddon.MeleeDistance() then
		return false
	end
	local z = {}
	z.SpellName = SpellName(33876--[[Mangle (Cat)]])
	z.Debuff = z.SpellName
	z.CastTime = CastTime(z.SpellName) + (EarlyRefreshSeconds or 0)
	z.EnemyTargetNeeded = 1
	z.NotIfActive = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Demoralizing Roar"] = function(EarlyRefreshSeconds)
	if not CheckInteractDistance("target", 3) then
		return false
	end
	local z = {}
	z.SpellName = SpellName(99--[[Demoralizing Roar]])
	z.Debuff = z.SpellName
	z.CastTime = CastTime(z.SpellName) + (EarlyRefreshSeconds or 0)
	z.EnemyTargetNeeded = 1
	z.NoRangeCheck = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Frenzied Regeneration"] = function()
	if HealthPercent("player") >= 80 then
		return false
	end
	local z = {}
	z.SpellName = SpellName(22842--[[Frenzied Regeneration]])
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Berserk"] = function()
	local z = {}
	z.SpellName = SpellName(50334--[[Berserk]])
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Survival Instincts"] = function()
	if HealthPercent("player") >= 70 then
		return false
	end
	local z = {}
	z.SpellName = SpellName(61336--[[Survival Instincts]])
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Faerie Fire (Feral)"] = function()
	local z = {}
	z.SpellName = SpellName(16857--[[Faerie Fire (Feral)]])
	z.EnemyTargetNeeded = 1
	z.Debuff = {
		z.SpellName,
		SpellName(770--[[Faerie Fire]]),
	}
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Faerie Fire"] = function()
	local z = {}
	z.SpellName = SpellName(770--[[Faerie Fire]])
	z.EnemyTargetNeeded = 1
	z.Debuff = {
		z.SpellName,
		SpellName(770--[[Faerie Fire]]),
	}
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Tiger's Fury"] = function()
	local z = {}
	z.SpellName = SpellName(5217--[[Tiger's Fury]])
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

AddonTable.Castable["Ferocious Bite"] = function()
	local z = {}
	z.SpellName = SpellName(22568--[[Ferocious Bite]])
	z.EnemyTargetNeeded = 1
	return SpellFlashAddon.CheckIfSpellCastable(z)
end

