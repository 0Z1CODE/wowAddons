-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/spellflash-priest/localization/

local AddonName, AddonTable = ...
AddonTable.Localize = setmetatable({}, {__index = function(_, key) return key end})
AddonTable.OldBuild = select(4, GetBuildInfo()) < (tonumber(GetAddOnMetadata(AddonName, "X-Compatible-With")) or 0)
local L = AddonTable.Localize

if GetLocale() == "frFR" then -- French

elseif GetLocale() == "deDE" then -- German

elseif GetLocale() == "koKR" then -- Korean

elseif GetLocale() == "esMX" then -- Latin American Spanish

elseif GetLocale() == "ruRU" then -- Russian

elseif GetLocale() == "zhCN" then -- Simplified Chinese

elseif GetLocale() == "esES" then -- Spanish

elseif GetLocale() == "zhTW" then -- Traditional Chinese

end