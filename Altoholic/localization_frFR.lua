local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "frFR" )

if not L then return end

-- Note: since 2.4.004 and the support of LibBabble, certain lines are commented, but remain there for clarity (especially those concerning the menu)
-- A lot of translations, especially those concerning the loot table, comes from atlas loot, credit goes to their team for gathering this info, I (Thaoky) simply took what I needed.

L["Death Knight"] = "Chevalier de la mort"

-- note: these string are the ones found in item tooltips, make sure to respect the case when translating, and to distinguish them (like crit vs spell crit)
L["Increases healing done by up to %d+"] = "Augmente les soins prodigués d'un maximum de %d+"
L["Increases damage and healing done by magical spells and effects by up to %d+"] = "Augmente les dégâts et les soins produits par les sorts et effets magiques de %d+"
L["Increases attack power by %d+"] = "Augmente de %d+ la puissance d'attaque"
L["Restores %d+ mana per"] = "Rend %d+ points de mana toutes les"
L["Classes: Shaman"] = "Classes: Chaman"
L["Classes: Mage"] = "Classes: Mage"
L["Classes: Rogue"] = "Classes: Voleur"
L["Classes: Hunter"] = "Classes: Chasseur"
L["Classes: Warrior"] = "Classes: Guerrier"
L["Classes: Paladin"] = "Classes: Paladin"
L["Classes: Warlock"] = "Classes: Démoniste"
L["Classes: Priest"] = "Classes: Prêtre"
L["Classes: Death Knight"] = "Classes: Chevalier de la mort"
L["Resistance"] = "Resistance"

--skills
L["Class Skills"] = "Compétences de classe"
L["Professions"] = "Métiers"
L["Secondary Skills"] = "Compétences secondaires"
L["Fishing"] = "Pêche"
L["Riding"] = "Monte"
L["Herbalism"] = "Herboristerie"
L["Mining"] = "Minage"
L["Skinning"] = "Dépeçage"
L["Lockpicking"] = "Crochetage"
L["Poisons"] = "Poisons"
L["Beast Training"] = "Dressage des bêtes"
L["Inscription"] = "Calligraphie"

--factions not in LibFactions or LibZone
L["Alliance Forces"] = "Forces de l'Alliance"
L["Horde Forces"] = "Forces de la Horde"
L["Steamwheedle Cartel"] = "Cartel Gentepression"
L["Other"] = "Autres"

-- menu
L["Reputations"] = "Réputations"
L["Containers"] = "Conteneurs"
L["Guild Bank not visited yet (or not guilded)"] = "Banque de guilde non visitée (ou non guildé)"
L["E-Mail"] = "Courrier"
L["Quests"] = "Quêtes"
L["Equipment"] = "Equipement"

--Altoholic.lua
L["Account"] = "Accompte"
L["Default"] = "Défaut"
L["Loots"] = "Loots"
L["Unknown"] = "Inconnus"
L["has come online"] = "vient de se connecter"
L["has gone offline"] = "vient de se déconnecter"
L["Bank not visited yet"] = "Banque non visitée"
L["Levels"] = "Niveaux"
L["(has mail)"] = "(a du courrier)"
L["(has auctions)"] = "(a des enchères)"
L["(has bids)"] = "(has bids)"

L["No rest XP"] = "Pas d'XP de repos"
L["Rested"] = "Reposé"
L["Transmute"] = "Transmute"

L["Bags"] = "Sacs"
L["Bank"] = "Banque"
L["AH"] = "HV"				-- for auction house, obviously
L["Equipped"] = "Equipé"
L["Mail"] = "Courrier"
L["Mails %s(%d)"] = "Courrier %s(%d)"
L["Mails"] = "Courrier"
L["Visited"] = "Visité"
L["Auctions %s(%d)"] = "Enchères %s(%d)"
L["Bids %s(%d)"] = "Offres %s(%d)"
L[", "] = ", "						-- required for znCH
L["(Guild bank: "] = "(Banque de guilde: "

L["Level"] = "Niveau"
L["Zone"] = "Zone"
L["Rest XP"] = "XP de repos"

L["Source"] = "Source"
L["Total owned"] = "Total possédé"
L["Already known by "] = "Déjà connu par "
L["Will be learnable by "] = "Pourra être appris par "
L["Could be learned by "] = "Pourrait être appris par "

L["At least one recipe could not be read"] = "Au moins une recette n'a pas pu être lue"
L["Please open this window again"] = "Veuillez ouvrir cette fenêtre à nouveau"

