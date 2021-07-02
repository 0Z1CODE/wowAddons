local L = LibStub("AceLocale-3.0"):NewLocale("Altoholic", "enUS", true)

if not L then return end

-- Note: since 2.4.004 and the support of LibBabble, certain lines are commented, but remain there for clarity (especially those concerning the menu)
-- A lot of translations, especially those concerning the loot table, comes from atlas loot, credit goes to their team for gathering this info, I (Thaoky) simply took what I needed.

L["Death Knight"] = true

-- note: these string are the ones found in item tooltips, make sure to respect the case when translating, and to distinguish them (like crit vs spell crit)
L["Increases healing done by up to %d+"] = true
L["Increases damage and healing done by magical spells and effects by up to %d+"] = true
L["Increases attack power by %d+"] = true
L["Restores %d+ mana per"] = true
L["Classes: Shaman"] = true
L["Classes: Mage"] = true
L["Classes: Rogue"] = true
L["Classes: Hunter"] = true
L["Classes: Warrior"] = true
L["Classes: Paladin"] = true
L["Classes: Warlock"] = true
L["Classes: Priest"] = true
L["Classes: Death Knight"] = true
L["Resistance"] = true

--skills
L["Class Skills"] = true
L["Professions"] = true
L["Secondary Skills"] = true
L["Fishing"] = true
L["Riding"] = true
L["Herbalism"] = true
L["Mining"] = true
L["Skinning"] = true
L["Lockpicking"] = true
L["Poisons"] = true
L["Beast Training"] = true
L["Inscription"] = true

--factions not in LibFactions or LibZone
L["Alliance Forces"] = true
L["Horde Forces"] = true
L["Steamwheedle Cartel"] = true
L["Other"] = true

-- menu
L["Reputations"] = true
L["Containers"] = true
L["Guild Bank not visited yet (or not guilded)"] = true
L["E-Mail"] = true
L["Quests"] = true
L["Equipment"] = true

--Altoholic.lua
L["Account"] = true
L["Default"] = true
L["Loots"] = true
L["Unknown"] = true
L["has come online"] = true
L["has gone offline"] = true
L["Bank not visited yet"] = true
L["Levels"] = true
L["(has mail)"] = true
L["(has auctions)"] = true
L["(has bids)"] = true

L["No rest XP"] = true
L["Rested"] = true
L["Transmute"] = true

L["Bags"] = true
L["Bank"] = true
L["AH"] = true				-- for auction house, obviously
L["Equipped"] = true
L["Mail"] = true
L["Mails %s(%d)"] = true
L["Mails"] = true
L["Visited"] = true
L["Auctions %s(%d)"] = true
L["Bids %s(%d)"] = true
L[", "] = true						-- required for znCH
L["(Guild bank: "] = true

L["Level"] = true
L["Zone"] = true
L["Rest XP"] = true

L["Source"] = true
L["Total owned"] = true
L["Already known by "] = true
L["Will be learnable by "] = true
L["Could be learned by "] = true

L["At least one recipe could not be read"] = true
L["Please open this window again"] = true

--Comm.lua
L["Sending account sharing request to %s"] = true
L["Account sharing request received from %s"] = true
L["You have received an account sharing request\nfrom %s%s|r, accept it?"] = true
L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"] = true
L["Request rejected by %s"] = true
L["%s is in combat, request cancelled"] = true
L["%s has disabled account sharing"] = true
L["Table of content received (%d items)"] = true
L["Sending reputations (%d of %d)"] = true
L["Sending currencies (%d of %d)"] = true
L["Sending guilds (%d of %d)"] = true
L["Sending character %s (%d of %d)"] = true
L["No reputations found"] = true
L["No currencies found"] = true
L["No guild found"] = true
L["Transfer complete"] = true
L["Reputations received !"] = true
L["Currencies received !"] = true
L["Guilds received !"] = true
L["Character %s received !"] = true
L["Requesting item %d of %d"] = true
L["Sending table of content (%d items)"] = true
L["Guild bank tab %s successfully updated !"] = true
L["%s has disabled guild communication"] = true
L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"] = true
L["%sWarning:|r make sure this user may view this information before accepting"] = true
L["%s|r has received a mail from %s"] = true
L["Sending reference data: %s (%d of %d)"] = true
L["Reference data not available"] = true
L["Reference data received (%s) !"] = true
L["Waiting for %s to accept .."] = true

