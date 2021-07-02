local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "deDE" )

if not L then return end

-- Note: since 2.4.004 and the support of LibBabble, certain lines are commented, but remain there for clarity (especially those concerning the menu)
-- A lot of translations, especially those concerning the loot table, comes from atlas loot, credit goes to their team for gathering this info, I (Thaoky) simply took what I needed.

L["Death Knight"] = "Todesritter"

-- note: these string are the ones found in item tooltips, make sure to respect the case when translating, and to distinguish them (like crit vs spell crit)
L["Increases healing done by up to %d+"] = " Erhöht durch sämtliche Zauber und magische Effekte verursachte Heilung um bis zu %d+"
L["Increases damage and healing done by magical spells and effects by up to %d+"] = "Erhöht durch Zauber und magische Effekte verursachten Schaden und Heilung um bis zu %d+"
L["Increases attack power by %d+"] = "Erhöht die Angriffskraft um %d+"
L["Restores %d+ mana per"] = "Stellt alle 5 Sek. %d+ Mana wieder her"
L["Classes: Shaman"] = "Klassen: Schamane"
L["Classes: Mage"] = "Klassen: Magier"
L["Classes: Rogue"] = "Klassen: Schurke"
L["Classes: Hunter"] = "Klassen: Jäger"
L["Classes: Warrior"] = "Klassen: Krieger"
L["Classes: Paladin"] = "Klassen: Paladin"
L["Classes: Warlock"] = "Klassen: Hexenmeister"
L["Classes: Priest"] = "Klassen: Priester"
L["Classes: Death Knight"] = "Klassen: Todesritter"
L["Resistance"] = "Widerstand"

--skills
L["Class Skills"] = "Class Skills"
L["Professions"] = "Berufe"
L["Secondary Skills"] = "Sekundäre Fertigkeiten"
L["Fishing"] = "Angeln"
L["Riding"] = "Reiten"
L["Herbalism"] = "Kräuterkunde"
L["Mining"] = "Bergbau"
L["Skinning"] = "Kürschnerei"
L["Lockpicking"] = "Schlossknacken"
L["Poisons"] = "Gifte"
L["Beast Training"] = "Begleiter Training"
L["Inscription"] = "Inschriftenkunde"

--factions not in LibFactions or LibZone
L["Alliance Forces"] = "Streitkräfte der Allianz"
L["Horde Forces"] = "Streitkräfte der Horde"
L["Steamwheedle Cartel"] = "Dampfdruckkartell"
L["Other"] = "Andere"

-- menu
L["Reputations"] = "Ruf"
L["Containers"] = "Taschen"
L["Guild Bank not visited yet (or not guilded)"] = "Guildenbank bisher nicht geöffnet (oder nicht in Gilde)"
L["E-Mail"] = "Post"
L["Quests"] = "Quests"
L["Equipment"] = "Ausrüstung"

--Altoholic.lua
L["Account"] = "Account"
L["Default"] = "Default"
L["Loots"] = "Loot"
L["Unknown"] = "Unbekannt"
L["has come online"] = "ist jetzt online"
L["has gone offline"] = "ist jetzt offline"
L["Bank not visited yet"] = "Bank noch nicht besucht"
L["Levels"] = "Levels"
L["(has mail)"] = "(hat Post)"
L["(has auctions)"] = "(hat Auktionen)"
L["(has bids)"] = "(hat Gebote)"

L["No rest XP"] = "Keine Erholt-XP"
L["Rested"] = "Erholt"
L["Transmute"] = "Umwandeln"

L["Bags"] = "Taschen"
L["Bank"] = "Bank"
L["AH"] = "AH"				-- for auction house, obviously
L["Equipped"] = "Angezogen"
L["Mail"] = "Mail"
L["Mails %s(%d)"] = "Mails %s(%d)"
L["Mails"] = "Mails"
L["Visited"] = "Visited"
L["Auctions %s(%d)"] = "Auktionen %s(%d)"
L["Bids %s(%d)"] = "Gebote %s(%d)"
L[", "] = ", "						-- required for znCH
L["(Guild bank: "] = "(Gildenbank: "

L["Level"] = "Level"
L["Zone"] = "Zone"
L["Rest XP"] = "Erholt XP"

L["Source"] = "Quelle"
L["Total owned"] = "Im Besitz"
L["Already known by "] = "Schon bekannt bei "
L["Will be learnable by "] = "Erlernbar bei "
L["Could be learned by "] = "Kann erlernt werden bei "

L["At least one recipe could not be read"] = "Mindestens ein Rezept konnte nicht gelesen werden"
L["Please open this window again"] = "Öffne das Fenster bitte erneut"