--Comm.lua
L["Sending account sharing request to %s"] = "Envoi de la demande de partage à %s"
L["Account sharing request received from %s"] = "Demande de partage de compte reçue de %s"
L["You have received an account sharing request\nfrom %s%s|r, accept it?"] = "%s%s|r vous a envoyé une demande de partage de compte\nAccepter?"
L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"] = "%sAvertissement:|r si vous acceptez, %sTOUTES|r les informations connues d'Altoholic seront envoyées à %s%s|r (sacs, argent, etc..)"
L["Request rejected by %s"] = "Demande rejetée par %s"
L["%s is in combat, request cancelled"] = "%s est en combat, demande annulée"
L["%s has disabled account sharing"] = "%s a désactivé le partage de compte"
L["Table of content received (%d items)"] = "Table des matières reçue (%d objets)"
L["Sending reputations (%d of %d)"] = "Envoi des réputations (%d de %d)"
L["Sending currencies (%d of %d)"] = "Envoi des monnaies (%d de %d)"
L["Sending guilds (%d of %d)"] = "Envoi des guildes (%d de %d)"
L["Sending character %s (%d of %d)"] = "Envoi du personnage %s (%d de %d)"
L["No reputations found"] = "Pas de réputations"
L["No currencies found"] = "Pas de monnaies"
L["No guild found"] = "Pas de guilde"
L["Transfer complete"] = "Transfert terminé"
L["Reputations received !"] = "Réputations reçues !"
L["Currencies received !"] = "Monnaies reçues !"
L["Guilds received !"] = "Guildes reçues !"
L["Character %s received !"] = "Personnage %s reçu !"
L["Requesting item %d of %d"] = "Demande de l'objet %d de %d"
L["Sending table of content (%d items)"] = "Envoi de la table des matières (%d objets)"
L["Guild bank tab %s successfully updated !"] = "Onglet de banque %s mis à jour !"
L["%s has disabled guild communication"] = "%s a désactivé la communication de guilde"
L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"] = "%s%s|r désire l'onglet de banque %s%s|r\nEnvoyer ces informations ?"
L["%sWarning:|r make sure this user may view this information before accepting"] = "%sAvertissement:|r Vérifiez que ce joueur a le droit de voir ces informations avant d'accepter"
L["%s|r has received a mail from %s"] = "%s|r a reçu du courrier de %s"
L["Sending reference data: %s (%d of %d)"] = "Envoi des données de référence : %s (%d of %d)"
L["Reference data not available"] = "Données de référence non disponibles"
L["Reference data received (%s) !"] = "Données de référence reçues (%s) !"
L["Waiting for %s to accept .."] = "Attente d'une réponse de %s .."

--GuildBankTabs.lua
L["Requesting %s information from %s"] = "Demande de l'onglet %s envoyée à %s"
L["Guild Bank Remote Update"] = "Mise-à-jour à distance de la banque de guilde"
L["Clicking this button will update\nyour local %s%s|r bank tab\nbased on %s%s's|r data"] = "Cliquer sur ce bouton mettra à jour\nles données locales de l'onglet %s%s|r\navec celles de %s%s's|r data"

--GuildMembers.lua
L["Left-click to see this character's equipment"] = "Clic-gauche pour voir l'équipement de ce personnage"
L["Click a character's AiL to see its equipment"] = "Cliquez sur l'AiL d'un personnage pour voir son équipment"

--GuildProfessions.lua
L["Offline Members"] = "Membres déconnectés"
L["Left click to view"] = "Clic gauche pour voir"
L["Shift+Left click to link"] = "Shift+Clic gauche pour linker"

--Core.lua
L['search'] = 'search'
L["Search in bags"] = "Recherche dans les sacs"
L['show'] = 'show'
L["Shows the UI"] = "Affiche l'interface"
L['hide'] = 'hide'
L["Hides the UI"] = "Cache l'interface"
L['toggle'] = 'toggle'
L["Toggles the UI"] = "Inverse l'état de l'interface"
L["Altoholic:|r Usage = /altoholic search <item name>"] = "Altoholic:|r Usage = /altoholic search <objet>"

--AltoholicFu.lua
L["Left-click to"] = "Clic-gauche pour"
L["open/close"] = "ouvrir/fermer"

--AccountSummary.lua
L["View bags"] = "Voir les sacs"
L["All-in-one"] = "Tout-en-un"
L["View mailbox"] = "Voir le courrier"
L["View quest log"] = "Voir le journal de quête"
L["View auctions"] = "Voir les enchères"
L["View bids"] = "Voir les offres"
L["Delete this Alt"] = "Effacer ce reroll"
L["Cannot delete current character"] = "Impossible d'effacer le personnage en cours"
L["Character %s successfully deleted"] = "Personnage %s effacé avec succès"
L["Delete this Realm"] = "Effacer ce royaume"
L["Cannot delete current realm"] = "Impossible d'effacer le royaume en cours"
L["Realm %s successfully deleted"] = "Royaume %s effacé avec succès"
L["Suggested leveling zone: "] = "Zone suggérée: "
L["Arena points: "] = "Points d'arène: "
L["Honor points: "] = "Points d'honneur: "
L["Right-Click for options"] = "Clic-droit pour plus d'options"
L["Average Item Level"] = "Niveau moyen des objets"

-- AuctionHouse.lua
L["%s has no auctions"] = "%s n'a pas d'enchères"
L["%s has no bids"] = "%s n'a pas d'offres"
L["last check "] = "dernière visite "
L["Goblin AH"] = "HV Gobelin"
L["Clear your faction's entries"] = "Effacer les entrées de votre faction"
L["Clear goblin AH entries"] = "Effacer les entrées de l'HV gobelin"
L["Clear all entries"] = "Effacer toutes les entrées"

--BagUsage.lua
L["Totals"] = "Totaux"
L["slots"] = "emplacements"
L["free"] = "libre"

--Containers.lua
L["32 Keys Max"] = "32 Clés Max"
L["28 Slot"] = "28 emplacements"
L["Bank bag"] = "Sac en banque"
L["Unknown link, please relog this character"] = "Lien inconnu, veuillez reconnecter ce personnage"

--Equipment.lua
L["Find Upgrade"] = "Trouver mieux"
L["(based on iLvl)"] = "(sur base de l'item level)"
L["Right-Click to find an upgrade"] = "Clic-Droit pour trouver mieux"
L["Tank"] = "Tank"
L["DPS"] = "DPS"
L["Balance"] = "Equilibre"
L["Elemental Shaman"] = "Chaman Elémentaire"		-- shaman spec !
L["Heal"] = "Soin"

--GuildBank.lua
L["Last visit: %s by %s"] = "Dernière visite: %s par %s"
L["Local Time: %s   %sRealm Time: %s"] = "Heure Locale: %s   %sHeure Royaume: %s"

