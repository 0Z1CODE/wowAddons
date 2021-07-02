Altoholic = LibStub("AceAddon-3.0"):NewAddon("Altoholic", "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0", "AceSerializer-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

BINDING_HEADER_ALTOHOLIC = "Altoholic";
BINDING_NAME_ALTOHOLIC_TOGGLE = "Toggle UI";

local options = { 
	type= "group",
	args = {
		search = {
			type = "input",
			name = L['search'],
			usage = "<item name>",
			desc = L["Search in bags"],
			get = false,
			set = "CmdSearchBags",
		},
		show = {
			type = "execute",
			name = L['show'],
			desc = L["Shows the UI"],
			func = function() AltoholicFrame:Show() end
		},
		hide = {
			type = "execute",
			name = L['hide'],
			desc = L["Hides the UI"],
			func = function() AltoholicFrame:Hide() end
		},
		toggle = {
			type = "execute",
			name = L['toggle'],
			desc = L["Toggles the UI"],
			func = function() Altoholic:ToggleUI() end
		},
	},
}

--[[	*** Note on reputation ***
the "reputation" table is kept out of the "char" table for practical reasons, as the table will be populated with so many different entries for each alt,
it was much easier to organize things this way to ensure a more efficient parsing when data will be displayed, this also prevents from creating
a large temporary table that would have to be garbage collected later on. Character names will be duplicated in each sub-table, 
but this is a little trade-off I accept.
--]]
 
local AltoholicDB_Defaults = { global = {		-- global written here to keep the same identation as in the Ace2 version
	options = {
		TabSummaryMode = 2,
		MinimapIconAngle = 180,
		MinimapIconRadius = 78,
		MailWarningThreshold = 5,
		CheckMailExpiry = 1,				-- check mail expiry or not
		SortDescending = 0, 				-- display search results in the loot table in ascending (0) or descending (1) order ?
		RestXPMode = 0, 					-- display max rest xp in normal 100% mode or in level equivalent 150% mode (1) ?
		ScanMailBody = 1,					-- by default, scan the body of a mail (this action marks it as read)
		IncludeNoMinLevel = 1,
		IncludeMailbox = 1,
		IncludeGuildBank = 1,
		IncludeRecipes = 1,
		TooltipSource = 1,
		TooltipCount = 1,
		TooltipTotal = 1,
		TooltipGuildBank = 1,
		TooltipGuildBankCount = 1,		-- total count = alts + guildbank (1) or alts only (0)
		TooltipRecipeInfo = 1,
		TooltipItemID = 0,				-- display item id & item level in the tooltip (default: off)
		TooltipGatheringNode = 1,		-- display counters when mousing over a gathering node (default:  on)
		TooltipCrossFaction = 1,		-- display counters for both factions on a pve server
		TooltipMultiAccount = 1,		-- display counters for all accounts on the same realm
		GuildHandlerEnabled = 1,		-- guild communication handler is enabled by default
		AccSharingHandlerEnabled = 0,	-- account sharing communication handler is disabled by default
		GuildBankAutoUpdate = 0,		-- can the guild bank tabs update requests be answered automatically or not.
		GuildMailWarning = 1,			-- be informed when a guildie sends a mail to one of my alts
		ShowMinimap = 1,
		FuBarIconShown = 1,
		FuBarTextShown = 1,
		SearchAutoQuery = 0,
		lastContainerView = 1,			-- default container view = bags+bank
		TotalLoots = 0,					-- make at least one search in the loot tables to initialize these values
		UnknownLoots = 0
	},
	reference = {
		['*'] = {							-- "englishClass" like "MAGE", "DRUID" etc..
			talentInfo = {
				['*'] = {					-- numeric index: [1] = first talent tree, [2] = second ...
					name = nil,
					icon = nil,
					background = nil,
					list = { ['*'] = nil },		-- name, icon, max rank etc..for talent x in this tree
					prereqs = { ['*'] = nil }	-- prerequisites
				},
			},
		},
	},
	data = {
		['*'] = {							-- Account: "Default" or user defined for other accounts
			['*'] = {						-- Realm
				reputation = {
					['*'] = {				-- "Ironforge"
						['*'] = nil
					}
				},
				tokens = {
					['*'] = {				-- "Honor Currency"
						['*'] = nil
					}
				},
				guild = {
					['*'] = {				-- guild["MyUberGuild"]
						hideInTooltip = nil,		-- true if this guild should not be shown in the tooltip counters
						bankmoney = 0,
						faction = nil,
						bank = {
							['*'] = {		-- tabID = table index [1] to [6]
--								tabID = nil,
								name = nil,
								visitedBy = "",
								ClientTime = 0,				-- since epoch
								ClientDate = nil,
								ClientHour = nil,
								ClientMinute = nil,
								ServerHour = nil,
								ServerMinute = nil,
								ids = { ['*'] = nil },
								links = { ['*'] = nil },
								counts = { ['*'] = nil }
							}
						},
						members = {
							['*'] = {		-- player name
								prof1link = nil,
								prof2link = nil,
								cookinglink = nil,
							}
						},
					}
				},
				unsafeItems = {},
				lastAccountSharing = nil,	-- a date, the last time information from this realm/account was queried and successfully saved.
				lastUpdatedWith = nil,		-- last player with whom the account sharing took place
				char = {
					['*'] = {					-- Character Name
						level = 0,
						race = "",
						class = "",
						englishClass = "",	-- "WARRIOR", "DRUID" .. english & caps, regardless of locale
						faction = "",
						talent = "",
						tree1 = { ['*'] = 0 },	-- points spent in this talent tree
						tree2 = { ['*'] = 0 },
						tree3 = { ['*'] = 0 },
						tree4 = { ['*'] = 0 },
						tree5 = { ['*'] = 0 },
						tree6 = { ['*'] = 0 },
						activeTalents = nil,
						guildName = nil,		-- nil = not in a guild, as returned by GetGuildInfo("player")
						numBagSlots = 0,
						numFreeBagSlots = 0,
						numBankSlots = 0,
						numFreeBankSlots = 0,
						zone = "",				-- in which zone the player went offline
						subzone = "",			-- in which subzone .. 
						xp = 0,					-- current level xp
						xpmax = 0,				-- max xp at current level 
						restxp = 0,
						isResting = nil,		-- nil = out of an inn
						money = 0,
						played = 0,				-- 57396 seconds = 0 days 15 hours 56 minutes 36 seconds
						lastlogout = 0,
						pvp_hk = 0,				-- pvp honorable kills
						pvp_dk = 0,				-- pvp dishonorable kills
						pvp_ArenaPoints = 0,
						pvp_HonorPoints = 0,
						coldWeatherFlying = nil,	-- can fly in northrend or not
						glyphInfo = nil,		-- "enabled : glyphType : spellID : icon | ... "
						skill = {
							['*'] = {			-- "Professions"
								['*'] = nil
							}
						},
						averageItemLvl = 0,
						inventory = {},		-- 19 inventory slots, a simple table containing item id's
						SavedInstance = {},	-- raid timers
						ProfessionCooldowns = {},
						questlog = {
							['*'] = {
								name = nil,		-- name: name of the header (usually the location)
								link = nil,		-- the quest link
								isHeader = nil,
								isCollapsed = false,
								tag = nil,			-- quest tag=  "Elite", "Dungeon", "PVP", "Raid", "Group", "Heroic" or nil
								groupsize = nil,
								money = nil,
								isComplete = nil
							}
						},
						recipes = {
							['*'] = {
								FullLink = nil,		-- Tradeskill link
								ScanFailed = true,	-- by default, consider that scanning this profession was not valid
								GreenCount = 0,		-- number of recipes which are still green..
								YellowCount = 0,		-- ..yellow..
								OrangeCount = 0,		-- .. or orange
								TotalCount = 0,		-- total number of recipes for this tradeskill.
								list = {
									['*'] = nil
								}
							}
						},
						lastAHcheck = 0,		-- last time the AH was checked for this char
						AHCheckClientDate = nil,
						AHCheckClientHour = nil,
						AHCheckClientMinute = nil,
						auctions = {
							['*'] = {
								id = nil,
								count = nil,
								AHLocation = nil,		-- nil = faction AH, 1 = goblin AH
								highBidder = nil,
								startPrice = nil,
								buyoutPrice = nil,
								timeLeft = nil
							}
						},
						bids = {
							['*'] = {
								id = nil,
								count = nil,
								AHLocation = nil,		-- nil = faction AH, 1 = goblin AH
								owner = nil,
								bidPrice = nil,
								buyoutPrice = nil,
								timeLeft = nil
							}
						},
						pets = {
							['*'] = {			-- "critter" or "mount"
								['*'] = nil
							}
						},
						TotalAchievements = 0,
						CompletedAchievements = 0,
						TotalAchievementPoints = 0,
						achievements = {},
						
						lastmailcheck = 0,	-- last time the mail was checked for this char
						MailCheckClientDate = nil,
						MailCheckClientHour = nil,
						MailCheckClientMinute = nil,
						mail = {
							['*'] = {
								icon = nil,
								link = nil,
								count = nil,
								money = 0,
								lastcheck = 0,		-- last time "THIS" mail was checked (can be different than that of the mailbox)
								text = "",
								subject = "",
								sender = "",
								daysleft = 0,
								realm = ""
							}
						},
						mailCache = {				-- same structure as "mail", but serves as a cache for mails sent by a guildmate, until the mail actually arrives in the real mailbox (1h delay)
							['*'] = {
								icon = nil,
								link = nil,
								count = nil,
								money = 0,
								lastcheck = 0,		-- last time "THIS" mail was checked (can be different than that of the mailbox)
								text = "",
								subject = "",
								sender = "",
								daysleft = 0,
								realm = ""
							}
						},
						bag = {
							['*'] = {					-- bag["Bag0"]
								icon = nil,				-- bag's texture
								link = nil,				-- bag's itemlink
								size = 0,
								freeslots = 0,
								bagtype = 0,
								ids = { ['*'] = nil },
								links = { ['*'] = nil },
								counts = { ['*'] = nil },
								cooldowns = { ['*'] = nil }
							}
						}
					}
				}
			}
		}
	}
}}

-- Let's try Omen's approach to fubar integration
LibStub("AceAddon-3.0"):EmbedLibrary(Altoholic, "LibFuBarPlugin-Mod-3.0", true)

-- ** LDB Launcher **
LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("Altoholic", {
	type = "launcher",
	icon = "Interface\\Icons\\INV_Drink_05",
	OnClick = function(clickedframe, button)
		Altoholic:ToggleUI()
	end,
})

function Altoholic:OnInitialize()
	Altoholic.db = LibStub("AceDB-3.0"):New("AltoholicDB", AltoholicDB_Defaults)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Altoholic", options)
--	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Altoholic", "Altoholic")
	self:RegisterChatCommand("Altoholic", "ChatCommand")
	self:RegisterChatCommand("Alto", "ChatCommand")
	
	Altoholic.title = "Altoholic"	-- this is for fubar
	-- borrowed from Omen
	if LibStub:GetLibrary("LibFuBarPlugin-Mod-3.0", true) then
		-- Create the FuBarPlugin bits.
		self:SetFuBarOption("tooltipType", "GameTooltip")
		self:SetFuBarOption("hasNoColor", true)
		self:SetFuBarOption("cannotDetachTooltip", true)
		self:SetFuBarOption("hideWithoutStandby", true)
		self:SetFuBarOption("iconPath", [[Interface\Icons\INV_Drink_05]])
	end
	
	Altoholic:RegisterComm("AltoShare", "AccSharingHandler")
	Altoholic:RegisterComm("AltoGuild", "GuildCommHandler")
end

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"

function Altoholic:OnUpdateFuBarTooltip()
	GameTooltip:AddLine(WHITE .. L["Left-click to"] .. " " .. GREEN ..L["open/close"] )
end

function Altoholic:OnFuBarClick(button)
	Altoholic:ToggleUI();
end

function Altoholic:ChatCommand(input)
	if not input then
		LibStub("AceConfigDialog-3.0"):Open("Altoholic")
	else
		LibStub("AceConfigCmd-3.0").HandleCommand(Altoholic, "Alto", "Altoholic", input)
	end
end

Altoholic.CharacterInfo = {}
Altoholic.CharacterInfoView = {}
Altoholic.vars = {}

Altoholic.Guild = {}
Altoholic.TradeSkills = {}
Altoholic.TradeSkills.Recipes = {}
Altoholic.Tabs = {}
Altoholic.Tabs.List = {
	"Summary",
	"Characters",
	"Search",
	"GuildBank",
	"Achievements",
	"Options",
}

function Altoholic.Tabs:HideAll()
	for _, v in pairs(self.List) do
		_G["AltoholicTab" .. v]:Hide();
	end
end

function Altoholic.Tabs:OnClick(index)
	PanelTemplates_SetTab(AltoholicFrame, index);
	self:HideAll()
	_G["AltoholicTab" .. self.List[index]]:Show()
end

-- Allow ESC to close the main frame
tinsert(UISpecialFrames, "AltoholicFrame");
tinsert(UISpecialFrames, "AltoMsgBox");

-- Add herb/ore possession info to Plants/Mines, thanks to Tempus on wowace for gathering this.
Altoholic.Gathering = {

	-- Mining nodes
	[L["Adamantite Deposit"]]              = 23425, -- Adamantite Ore
	[L["Copper Vein"]]                     =  2770, -- Copper Ore
	[L["Dark Iron Deposit"]]               = 11370, -- Dark Iron Ore
	[L["Fel Iron Deposit"]]                = 23424, -- Fel Iron Ore
	[L["Gold Vein"]]                       =  2776, -- Gold Ore
	[L["Hakkari Thorium Vein"]]            = 10620, -- Thorium Ore
	[L["Iron Deposit"]]                    =  2772, -- Iron Ore
	[L["Khorium Vein"]]                    = 23426, -- Khorium Ore
	[L["Mithril Deposit"]]                 =  3858, -- Mithril Ore
	[L["Ooze Covered Gold Vein"]]          =  2776, -- Gold Ore
	[L["Ooze Covered Mithril Deposit"]]    =  3858, -- Mithril Ore
	[L["Ooze Covered Rich Thorium Vein"]]  = 10620, -- Thorium Ore
	[L["Ooze Covered Silver Vein"]]        =  2775, -- Silver Ore
	[L["Ooze Covered Thorium Vein"]]       = 10620, -- Thorium Ore
	[L["Ooze Covered Truesilver Deposit"]] =  7911, -- Truesilver Ore
	[L["Rich Adamantite Deposit"]]         = 23425, -- Adamantite Ore
	[L["Rich Thorium Vein"]]               = 10620, -- Thorium Ore
	[L["Silver Vein"]]                     =  2775, -- Silver Ore
	[L["Small Thorium Vein"]]              = 10620, -- Thorium Ore
	[L["Tin Vein"]]                        =  2771, -- Tin Ore
	[L["Truesilver Deposit"]]              =  7911, -- Truesilver Ore

	[L["Lesser Bloodstone Deposit"]]       =  4278, -- Lesser Bloodstone Ore
	[L["Incendicite Mineral Vein"]]        =  3340, -- Incendicite Ore
	[L["Indurium Mineral Vein"]]           =  5833, -- Indurium Ore
	[L["Nethercite Deposit"]]              = 32464, -- Nethercite Ore
	[L["Large Obsidian Chunk"]]				= 22203,	-- Large Obsidian Shard	Both drop on both nodes..
	[L["Small Obsidian Chunk"]]				= 22202,	-- Small Obsidian Shard
	
	-- wotlk
	["Cobalt Node"]								= 36909, -- Cobalt Ore
	["Rich Cobalt Node"]							= 36909, -- Cobalt Ore
	["Saronite Node"]								= 36912, -- Saronite Ore
	["Rich Saronite Node"]						= 36912, -- Saronite Ore
	["Titanium Node"]								= 36910, -- Titanium Ore

	

	-- Herbs
	[L["Ancient Lichen"]]       = 22790,
	[L["Arthas' Tears"]]        =  8836,
	[L["Black Lotus"]]          = 13468,
	[L["Blindweed"]]            =  8839,
	[L["Bloodthistle"]]         = 22710,
	[L["Briarthorn"]]           =  2450,
	[L["Bruiseweed"]]           =  2453,
	[L["Dreamfoil"]]            = 13463,
	[L["Dreaming Glory"]]       = 22786,
	[L["Earthroot"]]            =  2449,
	[L["Fadeleaf"]]             =  3818,
	[L["Felweed"]]              = 22785,
	[L["Firebloom"]]            =  4625,
	[L["Flame Cap"]]            = 22788,
	[L["Ghost Mushroom"]]       =  8845,
	[L["Golden Sansam"]]        = 13464,
	[L["Goldthorn"]]            =  3821,
	[L["Grave Moss"]]           =  3369,
	[L["Gromsblood"]]           =  8846,
	[L["Icecap"]]               = 13467,
	[L["Khadgar's Whisker"]]    =  3358,
	[L["Kingsblood"]]           =  3356,
	[L["Liferoot"]]             =  3357,
	[L["Mageroyal"]]            =   785,
	[L["Mana Thistle"]]         = 22793,
	[L["Mountain Silversage"]]  = 13465,
	[L["Netherbloom"]]          = 22791,
	[L["Nightmare Vine"]]       = 22792,
	[L["Peacebloom"]]           =  2447,
	[L["Plaguebloom"]]          = 13466,
	[L["Purple Lotus"]]         =  8831,
	[L["Ragveil"]]              = 22787,
	[L["Silverleaf"]]           =   765,
	[L["Stranglekelp"]]         =  3820,
	[L["Sungrass"]]             =  8838,
	[L["Terocone"]]             = 22789,
	[L["Wild Steelbloom"]]      =  3355,
	[L["Wintersbite"]]          =  3819,

	[L["Glowcap"]]              = 24245,
	[L["Netherdust Bush"]]      = 32468, -- Netherdust Pollen
	[L["Sanguine Hibiscus"]]    = 24246,
	
	["Fel Lotus"]					= 22794,
	["Goldclover"]					= 36901,
	["Tiger Lily"]					= 36904,
}

function Altoholic:CmdSearchBags(arg1, arg2)
	-- arg 1 is a table, no idea of what it does, investigate later, only  arg2 matters at this point
	
	if string.len(arg2) == 0 then
		DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF9A" .. L["Altoholic:|r Usage = /altoholic search <item name>"])
		return
	end
	
	if not (AltoholicFrame:IsVisible()) then
		AltoholicFrame:Show();
	end
	AltoholicFrame_SearchEditBox:SetText(strlower(arg2))
	Altoholic.Search:FindItem();
end	