--Comm.lua
L["Sending account sharing request to %s"] = "Sending account sharing request to %s"
L["Account sharing request received from %s"] = "Account sharing request received from %s"
L["You have received an account sharing request\nfrom %s%s|r, accept it?"] = "You have received an account sharing request\nfrom %s%s|r, accept it?"
L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"] = "%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"
L["Request rejected by %s"] = "Request rejected by %s"
L["%s is in combat, request cancelled"] = "%s is in combat, request cancelled"
L["%s has disabled account sharing"] = "%s has disabled account sharing"
L["Table of content received (%d items)"] = "Table of content received (%d items)"
L["Sending reputations (%d of %d)"] = "Sending reputations (%d of %d)"
L["Sending currencies (%d of %d)"] = "Sending currencies (%d of %d)"
L["Sending guilds (%d of %d)"] = "Sending guilds (%d of %d)"
L["Sending character %s (%d of %d)"] = "Sending character %s (%d of %d)"
L["No reputations found"] = "No reputations found"
L["No currencies found"] = "No currencies found"
L["No guild found"] = "No guild found"
L["Transfer complete"] = "Transfer complete"
L["Reputations received !"] = "Reputations received !"
L["Currencies received !"] = "Currencies received !"
L["Guilds received !"] = "Guilds received !"
L["Character %s received !"] = "Character %s received !"
L["Requesting item %d of %d"] = "Requesting item %d of %d"
L["Sending table of content (%d items)"] = "Sending table of content (%d items)"
L["Guild bank tab %s successfully updated !"] = "Guild bank tab %s successfully updated !"
L["%s has disabled guild communication"] = "%s has disabled guild communication"
L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"] = "%s%s|r has requested the bank tab %s%s|r\nSend this information ?"
L["%sWarning:|r make sure this user may view this information before accepting"] = "%sWarning:|r make sure this user may view this information before accepting"
L["%s|r has received a mail from %s"] = "%s|r has received a mail from %s"
L["Sending reference data: %s (%d of %d)"] = "Sending reference data: %s (%d of %d)"
L["Reference data not available"] = "Reference data not available"
L["Reference data received (%s) !"] = "Reference data received (%s) !"
L["Waiting for %s to accept .."] = "Waiting for %s to accept .."

--GuildBankTabs.lua
L["Requesting %s information from %s"] = "Requesting %s information from %s"
L["Guild Bank Remote Update"] = "Guild Bank Remote Update"
L["Clicking this button will update\nyour local %s%s|r bank tab\nbased on %s%s's|r data"] = "Clicking this button will update\nyour local %s%s|r bank tab\nbased on %s%s's|r data"

--GuildMembers.lua
L["Left-click to see this character's equipment"] = "Left-click to see this character's equipment"
L["Click a character's AiL to see its equipment"] = "Click a character's AiL to see its equipment"

--GuildProfessions.lua
L["Offline Members"] = "Offline Members"
L["Left click to view"] = "Left click to view"
L["Shift+Left click to link"] = "Shift+Left click to link"

--Core.lua
L['search'] = 'Suche'
L["Search in bags"] = "In Taschen suchen"
L['show'] = 'zeigen'
L["Shows the UI"] = "Interface anzeigen"
L['hide'] = 'verstecken'
L["Hides the UI"] = "Interface verstecken"
L['toggle'] = 'sperren'
L["Toggles the UI"] = "Interface sperren"
L["Altoholic:|r Usage = /altoholic search <item name>"] = "Altoholic:|r Usage = /altoholic search <item name>"

--AltoholicFu.lua
L["Left-click to"] = "Links-Klick um zu"
L["open/close"] = "öffnen/schließen"

--AccountSummary.lua
L["View bags"] = "Taschen zeigen"
L["All-in-one"] = "All-in-one"
L["View mailbox"] = "Postfach zeigen"
L["View quest log"] = "Questlog zeigen"
L["View auctions"] = "Auktionen zeigen"
L["View bids"] = "Gebote zeigen"
L["Delete this Alt"] = "Lösche diesen Twink"
L["Cannot delete current character"] = "Aktueller Charakter kann nicht gelöscht werden"
L["Character %s successfully deleted"] = "Charakter %s erfolgreich gelöscht"
L["Delete this Realm"] = "Delete this Realm"
L["Cannot delete current realm"] = "Cannot delete current realm"
L["Realm %s successfully deleted"] = "Realm %s successfully deleted"
L["Suggested leveling zone: "] = "Vorgeschlagene Zone zum leveln: "
L["Arena points: "] = "Arenapunkte: "
L["Honor points: "] = "Ehrenpunkte: "
L["Right-Click for options"] = "Right-Click for options"
L["Average Item Level"] = "Average Item Level"

-- AuctionHouse.lua
L["%s has no auctions"] = "%s hat keine Auktionen"
L["%s has no bids"] = "%s hat keine Gebote"
L["last check "] = "letzte Überprüfung "
L["Goblin AH"] = "Goblin AH"
L["Clear your faction's entries"] = "Einträge der Fraktion löschen"
L["Clear goblin AH entries"] = "Einträge aus dem Goblin AH löschen"
L["Clear all entries"] = "Alle Einträge löschen"


--BagUsage.lua
L["Totals"] = "Gesamt"
L["slots"] = "slots"
L["free"] = "frei"

--Containers.lua
L["32 Keys Max"] = "Maximal 32 Tasten"
L["28 Slot"] = "28 Slot"
L["Bank bag"] = "Bank Tasche"
L["Unknown link, please relog this character"] = "Unbekannter Link, bitte den Charakter neu einloggen"

--Equipment.lua
L["Find Upgrade"] = "Upgrade suchen"
L["(based on iLvl)"] = "(basiert auf iLvl)"
L["Right-Click to find an upgrade"] = "Rechts-Klick um Upgrade zu finden"
L["Tank"] = "Tank"
L["DPS"] = "DPS"
L["Balance"] = "Balance"
L["Elemental Shaman"] = "Elementar Schamane"		-- shaman spec !
L["Heal"] = "Heal"