--GuildBankTabs.lua
L["Requesting %s information from %s"] = true
L["Guild Bank Remote Update"] = true
L["Clicking this button will update\nyour local %s%s|r bank tab\nbased on %s%s's|r data"] = true

--GuildMembers.lua
L["Left-click to see this character's equipment"] = true
L["Click a character's AiL to see its equipment"] = true

--GuildProfessions.lua
L["Offline Members"] = true
L["Left click to view"] = true
L["Shift+Left click to link"] = true

--Core.lua
L['search'] = true
L["Search in bags"] = true
L['show'] = true
L["Shows the UI"] = true
L['hide'] = true
L["Hides the UI"] = true
L['toggle'] = true
L["Toggles the UI"] = true
L["Altoholic:|r Usage = /altoholic search <item name>"] = true

--AltoholicFu.lua
L["Left-click to"] = true
L["open/close"] = true

--AccountSummary.lua
L["View bags"] = true
L["All-in-one"] = true
L["View mailbox"] = true
L["View quest log"] = true
L["View auctions"] = true
L["View bids"] = true
L["Delete this Alt"] = true
L["Cannot delete current character"] = true
L["Character %s successfully deleted"] = true
L["Delete this Realm"] = true
L["Cannot delete current realm"] = true
L["Realm %s successfully deleted"] = true
L["Suggested leveling zone: "] = true
L["Arena points: "] = true
L["Honor points: "] = true
L["Right-Click for options"] = true
L["Average Item Level"] = true

-- AuctionHouse.lua
L["%s has no auctions"] = true
L["%s has no bids"] = true
L["last check "] = true
L["Goblin AH"] = true
L["Clear your faction's entries"] = true
L["Clear goblin AH entries"] = true
L["Clear all entries"] = true

--BagUsage.lua
L["Totals"] = true
L["slots"] = true
L["free"] = true

--Containers.lua
L["32 Keys Max"] = true
L["28 Slot"] = true
L["Bank bag"] = true
L["Unknown link, please relog this character"] = true

--Equipment.lua
L["Find Upgrade"] = true
L["(based on iLvl)"] = true
L["Right-Click to find an upgrade"] = true
L["Tank"] = true
L["DPS"] = true
L["Balance"] = true
L["Elemental Shaman"] = true		-- shaman spec !
L["Heal"] = true

--GuildBank.lua
L["Last visit: %s by %s"] = true
L["Local Time: %s   %sRealm Time: %s"] = true

--Mails.lua
L[" has not visited his/her mailbox yet"] = true
L["%s has no mail"] = true
L[" has no mail, last check "] = true
L[" days ago"] = true
L["Mail was last checked "] = true
L[" days"] = true
L["Mail is about to expire on at least one character."] = true
L["Refer to the activity pane for more details."] = true
L["Do you want to view it now ?"] = true

--Quests.lua
L["No quest found for "] = true
L["QuestID"] = true
L["Are also on this quest:"] = true

--Recipes.lua
L["No data"] = true
L[" scan failed for "] = true

--Reputations.lua
L["Shift-Click to link this info"] = true
L[" is "] = true
L[" with "] = true

--Search.lua
L["Item Level"] = true
L[" results found (Showing "] = true
L["No match found!"] = true
L[" not found!"] = true
L["Socket"] = true

--skills.lua
L["Rogue Proficiencies"] = true
L["up to"] = true
L["at"] = true
L["and above"] = true
L["Suggestion"] = true
L["Prof. 1"] = true
L["Prof. 2"] = true
L["Grey"] = true
L["All cooldowns are up"] = true

-- TabSummary.lua
L["All accounts"] = true

-- TabCharacters.lua
L["Cannot link another realm's tradeskill"] = true
L["Cannot link another account's tradeskill"] = true
L["Invalid tradeskill link"] = true
L["Expiry:"] = true

-- TabGuildBank.lua
L["N/A"] = true
L["Delete Guild Bank?"] = true
L["Guild %s successfully deleted"] = true

-- TabSearch.lua
L["Any"] = true
L["Miscellaneous"] = true
L["Fishing Poles"] = true
L["This realm"] = true
L["All realms"] = true
L["Loot tables"] = true
L["This character"] = true
L["This faction"] = true
L["Both factions"] = true