--Mails.lua
L[" has not visited his/her mailbox yet"] = " n'a pas encore visité son/sa boîte aux lettres"
L["%s has no mail"] = "%s n'a pas de courrier"
L[" has no mail, last check "] = " n'a pas de courrier, dernière visite il y a "
L[" days ago"] = " jours"		-- this line goes with the previous one
L["Mail was last checked "] = "Courrier relevé il y a "
L[" days"] = " jours"
L["Mail is about to expire on at least one character."] = "Du courrier va bientôt expirer sur au moins un personnage."
L["Refer to the activity pane for more details."] = "Référez vous à l'onglet Activité pour plus de details."
L["Do you want to view it now ?"] = "Voulez-vous le voir maintenant ?"

--Quests.lua
L["No quest found for "] = "Pas de quête trouvée pour "
L["QuestID"] = "ID Quête"
L["Are also on this quest:"] = "Sont également sur cette quête:"

--Recipes.lua
L["No data"] = "Aucune données"
L[" scan failed for "] = " "

--Reputations.lua
L["Shift-Click to link this info"] = "Shift-Clic pour linker cette info"
L[" is "] = " est "
L[" with "] = " chez "		-- I know "with" translates to "avec" in French, but in the very specific sentence where this is used, "chez" is more appropriate
	
--Search.lua
L["Item Level"] = "Niveau de l'objet"
L[" results found (Showing "] = " résultats trouvés (Affichés "
L["No match found!"] = "Aucun résultat trouvé!"
L[" not found!"] = " non trouvé!"
L["Socket"] = "Châsse"

--skills.lua
L["Rogue Proficiencies"] = "Aptitudes du voleur"
L["up to"] = "jusqu'à"
L["at"] = "à"
L["and above"] = "et au-delà"
L["Suggestion"] = "Suggestion"
L["Prof. 1"] = "Prof. 1"
L["Prof. 2"] = "Prof. 2"
L["Grey"] = "Gris"
L["All cooldowns are up"] = "Tous les cooldowns\nsont disponibles"

-- TabSummary.lua
L["All accounts"] = "Tous les comptes"

-- TabCharacters.lua
L["Cannot link another realm's tradeskill"] = "Lien vers une profession d'un autre royaume impossible"
L["Cannot link another account's tradeskill"] = "Lien vers une profession d'un autre compte impossible"
L["Invalid tradeskill link"] = "Lien de profession invalide"
L["Expiry:"] = "Expiration:"

-- TabGuildBank.lua
L["N/A"] = "N/D"
L["Delete Guild Bank?"] = "Effacer cette banque de guilde?"
L["Guild %s successfully deleted"] = "Guilde %s effacée"

-- TabSearch.lua
L["Any"] = "Tout"
L["Miscellaneous"] = "Divers"
L["Fishing Poles"] = "Cannes à pêche"
L["This realm"] = "Ce royaume"
L["All realms"] = "Tous les royaumes"
L["Loot tables"] = "Loots"
L["This character"] = "Ce personnage"
L["This faction"] = "Cette faction"
L["Both factions"] = "Les 2 factions"

--loots.lua
--Instinct drop
L["Hard Mode"] = "Mode Difficile"
L["Trash Mobs"] = "Trash Mobs"
L["Random Boss"] = "Boss aléatoire"
L["Druid Set"] = "Set Druide"
L["Hunter Set"] = "Set Chasseur"
L["Mage Set"] = "Set Mage"
L["Paladin Set"] = "Set Paladin"
L["Priest Set"] = "Set Prêtre"
L["Rogue Set"] = "Set Voleur"
L["Shaman Set"] = "Set Chaman"
L["Warlock Set"] = "Set Démoniste"
L["Warrior Set"] = "Set Guerrier"
L["Legendary Mount"] = "Monture légendaire"
L["Legendaries"] = "Légendaires"
L["Muddy Churning Waters"] = "Muddy Churning Waters"
L["Shared"] = "Partagés"
L["Enchants"] = "Enchantements"
L["Rajaxx's Captains"] = "Les Capitaines de Rajaxx"
L["Class Books"] = "Livres de classe"
L["Quest Items"] = "Objets de quête"
L["Druid of the Fang (Trash Mob)"] = "Druide du Croc (Trash Mob)"
L["Spawn Of Hakkar"] = "Rejeton d'Hakkar"
L["Troll Mini bosses"] = "Mini Boss Trolls"
L["Henry Stern"] = "Henry Stern"
L["Magregan Deepshadow"] = "Magregan Fondombre"
L["Tablet of Ryuneh"] = "Tablette de Ryun'eh"
L["Krom Stoutarm Chest"] = "Coffre de Krom Rudebras"
L["Garrett Family Chest"] = "Coffre de la famille Garrett"
L["Eric The Swift"] = "Eric 'l'Agile'"
L["Olaf"] = "Olaf"
L["Baelog's Chest"] = "Coffre de Baelog"
L["Conspicuous Urn"] = "Urne ostentatoire"
L["Tablet of Will"] = "Tablette de volonté"
L["Shadowforge Cache"] = "Cachette d'Ombreforge"
L["Roogug"] = "Roogug"
L["Aggem Thorncurse"] = "Aggem Malépine"
L["Razorfen Spearhide"] = "Lanceur de Tranchebauge"
L["Pyron"] = "Pyron"
L["Theldren"] = "Theldren"
L["The Vault"] = "La Chambre forte"
L["Summoner's Tomb"] = "Tombe de l'invocateur"
L["Plans"] = "Plans"
L["Zelemar the Wrathful"] = "Zelemar le Courroucé"
L["Rethilgore"] = "Rethiltripe"
L["Fel Steed"] = "Palefroi corrompu"
L["Tribute Run"] = "Tribut du Roi"
L["Shen'dralar Provisioner"] = "Approvisionneur Shen'dralar"
L["Books"] = "Livres"
L["Trinkets"] = "Bijoux"
L["Sothos & Jarien"] = "Sothos et Jarien"
L["Fel Iron Chest"] = "Coffre en gangrefer"
L[" (Heroic)"] = " (Heroïque)"
L["Yor (Heroic Summon)"] = "Yor (Invocation Héroïque)"
L["Avatar of the Martyred"] = "Avatar des martyrs"
L["Anzu the Raven God (Heroic Summon)"] = "Anzu le Dieu Corbeau (Invocation Héroïque)"
L["Thomas Yance"] = "Thomas Yance"
L["Aged Dalaran Wizard"] = "Sorcier de Dalaran âgé"
L["Cache of the Legion"] = "Cache de la Légion"
L["Opera (Shared Drops)"] = "Opéra (Loots partagés)"
L["Timed Chest"] = "Course au coffre"
L["Patterns"] = "Patrons"