--GuildBank.lua
L["Last visit: %s by %s"] = "Last visit: %s by %s"
L["Local Time: %s   %sRealm Time: %s"] = "Local Time: %s   %sRealm Time: %s"

--Mails.lua
L[" has not visited his/her mailbox yet"] = " hat noch nicht sein Postfach besucht"
L["%s has no mail"] = "%s hat keine Post"
L[" has no mail, last check "] = " hat keine Post, zuletzt überprüft am "
L[" days ago"] = " Tage zuvor"
L["Mail was last checked "] = "Postfach wurde zuletzt überprüft "
L[" days"] = " Tage"
L["Mail is about to expire on at least one character."] = "Mail is about to expire on at least one character."
L["Refer to the activity pane for more details."] = "Refer to the activity pane for more details."
L["Do you want to view it now ?"] = "Do you want to view it now ?"

--Quests.lua
L["No quest found for "] = "Keine Quest gefunden für "
L["QuestID"] = "QuestID"
L["Are also on this quest:"] = "Haben auch diese Quest:"

--Recipes.lua
L["No data"] = "Keine Daten"
L[" scan failed for "] = " Scan fehlgeschlagen für "

--Reputations.lua
L["Shift-Click to link this info"] = "Shift-Klick um diese Information zu verlinken"
L[" is "] = " ist "
L[" with "] = " bei "

--Search.lua
L["Item Level"] = "Item Level"
L[" results found (Showing "] = " Ergebnisse gefunden (Zeige "
L["No match found!"] = "Kein Ergebnis gefunden!"
L[" not found!"] = " nicht gefunden!"
L["Socket"] = "Sockel"

--skills.lua
L["Rogue Proficiencies"] = "Schurken Fertigkeiten"
L["up to"] = "bis zu "
L["at"] = "auf"
L["and above"] = "und höher"
L["Suggestion"] = "Vorschlag"
L["Prof. 1"] = "Prof. 1"
L["Prof. 2"] = "Prof. 2"
L["Grey"] = "Grey"
L["All cooldowns are up"] = "All cooldowns are up"

-- TabSummary.lua
L["All accounts"] = "All accounts"

-- TabCharacters.lua
L["Cannot link another realm's tradeskill"] = "Cannot link another realm's tradeskill"
L["Cannot link another account's tradeskill"] = "Cannot link another account's tradeskill"
L["Invalid tradeskill link"] = "Invalid tradeskill link"
L["Expiry:"] = "Expiry:"

-- TabGuildBank.lua
L["N/A"] = "N/A"
L["Delete Guild Bank?"] = "Delete Guild Bank?"
L["Guild %s successfully deleted"] = "Guild %s successfully deleted"

-- TabSearch.lua
L["Any"] = "Sonstige"
L["Miscellaneous"] = "Verschiedenes"
L["Fishing Poles"] = "Angelruten"
L["This realm"] = "Dieser Realm"
L["All realms"] = "Alle Realms"
L["Loot tables"] = "Loot Tabellen"
L["This character"] = "This character"
L["This faction"] = "This faction"
L["Both factions"] = "Both factions"

--loots.lua
--Instinct drop
L["Hard Mode"] = "Hard Mode"
L["Trash Mobs"] = "Trash Mobs"
L["Random Boss"] = "Random Boss"
L["Druid Set"] = "Druiden Set"
L["Hunter Set"] = "Jäger Set"
L["Mage Set"] = "Magier Set"
L["Paladin Set"] = "Paladin Set"				-- translation needed
L["Priest Set"] = "Priester Set"
L["Rogue Set"] = "Schurken Set"
L["Shaman Set"] = "Schamanen Set"
L["Warlock Set"] = "Hexenmeister Set"
L["Warrior Set"] = "Krieger Set"
L["Legendary Mount"] = "Legendäres Mount"
L["Legendaries"] = "Legendäres"
L["Muddy Churning Waters"] = "Muddy Churning Waters"				-- translation needed
L["Shared"] = "Geteilt"
L["Enchants"] = "Verzauberungen"
L["Rajaxx's Captains"] = "Rajaxx's Captains"
L["Class Books"] = "Klassenbücher"
L["Quest Items"] = "Quest Items"
L["Druid of the Fang (Trash Mob)"] = "Druide des Giftzahns (Trash Mob)"
L["Spawn Of Hakkar"] = "Brut von Hakkar"
L["Troll Mini bosses"] = "Troll Mini Bosse"
L["Henry Stern"] = "Henry Stern"
L["Magregan Deepshadow"] = "Magregan Grubenschatten"
L["Tablet of Ryuneh"] = "Schrifttafel von Ryun'eh"
L["Krom Stoutarm Chest"] = "Krom Starkarms Truhe"
L["Garrett Family Chest"] = "Familientruhe der Garretts"
L["Eric The Swift"] = "Eric 'Der Flinke'"
L["Olaf"] = "Olaf"
L["Baelog's Chest"] = "Baelogs Truhe"
L["Conspicuous Urn"] = "Verdächtige Urne"
L["Tablet of Will"] = "Schrifttafel des Willens"
L["Shadowforge Cache"] = "Schattenschmiedecache"
L["Roogug"] = "Roogug"
L["Aggem Thorncurse"] = "Aggem Dornfluch"
L["Razorfen Spearhide"] = "Speerträger der Klingenhauer"
L["Pyron"] = "Pyron"
L["Theldren"] = "Theldren"
L["The Vault"] = "Der Tresor"
L["Summoner's Tomb"] = "Summoner's Tomb"				-- translation needed
L["Plans"] = "Pläne"
L["Zelemar the Wrathful"] = "Zelemar der Hasserfüllte"
L["Rethilgore"] = "Rotkralle"
L["Fel Steed"] = "Teufelsross"
L["Tribute Run"] = "Tribut Run"
L["Shen'dralar Provisioner"] = "Versorger der Shen'dralar"
L["Books"] = "Bücher"
L["Trinkets"] = "Trinkets"
L["Sothos & Jarien"] = "Sothos und Jarien"
L["Fel Iron Chest"] = "Teufelseisentruhe"
L[" (Heroic)"] = " (Heroisch)"
L["Yor (Heroic Summon)"] = "Yor (Heroisch)"
L["Avatar of the Martyred"] = "Avatar des Gemarterten"
L["Anzu the Raven God (Heroic Summon)"] = "Anzu the Raven God (Heroisch)"
L["Thomas Yance"] = "Thomas Yance"
L["Aged Dalaran Wizard"] = "Gealterter Hexer von Dalaran"
L["Cache of the Legion"] = "Behälter der Legion"
L["Opera (Shared Drops)"] = "Opera (Geteilte Drops)"
L["Timed Chest"] = "Timed Chest"				-- translation needed
L["Patterns"] = "Muster"

