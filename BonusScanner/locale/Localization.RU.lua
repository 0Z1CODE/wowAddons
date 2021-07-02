-- Russian localization by StingerSoft (work in progress)
local L = LibStub("AceLocale-3.0"):NewLocale("BonusScanner","ruRU")
if not L then return end
-- bonus names
L["BONUSSCANNER_NAMES"] = {
--Base Stats
	STR 		= "Сила",
	AGI 		= "Ловкость",
	STA 		= "Выносливость",
	INT 		= "Интеллект",
	SPI 		= "Дух",
	ARMOR 	= "Броня",

--Resistances
	ARCANERES = "Сопротивление тайной магии",	
	FIRERES 	= "Сопротивление огню",
	NATURERES = "Сопротивление силам природы",
	FROSTRES 	= "Сопротивление магии льда",
	SHADOWRES = "Сопротивление темной магии",

--Skills
	FISHING 	= "Рыбная ловля",
	MINING 		= "Горное дело",
	HERBALISM = "Травничество",
	SKINNING 	= "Снятие шкур",
	DEFENSE 	= "Рейтинг защиты",
	EXPERTISE = "Мастерство",
	
--Abilities
	BLOCK		= "Рейтинг блока",
	BLOCKVALUE	= "Показатель блокирования",
	DODGE 		= "Рейтинг уклонения",
	PARRY 		= "Рейтинг парирования",
	RESILIENCE = "Устойчивость", 
	DMGWPN = "Повышение урона в близи", 
	RANGEDDMG = "Урон оружия дальнего боя",
	ARMORPEN = "Рейтинг пробивания брони",

-- DPS
	DPSMAIN = "Main Weapon(s) DPS",
	DPSRANGED = "Ranged Weapon DPS",
	DPSTHROWN = "Thrown Weapon DPS",

--Attack Power
	ATTACKPOWER	= "Сила атаки",
	ATTACKPOWERUNDEAD	= "Attack Power against Undead",
	ATTACKPOWERFERAL	= "Attack Power in feral form",
	RANGEDATTACKPOWER = "Ranged Attack Power",
	
--Critical
	CRIT 		= "Рейтинг крит. удара ближ. боя",	
	RANGEDCRIT 	= "Рейтинг крит. удара дальн. боя",
	--HOLYCRIT 	= "Crit. Holy Spell", -- Investigation

--Hit
	TOHIT 		= "Рейтинг меткости",
	RANGEDHIT	= "Рейтинг меткости (оруж. дальн. боя)",	
  
--Haste
	HASTE = "Рейтинг скорости",

--Spell Damage/healing
	DMGUNDEAD	= "Spell Damage against Undead",
	ARCANEDMG 	= "Arcane Damage",
	FIREDMG 	= "Fire Damage",
	FROSTDMG 	= "Frost Damage",
	HOLYDMG 	= "Holy Damage",
	NATUREDMG 	= "Nature Damage",
	SHADOWDMG 	= "Shadow Damage",
	SPELLPEN 	= "Spell Penetration",
  SPELLPOW = "Сила заклинаний", 

--Regen
	HEALTHREG 	= "Life Regeneration",
	MANAREG 	= "Mana Regeneration",

--Health/mana
	HEALTH = "Life Points",
	MANA = "Mana Points",
	
--Extra bonuses
  THREATREDUCTION = "% Reduced Threat",
  THREATINCREASE = "% Increased Threat",
  INCRCRITDMG = "% Increased Critical Damage",
  SPELLREFLECT = "% Spell Reflect",
  STUNRESIST = "% Stun Resistance",
  PERCINT = "% Intellect",
  PERCBLOCKVALUE = "% Shield Block Value",
 
-- WOTLK Metagems
  PERCARMOR = "% Increased Armor Value",
  PERCMANA ="% Mana",
  PERCREDSPELLDMG = "% Reduced Spell Damage Taken",
  PERCSNARE = "% Reduced Snare/Root Duration",
  PERCSILENCE = "% Reduced Silence Duration",
  PERCFEAR = "% Reduced Fear Duration",
  PERCSTUN = "% Reduced Stun Duration",
  PERCCRITHEALING = "% Increased Critical Healing",  
};