--loots.lua
--Instinct drop
L["Hard Mode"] = true
L["Trash Mobs"] = true
L["Random Boss"] = true
L["Druid Set"] = true
L["Hunter Set"] = true
L["Mage Set"] = true
L["Paladin Set"] = true
L["Priest Set"] = true
L["Rogue Set"] = true
L["Shaman Set"] = true
L["Warlock Set"] = true
L["Warrior Set"] = true
L["Legendary Mount"] = true
L["Legendaries"] = true
L["Muddy Churning Waters"] = true
L["Shared"] = true
L["Enchants"] = true
L["Rajaxx's Captains"] = true
L["Class Books"] = true
L["Quest Items"] = true
L["Druid of the Fang (Trash Mob)"] = true
L["Spawn Of Hakkar"] = true
L["Troll Mini bosses"] = true
L["Henry Stern"] = true
L["Magregan Deepshadow"] = true
L["Tablet of Ryuneh"] = true
L["Krom Stoutarm Chest"] = true
L["Garrett Family Chest"] = true
L["Eric The Swift"] = true
L["Olaf"] = true
L["Baelog's Chest"] = true
L["Conspicuous Urn"] = true
L["Tablet of Will"] = true
L["Shadowforge Cache"] = true
L["Roogug"] = true
L["Aggem Thorncurse"] = true
L["Razorfen Spearhide"] = true
L["Pyron"] = true
L["Theldren"] = true
L["The Vault"] = true
L["Summoner's Tomb"] = true
L["Plans"] = true
L["Zelemar the Wrathful"] = true
L["Rethilgore"] = true
L["Fel Steed"] = true
L["Tribute Run"] = true
L["Shen'dralar Provisioner"] = true
L["Books"] = true
L["Trinkets"] = true
L["Sothos & Jarien"] = true
L["Fel Iron Chest"] = true
L[" (Heroic)"] = true
L["Yor (Heroic Summon)"] = true
L["Avatar of the Martyred"] = true
L["Anzu the Raven God (Heroic Summon)"] = true
L["Thomas Yance"] = true
L["Aged Dalaran Wizard"] = true
L["Cache of the Legion"] = true
L["Opera (Shared Drops)"] = true
L["Timed Chest"] = true
L["Patterns"] = true

--Rep
L["Token Hand-Ins"] = true
L["Items"] = true
L["Beasts Deck"] = true
L["Elementals Deck"] = true
L["Warlords Deck"] = true
L["Portals Deck"] = true
L["Furies Deck"] = true
L["Storms Deck"] = true
L["Blessings Deck"] = true
L["Lunacy Deck"] = true
L["Quest rewards"] = true
L["Shattrath"] = true