--Rep
L["Token Hand-Ins"] = "Token Hand-Ins"				-- translation needed
L["Items"] = "Items"
L["Beasts Deck"] = "Bestienkartenset"
L["Elementals Deck"] = "Elementarkartenset"
L["Warlords Deck"] = "Kriegsfürstenkartenset"
L["Portals Deck"] = "Portalkartenset"
L["Furies Deck"] = "Furienkartenset"
L["Storms Deck"] = "Sturmkartenset"
L["Blessings Deck"] = "Segenskartenset"
L["Lunacy Deck"] = "Deliriumkartenset"
L["Quest rewards"] = "Quest Belohnungen"
--L["Shattrath"] = true,

--World drop
L["Outdoor Bosses"] = "Outdoor Bosse"
L["Highlord Kruul"] = "Hochlord Kruul"
L["Bash'ir Landing"] = "Landeplatz von Bash'ir"
L["Skyguard Raid"] = "Raid unter freiem Himmel"
L["Stasis Chambers"] = "Stasiskammern"
L["Skettis"] = "Skettis"
L["Darkscreecher Akkarai"] = "Dunkelkreischer Akkarai"
L["Karrog"] = "Karrog"
L["Gezzarak the Huntress"] = "Gezzarak die Jägerin"
L["Vakkiz the Windrager"] = "Vakkiz der Windzürner"
L["Terokk"] = "Terokk"
L["Ethereum Prison"] = "Gefängnis des Astraleums"
L["Armbreaker Huffaz"] = "Armbrecher Huffaz"
L["Fel Tinkerer Zortan"] = "Teufelstüftler Zortan"
L["Forgosh"] = "Forgosh"
L["Gul'bor"] = "Gul'bor"
L["Malevus the Mad"] = "Malevus die Verrückte"
L["Porfus the Gem Gorger"] = "Porfus der Edelsteinschlinger"
L["Wrathbringer Laz-tarash"] = "Zornschaffer Laz-tarash"
L["Abyssal Council"] = "Abyssischer Rat"
L["Crimson Templar (Fire)"] = "Purpurroter Templer (Feuer)"
L["Azure Templar (Water)"] = "Azurblauer Templer (Wasser)"
L["Hoary Templar (Wind)"] = "Weißgrauer Templer (Wind)"
L["Earthen Templar (Earth)"] = "Irdener Templer (Erde)"
L["The Duke of Cinders (Fire)"] = "The Duke of Cinders (Fire)"				-- translation needed
L["The Duke of Fathoms (Water)"] = "The Duke of Fathoms (Water)"				-- translation needed
L["The Duke of Zephyrs (Wind)"] = "The Duke of Zephyrs (Wind)"				-- translation needed
L["The Duke of Shards (Earth)"] = "The Duke of Shards (Earth)"				-- translation needed
L["Elemental Invasion"] = "Invasion der Elementare"
L["Gurubashi Arena"] = "Gurubashi Arena"
L["Booty Run"] = "Booty Run"				-- translation needed
L["Fishing Extravaganza"] = "Fishing Extravaganza"				-- translation needed
L["First Prize"] = "Hauptpreis"
L["Rare Fish"] = "Besondere Fische"
L["Rare Fish Rewards"] = "Besonderer Fisch - Belohnungen"
L["Children's Week"] = "Kinderwoche"
L["Love is in the air"] = "Herzklopfen"
L["Gift of Adoration"] = "Geschenke der Verehrung"
L["Box of Chocolates"] = "Schokoladenschachtel"
L["Hallow's End"] = "Schlotternächte"
L["Various Locations"] = "Verschiedene Orte"
L["Treat Bag"] = "Schlotterbeutel"
L["Headless Horseman"] = "Kopfloser Reiter"
L["Feast of Winter Veil"] = "Winterhauchfest"
L["Smokywood Pastures Vendor"] = "Smokywood Pastures Vendor"				-- translation needed
L["Gaily Wrapped Present"] = "Fröhlich verpacktes Geschenk"
L["Festive Gift"] = "Festtagsgeschenk"
L["Winter Veil Gift"] = "Winterhauchgeschenk"
L["Gently Shaken Gift"] = "Leicht geschütteltes Geschenk"
L["Ticking Present"] = "Tickendes Geschenk"
L["Carefully Wrapped Present"] = "Sorgfältig verpacktes Geschenk"
L["Noblegarden"] = "Nobelgarten"
L["Brightly Colored Egg"] = "Osterei"
L["Smokywood Pastures Extra-Special Gift"] = "Kokelwälder Extraspezialgeschenk"
L["Harvest Festival"] = "Erntedankfest"
L["Food"] = "Essen"
L["Scourge Invasion"] = "Invasion der Geißel"
--L["Miscellaneous"] = true
L["Cloth Set"] = "Stoff Set"
L["Leather Set"] = "Leder Set"
L["Mail Set"] = "Schwere Rüstung Set"
L["Plate Set"] = "Platte Set"
L["Balzaphon"] = "Balzaphon"
L["Lord Blackwood"] = "Fürst Schwarzstahls "
L["Revanchion"] = "Revanchion"
L["Scorn"] = "des Verächter"
L["Sever"] = "des Kampfmeisters"
L["Lady Falther'ess"] = "Lady Falther'ess"
L["Lunar Festival"] = "Mondfest"
L["Fireworks Pack"] = "Feuerwerkspaket"
L["Lucky Red Envelope"] = "Roter Glücksumschlag"
L["Midsummer Fire Festival"] = "Das Sonnenwendfest"
L["Lord Ahune"] = "Lord Ahune"
L["Shartuul"] = "Shartuul"
L["Blade Edge Mountains"] = "Schergrat"
L["Brewfest"] = "Brewfest"
L["Barleybrew Brewery"] = "Gerstenbräu Brauerei"
L["Thunderbrew Brewery"] = "Donnerbräu Brauerei"
L["Gordok Brewery"] = "Gordok Brauerei"
L["Drohn's Distillery"] = "Drohn's  Brauerei"
L["T'chali's Voodoo Brewery"] = "T'chali's Voodoobrauerei"

