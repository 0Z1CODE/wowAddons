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




local BreakImprovedSteadyShotSpells = {
	s.SpellName(56641--[[Steady Shot]]),
	s.SpellName(1978--[[Serpent Sting]]),
	s.SpellName(19386--[[Wyvern Sting]]), -- unconfirmed
	s.SpellName(19434--[[Aimed Shot]]),
	s.SpellName(3044--[[Arcane Shot]]),
	s.SpellName(77767--[[Cobra Shot]]),
	s.SpellName(5116--[[Concussive Shot]]),
	s.SpellName(53351--[[Kill Shot]]),
	s.SpellName(2643--[[Multi-Shot]]),
	s.SpellName(19503--[[Scatter Shot]]),
	s.SpellName(19801--[[Tranquilizing Shot]]),
	s.SpellName(82654--[[Widow Venom]]),
	s.SpellName(53301--[[Explosive Shot]]), -- unconfirmed
	s.SpellName(3674--[[Black Arrow]]), -- unconfirmed
	s.SpellName(53209--[[Chimera Shot]]),
	--s.SpellName(19306--[[Counterattack]]), -- unconfirmed
	--s.SpellName(2974--[[Wing Clip]]),
	--s.SpellName(2973--[[Raptor Strike]]),
	--s.SpellName(781--[[Disengage]]),
	--s.SpellName(34490--[[Silencing Shot]]),
	--s.SpellName(1130--[[Hunter's Mark]]),
	--s.SpellName(34026--[[Kill Command]]),
	--s.SpellName(53271--[[Master's Call]]),
	--s.SpellName(136--[[Mend Pet]]),
	--s.SpellName(3045--[[Rapid Fire]]),
	--s.SpellName(19577--[[Intimidation]]),
	--s.SpellName(19574--[[Bestial Wrath]]),
	--s.SpellName(82726--[[Fervor]]),
	--s.SpellName(82692--[[Focus Fire]]),
	--s.SpellName(23989--[[Readiness]]),
}

local FIRST_STEADY_SHOT = nil

local function OnEvent(self, event, ...)
	local arg = {...}
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		if s.HasTalent(53221--[[Improved Steady Shot]]) then
			if arg[12] == "BUFF" then
				if FIRST_STEADY_SHOT and arg[6] == UnitGUID("player") and ( arg[2] == "SPELL_AURA_APPLIED" or arg[2] == "SPELL_AURA_REFRESH" ) and arg[10] == s.SpellName(53221--[[Improved Steady Shot]]) then
					FIRST_STEADY_SHOT = nil
				end
			elseif arg[3] == UnitGUID("player") and ( arg[2] == "SPELL_DAMAGE" or arg[2] == "SPELL_AURA_REFRESH" or arg[2] == "SPELL_AURA_APPLIED" or arg[2] == "SPELL_AURA_APPLIED_DOSE" ) then
				if FIRST_STEADY_SHOT then
					for _,v in ipairs(BreakImprovedSteadyShotSpells) do
						if v == arg[10] then
							FIRST_STEADY_SHOT = nil
							break
						end
					end
				elseif arg[10] == s.SpellName(56641--[[Steady Shot]]) then
					FIRST_STEADY_SHOT = 1
				end
			end
		end
	end
end
local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
EventFrame:SetScript("OnEvent", OnEvent)






function AddonTable.SecondSteadyShotReady()
	if s.HasTalent(53221--[[Improved Steady Shot]]) then
		if FIRST_STEADY_SHOT then
			local name = UnitCastingInfo("player")
			for _,v in ipairs(BreakImprovedSteadyShotSpells) do
				if v == name or s.SpellDelay(v) then
					return false
				end
			end
			return true
		elseif s.Casting(56641--[[Steady Shot]], "player") or s.SpellDelay(56641--[[Steady Shot]]) then
			return true
		end
	end
	return false
end

function AddonTable.Stung(unit)
	return s.MyDebuff({
		1978--[[Serpent Sting]],
		19386--[[Wyvern Sting]],
	}, unit)
end

AddonTable.Castable["Auto Shot"] = function()
	local z = {}
	z.SpellID = 75--[[Auto Shot]]
	z.EnemyTargetNeeded = 1
	z.NotIfActive = 1
	return not s.Shooting() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Counterattack"] = function()
	local z = {}
	z.SpellID = 19306--[[Counterattack]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Wing Clip"] = function()
	local z = {}
	z.SpellID = 2974--[[Wing Clip]]
	z.Debuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Raptor Strike"] = function()
	local z = {}
	z.SpellID = 2973--[[Raptor Strike]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end


AddonTable.Castable["Serpent Sting"] = function()
	local z = {}
	z.SpellID = 1978--[[Serpent Sting]]
	z.MyDebuff = {
		1978--[[Serpent Sting]],
		19386--[[Wyvern Sting]],
	}
	z.DebuffSlotNeeded = 1
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Wyvern Sting"] = function()
	local z = {}
	z.SpellID = 19386--[[Wyvern Sting]]
	z.MyDebuff = 1978--[[Serpent Sting]]
	z.EnemyTargetNeeded = 1
	return x.NoCC and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Aimed Shot"] = function()
	local z = {}
	z.SpellID = 19434--[[Aimed Shot]]
	z.EnemyTargetNeeded = 1
	z.NotIfActive = 1
	z.NotWhileMoving = 1
	return not s.InCombat() and not s.SpellDelay(z.SpellID) and (
		not x.ActiveEnemy
		or
		(
			UnitIsPlayer("target")
			and
			(
				(
					x.NoCC and not s.EnemyTargetingYou()
				)
				or
				(
					not x.NoCC and s.DebuffDuration({710--[[Banish]], 33786--[[Cyclone]]}) <= (s.CastTime(z.SpellID) + x.Lag)
				)
			)
		)
	) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Arcane Shot"] = function()
	local z = {}
	z.SpellID = 3044--[[Arcane Shot]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Aspect of the Fox"] = function()
	local z = {}
	z.SpellID = 82661--[[Aspect of the Fox]]
	z.Buff = z.SpellID
	z.BuffUnit = "player"
	return ( GetUnitSpeed("player") > 0 or ( s.MeleeDistance() and s.EnemyTargetingYou() ) ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Aspect of the Hawk"] = function()
	local z = {}
	z.SpellID = 13165--[[Aspect of the Hawk]]
	z.Buff = z.SpellID
	z.BuffUnit = "player"
	return ( not x.Enemy or not s.MeleeDistance() ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Camouflage"] = function()
	local z = {}
	z.SpellID = 51753--[[Camouflage]]
	z.Buff = z.SpellID
	z.BuffUnit = "player"
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Cobra Shot"] = function()
	local z = {}
	z.SpellID = 77767--[[Cobra Shot]]
	z.EnemyTargetNeeded = 1
	z.NotWhileMoving = not s.Buff(82661--[[Aspect of the Fox]], "player")
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Concussive Shot"] = function()
	local z = {}
	z.SpellID = 5116--[[Concussive Shot]]
	--z.Debuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return (
		not s.CastingOrChanneling() or
		( s.Class(nil, "Hunter") and s.Casting({56641--[[Steady Shot]], 77767--[[Cobra Shot]]}) )
		or
		( s.Class(nil, "Warlock") and s.Channeling(1949--[[Hellfire]]) )
	) and s.EnemyTargetingYou() and not s.MovementImpaired() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Disengage"] = function()
	local z = {}
	z.SpellID = 781--[[Disengage]]
	z.EnemyTargetNeeded = 1
	z.NoRangeCheck = 1
	return s.MeleeDistance() and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Hunter's Mark"] = function()
	local z = {}
	z.SpellID = 1130--[[Hunter's Mark]]
	z.Debuff = {
		z.SpellID,
		53241--[[Marked for Death]],
	}
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Kill Command"] = function()
	local z = {}
	z.SpellID = 34026--[[Kill Command]]
	z.NoRangeCheck = 1
	return s.Enemy("pettarget") and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Kill Shot"] = function()
	local z = {}
	z.SpellID = 53351--[[Kill Shot]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end
----
AddonTable.Castable["Master's Call"] = function()
	local z = {}
	z.SpellID = 53271--[[Master's Call]]
	z.NoRangeCheck = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Mend Pet"] = function()
	local z = {}
	z.SpellID = 136--[[Mend Pet]]
	z.Buff = z.SpellID
	z.BuffUnit = "pet"
	return x.PetAlive and ( s.HealthPercent("pet") <= 95  or ( s.HasTalent(19572--[[Improved Mend Pet]]) and s.Debuff(nil,"pet",nil,nil,1) ) ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Multi-Shot"] = function()
	local z = {}
	z.SpellID = 2643--[[Multi-Shot]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Rapid Fire"] = function()
	local z = {}
	z.SpellID = 3045--[[Rapid Fire]]
	z.EnemyTargetNeeded = 1
	return s.InCombat() and s.SpellInRange(75--[[Auto Shot]]) and ( s.HealthPercent() > 25 or UnitIsPlayer("target") or s.Boss() ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Scatter Shot"] = function()
	local z = {}
	z.SpellID = 19503--[[Scatter Shot]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Steady Shot"] = function()
	local z = {}
	z.SpellID = 56641--[[Steady Shot]]
	z.EnemyTargetNeeded = 1
	z.NotWhileMoving = not s.Buff(82661--[[Aspect of the Fox]], "player")
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Tranquilizing Shot"] = function()
	local z = {}
	z.SpellID = 19801--[[Tranquilizing Shot]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Widow Venom"] = function()
	local z = {}
	z.SpellID = 82654--[[Widow Venom]]
	z.Debuff = z.SpellID
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Explosive Shot"] = function()
	local z = {}
	z.SpellID = 53301--[[Explosive Shot]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Intimidation"] = function()
	local z = {}
	z.SpellID = 19577--[[Intimidation]]
	return UnitExists("pettarget") and x.PetNoCC and ( s.GetCastingOrChanneling(nil, "pettarget", 1) > (s.SpellCooldown(z.SpellID) + x.DoubleLag) or ( not UnitPlayerControlled("pettarget") and s.EnemyTargetingYou("pettarget") ) ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Bestial Wrath"] = function()
	local z = {}
	z.SpellID = 19574--[[Bestial Wrath]]
	return UnitExists("pettarget") and ( s.HealthPercent("pettarget") > 25 or UnitIsPlayer("pettarget") or s.Boss("pettarget") ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Black Arrow"] = function()
	local z = {}
	z.SpellID = 3674--[[Black Arrow]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Chimera Shot"] = function()
	local z = {}
	z.SpellID = 53209--[[Chimera Shot]]
	z.EnemyTargetNeeded = 1
	return ( s.AllDebuffSlotsUsed() or AddonTable.Stung() ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Fervor"] = function()
	local z = {}
	z.SpellID = 82726--[[Fervor]]
	z.EnemyTargetNeeded = 1
	return s.PowerMissing("player") >= 50 and ( not UnitExists("pettarget") or s.PowerMissing("pet") >= 50 ) and ( s.HealthPercent() > 25 or UnitIsPlayer("target") or s.Boss() ) and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Focus Fire"] = function()
	local z = {}
	z.SpellID = 82692--[[Focus Fire]]
	return s.BuffStack(19615--[[Frenzy Effect]], "pet") >= 5 and s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Readiness"] = function()
	local z = {}
	z.SpellID = 23989--[[Readiness]]
	z.EnemyTargetNeeded = 1
	return s.CheckIfSpellCastable(z)
end

AddonTable.Castable["Silencing Shot"] = function()
	local z = {}
	z.SpellID = 34490--[[Silencing Shot]]
	z.EnemyTargetNeeded = 1
	return s.GetCastingOrChanneling(nil, nil, 1) > (s.SpellCooldown(z.SpellID) + x.DoubleLag) and s.CheckIfSpellCastable(z)
end