-- equip and set bonus prefixes:
--L["BONUSSCANNER_PREFIX_EQUIP"] = "Equip: "; --no longer used but kept in case Blizzard decides to alter its own global string referring to this
L["BONUSSCANNER_PREFIX_SET"] = "Коплект: ";
L["BONUSSCANNER_PREFIX_SOCKET"] = "При соответствии цвета: ";
L["BONUSSCANNER_WEAPON_SPEED"] = "Скорость";
L["BONUSCANNER_GEM_STRINGS"] = {
	-- red
	["Для красного гнезда"] = { red = 1, yellow = 0, blue = 0, prismatic = 0},
	-- blue
	["Для синего гнезда"] = { red = 0, yellow = 0, blue = 1, prismatic = 0},
	-- yellow
	["Для желтого гнезда"] = { red = 0, yellow = 1, blue = 0, prismatic = 0},
	-- purple
	["Для красного или синего гнезда"] = { red = 1, yellow = 0, blue = 1, prismatic = 0},
	["Для синего или красного гнезда"] = { red = 1, yellow = 0, blue = 1, prismatic = 0},
	-- green
	["Для синего или желтого гнезда"] = { red = 0, yellow = 1, blue = 1, prismatic = 0},
	["Для желтого или синего гнезда"] = { red = 0, yellow = 1, blue = 1, prismatic = 0},
	-- orange
	["Для красного или желтого гнезда"] = { red = 1, yellow = 1, blue = 0, prismatic = 0},
	["Для желтого или красного гнезда"] = { red = 1, yellow = 1, blue = 0, prismatic = 0},
	-- prismatic
	["Подходит для любого гнезда"] = { red = 0, yellow = 0, blue = 0, prismatic = 1},
	["Для красного, желтого или синего гнезда"] = { red = 0, yellow = 0, blue = 0, prismatic = 1}
}

-- Enchant separators
L["BONUSSCANNER_GLOBAL_SEP"] = " +";
L["BONUSSCANNER_SEPARATORS"] = { "/", ", ", " & ", " и " };