--Rep
L["Token Hand-Ins"] = "Insignes de l'Aube / Croisade"
L["Items"] = "Objets"
L["Beasts Deck"] = "Suite de fauves"
L["Elementals Deck"] = "Suite d'Elémentaires"
L["Warlords Deck"] = "Suite de Seigneurs de guerre"
L["Portals Deck"] = "Suite de Portails"
L["Furies Deck"] = "Suite de Furies"
L["Storms Deck"] = "Suite d'Orages"
L["Blessings Deck"] = "Suite de Bénédictions"
L["Lunacy Deck"] = "Suite de Déraison"
L["Quest rewards"] = "Récompenses de quête"
--L["Shattrath"] = true,

--World drop
L["Outdoor Bosses"] = "Boss Extérieurs"
L["Highlord Kruul"] = "Généralissime Kruul"
L["Bash'ir Landing"] = "Point d'ancrage de Bash'ir"
L["Skyguard Raid"] = "Skyguard Raid"
L["Stasis Chambers"] = "Chambre de stase"
L["Skettis"] = "Skettis"
L["Darkscreecher Akkarai"] = "Akkarai le Hurle-sombre"
L["Karrog"] = "Karrog"
L["Gezzarak the Huntress"] = "Gezzarak la Chasseresse"
L["Vakkiz the Windrager"] = "Vakkiz le Ragevent"
L["Terokk"] = "Terokk"
L["Ethereum Prison"] = "Prison de l'Ethereum"
L["Armbreaker Huffaz"] = "Casse-bras Huffaz"
L["Fel Tinkerer Zortan"] = "Bricoleur gangrené Zortan"
L["Forgosh"] = "Forgosh"
L["Gul'bor"] = "Gul'bor"
L["Malevus the Mad"] = "Malevus le Fol"
L["Porfus the Gem Gorger"] = "Porfus le Goinfre-gemmes"
L["Wrathbringer Laz-tarash"] = "Porte-courroux Laz-tarash"
L["Abyssal Council"] = "Conseil abyssal"
L["Crimson Templar (Fire)"] = "Templier cramoisi (Feu)"
L["Azure Templar (Water)"] = "Templier d'azur (Eau)"
L["Hoary Templar (Wind)"] = "Templier chenu (Vent)"
L["Earthen Templar (Earth)"] = "Templier terrestre (Terre)"
L["The Duke of Cinders (Fire)"] = "Le duc des Cendres (Feu)"
L["The Duke of Fathoms (Water)"] = "Le duc des Profondeurs (Eau)"
L["The Duke of Zephyrs (Wind)"] = "Le duc des Zéphyrs (Vent)"
L["The Duke of Shards (Earth)"] = "Le duc des Eclats (Terre)"
L["Elemental Invasion"] = "Invasions élémentaires"
L["Gurubashi Arena"] = "Arène de Gurubashi"
L["Booty Run"] = "Le coffre pirate"
L["Fishing Extravaganza"] = "Concours de pêche" 
L["First Prize"] = "1er prix"
L["Rare Fish"] = "Poissons rares"
L["Rare Fish Rewards"] = "Récompenses des poissons rares"
L["Children's Week"] = "La Semaine des enfants"
L["Love is in the air"] = "De l'amour dans l'air"
L["Gift of Adoration"] = "Cadeau d'adoration"
L["Box of Chocolates"] = "Boîte de chocolats"
L["Hallow's End"] = "La Sanssaint"
L["Various Locations"] = "Lieux divers"
L["Treat Bag"] = "Sac de friandises"
L["Headless Horseman"] = "Cavalier sans tête"
L["Feast of Winter Veil"] = "La fête du Voile d'hiver"
L["Smokywood Pastures Vendor"] = "Vendeurs de Gourmandises Fumebois"
L["Gaily Wrapped Present"] = "Cadeau à l'emballage multicolore"
L["Festive Gift"] = "Cadeau de fête"
L["Winter Veil Gift"] = "Rob-fusée mécanique"
L["Gently Shaken Gift"] = "Cadeau secoué doucement"
L["Ticking Present"] = "Cadeau tic-taquant"
L["Carefully Wrapped Present"] = "Biscuit du Voile d'hiver"
L["Noblegarden"] = "Le jardin des nobles"
L["Brightly Colored Egg"] = "Oeuf brillamment coloré"
L["Smokywood Pastures Extra-Special Gift"] = "Cadeau extra-spécial des Gourmandises Fumebois"
L["Harvest Festival"] = "La Fête des moissons"
L["Food"] = "Nourriture"
L["Scourge Invasion"] = "Invasion du Fléau"
--L["Miscellaneous"] = true,
L["Cloth Set"] = "Set Tissu"
L["Leather Set"] = "Set Cuir"
L["Mail Set"] = "Set Maille"
L["Plate Set"] = "Set Plaque"
L["Balzaphon"] = "Balzaphon"
L["Lord Blackwood"] = "Seigneur Noirbois"
L["Revanchion"] = "Revanchion"
L["Scorn"] = "Scorn"
L["Sever"] = "Sever"
L["Lady Falther'ess"] = "Dame Falther'ess"
L["Lunar Festival"] = "La fête lunaire"
L["Fireworks Pack"] = "Sac de feux d'artifice"
L["Lucky Red Envelope"] = "Enveloppe rouge porte-bonheur"
L["Midsummer Fire Festival"] = "Solstice d'été : la fête du Feu"
L["Lord Ahune"] = "Seigneur Ahune"
L["Shartuul"] = "Shartuul"
L["Blade Edge Mountains"] = "Les Tranchantes"
L["Brewfest"] = "La fête des Brasseurs"
L["Barleybrew Brewery"] = "Apprenti Brasselorge"
L["Thunderbrew Brewery"] = "Apprenti Tonnebière"
L["Gordok Brewery"] = "Apprenti de la bière gordok"
L["Drohn's Distillery"] = "Apprenti de la distillerie Drohn"
L["T'chali's Voodoo Brewery"] = "Apprenti de la brasserie vaudou de T'chali"

