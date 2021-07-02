-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/spellflashcore/localization/

local AddonName, AddonTable = ...
AddonTable.Localize = setmetatable({}, {__index = function(_, key) return key end})
AddonTable.OldBuild = select(4, GetBuildInfo()) < (tonumber(GetAddOnMetadata(AddonName, "X-Compatible-With")) or 0)
local L = AddonTable.Localize

if GetLocale() == "frFR" then -- French
-- L["all settings cleared"] = ""
-- L["debug is disabled"] = ""
-- L["debug is enabled"] = ""

elseif GetLocale() == "deDE" then -- German
-- L["all settings cleared"] = ""
L["debug is disabled"] = "Fehlersuche ist deaktiviert"
L["debug is enabled"] = "Fehlersuche ist aktiviert"

elseif GetLocale() == "koKR" then -- Korean
-- L["all settings cleared"] = ""
-- L["debug is disabled"] = ""
-- L["debug is enabled"] = ""

elseif GetLocale() == "esMX" then -- Latin American Spanish
-- L["all settings cleared"] = ""
-- L["debug is disabled"] = ""
-- L["debug is enabled"] = ""

elseif GetLocale() == "ruRU" then -- Russian
-- L["all settings cleared"] = ""
-- L["debug is disabled"] = ""
-- L["debug is enabled"] = ""

elseif GetLocale() == "zhCN" then -- Simplified Chinese
-- L["all settings cleared"] = ""
-- L["debug is disabled"] = ""
-- L["debug is enabled"] = ""

elseif GetLocale() == "esES" then -- Spanish
-- L["all settings cleared"] = ""
-- L["debug is disabled"] = ""
-- L["debug is enabled"] = ""

elseif GetLocale() == "zhTW" then -- Traditional Chinese
-- L["all settings cleared"] = ""
-- L["debug is disabled"] = ""
-- L["debug is enabled"] = ""

end