--craft
L["Crafted Weapons"] = "Handgemachte Waffen"
L["Master Swordsmith"] = "Schwertschmiedemeister"
L["Master Axesmith"] = "Axtschmiedemeister"
L["Master Hammersmith"] = "Streitkolbenschmiedemeister"
L["Blacksmithing (Lv 60)"] = "Schmiedekunst (Lv 60)"
L["Blacksmithing (Lv 70)"] = "Schmiedekunst (Lv 70)"
L["Engineering (Lv 60)"] = "Ingeneurskunst (Lv 60)"
L["Engineering (Lv 70)"] = "Ingeneurskunst (Lv 70)"
L["Blacksmithing Plate Sets"] = "Schmiedekunst Platten Sets"
L["Imperial Plate"] = "Stolz des Imperiums"
L["The Darksoul"] = "Die dunkle Seele"
L["Fel Iron Plate"] = "Teufelseisenplattenrüstung"
L["Adamantite Battlegear"] = "Adamantitschlachtrüstung"
L["Flame Guard"] = "Flammenwächter"
L["Enchanted Adamantite Armor"] = "Verzauberte Adamantitrüstung"
L["Khorium Ward"] = "Khoriumschutz"
L["Faith in Felsteel"] = "Teufelsstählerner Wille"
L["Burning Rage"] = "Brennernder Zorn"
L["Blacksmithing Mail Sets"] = "Schmiedekunst Schwere Rüstung Sets"
L["Bloodsoul Embrace"] = "Umarmung der Blutseele"
L["Fel Iron Chain"] = "Teufelseisenkettenrüstung"	
L["Tailoring Sets"] = "Schneiderei Sets"
L["Bloodvine Garb"] = "Blutrebengewand"
L["Netherweave Vestments"] = "Netherstoffgewänder"
L["Imbued Netherweave"] = "Magieerfüllte Netherstoffroben"
L["Arcanoweave Vestments"] = "Arkanostoffgewänder"
L["The Unyielding"] = "Der Unerschütterliche"
L["Whitemend Wisdom"] = "Weisheit des weißen Heilers"
L["Spellstrike Infusion"] = "Insignien des Zauberschlags"
L["Battlecast Garb"] = "Gewand des Schlachtenzaubers"
L["Soulcloth Embrace"] = "Seelenstoffumarmung"
L["Primal Mooncloth"] = "Urmondroben"
L["Shadow's Embrace"] = "Umarmung der Schatten"
L["Wrath of Spellfire"] = "Zorn des Zauberfeuers"
L["Leatherworking Leather Sets"] = "Lederverarbeitung Leder Sets"
L["Volcanic Armor"] = "Vulkanrüstung"
L["Ironfeather Armor"] = "Eisenfederrüstung"
L["Stormshroud Armor"] = "Sturmschleier"
L["Devilsaur Armor"] = "Teufelsaurierrüstung"
L["Blood Tiger Harness"] = "Harnisch des Bluttigers"
L["Primal Batskin"] = "Urzeitliche Fledermaushaut"
L["Wild Draenish Armor"] = "Wilde draenische Rüstung"
L["Thick Draenic Armor"] = "Dicke draenische Rüstung"
L["Fel Skin"] = "Teufelshaut"
L["Strength of the Clefthoof"] = "Macht der Grollhufe"
L["Primal Intent"] = "Urinstinkt"
L["Windhawk Armor"] = "Rüstung des Windfalken"
L["Leatherworking Mail Sets"] = "Leatherworking Schwere Rüstung Sets"
L["Green Dragon Mail"] = "Grüner Drachenschuppenpanzer"
L["Blue Dragon Mail"] = "Blauer Drachenschuppenpanzer"
L["Black Dragon Mail"] = "Schwarzer Drachenschuppenpanzer"
L["Scaled Draenic Armor"] = "Geschuppte draenische Rüstung"
L["Felscale Armor"] = "Teufelsschuppenrüstung"
L["Felstalker Armor"] = "Rüstung des Teufelspirschers"
L["Fury of the Nether"] = "Netherzorn"
L["Netherscale Armor"] = "Netherschuppenrüstung"
L["Netherstrike Armor"] = "Rüstung des Netherstoßes"	
L["Armorsmith"] = "Rüstungsschmied"
L["Weaponsmith"] = "Waffenschmied"
L["Dragonscale"] = "Drachenlederverarbeitung"
L["Elemental"] = "Elementarlederverarbeitung"
L["Tribal"] = "Stammeslederverarbeitung"
L["Mooncloth"] = "Mondstoffschneiderei"
L["Shadoweave"] = "Schattenzwirnschneiderei"
L["Spellfire"] = "Zauberfeuerschneiderei"
L["Gnomish"] = "Gnomeningenieurskunst"
L["Goblin"] = "Gobliningenieurskunst"
L["Apprentice"] = "Lehring"
L["Journeyman"] = "Geselle"
L["Expert"] = "Experte"
L["Artisan"] = "Fachmann"
L["Master"] = "Meister"

