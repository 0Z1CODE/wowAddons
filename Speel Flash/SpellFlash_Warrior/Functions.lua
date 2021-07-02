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


LibStub:GetLibrary("BigLibTimer3"):Register(AddonTable)
local function OnEvent(self, event, ...)
	local arg = {...}
	if event == "UNIT_SPELLCAST_SUCCEEDED" and arg[1] == "player" then
		if arg[2] == s.SpellName(100--[[Charge]], 1) or arg[2] == s.SpellName(20252--[[Intercept]], 1) then
			AddonTable:SetTimer("Charge", 5)
		end
	end
end
local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
EventFrame:SetScript("OnEvent", OnEvent)



AddonTable.Castable["Auto Attack"] = function()
	local z = {}
	z.SpellID = 6603--[[Auto Attack]]
	z.EnemyTargetNeeded = 1
	return s.MeleeDistance() and not s.CurrentSpell(z.SpellID) and not s.CurrentSpell(88163--[[Attack]]) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Attack"] = function()
	local z = {}
	z.SpellID = 88163--[[Attack]]
	z.EnemyTargetNeeded = 1
	return s.MeleeDistance() and not s.CurrentSpell(6603--[[Auto Attack]]) and not s.CurrentSpell(z.SpellID) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Battle Stance"] = function()
	local z = {}
	z.SpellID = 2457--[[Battle Stance]]
	return not s.Form(z.SpellID) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Defensive Stance"] = function()
	local z = {}
	z.SpellID = 71--[[Defensive Stance]]
	return not s.Form(z.SpellID) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Berserker Stance"] = function()
	local z = {}
	z.SpellID = 2458--[[Berserker Stance]]
	return not s.Form(z.SpellID) and s.CheckIfSpellCastable(z)
end

AddonTable.BattleBuffs = {
	6673--[[Battle Shout]],
	57330--[[Horn of Winter]],
	93435--[[Roar of Courage]],
	8075--[[Strength of Earth Totem]],
}

AddonTable.CommandingBuffs = {
	469--[[Commanding Shout]],
	90364--[[Qiraji Fortitude]],
	21562--[[Power Word: Fortitude]],
	6307--[[Blood Pact]],
}

