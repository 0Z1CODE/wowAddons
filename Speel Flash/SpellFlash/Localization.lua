﻿-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/spellflash/localization/

local AddonName, AddonTable = ...
AddonTable.Localize = setmetatable({}, {__index = function(_, key) return key end})
AddonTable.OldBuild = select(4, GetBuildInfo()) < (tonumber(GetAddOnMetadata(AddonName, "X-Compatible-With")) or 0)
local L = AddonTable.Localize

if GetLocale() == "frFR" then -- French
L["Add Name or Target to List"] = "ajouter le nom ou la cible a la liste"
L["Asleep"] = "Endormi"
L["Blink Spells"] = "clignotement des sort"
L["Clear Collected Immune Mob Database For All Characters"] = "effacer la liste des immunité des mob a ignorer "
L["Configure Class Module"] = "configuration le module de la classe"
L["Debuff Owner Checking"] = "vérification du possesseur du debuff"
L["Flash Brightness:"] = "luminosité de l'eclat"
L["Flash Macros"] = "éclat sur les macro"
L["Flash Size:"] = "taille de l'éclat "
L["Immune Mob Ignore List:"] = "liste le l'immunité des mob a ignorer"
L["Mob Immunity Detection"] = "détection de l'immunité du mob"
L["Movement Check"] = "vérification du mouvement"
L["Range Check"] = "vérification de la distance"
L["Remove Selection from List"] = "retirer l'élément sélectionné de la liste "
L["Selected Class Module:"] = "sélectionner le module de classe"
L["Shields"] = "Boucliers"
L["Spell Flashing"] = "éclat"
L["SpellFlash settings have been reset for all players"] = "toute les configuration ont bien été réinitialise pour tout les personnages"
L["SpellFlash: Enabled checking to see if debuffs are from you."] = "éclat : active la vérification pour voir si le debuff vient de vous"
L["Use All Class Modules"] = "utiliser tout les module de classe"

elseif GetLocale() == "deDE" then -- German
L["Add Name or Target to List"] = "Name oder Ziel zur Liste hinzufügen"
L["Asleep"] = "Schlafend"
L["Blink Spells"] = "Zaubersprüche aufblinken"
L["Clear Collected Immune Mob Database For All Characters"] = "DAtensammlung immuner Mobs bei allen Charakteren löschen"
L["Configure Class Module"] = "Klassen-Module konfigurieren"
L["Debuff Owner Checking"] = "Überprüfung der Besitzer von Schwächungszaubern"
L["Flash Brightness:"] = "Aufblitz-Leuchtkraft:"
L["Flash Macros"] = "Aufblitz-Makros"
L["Flash Size:"] = "Aufblitz-Größe:"
L["Immune Mob Ignore List:"] = "Ignorierliste immuner Mobs:"
L["Mob Immunity Detection"] = "Erkennung gegnerischer Immunitäten"
L["Movement Check"] = "Bewegungsüberprüfung"
L["Range Check"] = "Reichweitenüberprüfung"
L["Remove Selection from List"] = "Auswahl aus der Liste entfernen"
L["Selected Class Module:"] = "Ausgewählte Klassen-Module:"
L["Shields"] = "Schilde"
L["Spell Flashing"] = "Aufblitzende Zauber"
L["SpellFlash settings have been reset for all players"] = "SpellFlash-Einstellungen wurden für alle Spieler zurückgesetzt."
L["SpellFlash: Enabled checking to see if debuffs are from you."] = "SpellFlash: Überprüfung, ob die Schwächungszauber von dir stammen, ist aktiviert."
L["Use All Class Modules"] = "Alle Klassen-Module verwenden"

elseif GetLocale() == "koKR" then -- Korean
-- L["Add Name or Target to List"] = ""
-- L["Asleep"] = ""
-- L["Blink Spells"] = ""
-- L["Clear Collected Immune Mob Database For All Characters"] = ""
-- L["Configure Class Module"] = ""
-- L["Debuff Owner Checking"] = ""
-- L["Flash Brightness:"] = ""
-- L["Flash Macros"] = ""
-- L["Flash Size:"] = ""
-- L["Immune Mob Ignore List:"] = ""
-- L["Mob Immunity Detection"] = ""
-- L["Movement Check"] = ""
-- L["Range Check"] = ""
-- L["Remove Selection from List"] = ""
-- L["Selected Class Module:"] = ""
-- L["Shields"] = ""
-- L["Spell Flashing"] = ""
-- L["SpellFlash settings have been reset for all players"] = ""
-- L["SpellFlash: Enabled checking to see if debuffs are from you."] = ""
-- L["Use All Class Modules"] = ""