--craft
L["Crafted Weapons"] = "Armes fabriquées"
L["Master Swordsmith"] = "Maître fabricant d'épées"
L["Master Axesmith"] = "Maître fabricant de haches"
L["Master Hammersmith"] = "Maître fabricant de marteaux"
L["Blacksmithing (Lv 60)"] = "Forge (Niv 60)"
L["Blacksmithing (Lv 70)"] = "Forge (Niv 70)"
L["Engineering (Lv 60)"] = "Ingéniérie (Niv 60)"
L["Engineering (Lv 70)"] = "Ingéniérie (Niv 70)"
L["Blacksmithing Plate Sets"] = "Sets forge, en plaque"
L["Imperial Plate"] = "Armure impériale en plaques"
L["The Darksoul"] = "La Ténébrâme"
L["Fel Iron Plate"] = "Plaque de gangrefer"
L["Adamantite Battlegear"] = "Tenue de combat en adamantite"
L["Flame Guard"] = "Garde des flammes"
L["Enchanted Adamantite Armor"] = "Armure d'adamantite enchantée"
L["Khorium Ward"] = "Gardien de khorium"
L["Faith in Felsteel"] = "Foi dans le gangracier"
L["Burning Rage"] = "Rage ardente"
L["Blacksmithing Mail Sets"] = "Sets forge, en maille"
L["Bloodsoul Embrace"] = "Etreinte d'âmesang"
L["Fel Iron Chain"] = "Anneaux de gangrefer"	
L["Tailoring Sets"] = "Sets couture"
L["Bloodvine Garb"] = "Atours de vignesang"
L["Netherweave Vestments"] = "Habit en tisse-néant"
L["Imbued Netherweave"] = "Tisse-néant imprégné"
L["Arcanoweave Vestments"] = "Habit de tisse-arcane"
L["The Unyielding"] = "L'Inflexible"
L["Whitemend Wisdom"] = "Sagesse de la blanche guérison"
L["Spellstrike Infusion"] = "Infusion frappe-sort"
L["Battlecast Garb"] = "Atours d'escarmouche"
L["Soulcloth Embrace"] = "Etreinte d'âmétoffe"
L["Primal Mooncloth"] = "Etoffe lunaire primordiale"
L["Shadow's Embrace"] = "Etreinte de l'ombre"
L["Wrath of Spellfire"] = "Habit du feu-sorcier"
L["Leatherworking Leather Sets"] = "Sets travail du cuir, en cuir"
L["Volcanic Armor"] = "Armure volcanique"
L["Ironfeather Armor"] = "Armure de plumacier"
L["Stormshroud Armor"] = "Armure tempétueuse"
L["Devilsaur Armor"] = "Armure de diablosaure"
L["Blood Tiger Harness"] = "Harnais du tigre-sang"
L["Primal Batskin"] = "Peau de chauve-souris primodiale"
L["Wild Draenish Armor"] = "Armure draenique sauvage"
L["Thick Draenic Armor"] = "Armure draenique épaisse"
L["Fel Skin"] = "Gangrepeau"
L["Strength of the Clefthoof"] = "Force du sabot-fourchu"
L["Primal Intent"] = "Intention primordiale"
L["Windhawk Armor"] = "Armure Faucont-du-vent"
L["Leatherworking Mail Sets"] = "Sets travail du cuir, en maille"
L["Green Dragon Mail"] = "Mailles de dragon vert"
L["Blue Dragon Mail"] = "Mailles de dragon bleu"
L["Black Dragon Mail"] = "Mailles de dragon noir"
L["Scaled Draenic Armor"] = "Armure draenique en écailles"
L["Felscale Armor"] = "Armure en gangrécaille"
L["Felstalker Armor"] = "Armure de traqueur gangrené"
L["Fury of the Nether"] = "Furie du Néant"
L["Netherscale Armor"] = "Armure en écailles du Néant"
L["Netherstrike Armor"] = "Armure Coup-de-Néant"	
L["Armorsmith"] = "Fabricant d'armures"
L["Weaponsmith"] = "Fabricant d'armes"
L["Dragonscale"] = "Ecailles de dragon"
L["Elemental"] = "Elémentaire"
L["Tribal"] = "Tribale"
L["Mooncloth"] = "Etoffe Lunaire"
L["Shadoweave"] = "Tisse ombre"
L["Spellfire"] = "Feu Sorcier"
L["Gnomish"] = "Gnome"
L["Goblin"] = "Gobelin"
L["Apprentice"] = "Apprenti"
L["Journeyman"] = "Compagnon"
L["Expert"] = "Expert"
L["Artisan"] = "Artisan"
L["Master"] = "Maître"