--Set & PVP
L["Superior Rewards"] = "Seltene Items"
L["Epic Rewards"] = "Epische Items"
-- L["Lv 10-19 Rewards"] = "Belohnungen (Level 10-19)"
-- L["Lv 20-29 Rewards"] = "Belohnungen (Level 20-29)"
-- L["Lv 30-39 Rewards"] = "Belohnungen (Level 30-39)"
-- L["Lv 40-49 Rewards"] = "Belohnungen (Level 40-49)"
-- L["Lv 50-59 Rewards"] = "Belohnungen (Level 50-59)"
-- L["Lv 60 Rewards"] = "Belohnungen (Level 60)"	
L["Lv %s Rewards"] = "Belohnungen (Level %s)"
L["PVP Cloth Set"] = "PVP Stoff Set"
L["PVP Leather Sets"] = "PVP Leder Sets"
L["PVP Mail Sets"] = "PVP Schwere Rüstung Sets"
L["PVP Plate Sets"] = "PVP Platte Sets"
L["World PVP"] = "Welt PVP"
L["Hellfire Fortifications"] = "Befestigung des Höllenfeuers"
L["Twin Spire Ruins"] = "Ruinen der Zwillingsspitze"
L["Spirit Towers (Terrokar)"] = "Geistertürme (Terrokar)"
L["Halaa (Nagrand)"] = "Halaa (Nagrand)"
-- L["Arena Season 1"] = "Arena Season 1"
-- L["Arena Season 2"] = "Arena Season 2"
-- L["Arena Season 3"] = "Arena Season 3"
-- L["Arena Season 4"] = "Arena Season 4"
L["Arena Season %d"] = "Arena Season %d"
L["Weapons"] = "Waffen"
L["Accessories"] = "Zubehör"
L["Level 70 Reputation PVP"] = "Level 70 Ruf PVP"
L["Level %d Honor PVP"] = "Level %d Ehre PVP"
L["Savage Gladiator\'s Weapons"] = "Savage Gladiator\'s Weapons"
L["Deadly Gladiator\'s Weapons"] = "Deadly Gladiator\'s Weapons"
L["Lake Wintergrasp"] = "Lake Wintergrasp"
L["Non Set Accessories"] = "Nicht Set Zubehör"
L["Non Set Cloth"] = "Nicht Set Stoff"
L["Non Set Leather"] = "Nicht Set Leder"
L["Non Set Mail"] = "Nicht Set Schwere Rüstung"
L["Non Set Plate"] = "Nicht Set Platte"
L["Tier 0.5 Quests"] = "Tier 0.5 Quests"
L["Tier %d Tokens"] = "Tier %d Marken"
L["Blizzard Collectables"] = "Blizzard Collectables"				-- translation needed
L["WoW Collector Edition"] = "WoW Collector Edition"
L["BC Collector Edition (Europe)"] = "BC Collector Edition (Europe)"
L["Blizzcon 2005"] = "Blizzcon 2005"
L["Blizzcon 2007"] = "Blizzcon 2007"
L["Christmas Gift 2006"] = "Weihnachtsgeschenk 2006"
L["Upper Deck"] = "Upper Deck"				-- translation needed
L["Loot Card Items"] = "Loot Card Items"
L["Heroic Mode Tokens"] = "Hero Marken"
L["Fire Resistance Gear"] = "Feuerwiderstand Ausrüstung"
L["Emblems of Valor"] = "Emblems of Valor"
L["Emblems of Heroism"] = "Emblems of Heroism"

L["Cloaks"] = "Umhänge"
L["Relics"] = "Reliquien"
L["World Drops"] = "World Drops"
L["Level 30-39"] = "Level 30-39"
L["Level 40-49"] = "Level 40-49"
L["Level 50-60"] = "Level 50-60"
L["Level 70"] = "Level 70"