elseif GetLocale() == "esMX" then -- Latin American Spanish
-- L["Add Name or Target to List"] = ""
-- L["Asleep"] = ""
-- L["Blink Spells"] = ""
-- L["Clear Collected Immune Mob Database For All Characters"] = ""
-- L["Configure Class Module"] = ""
-- L["Debuff Owner Checking"] = ""
-- L["Flash Brightness:"] = ""
-- L["Flash Macros"] = ""
-- L["Flash Size:"] = ""
-- L["Immune Mob Ignore List:"] = ""
-- L["Mob Immunity Detection"] = ""
-- L["Movement Check"] = ""
-- L["Range Check"] = ""
-- L["Remove Selection from List"] = ""
-- L["Selected Class Module:"] = ""
-- L["Shields"] = ""
-- L["Spell Flashing"] = ""
-- L["SpellFlash settings have been reset for all players"] = ""
-- L["SpellFlash: Enabled checking to see if debuffs are from you."] = ""
-- L["Use All Class Modules"] = ""

elseif GetLocale() == "ruRU" then -- Russian
-- L["Add Name or Target to List"] = ""
L["Asleep"] = "Сон"
-- L["Blink Spells"] = ""
-- L["Clear Collected Immune Mob Database For All Characters"] = ""
-- L["Configure Class Module"] = ""
-- L["Debuff Owner Checking"] = ""
-- L["Flash Brightness:"] = ""
-- L["Flash Macros"] = ""
-- L["Flash Size:"] = ""
-- L["Immune Mob Ignore List:"] = ""
-- L["Mob Immunity Detection"] = ""
-- L["Movement Check"] = ""
-- L["Range Check"] = ""
-- L["Remove Selection from List"] = ""
-- L["Selected Class Module:"] = ""
L["Shields"] = "Щиты" -- Needs review
-- L["Spell Flashing"] = ""
-- L["SpellFlash settings have been reset for all players"] = ""
-- L["SpellFlash: Enabled checking to see if debuffs are from you."] = ""
-- L["Use All Class Modules"] = ""

elseif GetLocale() == "zhCN" then -- Simplified Chinese
-- L["Add Name or Target to List"] = ""
-- L["Asleep"] = ""
-- L["Blink Spells"] = ""
-- L["Clear Collected Immune Mob Database For All Characters"] = ""
-- L["Configure Class Module"] = ""
-- L["Debuff Owner Checking"] = ""
-- L["Flash Brightness:"] = ""
-- L["Flash Macros"] = ""
-- L["Flash Size:"] = ""
-- L["Immune Mob Ignore List:"] = ""
-- L["Mob Immunity Detection"] = ""
-- L["Movement Check"] = ""
-- L["Range Check"] = ""
-- L["Remove Selection from List"] = ""
-- L["Selected Class Module:"] = ""
-- L["Shields"] = ""
-- L["Spell Flashing"] = ""
-- L["SpellFlash settings have been reset for all players"] = ""
-- L["SpellFlash: Enabled checking to see if debuffs are from you."] = ""
-- L["Use All Class Modules"] = ""

elseif GetLocale() == "esES" then -- Spanish
-- L["Add Name or Target to List"] = ""
L["Asleep"] = "Dormido"
-- L["Blink Spells"] = ""
-- L["Clear Collected Immune Mob Database For All Characters"] = ""
-- L["Configure Class Module"] = ""
-- L["Debuff Owner Checking"] = ""
-- L["Flash Brightness:"] = ""
-- L["Flash Macros"] = ""
-- L["Flash Size:"] = ""
-- L["Immune Mob Ignore List:"] = ""
-- L["Mob Immunity Detection"] = ""
-- L["Movement Check"] = ""
-- L["Range Check"] = ""
-- L["Remove Selection from List"] = ""
-- L["Selected Class Module:"] = ""
L["Shields"] = "Escudos" -- Needs review
-- L["Spell Flashing"] = ""
-- L["SpellFlash settings have been reset for all players"] = ""
-- L["SpellFlash: Enabled checking to see if debuffs are from you."] = ""
-- L["Use All Class Modules"] = ""

elseif GetLocale() == "zhTW" then -- Traditional Chinese
-- L["Add Name or Target to List"] = ""
-- L["Asleep"] = ""
-- L["Blink Spells"] = ""
-- L["Clear Collected Immune Mob Database For All Characters"] = ""
-- L["Configure Class Module"] = ""
-- L["Debuff Owner Checking"] = ""
-- L["Flash Brightness:"] = ""
-- L["Flash Macros"] = ""
-- L["Flash Size:"] = ""
-- L["Immune Mob Ignore List:"] = ""
-- L["Mob Immunity Detection"] = ""
-- L["Movement Check"] = ""
-- L["Range Check"] = ""
-- L["Remove Selection from List"] = ""
-- L["Selected Class Module:"] = ""
L["Shields"] = "盾牌" -- Needs review
-- L["Spell Flashing"] = ""
-- L["SpellFlash settings have been reset for all players"] = ""
-- L["SpellFlash: Enabled checking to see if debuffs are from you."] = ""
-- L["Use All Class Modules"] = ""

end