--Set & PVP
L["Superior Rewards"] = "Récompenses Supérieures"
L["Epic Rewards"] = "Récompenses Epiques"
-- L["Lv 10-19 Rewards"] = "Récompenses Niveau 10-19"
-- L["Lv 20-29 Rewards"] = "Récompenses Niveau 20-29"
-- L["Lv 30-39 Rewards"] = "Récompenses Niveau 30-39"
-- L["Lv 40-49 Rewards"] = "Récompenses Niveau 40-49"
-- L["Lv 50-59 Rewards"] = "Récompenses Niveau 50-59"
-- L["Lv 60 Rewards"] = "Récompenses Niveau 60"
L["Lv %s Rewards"] = "Récompenses Niveau %s"
L["PVP Cloth Set"] = "Set Tissu JcJ"
L["PVP Leather Sets"] = "Set Cuir JcJ"
L["PVP Mail Sets"] = "Set Maille JcJ"
L["PVP Plate Sets"] = "Set Plaque JcJ"
L["World PVP"] = "PVP Sauvage"
L["Hellfire Fortifications"] = "Fortifications des flammes infernales"
L["Twin Spire Ruins"] = "Ruines des flèches jumelles"
L["Spirit Towers (Terrokar)"] = "Tour des esprits (Terrokar)"
L["Halaa (Nagrand)"] = "Halaa (Nagrand)"
-- L["Arena Season 1"] = "Arène Saison 1"
-- L["Arena Season 2"] = "Arène Saison 2"
-- L["Arena Season 3"] = "Arène Saison 3"
-- L["Arena Season 4"] = "Arène Saison 4"
L["Arena Season %d"] = "Arène Saison %d"
L["Weapons"] = "Armes"
L["Accessories"] = "Accessoires"
L["Level 70 Reputation PVP"] = "JcJ Réputation Niveau 70"
L["Level %d Honor PVP"] = "JcJ Honneur Niveau %d"
L["Savage Gladiator\'s Weapons"] = "Armes Gladiateur sauvage"
L["Deadly Gladiator\'s Weapons"] = "Armes Gladiateur fatal"
L["Lake Wintergrasp"] = "Lac Joug-d'hiver"
L["Non Set Accessories"] = "Accessoires Hors-Set"
L["Non Set Cloth"] = "Tissu Hors-Set"
L["Non Set Leather"] = "Cuir Hors-Set"
L["Non Set Mail"] = "Maille Hors-Set"
L["Non Set Plate"] = "Plaque Hors-Set"
L["Tier 0.5 Quests"] = "Quêtes T0.5"
L["Tier %d Tokens"] = "Insignes T%d"
L["Blizzard Collectables"] = "Goodies Blizzard"
L["WoW Collector Edition"] = "WoW Edition Collector"
L["BC Collector Edition (Europe)"] = "BC Edition Collector (Europe)"
L["Blizzcon 2005"] = "Blizzcon 2005"
L["Blizzcon 2007"] = "Blizzcon 2007"
L["Christmas Gift 2006"] = "Cadeau de Noël 2006"
L["Upper Deck"] = "Upper Deck"
L["Loot Card Items"] = "Butin des cartes à jouer"
L["Heroic Mode Tokens"] = "Insignes Mode Héroïque"
L["Fire Resistance Gear"] = "Equipements de Résistance au Feu"
L["Emblems of Valor"] = "Emblems of Valor"
L["Emblems of Heroism"] = "Emblems of Heroism"

L["Cloaks"] = "Capes"
L["Relics"] = "Reliques"
L["World Drops"] = "World Drops"
L["Level 30-39"] = "Niveau 30-39"
L["Level 40-49"] = "Niveau 40-49"
L["Level 50-60"] = "Niveau 50-60"
L["Level 70"] = "Niveau 70"

-- Altoholic.Gathering : Mining 
L["Copper Vein"] = "Filon de cuivre"
L["Tin Vein"] = "Filon d'étain"
L["Iron Deposit"] = "Gisement de fer"
L["Silver Vein"] = "Filon d'argent"
L["Gold Vein"] = "Filon d'or"
L["Mithril Deposit"] = "Gisement de mithril"
L["Ooze Covered Mithril Deposit"] = "Gisement de mithril couvert de vase"
L["Truesilver Deposit"] = "Gisement de vrai-argent"
L["Ooze Covered Silver Vein"] = "Filon d'argent couvert de limon"
L["Ooze Covered Gold Vein"] = "Filon d'or couvert de limon"
L["Ooze Covered Truesilver Deposit"] = "Gisement de vrai-argent couvert de vase"
L["Ooze Covered Rich Thorium Vein"] = "Riche filon de thorium couvert de limon"
L["Ooze Covered Thorium Vein"] = "Filon de thorium couvert de limon"
L["Small Thorium Vein"] = "Petit filon de thorium"
L["Rich Thorium Vein"] = "Riche filon de thorium"
L["Hakkari Thorium Vein"] = "Filon de thorium Hakkari"
L["Dark Iron Deposit"] = "Gisement de sombrefer"
L["Lesser Bloodstone Deposit"] = "Gisement de pierre de sang inférieure"
L["Incendicite Mineral Vein"] = "Filon d'incendicite"
L["Indurium Mineral Vein"] = "Filon d'indurium"
L["Fel Iron Deposit"] = "Gisement de gangrefer"
L["Adamantite Deposit"] = "Gisement d'adamantite"
L["Rich Adamantite Deposit"] = "Riche gisement d'adamantite"
L["Khorium Vein"] = "Filon de khorium"
L["Large Obsidian Chunk"] = "Grand morceau d'obsidienne"
L["Small Obsidian Chunk"] = "Petit morceau d'obsidienne"
L["Nethercite Deposit"] = "Gisement de néanticite"