-- passive bonus patterns. checked against lines which start with above prefixes
L["BONUSSCANNER_PATTERNS_PASSIVE"] = {
--Skills
	{ pattern = "Рейтинг защиты %+(%d+)%.", effect = "DEFENSE" }, --jmlsteele
  { pattern = "Рейтинг устойчивости %+(%d+)%.", effect = "RESILIENCE" }, 
  { pattern = "Рейтинг мастерства %+(%d+)%.", effect = "EXPERTISE" },
  { pattern = "Навык рыбной ловли увеличивается на (%d+)%.", effect = "FISHING" }, -- fishing poles

-- Abilities
	{ pattern = "Увеличение рейтинга блока на (%d+) ед%.", effect = "BLOCK" },
	{ pattern = "Рейтинг блока %+(%d+).", effect = "BLOCK" },
	{ pattern = "Рейтинг блокирования щитом %+(%d+)%.", effect = "BLOCK" },
	{ pattern = "Увеличивает показатель блокирования вашего щита на (%d+) ед%.", effect = "BLOCKVALUE" },
	{ pattern = "Рейтинг защиты %+(%d+)%.", effect = "DEFENSE" },
	{ pattern = "Рейтинг уклонения %+(%d+)%.", effect = "DODGE" },
	{ pattern = "Рейтинг парирования %+(%d+)%.", effect = "PARRY" },
	{ pattern = "%+(%d+) к урону оружием%.", effect = "DMGWPN" }, -- Might of Cenarius... 

--Crit
	{ pattern = "Увеличение вероятности нанесения критического урона на (%d+) ед%.", effect = "CRIT" },
	{ pattern = "Повышает рейтинг критического удара на (%d+)%.", effect = "CRIT" },
	{ pattern = "Рейтинг критического удара %+(%d+)%.", effect = {"CRIT", "RANGEDCRIT"} }, 
	--{ pattern = "Improves melee critical strike rating by (%d+)%.", effect = "CRIT" },
	--{ pattern = "Increases your ranged critical strike rating by (%d+)%.", effect = "RANGEDCRIT" },
	
--Damage/Heal/Spell Power
  { pattern = "Увеличивает силу заклинаний на (%d+)%.", effect = "SPELLPOW" }, 
  { pattern = "Увеличивает вашу силу заклинаний на (%d+)%.", effect = "SPELLPOW" },
  { pattern = "Увеличение наносимого игроком урона от магических эффектов и заклинаний на (%d+)%.", effect = "SPELLPOW" },
  { pattern = "Увеличивает силу заклинаний темной магии на (%d+)%.", effect = "SHADOWDMG" }, 
  { pattern = "Увеличивает силу заклинаний тайной магии на (%d+)%.", effect = "ARCANEDMG" }, 
  { pattern = "Увеличивает силу заклинаний магии огня на (%d+)%.", effect = "FIREDMG" }, 
  { pattern = "Увеличивает силу заклинаний магии льда на (%d+)%.", effect = "FROSTDMG" }, 
  { pattern = "Увеличивает силу заклинаний светлой магии на (%d+)%.", effect = "HOLYDMG" }, 
  { pattern = "Увеличивает силу заклинаний природы на (%d+)%.", effect = "NATUREDMG" },
	{ pattern = "Слегка увеличивает силу заклинаний%.", effect = "SPELLPOW", value = 6 },
	{ pattern = "Увеличивает силу заклинаний, применяемых против нежити, на (%d+)", effect = "DMGUNDEAD" },
	
	-- Multibonus Equip patterns
	{ pattern = "Увеличивает силу заклинаний членов группы, находящихся не далее, чем в %d+ м, на (%d+)%.", effect = "SPELLPOW" },	
	{ pattern = "Увеличивает сопротивление прислужника магии на 130, а вашу силу заклинаний – на (%d+)%.", effect = "SPELLPOW" }, -- Void Star Talisman
	--{ pattern = "Increases healing done by up to (%d+) and damage done by up to (%d+) for all magical spells and effects%.", effect = {"HEAL","DMG"} },
	--{ pattern = "Increases your spell damage by up to (%d+) and your healing by up to (%d+)%.", effect = {"DMG","HEAL"} },
	--{ pattern = "Increases healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%. ", effect = "HEAL" },
	--{ pattern = "Increases damage and healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%.", effect = {"HEAL", "DMG"} },
	{ pattern = "Восполнение (%d+) ед. маны раз в 5 секунд у всех участников группы в радиусе %d+ м%.", effect = "MANAREG" },
	{ pattern = "Повышает рейтинг критического поражения заклинаний всех участников группы в радиусе %d+ м на (%d+)%.", effect = "CRIT" }, --SPELLCRIT
	{ pattern = "Увеличивает рейтинг защиты на (%d+), сопротивления темной магии – на (%d+) ед. и скорости восполнения здоровья – на (%d+)%.", effect = {"DEFENSE", "SHADOWRES", "HEALTHREG"} },
	
--Attack power
	{ pattern = "Сила атаки увеличена на (%d+)%.", effect = "ATTACKPOWER" },
	{ pattern = "Увеличивает силу атаки на (%d+)%.", effect = "ATTACKPOWER" },
	{ pattern = "Увеличение силы атаки ближнего и дальнего боя на (%d+) ед%.", effect = {"ATTACKPOWER","RANGEDATTACKPOWER"} }, -- Andonisus, Reaper of Souls pattern
	{ pattern = "+(%d+) к силе атаки дальнего боя%.", effect = "RANGEDATTACKPOWER" },
	{ pattern = "Увеличивает силу атаки дальнего боя на (%d+)%.", effect = "RANGEDATTACKPOWER" },
  { pattern = "Увеличивает силу атаки на (%d+) в облике кошки, медведя, лютого медведя или лунного совуха%.", effect = "ATTACKPOWERFERAL" },
  { pattern = "Увеличение силы атаки на (%d+) ед. в бою с нежитью%.", effect = "ATTACKPOWERUNDEAD" },
  { pattern = "Увеличение силы атаки на (%d+) ед. в битве с нежитью%.", effect = "ATTACKPOWERUNDEAD" },
  { pattern = "+(%d+) к силе атаки в бою с нежитью%.", effect = "ATTACKPOWERUNDEAD" },
  { pattern = "+(%d+) к силе атаки в битве с нежитью%.", effect = "ATTACKPOWERUNDEAD" },
  
--Regen
	{ pattern = "Восполняет (%d+) ед. здоровья каждые 5 секунд%.", effect = "HEALTHREG" }, 
	{ pattern = "Восполнение (%d+) ед. здоровья раз в 5 секунд%.", effect = "HEALTHREG" },  -- both versions ('per' and 'every') seem to be used
	{ pattern = "Восполнение (%d+) ед. маны раз в 5 секунд%.", effect = "MANAREG" },
	{ pattern = "Восполняет (%d+) ед. маны каждые 5 секунд%.", effect = "MANAREG" },
	
--Hit
	{ pattern = "Повышает рейтинг меткости на (%d+)%.", effect = "TOHIT" },
	{ pattern = "Рейтинг меткости %+(%d+)%.", effect = "TOHIT" }, 	
	
--Haste
	{ pattern = "Рейтинг скорости %+(%d+)%.", effect = "HASTE" },
		
--Penetration
	{ pattern = "Уменьшение сопротивления магии целей заклинаний на (%d+).", effect = "SPELLPEN" },
	{ pattern = "Увеличивает проникающую способность заклинаний на (%d+)%.", effect = "SPELLPEN" },	
	{ pattern = "Повышает рейтинг пробивания брони на (%d+)%.", effect = "ARMORPEN" },
	{ pattern = "Увеличивает рейтинг пробивания брони на (%d+)%.", effect = "ARMORPEN" }	
};

