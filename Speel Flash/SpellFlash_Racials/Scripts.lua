local AddonName, AddonTable = ...
if AddonTable.OldBuild then return end
local L = AddonTable.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local function RunSpamTable(...)
	local i = s.GetModuleConfig(AddonName, "script_number") or 1
	if type(AddonTable.Spam[i]) == "table" and type(AddonTable.Spam[i].Function) == "function" then
		AddonTable.Spam[i].Function(...)
	elseif type(AddonTable.Spam[1]) == "table" and type(AddonTable.Spam[1].Function) == "function" then
		s.SetModuleConfig(AddonName, "script_number", nil)
		AddonTable.Spam[1].Function(...)
	end
end

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


function AddonTable.HUMAN()
	if s.Flashable(59752--[[Every Man for Himself]]) and Castable("Every Man for Himself") then
		s.Flash(59752--[[Every Man for Himself]], "Aqua")
	end
end

function AddonTable.UNDEAD()
	if s.Flashable(7744--[[Will of the Forsaken]]) and Castable("Will of the Forsaken") then
		s.Flash(7744--[[Will of the Forsaken]], "Aqua")
	end
end

function AddonTable.DWARF()
	if s.Flashable(20594--[[Stoneform]]) and Castable("Stoneform") then
		s.Flash(20594--[[Stoneform]], "Aqua")
	end
end

function AddonTable.BLOODELF()
	if s.Flashable(28730--[[Arcane Torrent]]) and Castable("Arcane Torrent") then
		s.Flash(28730--[[Arcane Torrent]], "Aqua")
	end
end

function AddonTable.TROLL()
	if s.Flashable(26297--[[Berserking]]) and Castable("Berserking") then
		s.Flash(26297--[[Berserking ]], "Green")
	end
end

function AddonTable.ORC()
	if s.Flashable(20572--[[Blood Fury]]) and Castable("Blood Fury") then
		s.Flash(20572--[[Blood Fury ]], "Green")
	end
end

function AddonTable.GNOME()
	if s.Flashable(20589--[[Escape Artist]]) and Castable("Escape Artist") then
		s.Flash(20589--[[Escape Artist]], "Aqua")
	end
end

function AddonTable.TAUREN()
	if s.Flashable(20549--[[War Stomp]]) and Castable("War Stomp") then
		s.Flash(20549--[[War Stomp]], "Aqua")
	end
end

function AddonTable.GOBLIN()
	if s.Flashable(69041--[[Rocket Barrage]]) and Castable("Rocket Barrage") then
		s.Flash(69041--[[Rocket Barrage]], SetColor(x.ActiveEnemy))
	end
end

local RACE = s.Race("player")

-- Use this single spam function and remove the multiple spam table below, or just use the multiple spam table below and leave this function in place.
s.Spam[AddonName] = function()
	if s.GetModuleConfig(AddonName, "spell_flashing_off") then return elseif AddonTable.Spam then RunSpamTable() else
		-- x.Enemy, x.ActiveEnemy, x.NoCC, x.InInstance, x.InstanceType, x.PetAlive, x.PetActiveEnemy, x.PetNoCC, x.Lag, x.DoubleLag, x.ThreatPercent
		
		AddonTable[RACE]()
		
	end
end