AddonTable.Castable["Battle Shout"] = function()
	if not ( s.InCombat() or s.Enemy("target") or s.Enemy("focus") ) then
		return false
	end
	local z = {}
	z.SpellID = 6673--[[Battle Shout]]
	if s.PowerMissing("player") < 20 then
		z.Buff = AddonTable.BattleBuffs
	elseif not ( not s.Flashable(469--[[Commanding Shout]]) or not s.Buff(AddonTable.BattleBuffs, "player", x.DoubleLag) or s.Buff(AddonTable.CommandingBuffs, "player", x.DoubleLag) or s.MyBuff(z.SpellID, "player", x.DoubleLag) ) then
		return false
	end
	z.MyBuff = 469--[[Commanding Shout]]
	z.BuffUnit = "player"
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Commanding Shout"] = function()
	if not ( s.InCombat() or s.Enemy("target") or s.Enemy("focus") ) then
		return false
	end
	local z = {}
	z.SpellID = 469--[[Commanding Shout]]
	if s.PowerMissing("player") < 20 then
		z.Buff = AddonTable.CommandingBuffs
	elseif not ( not s.Flashable(6673--[[Battle Shout]]) or not s.Buff(AddonTable.CommandingBuffs, "player", x.DoubleLag) or s.Buff(AddonTable.BattleBuffs, "player", x.DoubleLag) or s.MyBuff(z.SpellID, "player", x.DoubleLag) ) then
		return false
	end
	z.MyBuff = 6673--[[Battle Shout]]
	z.BuffUnit = "player"
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Berserker Rage"] = function()
	local z = {}
	z.SpellID = 18499--[[Berserker Rage]]
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Charge"] = function()
	local z = {}
	z.SpellID = 100--[[Charge]]
	z.EnemyTargetNeeded = 1
	return not s.CurrentSpell(20252--[[Intercept]]) and not AddonTable:IsTimer("Charge") and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Cleave"] = function()
	local z = {}
	z.SpellID = 845--[[Cleave]]
	z.EnemyTargetNeeded = 1
	z.NotIfActive = 1
	return ( s.Power("player") >= 70 or s.BuffDuration(85730--[[Deadly Calm]], "player") > (s.SpellCooldown(z.SpellID) + x.Lag) ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Colossus Smash"] = function()
	local z = {}
	z.SpellID = 86346--[[Colossus Smash]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Demoralizing Shout"] = function()
	local z = {}
	z.SpellID = 1160--[[Demoralizing Shout]]
	z.Debuff = {
		702--[[Curse of Weakness]],
		1160--[[Demoralizing Shout]],
		99--[[Demoralizing Roar]],
		24423--[[Demoralizing Screech]],
		26016--[[Vindication]],
	}
	z.EnemyTargetNeeded = 1
	z.NoRangeCheck = 1
	return CheckInteractDistance("target", 3) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Disarm"] = function()
	local z = {}
	z.SpellID = 676--[[Disarm]]
	z.Debuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Enraged Regeneration"] = function()
	local z = {}
	z.SpellID = 55694--[[Enraged Regeneration]]
	return ( s.InCombat() or s.EnemyTargetingYou("target") or s.EnemyTargetingYou("focus") ) and s.HealthPercent("player") <= 45 and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Execute"] = function()
	local z = {}
	z.SpellID = 5308--[[Execute]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Hamstring"] = function()
	local z = {}
	z.SpellID = 1715--[[Hamstring]]
	z.Debuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return ( UnitIsPlayer("target") or not UnitExists("targettarget") ) and not s.Boss() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Heroic Strike"] = function()
	local z = {}
	z.SpellID = 78--[[Heroic Strike]]
	z.EnemyTargetNeeded = 1
	z.NotIfActive = 1
	return ( s.Power("player") >= 70 or s.BuffDuration(85730--[[Deadly Calm]], "player") > (s.SpellCooldown(z.SpellID) + x.Lag) ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Heroic Throw"] = function()
	local z = {}
	z.SpellID = 57755--[[Heroic Throw]]
	z.EnemyTargetNeeded = 1
	return not s.MeleeDistance() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Inner Rage"] = function()
	local z = {}
	z.SpellID = 1134--[[Inner Rage]]
	z.EnemyTargetNeeded = 1
	return s.MeleeDistance() and s.SpellCooldown(78--[[Heroic Strike]]) > x.Lag and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Intercept"] = function()
	local z = {}
	z.SpellID = 20252--[[Intercept]]
	z.EnemyTargetNeeded = 1
	return not s.CurrentSpell(100--[[Charge]]) and not AddonTable:IsTimer("Charge") and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Intervene"] = function()
	local z = {}
	z.SpellID = 3411--[[Intervene]]
	return UnitIsFriend("player", "target") and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Overpower"] = function()
	local z = {}
	z.SpellID = 7384--[[Overpower]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Pummel"] = function()
	local z = {}
	z.SpellID = 6552--[[Pummel]]
	z.EnemyTargetNeeded = 1
	return s.GetCastingOrChanneling(nil, nil, 1) > s.SpellCooldown(z.SpellID) + x.DoubleLag and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Recklessness"] = function()
	local z = {}
	z.SpellID = 1719--[[Recklessness]]
	z.EnemyTargetNeeded = 1
	return s.InCombat() and s.MeleeDistance() and UnitExists("targettarget") and not s.EnemyTargetingYou("target") and not s.EnemyTargetingYou("focus") and ( s.HealthPercent() > 25 or UnitIsPlayer("target") or s.Boss() ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Rend"] = function()
	local z = {}
	z.SpellID = 772--[[Rend]]
	z.DebuffSlotNeeded = 1
	z.MyDebuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Retaliation"] = function()
	local z = {}
	z.SpellID = 20230--[[Retaliation]]
	z.EnemyTargetNeeded = 1
	return s.InCombat() and s.MeleeDistance() and s.EnemyTargetingYou() and ( s.HealthPercent() > 25 or UnitIsPlayer("target") or s.Boss() ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Revenge"] = function()
	local z = {}
	z.SpellID = 6572--[[Revenge]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shattering Throw"] = function()
	local z = {}
	z.SpellID = 64382--[[Shattering Throw]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shield Bash"] = function()
	local z = {}
	z.SpellID = 72--[[Shield Bash]]
	z.EnemyTargetNeeded = 1
	return s.GetCastingOrChanneling(nil, nil, 1) > s.SpellCooldown(z.SpellID) + x.DoubleLag and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shield Block"] = function()
	local SpellName, cooldown, duration
	if s.HasTalent(86894--[[Heavy Repercussions]]) then
		SpellName = 23922--[[Shield Slam]]
		cooldown, duration = s.SpellCooldown(SpellName)
	else
		if not s.EnemyTargetingYou("target") and not s.EnemyTargetingYou("focus") then
			return false
		end
		SpellName = 6572--[[Revenge]]
		cooldown, duration = s.SpellCooldown(SpellName)
	end
	local z = {}
	z.SpellID = 2565--[[Shield Block]]
	z.Buff = z.SpellID
	z.BuffUnit = "player"
	return cooldown <= s.SpellCooldown(z.SpellID) + x.DoubleLag and ( s.BuffDuration(85730--[[Deadly Calm]], "player") > 1.5 + x.DoubleLag or s.Power("player") >= s.SpellCost(z.SpellID) + s.SpellCost(SpellName) ) and s.MeleeDistance() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shield Wall"] = function()
	local z = {}
	z.SpellID = 871--[[Shield Wall]]
	z.EnemyTargetNeeded = 1
	return ( s.InCombat() or s.EnemyTargetingYou("target") or s.EnemyTargetingYou("focus") ) and s.HealthPercent("player") <= 35 and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Slam"] = function()
	local z = {}
	z.SpellID = 1464--[[Slam]]
	z.EnemyTargetNeeded = 1
	return s.SpellCooldown(78--[[Heroic Strike]]) > x.Lag and ( s.Power("player") >= 70 or s.BuffDuration(85730--[[Deadly Calm]], "player") > (s.SpellCooldown(z.SpellID) + x.Lag) ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Spell Reflection"] = function()
	local z = {}
	z.SpellID = 23920--[[Spell Reflection]]
	z.EnemyTargetNeeded = 1
	return ( ( s.EnemyTargetingYou("target") and s.GetCasting(nil, "target") > (s.SpellCooldown(z.SpellID) + x.DoubleLag) ) or ( s.EnemyTargetingYou("focus") and s.GetCasting(nil, "focus") > (s.SpellCooldown(z.SpellID) + x.DoubleLag) ) ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Strike"] = function()
	local z = {}
	z.SpellID = 88161--[[Strike]]
	z.EnemyTargetNeeded = 1
	return not s.TalentMastery() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Sunder Armor"] = function()
	local z = {}
	z.SpellID = 7386--[[Sunder Armor]]
	z.EnemyTargetNeeded = 1
	return s.DebuffStack(z.SpellID, nil, 10) < 3 and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Taunt"] = function()
	local z = {}
	z.SpellID = 355--[[Taunt]]
	return s.EnemyTargetingYourFriend() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Thunder Clap"] = function()
	local z = {}
	z.SpellID = 6343--[[Thunder Clap]]
	z.NoRangeCheck = 1
	z.EnemyTargetNeeded = 1
	return s.MeleeDistance() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Victory Rush"] = function()
	local z = {}
	z.SpellID = 34428--[[Victory Rush]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Whirlwind"] = function()
	local z = {}
	z.SpellID = 1680--[[Whirlwind]]
	z.NoRangeCheck = 1
	z.EnemyTargetNeeded = 1
	return s.MeleeDistance() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Bloodthirst"] = function()
	local z = {}
	z.SpellID = 23881--[[Bloodthirst]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Mortal Strike"] = function()
	local z = {}
	z.SpellID = 12294--[[Mortal Strike]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shield Slam"] = function()
	local z = {}
	z.SpellID = 23922--[[Shield Slam]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Bladestorm"] = function()
	local z = {}
	z.SpellID = 46924--[[Bladestorm]]
	z.EnemyTargetNeeded = 1
	return s.MeleeDistance() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Concussion Blow"] = function()
	local z = {}
	z.SpellID = 12809--[[Concussion Blow]]
	z.EnemyTargetNeeded = 1
	return s.GetCastingOrChanneling(nil, nil, 1) > s.SpellCooldown(z.SpellID) + x.DoubleLag and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Deadly Calm"] = function()
	local z = {}
	z.SpellID = 85730--[[Deadly Calm]]
	z.EnemyTargetNeeded = 1
	return s.InCombat() and s.Power("player") < 50 and ( s.HealthPercent() > 25 or UnitIsPlayer("target") or s.Boss() ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Death Wish"] = function()
	local z = {}
	z.SpellID = 12292--[[Death Wish]]
	z.EnemyTargetNeeded = 1
	return s.InCombat() and s.MeleeDistance() and ( s.HealthPercent() > 25 or UnitIsPlayer("target") or s.Boss() ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Devastate"] = function()
	local z = {}
	z.SpellID = 20243--[[Devastate]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Heroic Fury"] = function()
	local z = {}
	z.SpellID = 60970--[[Heroic Fury]]
	z.EnemyTargetNeeded = 1
	return s.Rooted("player") and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Last Stand"] = function()
	local z = {}
	z.SpellID = 12975--[[Last Stand]]
	z.EnemyTargetNeeded = 1
	return ( s.InCombat() or s.EnemyTargetingYou("target") or s.EnemyTargetingYou("focus") ) and s.HealthPercent("player") <= 10 and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Piercing Howl"] = function()
	local z = {}
	z.SpellID = 12323--[[Piercing Howl]]
	z.EnemyTargetNeeded = 1
	return CheckInteractDistance("target", 3) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Raging Blow"] = function(EvenIfNotUsable)
	local z = {}
	z.SpellID = 85288--[[Raging Blow]]
	z.EnemyTargetNeeded = 1
	z.EvenIfNotUsable = EvenIfNotUsable
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Shockwave"] = function()
	local z = {}
	z.SpellID = 46968--[[Shockwave]]
	z.EnemyTargetNeeded = 1
	return CheckInteractDistance("target", 3) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Sweeping Strikes"] = function()
	local z = {}
	z.SpellID = 12328--[[Sweeping Strikes]]
	z.EnemyTargetNeeded = 1
	return s.MeleeDistance() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Throwdown"] = function()
	local z = {}
	z.SpellID = 85388--[[Throwdown]]
	z.EnemyTargetNeeded = 1
	return s.GetCastingOrChanneling(nil, nil, 1) > s.SpellCooldown(z.SpellID) + x.DoubleLag and s.CheckIfSpellCastable(z)
end