-- generic patterns have the form "+xx bonus" or "bonus +xx" or even "xx bonus" with an optional % sign after the value.

-- first the generic bonus string is looked up in the following table
L["BONUSSCANNER_PATTERNS_GENERIC_LOOKUP"] = {
	["ко всем характеристикам"] 			= {"STR", "AGI", "STA", "INT", "SPI"},
	--["to All Stats"] 			= {"STR", "AGI", "STA", "INT", "SPI"},
	["к силе"]			= "STR",
	["к ловкости"]			= "AGI",
	["к выносливости"]			= "STA",
	["к интеллекту"]			= "INT",
	["к духу"] 			= "SPI",

	["ко всем видам сопротивления"] 	= { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}, -- obsidian items
	["Сопротивление всему"] 	= { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}, -- prismatic gems

	["к навыку рыбной ловли"]		= "FISHING",
	["Приманка"]	= "FISHING",
	["Навык рыбной ловли увеличивается на"]	= "FISHING",
	["к навыку горного дела"]		= "MINING",
	["к навыку травничества"]		= "HERBALISM",
	["к навыку снятия шкур"]		= "SKINNING",
	["к рейтингу защиты"]		= "DEFENSE",
	["Повышение защиты"]	= "DEFENSE",

	["к силе атаки"] 	= "ATTACKPOWER",
  --["Attack Power when fighting Undead"] = "ATTACKPOWERUNDEAD",  -- do not find it
  ["к силе атаки против нежити"] = "ATTACKPOWERUNDEAD",
	["силу атаки ближнего боя в облике кошки, медведя и лютого медведя"] = "ATTACKPOWERFERAL", --need check
	["к урону оружием"] = "DMGWPN",
	
	-- TBC/Wotlk Patterns Generic/Gems/Sockets
	
	["к силе заклинаний"] = "SPELLPOW",
	["к рейтингу критического удара"] = "CRIT",
	--["Critical strike rating"] = "CRIT", -- do not find it
	--["Critical Rating"] = "CRIT", -- do not find it
	--["Crit Rating"] = "CRIT", -- do not find it
	--["Ranged Critical Strike"] = "RANGEDCRIT", -- do not find it
	["к проникающей способности заклинаний"] = "SPELLPEN",
	["к рейтингу пробивания брони"] = "ARMORPEN",	
	["к рейтингу защиты"] = "DEFENSE",
	["к рейтингу скорости"] = "HASTE",
	["Mana per 5 Seconds"] = "MANAREG",
	["mana per 5 seconds"] = "MANAREG",
	["Mana every 5 Sec"] = "MANAREG",
	["Mana every 5 seconds"] = "MANAREG",
	["Mana restored per 5 seconds"] = "MANAREG",
	["Mana Per 5 sec"] = "MANAREG",
	["mana per 5 sec"] = "MANAREG",
	["Mana per 5 Sec"] = "MANAREG",
	["Mana per 5 sec"] = "MANAREG",
	["к рейтингу уклонения"] 		= "DODGE",
	["к рейтингу парирования"] 		= "PARRY",
	["к рейтингу устойчивости"] = "RESILIENCE",
	--["Melee Damage"] = "DMGWPN", --do not find it
	["к рейтингу мастерства"] = "EXPERTISE",
	
	-- End TBC Patterns
	
	["Dodge"] 		= "DODGE",
	["Block"]		= "BLOCKVALUE",
	["к показателю блокирования"]		= "BLOCKVALUE",
	["к рейтингу блока"]		= "BLOCK",
	["к рейтингу блока щитом"]		= "BLOCK",
	--["Blocking"]		= "BLOCK", -- ??
	--["Hit"] 		= "TOHIT",  -- ??
	["к рейтингу меткости"] = "TOHIT",	
	--["Ranged Hit Rating"] = "RANGEDHIT", -- ??
	["к силе атаки дальнего боя"]	= "RANGEDATTACKPOWER",
	--["ranged Attack Power"]	= "RANGEDATTACKPOWER", -- Experimental for TBC 
	["Health per 5 sec"]	= "HEALTHREG",-- need check
	["health every 5 sec"]	= "HEALTHREG",-- need check
	["Healing"] = "HEAL",-- need check
	["исцеляющими заклинаниями"] 	= "HEAL",
	["Повышение исцеления"] 	= "HEAL",
	["mana every 5 sec"] 	= "MANAREG",-- need check
	["Mana Regen"]		= "MANAREG",-- need check
	["Critical"]		= "CRIT",-- need check
	["Critical Hit"]	= "CRIT",-- need check
	["Health"]		= "HEALTH",-- need check
	["HP"]			= "HEALTH",-- need check
	["Mana"]		= "MANA",
	["к броне"]		= "ARMOR",
	["Усиленный"]	= "ARMOR", -- need check
	["Resilience"]			= "RESILIENCE",-- need check
	
	-- Patterns for color coded/special lines
	
	["Сниженная угроза"] = "THREATREDUCTION",
	["снижение угрозы на"] = "THREATREDUCTION",
	["Увеличенный критический урон"] = "INCRCRITDMG",
	["отражения заклинаний"] = "SPELLREFLECT",
	["вероятность отразить заклинание"] = "SPELLREFLECT",
	["Сопротивление оглушению"] = "STUNRESIST",
	["к сопротивлению оглушению"] = "STUNRESIST",
	["Shield Block Value"] = "PERCBLOCKVALUE",
	["увеличение показателя брони от носимой экипировки на"] = "PERCARMOR",
	["уменьшение получаемого урона от заклинаний на"] = "PERCREDSPELLDMG",	
	["уменьшение длительности эффекта немоты на"] = "PERCSILENCE",
	["уменьшение длительности эффекта страха на"] = "PERCFEAR",
	["время действия оглушения снижено на"] = "PERCSTUN",
	["сковывания на"] = "PERCSNARE",
	["к критическим эффектам лечения"] = "PERCCRITHEALING",
};	