--World drop
L["Outdoor Bosses"] = true
L["Highlord Kruul"] = true
L["Bash'ir Landing"] = true
L["Skyguard Raid"] = true
L["Stasis Chambers"] = true
L["Skettis"] = true
L["Darkscreecher Akkarai"] = true
L["Karrog"] = true
L["Gezzarak the Huntress"] = true
L["Vakkiz the Windrager"] = true
L["Terokk"] = true
L["Ethereum Prison"] = true
L["Armbreaker Huffaz"] = true
L["Fel Tinkerer Zortan"] = true
L["Forgosh"] = true
L["Gul'bor"] = true
L["Malevus the Mad"] = true
L["Porfus the Gem Gorger"] = true
L["Wrathbringer Laz-tarash"] = true
L["Abyssal Council"] = true
L["Crimson Templar (Fire)"] = true
L["Azure Templar (Water)"] = true
L["Hoary Templar (Wind)"] = true
L["Earthen Templar (Earth)"] = true
L["The Duke of Cinders (Fire)"] = true
L["The Duke of Fathoms (Water)"] = true
L["The Duke of Zephyrs (Wind)"] = true
L["The Duke of Shards (Earth)"] = true
L["Elemental Invasion"] = true
L["Gurubashi Arena"] = true
L["Booty Run"] = true
L["Fishing Extravaganza"] = true
L["First Prize"] = true
L["Rare Fish"] = true
L["Rare Fish Rewards"] = true
L["Children's Week"] = true
L["Love is in the air"] = true
L["Gift of Adoration"] = true
L["Box of Chocolates"] = true
L["Hallow's End"] = true
L["Various Locations"] = true
L["Treat Bag"] = true
L["Headless Horseman"] = true
L["Feast of Winter Veil"] = true
L["Smokywood Pastures Vendor"] = true
L["Gaily Wrapped Present"] = true
L["Festive Gift"] = true
L["Winter Veil Gift"] = true
L["Gently Shaken Gift"] = true
L["Ticking Present"] = true
L["Carefully Wrapped Present"] = true
L["Noblegarden"] = true
L["Brightly Colored Egg"] = true
L["Smokywood Pastures Extra-Special Gift"] = true
L["Harvest Festival"] = true
L["Food"] = true
L["Scourge Invasion"] = true
L["Miscellaneous"] = true
L["Cloth Set"] = true
L["Leather Set"] = true
L["Mail Set"] = true
L["Plate Set"] = true
L["Balzaphon"] = true
L["Lord Blackwood"] = true
L["Revanchion"] = true
L["Scorn"] = true
L["Sever"] = true
L["Lady Falther'ess"] = true
L["Lunar Festival"] = true
L["Fireworks Pack"] = true
L["Lucky Red Envelope"] = true
L["Midsummer Fire Festival"] = true
L["Lord Ahune"] = true
L["Shartuul"] = true
L["Blade Edge Mountains"] = true
L["Brewfest"] = true
L["Barleybrew Brewery"] = true
L["Thunderbrew Brewery"] = true
L["Gordok Brewery"] = true
L["Drohn's Distillery"] = true
L["T'chali's Voodoo Brewery"] = true

--craft
L["Crafted Weapons"] = true
L["Master Swordsmith"] = true
L["Master Axesmith"] = true
L["Master Hammersmith"] = true
L["Blacksmithing (Lv 60)"] = true
L["Blacksmithing (Lv 70)"] = true
L["Engineering (Lv 60)"] = true
L["Engineering (Lv 70)"] = true
L["Blacksmithing Plate Sets"] = true
L["Imperial Plate"] = true
L["The Darksoul"] = true
L["Fel Iron Plate"] = true
L["Adamantite Battlegear"] = true
L["Flame Guard"] = true
L["Enchanted Adamantite Armor"] = true
L["Khorium Ward"] = true
L["Faith in Felsteel"] = true
L["Burning Rage"] = true
L["Blacksmithing Mail Sets"] = true
L["Bloodsoul Embrace"] = true
L["Fel Iron Chain"] = true
L["Tailoring Sets"] = true
L["Bloodvine Garb"] = true
L["Netherweave Vestments"] = true
L["Imbued Netherweave"] = true
L["Arcanoweave Vestments"] = true
L["The Unyielding"] = true
L["Whitemend Wisdom"] = true
L["Spellstrike Infusion"] = true
L["Battlecast Garb"] = true
L["Soulcloth Embrace"] = true
L["Primal Mooncloth"] = true
L["Shadow's Embrace"] = true
L["Wrath of Spellfire"] = true
L["Leatherworking Leather Sets"] = true
L["Volcanic Armor"] = true
L["Ironfeather Armor"] = true
L["Stormshroud Armor"] = true
L["Devilsaur Armor"] = true
L["Blood Tiger Harness"] = true
L["Primal Batskin"] = true
L["Wild Draenish Armor"] = true
L["Thick Draenic Armor"] = true
L["Fel Skin"] = true
L["Strength of the Clefthoof"] = true
L["Primal Intent"] = true
L["Windhawk Armor"] = true
L["Leatherworking Mail Sets"] = true
L["Green Dragon Mail"] = true
L["Blue Dragon Mail"] = true
L["Black Dragon Mail"] = true
L["Scaled Draenic Armor"] = true
L["Felscale Armor"] = true
L["Felstalker Armor"] = true
L["Fury of the Nether"] = true
L["Netherscale Armor"] = true
L["Netherstrike Armor"] = true
L["Armorsmith"] = true
L["Weaponsmith"] = true
L["Dragonscale"] = true
L["Elemental"] = true
L["Tribal"] = true
L["Mooncloth"] = true
L["Shadoweave"] = true
L["Spellfire"] = true
L["Gnomish"] = true
L["Goblin"] = true
L["Apprentice"] = true
L["Journeyman"] = true
L["Expert"] = true
L["Artisan"] = true
L["Master"] = true