-- Altoholic.Gathering : Herbalism
L["Peacebloom"] = "Pacifique"
L["Silverleaf"] = "Feuillargent"
L["Earthroot"] = "Terrestrine"
L["Mageroyal"] = "Mage royal"
L["Briarthorn"] = "Eglantine"
L["Swiftthistle"] = "Chardonnier"
L["Stranglekelp"] = "Etouffante"
L["Bruiseweed"] = "Doulourante"
L["Wild Steelbloom"] = "Aciérite sauvage"
L["Grave Moss"] = "Tombeline"
L["Kingsblood"] = "Sang-royal"
L["Liferoot"] = "Vietérule"
L["Fadeleaf"] = "Pâlerette"
L["Goldthorn"] = "Dorépine"
L["Khadgar's Whisker"] = "Moustache de Khadgar"
L["Wintersbite"] = "Hivernale"
L["Firebloom"] = "Fleur de feu"
L["Purple Lotus"] = "Lotus pourpre"
L["Wildvine"] = "Sauvageonne"
L["Arthas' Tears"] = "Larmes d'Arthas"
L["Sungrass"] = "Soleillette"
L["Blindweed"] = "Aveuglette"
L["Ghost Mushroom"] = "Champignon fantôme"
L["Gromsblood"] = "Gromsang"
L["Golden Sansam"] = "Sansam doré"
L["Dreamfoil"] = "Feuillerêve"
L["Mountain Silversage"] = "Sauge-argent des montagnes"
L["Plaguebloom"] = "Fleur de peste"
L["Icecap"] = "Calot de glace"
L["Bloodvine"] = "Vignesang"
L["Black Lotus"] = "Lotus noir"
L["Felweed"] = "Gangrelette"
L["Dreaming Glory"] = "Glaurier"
L["Terocone"] = "Terocône"
L["Ancient Lichen"] = "Lichen ancien"
L["Bloodthistle"] = "Chardon sanglant"
L["Mana Thistle"] = "Chardon de mana"
L["Netherbloom"] = "Néantine"
L["Nightmare Vine"] = "Cauchemardelle"
L["Ragveil"] = "Voile-misère"
L["Flame Cap"] = "Chapeflamme"
L["Fel Lotus"] = "Gangrelotus"
L["Netherdust Bush"] = "Buisson de pruinéante"
-- L["Glowcap"] = true, 
-- L["Sanguine Hibiscus"] = true,
	

if GetLocale() == "frFR" then
-- Altoholic.xml local
LEFT_HINT = "Clic-gauche pour |cFF00FF00ouvrir";
RIGHT_HINT = "Clic-droit pour |cFF00FF00déplacer";

XML_ALTO_SHARING_HINT1 = "Enter an account name that will be\nused for |cFF00FF00display|r purposes only.\n"
				.. "This name can be anything you like,\nit does |cFF00FF00NOT|r have to be the real account name.\n\n"
XML_ALTO_SHARING_HINT2 = "This field |cFF00FF00cannot|r be left empty."


XML_ALTO_SHARING_HINT1 = "Entrez un nom de compte qui sera utilisé\nà des fins |cFF00FF00d'afffichage|r uniquement.\n"
				.. "Ce nom peut être ce que vous voulez,\nil ne doit |cFF00FF00PAS|r forcément être le nom réel du compte.\n\n"
XML_ALTO_SHARING_HINT2 = "Ce champ |cFF00FF00ne peut pas|r être laissé vide."

XML_ALTO_TAB1 = "Résumé"
XML_ALTO_TAB2 = "Personnages"
XML_ALTO_TAB3 = "Recherche"
-- XML_ALTO_TAB4 = GUILD_BANK
XML_ALTO_TABOPTIONS = "Options"

XML_ALTO_SUMMARY_MENU1 = "Résumé du compte"
XML_ALTO_SUMMARY_MENU2 = "Sacs"
-- XML_ALTO_SUMMARY_MENU3 = SKILLS
XML_ALTO_SUMMARY_MENU4 = "Activité"
XML_ALTO_SUMMARY_MENU5 = "Membres de guilde"
XML_ALTO_SUMMARY_MENU6 = "Métiers de guilde"
XML_ALTO_SUMMARY_MENU7 = "Onglets banque de guilde"

XML_ALTO_SUMMARY_TEXT1 = "Demande de partage de compte"
XML_ALTO_SUMMARY_TEXT2 = "Cliquez sur ce bouton pour demander\n"
				.. "à un joueur de partager sa base de donnée Altoholic\n"
				.. "et l'ajouter à la vôtre"
XML_ALTO_SUMMARY_TEXT3 = "Les deux côtés doivent avoir activé le partage de compte\navant de pouvoir utiliser cette fonctionalité (voir options)"
XML_ALTO_SUMMARY_TEXT4 = "Partage de compte"

XML_ALTO_CHAR_DD1 = "Royaume"
XML_ALTO_CHAR_DD2 = "Personnage"
XML_ALTO_CHAR_DD3 = "Voir"

XML_ALTO_SEARCH_COL1 = "Objet / Lieu"

XML_ALTO_GUILD_TEXT1 = "Cacher cette guilde dans le tooltip"

XML_ALTO_ACH_NOTSTARTED = "Pas commencé"
XML_ALTO_ACH_STARTED = "Commencé"

XML_ALTO_OPT_MENU1 = "Général"
XML_ALTO_OPT_MENU2 = "Recherche"
XML_ALTO_OPT_MENU3 = "Courrier"
XML_ALTO_OPT_MENU4 = "Minimap"
XML_ALTO_OPT_MENU5 = "Tooltip"

XML_TEXT_1 = "Totaux";
XML_TEXT_2 = "Recherche Conteneurs";
XML_TEXT_3 = "Niv. Min/Max";
XML_TEXT_4 = "Rareté";
XML_TEXT_5 = "Equipement";
XML_TEXT_6 = "R.à.z.";
XML_TEXT_7 = "Recherche";