-- next we try to match against one pattern of stage 1 and one pattern of stage 2 and concatenate the effect strings
L["BONUSSCANNER_PATTERNS_GENERIC_STAGE1"] = {
	{ pattern = "Arcane", 	effect = "ARCANE" },	
	{ pattern = "Fire", 	effect = "FIRE" },	
	{ pattern = "Frost", 	effect = "FROST" },	
	{ pattern = "Holy", 	effect = "HOLY" },	
	{ pattern = "Shadow",	effect = "SHADOW" },	
	{ pattern = "Nature", 	effect = "NATURE" }
}; 	

L["BONUSSCANNER_PATTERNS_GENERIC_STAGE2"] = {
	{ pattern = "Resist", 	effect = "RES" },	
	{ pattern = "Damage", 	effect = "DMG" },
	{ pattern = "Effects", 	effect = "DMG" }
}; 	

-- finally if we got no match, we match against some special enchantment patterns.
L["BONUSSCANNER_PATTERNS_OTHER"] = {
-- Infused Amethyst
	{ pattern = "%+(%d+)к силе заклинаний и %+(%d+) к выносливости", effect = {"SPELLPOW", "STA"} },
	
-- special patterns that cannot be handled any other way
	{ pattern = "%+21 к рейтингу критического удара и %+2%% к мане", effect = {"CRIT", "PERCMANA"}, value = {21, 2} },
	{ pattern = "%+12 к рейтингу критического удара и уменьшение длительности эффектов оплетения/сковывания на 10%%", effect = {"CRIT", "PERCSNARE"}, value = {12, 10} },
	{ pattern = "%+21 к рейтингу критического удара и уменьшение длительности эффектов оплетения/сковывания на  10%%", effect = {"CRIT", "PERCSNARE"}, value = {21, 10} },
	{ pattern = "%+14 Spell Power and %+2%% Intellect", effect = {"SPELLPOW", "PERCINT"}, value = {14, 2} },
	{ pattern = "%+25 Spell Power and %+2%% Intellect", effect = {"SPELLPOW", "PERCINT"}, value = {25, 2} },	
	{ pattern = "%+18 Stamina and  Stun Duration Reduced by 15%% Stun Resist", effect = {"STA", "PERCSTUN"}, value = {18, 15} },
	{ pattern = "%+18 Spell Power and %+4 Mana/5 seconds", effect = {"SPELLPOW", "MANAREG"}, value = {18, 4} },
	{ pattern = "%+24 Spell Power and %+6 Mana/5 seconds", effect = {"SPELLPOW", "MANAREG"}, value = {24, 6} },
	{ pattern = "%+61 Spell Power and %+6 Mana/5 seconds", effect = {"SPELLPOW", "MANAREG"}, value = {61, 6} },
	{ pattern = "%+2%% Threat and 10 Parry Rating", effect = {"THREATINCREASE","PARRY"}, value = {2 , 10} },

-- rest of custom patterns
  { pattern = "Increases attack power by (%d+) in Cat, Bear, Dire Bear, and Moonkin forms only%.", effect = "ATTACKPOWERFERAL" },
	{ pattern = "Mana Regen (%d+) per 5 sec", effect = "MANAREG" },
	{ pattern = "%+(%d+)% Health and Mana every 5 sec", effect = {"MANAREG", "HEALTHREG"} },
	{ pattern = "%+(%d+)% Mana and Health every 5 sec", effect = {"MANAREG", "HEALTHREG"} },
	{ pattern = "Reinforced %(%+(%d+) Armor%)", effect = "ARMOR" },
	{ pattern = "%+(%d+)%% Threat", effect = "THREATINCREASE" },
	{ pattern = "Scope %(%+(%d+) Critical Strike Rating%)", effect = "CRIT" },
	{ pattern = "Scope %(%+(%d+) Damage%)", effect = "RANGEDDMG" },
};