--Set & PVP
L["Superior Rewards"] = true
L["Epic Rewards"] = true
-- L["Lv 10-19 Rewards"] = true
-- L["Lv 20-29 Rewards"] = true
-- L["Lv 30-39 Rewards"] = true
-- L["Lv 40-49 Rewards"] = true
-- L["Lv 50-59 Rewards"] = true
-- L["Lv 60 Rewards"] = true
L["Lv %s Rewards"] = true
L["PVP Cloth Set"] = true
L["PVP Leather Sets"] = true
L["PVP Mail Sets"] = true
L["PVP Plate Sets"] = true
L["World PVP"] = true
L["Hellfire Fortifications"] = true
L["Twin Spire Ruins"] = true
L["Spirit Towers (Terrokar)"] = true
L["Halaa (Nagrand)"] = true
-- L["Arena Season 1"] = true
-- L["Arena Season 2"] = true
-- L["Arena Season 3"] = true
-- L["Arena Season 4"] = true
L["Arena Season %d"] = true
L["Weapons"] = true
L["Accessories"] = true
L["Level 70 Reputation PVP"] = true
L["Level %d Honor PVP"] = true
L["Savage Gladiator\'s Weapons"] = true
L["Deadly Gladiator\'s Weapons"] = true
L["Lake Wintergrasp"] = true
L["Non Set Accessories"] = true
L["Non Set Cloth"] = true
L["Non Set Leather"] = true
L["Non Set Mail"] = true
L["Non Set Plate"] = true
L["Tier 0.5 Quests"] = true
L["Tier %d Tokens"] = true
L["Blizzard Collectables"] = true
L["WoW Collector Edition"] = true
L["BC Collector Edition (Europe)"] = true
L["Blizzcon 2005"] = true
L["Blizzcon 2007"] = true
L["Christmas Gift 2006"] = true
L["Upper Deck"] = true
L["Loot Card Items"] = true
L["Heroic Mode Tokens"] = true
L["Fire Resistance Gear"] = true
L["Emblems of Valor"] = true
L["Emblems of Heroism"] = true

L["Cloaks"] = true
L["Relics"] = true
L["World Drops"] = true
L["Level 30-39"] = true
L["Level 40-49"] = true
L["Level 50-60"] = true
L["Level 70"] = true

-- Altoholic.Gathering : Mining 
L["Copper Vein"] = true
L["Tin Vein"] = true
L["Iron Deposit"] = true
L["Silver Vein"] = true
L["Gold Vein"] = true
L["Mithril Deposit"] = true
L["Ooze Covered Mithril Deposit"] = true
L["Truesilver Deposit"] = true
L["Ooze Covered Silver Vein"] = true
L["Ooze Covered Gold Vein"] = true
L["Ooze Covered Truesilver Deposit"] = true
L["Ooze Covered Rich Thorium Vein"] = true
L["Ooze Covered Thorium Vein"] = true
L["Small Thorium Vein"] = true
L["Rich Thorium Vein"] = true
L["Hakkari Thorium Vein"] = true
L["Dark Iron Deposit"] = true
L["Lesser Bloodstone Deposit"] = true
L["Incendicite Mineral Vein"] = true
L["Indurium Mineral Vein"] = true
L["Fel Iron Deposit"] = true
L["Adamantite Deposit"] = true
L["Rich Adamantite Deposit"] = true
L["Khorium Vein"] = true
L["Large Obsidian Chunk"] = true
L["Small Obsidian Chunk"] = true
L["Nethercite Deposit"] = true