-- Altoholic.Gathering : Mining 
L["Copper Vein"] = "Kupfervorkommen"
L["Tin Vein"] = "Zinnvorkommen"
L["Iron Deposit"] = "Eisenvorkommen"
L["Silver Vein"] = "Silbervorkommen"
L["Gold Vein"] = "Goldvorkommen"
L["Mithril Deposit"] = "Mithrilablagerung"
L["Ooze Covered Mithril Deposit"] = "Brühschlammbedeckte Mithrilablagerung"
L["Truesilver Deposit"] = "Echtsilberablagerung"
L["Ooze Covered Silver Vein"] = "Brühschlammbedecktes Silbervorkommen"
L["Ooze Covered Gold Vein"] = "Brühschlammbedecktes Goldvorkommen"
L["Ooze Covered Truesilver Deposit"] = "Brühschlammbedeckte Echtsilberablagerung"
L["Ooze Covered Rich Thorium Vein"] = "Brühschlammbedecktes reiches Thoriumvorkommen"
L["Ooze Covered Thorium Vein"] = "Brühschlammbedecktes Thoriumvorkommen"
L["Small Thorium Vein"] = "Kleines Thoriumvorkommen"
L["Rich Thorium Vein"] = "Reiches Thoriumvorkommen"
L["Hakkari Thorium Vein"] = "Hakkari Thoriumvorkommen"
L["Dark Iron Deposit"] = "Dunkeleisenablagerung"
L["Lesser Bloodstone Deposit"] = "Geringe Blutsteinablagerung"
L["Incendicite Mineral Vein"] = "Pyrophormineralvorkommen"
L["Indurium Mineral Vein"] = "Induriummineralvorkommen"
L["Fel Iron Deposit"] = "Teufelseisenvorkommen"
L["Adamantite Deposit"] = "Adamantitablagerung"
L["Rich Adamantite Deposit"] = "Reiche Adamantitablagerung"
L["Khorium Vein"] = "Khoriumvorkommen"
L["Large Obsidian Chunk"] = "Großer Obsidianbrocken"
L["Small Obsidian Chunk"] = "Kleiner Obsidianbrocken"
L["Nethercite Deposit"] = "Netheritablagerung"

-- Altoholic.Gathering : Herbalism
L["Peacebloom"] = "Friedensblume"
L["Silverleaf"] = "Silberblatt"
L["Earthroot"] = "Erdwurzel"
L["Mageroyal"] = "Maguskönigskraut"
L["Briarthorn"] = "Wilddornrose"
L["Swiftthistle"] = "Flitzdistel"
L["Stranglekelp"] = "Würgetang"
L["Bruiseweed"] = "Beulengras"
L["Wild Steelbloom"] = "Wildstahlblume"
L["Grave Moss"] = "Grabmoos"
L["Kingsblood"] = "Königsblut"
L["Liferoot"] = "Lebenswurz"
L["Fadeleaf"] = "Blassblatt"
L["Goldthorn"] = "Golddorn"
L["Khadgar's Whisker"] = "Khadgars Schnurrbart"
L["Wintersbite"] = "Winterbiss"
L["Firebloom"] = "Feuerblüte"
L["Purple Lotus"] = "Lila Lotus"
L["Wildvine"] = "Wildranke"
L["Arthas' Tears"] = "Arthas’ Tränen"
L["Sungrass"] = "Sonnengras"
L["Blindweed"] = "Blindkraut"
L["Ghost Mushroom"] = "Geisterpilz"
L["Gromsblood"] = "Gromsblut"
L["Golden Sansam"] = "Goldener Sansam"
L["Dreamfoil"] = "Traumblatt"
L["Mountain Silversage"] = "Bergsilbersalbei"
L["Plaguebloom"] = "Pestblüte"
L["Icecap"] = "Eiskappe"
L["Bloodvine"] = "Blutrebe"
L["Black Lotus"] = "Schwarzer Lotus"
L["Felweed"] = "Teufelsgras"
L["Dreaming Glory"] = "Traumwinde"
L["Terocone"] = "Terozapfen"
L["Ancient Lichen"] = "Urflechte"
L["Bloodthistle"] = "Blutdistel"
L["Mana Thistle"] = "Manadistel"
L["Netherbloom"] = "Netherblüte"
L["Nightmare Vine"] = "Alptraumranke"
L["Ragveil"] = "Zottelkappe"
L["Flame Cap"] = "Flammenkappe"
L["Fel Lotus"] = "Teufelslotus"
L["Netherdust Bush"] = "Netherstaubbusch"  	
-- L["Glowcap"] = true,
-- L["Sanguine Hibiscus"] = true,
	


if GetLocale() == "deDE" then

-- This is a global string from wow, for some reason the original is causing problem. DO NOT copy this line in other languages !!!
ITEM_MOD_SPELL_POWER = "Erh\195\182ht die Zaubermacht um %d."; 

-- Altoholic.xml local
LEFT_HINT = "Links-Klick zum |cFF00FF00öffnen";
RIGHT_HINT = "Rechts-Klick zum |cFF00FF00bewegen";

XML_ALTO_SHARING_HINT1 = "Enter an account name that will be\nused for |cFF00FF00display|r purposes only.\n"
				.. "This name can be anything you like,\nit does |cFF00FF00NOT|r have to be the real account name.\n\n"
