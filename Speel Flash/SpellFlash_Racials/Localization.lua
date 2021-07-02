local AddonName, AddonTable = ...
AddonTable.Localize = setmetatable({}, {__index = function(_, key) return key end})
AddonTable.OldBuild = select(4, GetBuildInfo()) < (tonumber(GetAddOnMetadata(AddonName, "X-Compatible-With")) or 0)
local L = AddonTable.Localize

if GetLocale() == "frFR" then -- French
-- Example:
-- L["English text goes here."] = "French text goes here."

elseif GetLocale() == "deDE" then -- German
-- Example:
-- L["English text goes here."] = "German text goes here."

elseif GetLocale() == "koKR" then -- Korean
-- Example:
-- L["English text goes here."] = "Korean text goes here."

elseif GetLocale() == "esMX" then -- Latin American Spanish
-- Example:
-- L["English text goes here."] = "Latin American Spanish text goes here."

elseif GetLocale() == "ruRU" then -- Russian
-- Example:
-- L["English text goes here."] = "Russian text goes here."

elseif GetLocale() == "zhCN" then -- Simplified Chinese
-- Example:
-- L["English text goes here."] = "Simplified Chinese text goes here."

elseif GetLocale() == "esES" then -- Spanish
-- Example:
-- L["English text goes here."] = "Spanish text goes here."

elseif GetLocale() == "zhTW" then -- Traditional Chinese
-- Example:
-- L["English text goes here."] = "Traditional Chinese text goes here."

end