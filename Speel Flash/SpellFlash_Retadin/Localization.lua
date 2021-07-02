-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/spellflash_retadin/localization/

local AddonName, AddonTable = ...
AddonTable.Localize = setmetatable({}, {__index = function(_, key) return key end})
AddonTable.OldBuild = select(4, GetBuildInfo()) < (tonumber(GetAddOnMetadata(AddonName, "X-Compatible-With")) or 0)
local L = AddonTable.Localize

if GetLocale() == "frFR" then -- French
-- L["Retribution"] = ""

elseif GetLocale() == "deDE" then -- German
-- L["Retribution"] = ""

elseif GetLocale() == "koKR" then -- Korean
-- L["Retribution"] = ""

elseif GetLocale() == "esMX" then -- Latin American Spanish
-- L["Retribution"] = ""

elseif GetLocale() == "ruRU" then -- Russian
-- L["Retribution"] = ""

elseif GetLocale() == "zhCN" then -- Simplified Chinese
-- L["Retribution"] = ""

elseif GetLocale() == "esES" then -- Spanish
-- L["Retribution"] = ""

elseif GetLocale() == "zhTW" then -- Traditional Chinese
-- L["Retribution"] = ""

end