-- Altoholic.Gathering : Herbalism
L["Peacebloom"] = true
L["Silverleaf"] = true
L["Earthroot"] = true
L["Mageroyal"] = true
L["Briarthorn"] = true
L["Swiftthistle"] = true
L["Stranglekelp"] = true
L["Bruiseweed"] = true
L["Wild Steelbloom"] = true
L["Grave Moss"] = true
L["Kingsblood"] = true
L["Liferoot"] = true
L["Fadeleaf"] = true
L["Goldthorn"] = true
L["Khadgar's Whisker"] = true
L["Wintersbite"] = true
L["Firebloom"] = true
L["Purple Lotus"] = true
L["Wildvine"] = true
L["Arthas' Tears"] = true
L["Sungrass"] = true
L["Blindweed"] = true
L["Ghost Mushroom"] = true
L["Gromsblood"] = true
L["Golden Sansam"] = true
L["Dreamfoil"] = true
L["Mountain Silversage"] = true
L["Plaguebloom"] = true
L["Icecap"] = true
L["Bloodvine"] = true
L["Black Lotus"] = true
L["Felweed"] = true
L["Dreaming Glory"] = true
L["Terocone"] = true
L["Ancient Lichen"] = true
L["Bloodthistle"] = true
L["Mana Thistle"] = true
L["Netherbloom"] = true
L["Nightmare Vine"] = true
L["Ragveil"] = true
L["Flame Cap"] = true
L["Fel Lotus"] = true
L["Netherdust Bush"] = true

L["Glowcap"] = true
L["Sanguine Hibiscus"] = true
	

if GetLocale() == "enUS" then
-- Altoholic.xml local
LEFT_HINT = "Left-click to |cFF00FF00open";
RIGHT_HINT = "Right-click to |cFF00FF00drag";

XML_ALTO_SHARING_HINT1 = "Enter an account name that will be\nused for |cFF00FF00display|r purposes only.\n"
				.. "This name can be anything you like,\nit does |cFF00FF00NOT|r have to be the real account name.\n\n"
XML_ALTO_SHARING_HINT2 = "This field |cFF00FF00cannot|r be left empty."

XML_ALTO_TAB1 = "Summary"
XML_ALTO_TAB2 = "Characters"
-- XML_ALTO_TAB3 = SEARCH
-- XML_ALTO_TAB4 = GUILD_BANK
-- XML_ALTO_TABOPTIONS = GAMEOPTIONS_MENU

XML_ALTO_SUMMARY_MENU1 = "Account Summary"
XML_ALTO_SUMMARY_MENU2 = "Bag Usage"
-- XML_ALTO_SUMMARY_MENU3 = SKILLS
XML_ALTO_SUMMARY_MENU4 = "Activity"
XML_ALTO_SUMMARY_MENU5 = "Guild Members"
XML_ALTO_SUMMARY_MENU6 = "Guild Skills"
XML_ALTO_SUMMARY_MENU7 = "Guild Bank Tabs"

XML_ALTO_SUMMARY_TEXT1 = "Account Sharing Request"
XML_ALTO_SUMMARY_TEXT2 = "Click this button to ask a player\n"
				.. "to share his entire Altoholic Database\n"
				.. "and add it to your own"
XML_ALTO_SUMMARY_TEXT3 = "Both parties must enable account sharing\nbefore using this feature (see options)"
XML_ALTO_SUMMARY_TEXT4 = "Account Sharing"
				
XML_ALTO_CHAR_DD1 = "Realm"
XML_ALTO_CHAR_DD2 = "Character"
XML_ALTO_CHAR_DD3 = "View"

XML_ALTO_SEARCH_COL1 = "Item / Location"

XML_ALTO_GUILD_TEXT1 = "Hide this guild in the tooltip"

XML_ALTO_ACH_NOTSTARTED = "Not started"
XML_ALTO_ACH_STARTED = "Started"

XML_ALTO_OPT_MENU1 = "General"
XML_ALTO_OPT_MENU2 = "Search"
XML_ALTO_OPT_MENU3 = "Mail"
XML_ALTO_OPT_MENU4 = "Minimap"
XML_ALTO_OPT_MENU5 = "Tooltip"

XML_TEXT_1 = "Totals";
XML_TEXT_2 = "Search Containers";
XML_TEXT_3 = "Level Range";
XML_TEXT_4 = "Rarity";
XML_TEXT_5 = "Equipment Slot";
XML_TEXT_6 = "Reset";
-- XML_TEXT_7 = SEARCH;

XML_ALTO_TEXT10 = "Account Name"
XML_ALTO_TEXT11 = "Send account sharing request to:"