XML_ALTO_SHARING_HINT2 = "This field |cFF00FF00cannot|r be left empty."

XML_ALTO_TAB1 = "Zusammenfassung"
XML_ALTO_TAB2 = "Charaktere"
XML_ALTO_TAB3 = "Suche"
-- XML_ALTO_TAB4 = GUILD_BANK
XML_ALTO_TABOPTIONS = "Optionen"

XML_ALTO_SUMMARY_MENU1 = "Account Übersicht"
XML_ALTO_SUMMARY_MENU2 = "Taschennutzung"
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
XML_ALTO_CHAR_DD2 = "Charakter"
XML_ALTO_CHAR_DD3 = "Anzeigen"

XML_ALTO_SEARCH_COL1 = "Item / Location"

XML_ALTO_GUILD_TEXT1 = "Hide this guild in the tooltip"

XML_ALTO_ACH_NOTSTARTED = "Not started"
XML_ALTO_ACH_STARTED = "Started"

XML_ALTO_OPT_MENU1 = "Allgemein"
XML_ALTO_OPT_MENU2 = "Suche"
XML_ALTO_OPT_MENU3 = "Postfach"
XML_ALTO_OPT_MENU4 = "Minimap"
XML_ALTO_OPT_MENU5 = "Tooltip"

XML_TEXT_1 = "Gesamt";
XML_TEXT_2 = "Suche";
XML_TEXT_3 = "Level Bereich";
XML_TEXT_4 = "Seltenheit";
XML_TEXT_5 = "Ausrüstungsplatz";
XML_TEXT_6 = "Zurücksetzen";
XML_TEXT_7 = "Suche";

XML_ALTO_TEXT10 = "Account Name"
XML_ALTO_TEXT11 = "Send account sharing request to:"

--Options.xml
XML_ALTO_OPT_GENERAL1 = "Maximale Erholt-XP wird angezeigt als 150%";
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

XML_ALTO_OPT_SEARCH1 = "AutoAbfrage vom Server |cFFFF0000(disconnection risiko)";
XML_ALTO_OPT_SEARCH2 = "|cFFFFFFFFWenn ein Item, dass nicht im lokalen Item Cache\n"
				.. "ist, gefunden wird, während die Loot Tabellen durchsucht werden,\n"
				.. "wird Altoholic versuchen den Server nach 5 neuen Items abzufragen.\n\n"
				.. "Dieses verbessert stufenweise die Übereinstimmung der Suchen,\n"
				.. "da mehr Einzelteile im Item Cache vorhanden sind\n\n"
				.. "Es gibt ein Disconnect Risiko, wenn das gefragte Item\n"
				.. "eine Beute von einem High Level Dungeon ist.\n\n"
				.. "|cFF00FF00Deaktivieren|r um das Risiko zu vermeiden";
XML_ALTO_OPT_SEARCH3 = "Loot in absteigender Reihenfolge sortieren";
XML_ALTO_OPT_SEARCH4 = "Items ohne Levelbegrenzung hinzufügen";
XML_ALTO_OPT_SEARCH5 = "Postfach hinzufügen";
XML_ALTO_OPT_SEARCH6 = "Gildenbank hinzufügen";
XML_ALTO_OPT_SEARCH7 = "Bekannte Rezepte hinzufügen";

XML_ALTO_OPT_MAIL1 = "Warnen, wenn Post abläuft in weniger Tagen als";
XML_ALTO_OPT_MAIL2 = "Mail Ablauf Warnung";
XML_ALTO_OPT_MAIL3 = "Inhalt der Briefe scannen (markiert als gelesen)";
XML_ALTO_OPT_MAIL4 = "New mail notification";
XML_ALTO_OPT_MAIL5 = "Be informed when a guildmate sends a mail to one of my alts.\n\n"
				.. "Mail content is directly visible without having to reconnect the character";

XML_ALTO_OPT_MINIMAP1 = "Bewegen um den Winkel an der Minimap zu ändern";
XML_ALTO_OPT_MINIMAP2 = "Minimap Icon Winkel";
XML_ALTO_OPT_MINIMAP3 = "Bewegen um den Radius an der Minimap zu ändern";
XML_ALTO_OPT_MINIMAP4 = "Minimap Icon Radius";
XML_ALTO_OPT_MINIMAP5 = "Minimap Icon zeigen";

XML_ALTO_OPT_TOOLTIP1 = "Item Quelle anzeigen"; 
XML_ALTO_OPT_TOOLTIP2 = "Anzahl der Items pro Charakter anzeigen";
XML_ALTO_OPT_TOOLTIP3 = "Anzahl der Gesamtzahl der Items anzeigen";
XML_ALTO_OPT_TOOLTIP4 = "Gildenbank miteinbeziehen";
XML_ALTO_OPT_TOOLTIP5 = "Bereits bekannt/Erlernbar durch miteinbeziehen";
XML_ALTO_OPT_TOOLTIP6 = "Show item ID and item Level";
XML_ALTO_OPT_TOOLTIP7 = "Show counters on gathering nodes";
XML_ALTO_OPT_TOOLTIP8 = "Show counters for both factions";
XML_ALTO_OPT_TOOLTIP9 = "Show counters for all accounts";
XML_ALTO_OPT_TOOLTIP10 = "Include guild bank count in the total count";
end