-- localized strings
L["BONUSSCANNER_BONUSSUM_LABEL"] = "Item Bonus Summary";
L["BONUSSCANNER_TOOLTIP_STRING"] = "BonusScanner Tooltip Bonus Summary ";
L["BONUSSCANNER_TOOLTIPGEMS_STRING"] = "Gem color count ";
L["BONUSSCANNER_BASICLINKID_STRING"] = "Basic Itemlink ID's ";
L["BONUSSCANNER_EXTENDEDLINKID_STRING"] = "Extended Itemlink ID's ";
L["BONUSSCANNER_TOOLTIP_ENABLED"] = "Enabled";
L["BONUSSCANNER_TOOLTIP_DISABLED"] = "Disabled";
L["BONUSSCANNER_IBONUS_LABEL"] = "Item bonuses of ";
L["BONUSSCANNER_NOBONUS_LABEL"] = "No bonuses detected.";
L["BONUSSCANNER_CUREQ_LABEL"] = "Current equipment bonuses";
L["BONUSSCANNER_CUREQDET_LABEL"] = "Current equipment bonus details";
L["BONUSSCANNER_OOR_LABEL"] = " is out of range.";
L["BONUSSCANNER_GEMCOUNT_LABEL"] = "Counts as ";
L["BONUSSCANNER_INVALIDTAR_LABEL"] = "Invalid target to scan.";
L["BONUSSCANNER_SELTAR_LABEL"] = "Please select a target first.";
L["BONUSSCANNER_SLOT_LABEL"] = "slot";
L["BONUSSCANNER_FAILEDPARSE_LABEL"] = "Item is either not cached or hasn't been validated on the server.";
L["BONUSSCANNER_CACHESUMMARY_LABEL"] = "BonusScanner items cached: ";
L["BONUSSCANNER_CACHECLEAR_LABEL"] = "BonusScanner item cache has been cleared.";
L["BONUSSCANNER_SPECIAL1_LABEL"] = " crit chance";
L["BONUSSCANNER_SPECIAL2_LABEL"] = " dodged/parried";
L["BONUSSCANNER_SPECIAL3_LABEL"] = " melee";
L["BONUSSCANNER_SPECIAL4_LABEL"] = " spells";
L["BONUSSCANNER_SPECIAL5_LABEL"] = " ranged/spells";
L["BONUSSCANNER_ITEMID_LABEL"] = "Item ID: |cffffffff";
L["BONUSSCANNER_ILVL_LABEL"] = "Item Level: |cffffffff";
L["BONUSSCANNER_ENCHANTID_LABEL"] = "Enchant ID: |cffffffff";
L["BONUSSCANNER_GEM1ID_LABEL"] = "Gem1 ID: |cffffffff";
L["BONUSSCANNER_GEM2ID_LABEL"] = "Gem2 ID: |cffffffff";
L["BONUSSCANNER_GEM3ID_LABEL"] = "Gem3 ID: |cffffffff";
L["BONUSSCANNER_GEMRED_LABEL"] = "Red";
L["BONUSSCANNER_GEMBLUE_LABEL"] = "Blue";
L["BONUSSCANNER_GEMYELLOW_LABEL"] = "Yellow";
L["BONUSSCANNER_GEMPRISM_LABEL"] = "Prismatic";
L["BONUSSCANNER_AVERAGE_ILVL_LABEL"] = "Average item Level";
L["BONUSSCANNER_NEEDS_RELOADUI_LABEL"] = "Changes will take effect after the UI has been reloaded.";
L["BONUSSCANNER_LDB_PLUGIN_LABEL"] = "BonusScanner LDB Plugin ";
--bonus categories
L["BONUSSCANNER_CAT_ATT"] = "Attributes";
L["BONUSSCANNER_CAT_RES"] = "Resistance";
L["BONUSSCANNER_CAT_SKILL"] = "Skills";
L["BONUSSCANNER_CAT_BON"] = "Melee and ranged combat";
L["BONUSSCANNER_CAT_SBON"] = "Spells";
L["BONUSSCANNER_CAT_OBON"] = "Life and mana";
L["BONUSSCANNER_CAT_EBON"] = "Special Bonuses";
L["BONUSSCANNER_CAT_GEMS"] = "Socketed Gems";
--slash command text
L["BONUSSCANNER_SLASH_STRING1"] = GREEN_FONT_COLOR_CODE.."BonusScanner ";
L["BONUSSCANNER_SLASH_STRING1a"] = "|cffffffff by Crowley, Archarodim, jmsteele, Tristanian";
L["BONUSSCANNER_SLASH_STRING2"] = LIGHTYELLOW_FONT_COLOR_CODE.."Usage: |cffffffff/bscan {show | details | tooltip | tooltip gems | itembasic | itemextend | broker | clearcache | target | target <player> | <itemlink> | <itemlink> <player> | <slotname>}";
L["BONUSSCANNER_SLASH_STRING3"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."show: |cffffffffShows all the bonuses of the current equipment.";
L["BONUSSCANNER_SLASH_STRING4"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."details: |cffffffffShows bonuses with slot distribution.";
L["BONUSSCANNER_SLASH_STRING5"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."tooltip: [";
L["BONUSSCANNER_SLASH_STRING5a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffAttaches item bonus summary on tooltips.";
L["BONUSSCANNER_SLASH_STRING14"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."tooltip gems: [";
L["BONUSSCANNER_SLASH_STRING14a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffAttaches gem color count on tooltips (requires tooltips enabled).";
L["BONUSSCANNER_SLASH_STRING12"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."itembasic: [";
L["BONUSSCANNER_SLASH_STRING12a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffAttaches item level and item ID properties on tooltips (requires tooltips enabled).";
L["BONUSSCANNER_SLASH_STRING13"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."itemextend: [";
L["BONUSSCANNER_SLASH_STRING13a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffAttaches enchant and gem ID properties on tooltips (requires tooltips enabled).";
L["BONUSSCANNER_SLASH_STRING15"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."broker: [";
L["BONUSSCANNER_SLASH_STRING15a"] = LIGHTYELLOW_FONT_COLOR_CODE.."] |cffffffffToggles the state of the LDB feed, used to display gear bonuses for the current character.";
L["BONUSSCANNER_SLASH_STRING11"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."clearcache: |cffffffffClears the item cache and forces a garbage collection.";
L["BONUSSCANNER_SLASH_STRING6"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."target: |cffffffffShows bonuses for your target's equipped gear (must be in inspect range).";
L["BONUSSCANNER_SLASH_STRING7"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."target <player>: |cffffffffWhispers bonuses for your target's equipped gear to the player specified.";
L["BONUSSCANNER_SLASH_STRING8"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<itemlink>: |cffffffffShows bonuses of linked item (insert link with Shift-Click).";
L["BONUSSCANNER_SLASH_STRING9"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<itemlink> <player>: |cffffffffWhispers bonuses of linked item to the player specified.";
L["BONUSSCANNER_SLASH_STRING10"] = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."<slotname>: |cffffffffShows bonuses of given equipment slot.";