--Options.xml
XML_ALTO_OPT_GENERAL1 = "Max rest XP displayed as 150%";
XML_ALTO_OPT_GENERAL2 = "Show FuBar icon";
XML_ALTO_OPT_GENERAL3 = "Show FuBar text";
XML_ALTO_OPT_GENERAL4 = "Account Sharing Enabled";
XML_ALTO_OPT_GENERAL5 = "Guild Communication Enabled";
XML_ALTO_OPT_GENERAL6 = "|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\n"
				.. "to send you account sharing requests.\n"
				.. "Your confirmation will still be required any time someone requests your information.\n\n"
				.. "When |cFFFF0000disabled|cFFFFFFFF, all requests will be automatically rejected.\n\n"
				.. "Security hint: Only enable this when you actually need to transfer data,\ndisable otherwise"
XML_ALTO_OPT_GENERAL7 = "|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow your guildmates\n"
				.. "to see your alts and their professions.\n\n"
				.. "When |cFFFF0000disabled|cFFFFFFFF, there will be no communication with the guild."
XML_ALTO_OPT_GENERAL8 = "Automatically authorize guild bank updates"
XML_ALTO_OPT_GENERAL9 = "|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\n"
				.. "to update their guild bank information with yours automatically.\n\n"
				.. "When |cFFFF0000disabled|cFFFFFFFF, your confirmation will be\n"
				.. "required before sending any information.\n\n"
				.. "Security hint: disable this if you have officer rights\n"
				.. "on guild bank tabs that may not be viewed by everyone,\n"
				.. "and authorize requests manually"
				
XML_ALTO_OPT_SEARCH1 = "AutoQuery server |cFFFF0000(disconnection risk)";
XML_ALTO_OPT_SEARCH2 = "|cFFFFFFFFIf an item not in the local item cache\n"
				.. "is encountered while searching loot tables,\n"
				.. "Altoholic will attempt to query the server for 5 new items.\n\n"
				.. "This will gradually improve the consistency of the searches,\n"
				.. "as more items are available in the item cache.\n\n"
				.. "There is a risk of disconnection if the queried item\n"
				.. "is a loot from a high level dungeon.\n\n"
				.. "|cFF00FF00Disable|r to avoid this risk";
XML_ALTO_OPT_SEARCH3 = "Sort loots in descending order";
XML_ALTO_OPT_SEARCH4 = "Include items without level requirement";
XML_ALTO_OPT_SEARCH5 = "Include mailboxes";
XML_ALTO_OPT_SEARCH6 = "Include guild bank(s)";
XML_ALTO_OPT_SEARCH7 = "Include known recipes";

XML_ALTO_OPT_MAIL1 = "Warn when mail expires in less days than this value";
XML_ALTO_OPT_MAIL2 = "Mail Expiry Warning";
XML_ALTO_OPT_MAIL3 = "Scan mail body (marks it as read)";
XML_ALTO_OPT_MAIL4 = "New mail notification";
XML_ALTO_OPT_MAIL5 = "Be informed when a guildmate sends a mail to one of my alts.\n\n"
				.. "Mail content is directly visible without having to reconnect the character";

XML_ALTO_OPT_MINIMAP1 = "Move to change the angle of the minimap icon";
XML_ALTO_OPT_MINIMAP2 = "Minimap Icon Angle";
XML_ALTO_OPT_MINIMAP3 = "Move to change the radius of the minimap icon";
XML_ALTO_OPT_MINIMAP4 = "Minimap Icon Radius";
XML_ALTO_OPT_MINIMAP5 = "Show Minimap Icon";

XML_ALTO_OPT_TOOLTIP1 = "Show item source"; 
XML_ALTO_OPT_TOOLTIP2 = "Show item count per character";
XML_ALTO_OPT_TOOLTIP3 = "Show total item count";
XML_ALTO_OPT_TOOLTIP4 = "Show guild bank count";
XML_ALTO_OPT_TOOLTIP5 = "Show already known/learnable by";
XML_ALTO_OPT_TOOLTIP6 = "Show item ID and item level";
XML_ALTO_OPT_TOOLTIP7 = "Show counters on gathering nodes";
XML_ALTO_OPT_TOOLTIP8 = "Show counters for both factions";
XML_ALTO_OPT_TOOLTIP9 = "Show counters for all accounts";
XML_ALTO_OPT_TOOLTIP10 = "Include guild bank count in the total count";
end