XML_ALTO_TEXT10 = "Nom du compte"
XML_ALTO_TEXT11 = "Envoyer la demande de partage à:"

--Options.xml
XML_ALTO_OPT_GENERAL1 = "XP de repos max affichée comme 150%";
XML_ALTO_OPT_GENERAL2 = "Afficher l'icône FuBar";
XML_ALTO_OPT_GENERAL3 = "Afficher le texte FuBar";
XML_ALTO_OPT_GENERAL4 = "Partage de compte activé";
XML_ALTO_OPT_GENERAL5 = "Communication de guilde activée";
XML_ALTO_OPT_GENERAL6 = "|cFFFFFFFFQuand elle est |cFF00FF00activée|cFFFFFFFF, cette option autorise les autres utilisateurs d'Altoholic\n"
				.. "à vous envoyer des demandes de partage de compte.\n"
				.. "Votre confirmation sera toujours requise à chaque fois que vous recevrez une demande de partage.\n\n"
				.. "Quand elle est |cFFFF0000désactivée|cFFFFFFFF, toutes ces requêtes seront automatiquement rejetées.\n\n"
				.. "Conseil Sécurité: N'activez cette option que quand vous devez transférer des donneés,\ndésactivez là le reste du temps"
XML_ALTO_OPT_GENERAL7 = "|cFFFFFFFFQuand elle est |cFF00FF00activée|cFFFFFFFF, cette option autorise votre guilde\n"
				.. "à voir vos autres personnages et leurs métiers.\n\n"
				.. "Quand elle est |cFFFF0000désactivée|cFFFFFFFF, il n'y aura aucune communication avec la guilde."
XML_ALTO_OPT_GENERAL8 = "Autoriser automatiquement les mise-à-jours de la banque"
XML_ALTO_OPT_GENERAL9 = "|cFFFFFFFFQuand elle est |cFF00FF00activée|cFFFFFFFF, cette option autorise les autres utilisateurs d'Altoholic\n"
				.. "à mettre à jour automatiquement leur données de banque de guilde avec les vôtres.\n\n"
				.. "Quand elle est |cFFFF0000désactivée|cFFFFFFFF, votre confirmation sera\n"
				.. "requise avant tout envoi d'information.\n\n"
				.. "Conseil Sécurité: désactivez cette option si vous avez des droits d'officier\n"
				.. "sur des onglets de banque de guilde qui ne peuvent pas être vus de tous,\n"
				.. "et autorisez les requêtes manuellement"

XML_ALTO_OPT_SEARCH1 = "AutoQuery server |cFFFF0000(risques de déconnexion)";
XML_ALTO_OPT_SEARCH2 = "|cFFFFFFFFSi un objet n'existant pas dans le cache local\n"
				.. "est rencontré lors d'une recherche dans la table des loots,\n"
				.. "Altoholic va tenter d'envoyer des requêtes au serveur pour valider 5 nouveaux objets.\n\n"
				.. "Ceci va graduellement améliorer la consistance des recherches,\n"
				.. "puisque plus d'objets seront disponibles dans le cache local.\n\n"
				.. "Il existe un risque de déconnexion si l'objet\n"
				.. "est un loot d'une instance haut niveau.\n\n"
				.. "|cFF00FF00Désactiver|r pour éviter ce risque";
XML_ALTO_OPT_SEARCH3 = "Tri des loots décroissant";
XML_ALTO_OPT_SEARCH4 = "Incl. les objets sans niveau requis";
XML_ALTO_OPT_SEARCH5 = "Incl. boites aux lettres";
XML_ALTO_OPT_SEARCH6 = "Incl. banque de guilde";
XML_ALTO_OPT_SEARCH7 = "Incl. recettes connues";

XML_ALTO_OPT_MAIL1 = "Avertir quand du courrier arrive à expiration\ndans moins de jours que cette valeur";
XML_ALTO_OPT_MAIL2 = "Avertis. d'expiration du courrier";
XML_ALTO_OPT_MAIL3 = "Lire le courrier (le marque comme lu)";
XML_ALTO_OPT_MAIL4 = "Alerte nouveau courrier";
XML_ALTO_OPT_MAIL5 = "Etre informé quand un membre de la guilde envoie du\ncourrier à un de mes personnages.\n\n"
				.. "Le contenu du courrier est directement visible sans avoir à reconnecter le personnage";

XML_ALTO_OPT_MINIMAP1 = "Déplacer pour changer l'angle de l'icône minimap";
XML_ALTO_OPT_MINIMAP2 = "Angle de l'icône minimap";
XML_ALTO_OPT_MINIMAP3 = "Déplacer pour changer le rayon de l'icône minimap";
XML_ALTO_OPT_MINIMAP4 = "Rayon de l'icône minimap";
XML_ALTO_OPT_MINIMAP5 = "Afficher l'icône minimap";

XML_ALTO_OPT_TOOLTIP1 = "Afficher la source de l'objet";
XML_ALTO_OPT_TOOLTIP2 = "Afficher le décompte par personnage";
XML_ALTO_OPT_TOOLTIP3 = "Afficher le décompte total";
XML_ALTO_OPT_TOOLTIP4 = "Afficher la banque de guilde";
XML_ALTO_OPT_TOOLTIP5 = "Afficher Déjà Connu/Peut être appris par";
XML_ALTO_OPT_TOOLTIP6 = "Afficher l'item ID et l'item level";
XML_ALTO_OPT_TOOLTIP7 = "Afficher les compteurs sur mines et plantes";
XML_ALTO_OPT_TOOLTIP8 = "Afficher les compteurs des deux factions";
XML_ALTO_OPT_TOOLTIP9 = "Afficher les compteurs de tous les comptes";
XML_ALTO_OPT_TOOLTIP10 = "Inclure la banque de guilde dans le décompte total";
end
