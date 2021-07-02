local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "esES" )

if not L then return end

-- Note: since 2.4.004 and the support of LibBabble, certain lines are commented, but remain there for clarity (especially those concerning the menu)
-- A lot of translations, especially those concerning the loot table, comes from atlas loot, credit goes to their team for gathering this info, I (Thaoky) simply took what I needed.

L["Death Knight"] = "Caballero de la Muerte"

-- note: these string are the ones found in item tooltips, make sure to respect the case when translating, and to distinguish them (like crit vs spell crit)
L["Increases healing done by up to %d+"] = "Aumenta la curación hasta %d+"
L["Increases damage and healing done by magical spells and effects by up to %d+"] = "Aumenta el daño y la curación realizada por hechizos mágicos y efectos hasta %d+"
L["Increases attack power by %d+"] = "Aumenta %d+ el poder de ataque"
L["Restores %d+ mana per"] = "Restaura %d+ p. de mana cada"
L["Classes: Shaman"] = "Clases: Chamán"
L["Classes: Mage"] = "Clases: Mago"
L["Classes: Rogue"] = "Clases: Pícaro"
L["Classes: Hunter"] = "Clases: Cazador"
L["Classes: Warrior"] = "Clases: Guerrero"
L["Classes: Paladin"] = "Clases: Paladín"
L["Classes: Warlock"] = "Clases: Brujo"
L["Classes: Priest"] = "Clases: Sacerdote"
L["Classes: Death Knight"] = "Clases: Caballero de la muerte"
L["Resistance"] = "Resistencia"

--skills
L["Class Skills"] = "Habilidades de clase"
L["Professions"] = "Profesiones"
L["Secondary Skills"] = "Habilidades secundarias"
L["Fishing"] = "Pesca"
L["Riding"] = "Equitación"
L["Herbalism"] = "Herboristería"
L["Mining"] = "Minería"
L["Skinning"] = "Desollar"
L["Lockpicking"] = "Ganzúa"
L["Poisons"] = "Venenos"
L["Beast Training"] = "Entrenamiento de bestias"
L["Inscription"] = "Inscripción"

--factions not in LibFactions or LibZone
L["Alliance Forces"] = "Ejercitos de la Alianza"
L["Horde Forces"] = "Ejercitos de la Horda"
L["Steamwheedle Cartel"] = "Cártel Bonvapor"
L["Other"] = "Otros"

-- menu
L["Reputations"] = "Reputación"
L["Containers"] = "Almacenes"
L["Guild Bank not visited yet (or not guilded)"] = "Banco de la Hermandad no visitado aún (o no tienes Hermandad)"
L["E-Mail"] = "Correo"
L["Quests"] = "Misiones"
L["Equipment"] = "Equipo"

--Altoholic.lua
L["Account"] = "Cuenta"
L["Default"] = "Predeterminado"
L["Loots"] = "Saqueos"
L["Unknown"] = "Desconocido"
L["has come online"] = "se ha conectado"
L["has gone offline"] = "se ha desconectado"
L["Bank not visited yet"] = "Banco no visitado aún"
L["Levels"] = "Niveles"
L["(has mail)"] = "(tienes correo)"
L["(has auctions)"] = "(tienes subastas)"
L["(has bids)"] = "(tienes pujas)"

L["No rest XP"] = "Sin reposo de XP"
L["Rested"] = "Reposo"
L["Transmute"] = "Transmutar"

L["Bags"] = "Bolsas"
L["Bank"] = "Banco"
L["AH"] = "AH"				-- for auction house, obviously
L["Equipped"] = "Equipado"
L["Mail"] = "Correo"
L["Mails %s(%d)"] = "Correos %s(%d)"
L["Mails"] = "Correos"
L["Visited"] = "Visitado"
L["Auctions %s(%d)"] = "Subastas %s(%d)"
L["Bids %s(%d)"] = "Pujas %s(%d)"
L[", "] = ", "                        -- required for znCH
L["(Guild bank: "] = "(Banco de la Hermandad: "

L["Level"] = "Nivel"
L["Zone"] = "Zona"
L["Rest XP"] = "XP de reposo"

L["Source"] = "Fuente:"
L["Total owned"] = "Total poseídos"
L["Already known by "] = "Conocido actualmente por  "
L["Will be learnable by "] = "Podría aprenderlo "
L["Could be learned by "] = "Puede aprenderlo "

L["At least one recipe could not be read"] = "Al menos una receta puede no haber sido leída"
L["Please open this window again"] = "Por favor abra esta ventana de nuevo"

--Comm.lua
L["Sending account sharing request to %s"] = "Mandando petición de compartir cuenta a %s"
L["Account sharing request received from %s"] = "Petición de compartir cuenta recibida de %s"
L["You have received an account sharing request\nfrom %s%s|r, accept it?"] = "Has recibido una petición de compartir cuenta\n de %s%s|r, ¿ la aceptas ?"
L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"] = "%sCuidado:|r si aceptas, %sTODA|r la información conocida\npor Altoholic será enviada a %s%s|r (bolsas, dinero, etc..)"
L["Request rejected by %s"] = "Petición rechazada por %s"
L["%s is in combat, request cancelled"] = "%s está en combate, petición cancelada"
L["%s has disabled account sharing"] = "%s tiene desconectado la compartición de cuenta"
L["Table of content received (%d items)"] = "Tabla de contenidos recibida (%d partes)"
L["Sending reputations (%d of %d)"] = "Mandando reputaciones (%d de %d)"
L["Sending currencies (%d of %d)"] = "Mandando economía (%d de %d)"
L["Sending guilds (%d of %d)"] = "Mandando hermandades (%d de %d)"
L["Sending character %s (%d of %d)"] = "Mandando personaje %s (%d de %d)"
L["No reputations found"] = "No se han encontrado reputaciones"
L["No currencies found"] = "No se ha encontrado economía"
L["No guild found"] = "No se ha encontrado hermandad"
L["Transfer complete"] = "Transferencia completada"
L["Reputations received !"] = "¡ Reputaciones recibidas !"
L["Currencies received !"] = "¡ Economía recibida !"
L["Guilds received !"] = "¡ Hermandades recibidas !"
L["Character %s received !"] = "¡ Personaje %s recibidas !"
L["Requesting item %d of %d"] = "Pidiendo parte %d de %d"
L["Sending table of content (%d items)"] = "Mandando tabla de contenidos (%d partes)"
L["Guild bank tab %s successfully updated !"] = "¡ Pestaña de banco de hermandad %s actualizada con éxito !"
L["%s has disabled guild communication"] = "%s ha desactivado la comunicación de hermandad"
L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"] = "%s%s|r ha solicitado la pestaña del banco %s%s|r\n¿ Mandar esta información ?"
L["%sWarning:|r make sure this user may view this information before accepting"] = "%sCuidado:|r asegúrate de que quieres que este usuario vea la información antes de aceptar"
L["%s|r has received a mail from %s"] = "%s|r ha recibido un correo de %s"
L["Sending reference data: %s (%d of %d)"] = "Sending reference data: %s (%d of %d)"
L["Reference data not available"] = "Reference data not available"
L["Reference data received (%s) !"] = "Reference data received (%s) !"
L["Waiting for %s to accept .."] = "Waiting for %s to accept .."

--GuildBankTabs.lua
L["Requesting %s information from %s"] = "Pidiendo %s información de %s"
L["Guild Bank Remote Update"] = "Actualización remota del banco de hermandad"
L["Clicking this button will update\nyour local %s%s|r bank tab\nbased on %s%s's|r data"] = "Clickear en este botón actualizará\ntu banco local de %s%s|r\nbasádose en los datos de %s%s|r"

--GuildMembers.lua
L["Left-click to see this character's equipment"] = "Click-izdo para ver el equipo de este personaje"
L["Click a character's AiL to see its equipment"] = "Click en el valor AiL para ver su equipo"

--GuildProfessions.lua
L["Offline Members"] = "Miembros desconectados"
L["Left click to view"] = "Left click to view"
L["Shift+Left click to link"] = "Shift+Left click to link"

--Core.lua
L['search'] = 'buscar'
L["Search in bags"] = "Buscar en las bolsas"
L['show'] = 'mostrar'
L["Shows the UI"] = "Mostrar el interfaz"
L['hide'] = 'ocultar'
L["Hides the UI"] = "Ocultar el interfaz"
L['toggle'] = 'alternar'
L["Toggles the UI"] = "Alternar el interfaz"
L["Altoholic:|r Usage = /altoholic search <item name>"] = "Altoholic:|r Uso = /altoholic buscar <objeto>"

--AltoholicFu.lua
L["Left-click to"] = "Click-izdo para"
L["open/close"] = "abrir/cerrar"

--AccountSummary.lua
L["View bags"] = "Ver las bolsas"
L["All-in-one"] = "Todo en uno"
L["View mailbox"] = "Ver el buzón de correos"
L["View quest log"] = "Ver el libro de misiones"
L["View auctions"] = "Ver las subastas"
L["View bids"] = "Ver las pujas"
L["Delete this Alt"] = "Borrar este alter"
L["Cannot delete current character"] = "No se puede borrar el personaje actual"
L["Character %s successfully deleted"] = "Personaje %s eliminado correctamente"
L["Delete this Realm"] = "Borrar este reino"
L["Cannot delete current realm"] = "No se puede borrar el reino actual"
L["Realm %s successfully deleted"] = "Reino %s borrado correctamente"
L["Suggested leveling zone: "] = "Zona para subir de nivel sugerida: "
L["Arena points: "] = "Puntos de arena: "
L["Honor points: "] = "Puntos de honor: "
L["Right-Click for options"] = "Click-dcho para opciones"
L["Average Item Level"] = "Nivel medio de objetos"

-- AuctionHouse.lua
L["%s has no auctions"] = "%s no tiene subastas"
L["%s has no bids"] = "%s no tiene pujas"
L["last check "] = "ultima comprobación "
L["Goblin AH"] = "Casa de subastas goblin"
L["Clear your faction's entries"] = "Borrar entradas de tu facción"
L["Clear goblin AH entries"] = "Borrar entradas de subastas goblin"
L["Clear all entries"] = "Borrar todas las entradas"

--BagUsage.lua
L["Totals"] = "Total"
L["slots"] = "casillas"
L["free"] = "libres"

--Containers.lua
L["32 Keys Max"] = "Máximo 32 llaves"
L["28 Slot"] = "28 casillas"
L["Bank bag"] = "Bolsa en banco"
L["Unknown link, please relog this character"] = "Enlace desconocido, por favor, entra con este personaje"

--Equipment.lua
L["Find Upgrade"] = "Encontrar mejora"
L["(based on iLvl)"] = "(basado en el nivel del objeto)"
L["Right-Click to find an upgrade"] = "Botón derecho para encontrar una mejora"
L["Tank"] = "Tanque"
L["DPS"] = "DPS"
L["Balance"] = "Equilibrio"
L["Elemental Shaman"] = "Chamán Elemental"        -- shaman spec !
L["Heal"] = "Curación"

--GuildBank.lua
L["Last visit: %s by %s"] = "Ultima visita: %s by %s"
L["Local Time: %s   %sRealm Time: %s"] = "Hora local: %s   %sHora del reino: %s"

--Mails.lua
L[" has not visited his/her mailbox yet"] = " no ha visitado su buzón de correos aún"
L["%s has no mail"] = "%s no tiene correo"
L[" has no mail, last check "] = " no tiene correo, última comprobación hace "
L[" days ago"] = " días"        -- this line goes with the previous one
L["Mail was last checked "] = "Correo comprobado hace "
L[" days"] = " días"
L["Mail is about to expire on at least one character."] = "Hay correo a punto de expirar en al menos un personaje."
L["Refer to the activity pane for more details."] = "Revisa el panel de actividad para saber más detalles."
L["Do you want to view it now ?"] = "¿ Quieres verlo ahora ?"

--Quests.lua
L["No quest found for "] = "No hay misiones para "
L["QuestID"] = "ID de misión"
L["Are also on this quest:"] = "Estan en esta misión:"

--Recipes.lua
L["No data"] = "Sin datos"
L[" scan failed for "] = " análisis fallido por "

--Reputations.lua
L["Shift-Click to link this info"] = "Mays+Click para enlazar esta información"
L[" is "] = " es "
L[" with "] = " con "        
    
--Search.lua
L["Item Level"] = "Nivel del objeto"
L[" results found (Showing "] = " resultados encontrados (mostrando "
L["No match found!"] = "No se encontro nada!"
L[" not found!"] = " no encontrado!"
L["Socket"] = "Ranuras"

--skills.lua
L["Rogue Proficiencies"] = "Habilidades de pícaro"
L["up to"] = "hasta"
L["at"] = "a"
L["and above"] = "y por encima"
L["Suggestion"] = "Sugerencia"
L["Prof. 1"] = "Prof. 1"
L["Prof. 2"] = "Prof. 2"
L["Grey"] = "Gris"
L["All cooldowns are up"] = "No hay habilidades recargándose"

-- TabSummary.lua
L["All accounts"] = "Todas las cuentas"

-- TabCharacters.lua
L["Cannot link another realm's tradeskill"] = "No se puede enlazar el craft de otro reino"
L["Cannot link another account's tradeskill"] = "No se puede enlazar el craft de otra cuenta"
L["Invalid tradeskill link"] = "Enlace de craft no válido"
L["Expiry:"] = "Expiración:"

-- TabGuildBank.lua
L["N/A"] = "N/D"
L["Delete Guild Bank?"] = "¿Borrar el Banco de la hermandad?"
L["Guild %s successfully deleted"] = "Banco de la hermandad %s borrado"

-- TabSearch.lua
L["Any"] = "Todos"
L["Miscellaneous"] = "Misc."
L["Fishing Poles"] = "Cañas de pescar"
L["This realm"] = "Este reino"
L["All realms"] = "Todos los reinos"
L["Loot tables"] = "Saqueos"
L["This character"] = "This character"
L["This faction"] = "This faction"
L["Both factions"] = "Both factions"

--loots.lua
--Instinct drop
L["Hard Mode"] = "Hard Mode"
L["Trash Mobs"] = "Enemigos basura"
L["Random Boss"] = "Jefe aleatorio"
L["Druid Set"] = "Set de Druida"
L["Hunter Set"] = "Set de Cazador"
L["Mage Set"] = "Set de Mago"
L["Paladin Set"] = "Set de Paladín"
L["Priest Set"] = "Set de Sacerdote"
L["Rogue Set"] = "Set de Pícaro"
L["Shaman Set"] = "Set de Chamán"
L["Warlock Set"] = "Set de Brujo"
L["Warrior Set"] = "Set de Guerrero"
L["Legendary Mount"] = "Montura legendaria"
L["Legendaries"] = "Legendarios"
L["Muddy Churning Waters"] = "Cebo de Fangoapestoso"
L["Shared"] = "Compartidos"
L["Enchants"] = "Encantamientos"
L["Rajaxx's Captains"] = "Los Capitanes de Rajaxx"
L["Class Books"] = "Libros de clase"
L["Quest Items"] = "Objetos de misión"
L["Druid of the Fang (Trash Mob)"] = "Druida del Colmillo (Enemigos basura)"
L["Spawn Of Hakkar"] = "Engendro de Hakkar"
L["Troll Mini bosses"] = "Mini Jefes Trolls"
L["Henry Stern"] = "Henry Stern"
L["Magregan Deepshadow"] = "Magregan Sombraprofunda"
L["Tablet of Ryuneh"] = "Tablilla de Ryun'eh"
L["Krom Stoutarm Chest"] = "Cofre de Krom Brazorecio"
L["Garrett Family Chest"] = "Cofre de la familia Garrett"
L["Eric The Swift"] = "Eric 'El Veloz'"
L["Olaf"] = "Olaf"
L["Baelog's Chest"] = "Cofre de Baelog"
L["Conspicuous Urn"] = "Urna Llamativa"
L["Tablet of Will"] = "Tablilla de voluntad"
L["Shadowforge Cache"] = "Alijo de Forjatiniebla"
L["Roogug"] = "Roogug"
L["Aggem Thorncurse"] = "Aggem Malaespina"
L["Razorfen Spearhide"] = "Cuerolanza de Rajacieno"
L["Pyron"] = "Pyron"
L["Theldren"] = "Theldren"
L["The Vault"] = "The Vault"                           -- ??  maybe "The Bunker"
L["Summoner's Tomb"] = "Summoner's Tomb"     -- ??  mayber "Tumba del Invocador"
L["Plans"] = "Planos"
L["Zelemar the Wrathful"] = "Zelemar El Colérico"
L["Rethilgore"] = "Rethilgore"
L["Fel Steed"] = "Corcel Vil"
L["Tribute Run"] = "Tribute Run"                      -- ??
L["Shen'dralar Provisioner"] = "Proveedor Shen'dralar"
L["Books"] = "Libros"
L["Trinkets"] = "Abalorios"
L["Sothos & Jarien"] = "Sothos y Jarien"
L["Fel Iron Chest"] = "Cofre de Hierro Vil"
L[" (Heroic)"] = " (Heroico)"
L["Yor (Heroic Summon)"] = "Yor (Invocación Heroica)"
L["Avatar of the Martyred"] = "Avatar de los Martirizados"
L["Anzu the Raven God (Heroic Summon)"] = "Anzu El dios Cuervo (Invocación Heroica)"
L["Thomas Yance"] = "Thomas Yance"
L["Aged Dalaran Wizard"] = "Zahorí de Dalaran Envegecido"
L["Cache of the Legion"] = "Alijo de la Legión"
L["Opera (Shared Drops)"] = "Opera (Loots Comunes)"
L["Timed Chest"] = "Cofres contrareloj"
L["Patterns"] = "Patrones"

--Rep
L["Token Hand-Ins"] = "Insignias"
L["Items"] = "Objetos"
L["Beasts Deck"] = "Baraja de Bestias"
L["Elementals Deck"] = "Baraja de Elementales"
L["Warlords Deck"] = "Baraja de Señores de la guerra"
L["Portals Deck"] = "Baraja de Portales"
L["Furies Deck"] = "Baraja de furias"
L["Storms Deck"] = "Baraja de Tormentas"
L["Blessings Deck"] = "Baraja de Bendiciones"
L["Lunacy Deck"] = "Baraja de Locuras"
L["Quest rewards"] = "Recompensas de misión"
--L["Shattrath"] = true,

--World drop
L["Outdoor Bosses"] = "Bosses de Exteriores"
L["Highlord Kruul"] = "Alto Señor Kruul"
L["Bash'ir Landing"] = "Alto Bash'ir"
L["Skyguard Raid"] = "Raid Guardiadelcielo"
L["Stasis Chambers"] = "Cámara de Estasis"
L["Skettis"] = "Skettis"
L["Darkscreecher Akkarai"] = "Estridador Oscuro Akkarai"
L["Karrog"] = "Karrog"
L["Gezzarak the Huntress"] = "Gezzarak la Cazadora"
L["Vakkiz the Windrager"] = "Vakkiz el Foribundo del Viento"
L["Terokk"] = "Terokk"
L["Ethereum Prison"] = "Prisión de el Etereum"
L["Armbreaker Huffaz"] = "Partebrazos Huffaz"
L["Fel Tinkerer Zortan"] = "Manitas Vil Zortan"
L["Forgosh"] = "Forgosh"
L["Gul'bor"] = "Gul'bor"
L["Malevus the Mad"] = "Malevus la Loca"
L["Porfus the Gem Gorger"] = "Porfus el Engullidor de Gemas"
L["Wrathbringer Laz-tarash"] = "Encolerizador Laz-tarash"
L["Abyssal Council"] = "Consejo abisal"
L["Crimson Templar (Fire)"] = "Templario Carmesí (Fuego)"
L["Azure Templar (Water)"] = "Templario Azur (Agua)"
L["Hoary Templar (Wind)"] = "Templario Vestusto (Viento)"
L["Earthen Templar (Earth)"] = "Templario de Tierra (Tierra)"
L["The Duke of Cinders (Fire)"] = "El Duque de las Brasas (Fuego)"
L["The Duke of Fathoms (Water)"] = "El Duque de las Profundidades (Agua)"
L["The Duke of Zephyrs (Wind)"] = "El Duque de los Céfiros (Viento)"
L["The Duke of Shards (Earth)"] = "El Duque de las Esquirlas (Tierra)"
L["Elemental Invasion"] = "Invasión Elemental"
L["Gurubashi Arena"] = "Arena de Gurubashi"
L["Booty Run"] = "El Botín Pirata"
L["Fishing Extravaganza"] = "Concurso de Pesca" 
L["First Prize"] = "1er Premio"
L["Rare Fish"] = "Peces Raros"
L["Rare Fish Rewards"] = "Recompensas por Peces Raros"
L["Children's Week"] = "La semana de los Niños"
L["Love is in the air"] = "El Amor esta en el aire"
L["Gift of Adoration"] = "Regalo de admiración"
L["Box of Chocolates"] = "Caja de Bombones"
L["Hallow's End"] = "Halloween"
L["Various Locations"] = "Varios Lugares"
L["Treat Bag"] = "Bolsa de premios"
L["Headless Horseman"] = "Jinete sin Cabeza"
L["Feast of Winter Veil"] = "Festival de Invierno"
L["Smokywood Pastures Vendor"] = "Vendedor de los Pastos de Bosquehumeante"
L["Gaily Wrapped Present"] = "Regalo con Emboltorio Alegre"
L["Festive Gift"] = "Obsequio Festival"
L["Winter Veil Gift"] = "Regalo del Festival de Invierno"
L["Gently Shaken Gift"] = "Regalo ligeramente agitado"
L["Ticking Present"] = "Obsequio que hace Tic-Tac"
L["Carefully Wrapped Present"] = "Presente envuelto con cuidado"
L["Noblegarden"] = "Noblegarden"
L["Brightly Colored Egg"] = "Huevo Coloreado"
L["Smokywood Pastures Extra-Special Gift"] = "Regalo superespecial de los Pastos de Bosquehumeante"
L["Harvest Festival"] = "Festival de la Cosecha"
L["Food"] = "Comida"
L["Scourge Invasion"] = "Invasión de la Plaga"
--L["Miscellaneous"] = true,
L["Cloth Set"] = "Set de Tela"
L["Leather Set"] = "Set de Cuero"
L["Mail Set"] = "Set de Mallas"
L["Plate Set"] = "Set de Placas"
L["Balzaphon"] = "Balzaphon"
L["Lord Blackwood"] = "Lord Bosque Negro"
L["Revanchion"] = "Revanchion"
L["Scorn"] = "Scorn"
L["Sever"] = "Sever"
L["Lady Falther'ess"] = "Dama Falther'ess"
L["Lunar Festival"] = "Festival de la luna"
L["Fireworks Pack"] = "Paquete de fuegos de Artificio"
L["Lucky Red Envelope"] = "Sobre de la suerte Rojo"
L["Midsummer Fire Festival"] = "Festival del Solsticio de Verano"
L["Lord Ahune"] = "Ahune"
L["Shartuul"] = "Shartuul"
L["Blade Edge Mountains"] = "Montañas de Filoespada"
L["Brewfest"] = "Fiesta de la Cerveza"
L["Barleybrew Brewery"] = "Aprendiz Cebadiz"
L["Thunderbrew Brewery"] = "Aprendiz Cebatruenos"
L["Gordok Brewery"] = "Aprediz de Cerveza gordok"
L["Drohn's Distillery"] = "Aprendiz de destilerias Drohn"
L["T'chali's Voodoo Brewery"] = "Aprendiz de cerveza vudu T'chali"

--craft
L["Crafted Weapons"] = "Armas Construidas"
L["Master Swordsmith"] = "Maestro Forjador de Espadas"
L["Master Axesmith"] = "Maestro Forjador de Hachas"
L["Master Hammersmith"] = "Maestro Forjador de Martillos"
L["Blacksmithing (Lv 60)"] = "Herrería (Niv 60)"
L["Blacksmithing (Lv 70)"] = "Herrería (Niv 70)"
L["Engineering (Lv 60)"] = "Ingeniería (Niv 60)"
L["Engineering (Lv 70)"] = "Ingeniería (Niv 70)"
L["Blacksmithing Plate Sets"] = "Sets de Placas de Herrería"
L["Imperial Plate"] = "Placas Imperiales"
L["The Darksoul"] = "El Alma Negra"
L["Fel Iron Plate"] = "Placa de Hierro Vil"
L["Adamantite Battlegear"] = "Equipo de Batalla de Adamantita"
L["Flame Guard"] = "Guardia de las Llamas"
L["Enchanted Adamantite Armor"] = "Armadura de Adamantita Encantada"
L["Khorium Ward"] = "Resguardo de Korio"
L["Faith in Felsteel"] = "Fé en el Acero Vil"
L["Burning Rage"] = "Ira Ardiente"
L["Blacksmithing Mail Sets"] = "Sets de Mallas de Herrería"
L["Bloodsoul Embrace"] = "Abrazo de Alma de Sangre"
L["Fel Iron Chain"] = "Cadena de Hierro Vil"    
L["Tailoring Sets"] = "Sets de Sastrería"
L["Bloodvine Garb"] = "Atuendo de Vid de Sangre"
L["Netherweave Vestments"] = "Vestimentas de Tejido Abisal"
L["Imbued Netherweave"] = "Tejido Abisal Imbuido"
L["Arcanoweave Vestments"] = "Vestimentas de Tejido Arcano"
L["The Unyielding"] = "Los Implacables"
L["Whitemend Wisdom"] = "Sabiduría con Remiendos Blancos"
L["Spellstrike Infusion"] = "Infusíon de Golpe de Hechizo"
L["Battlecast Garb"] = "Atuendo de Conjuro de Batalla"
L["Soulcloth Embrace"] = "Abrazo de Paño de Alma"
L["Primal Mooncloth"] = "Tela Lunar Primigenia"
L["Shadow's Embrace"] = "Abrazo de las Sombras"
L["Wrath of Spellfire"] = "Cólera de Hechizo de Fuego"
L["Leatherworking Leather Sets"] = "Sets de Cuero de Peletería"
L["Volcanic Armor"] = "Armadura Volcánica"
L["Ironfeather Armor"] = "Armadura Plumahierro"
L["Stormshroud Armor"] = "Armadura de Sudario de Tormentas"
L["Devilsaur Armor"] = "Armadura de Demosaurio"
L["Blood Tiger Harness"] = "Arnés de Tigre de Sangre"
L["Primal Batskin"] = "Piel de Murciélago Primigenia"
L["Wild Draenish Armor"] = "Armadura Draenei Salvage"
L["Thick Draenic Armor"] = "Armadura Draenei Gruesa"
L["Fel Skin"] = "Piel Vil"
L["Strength of the Clefthoof"] = "Fuerza de los Uñagrieta"
L["Primal Intent"] = "Intención Primigenia"
L["Windhawk Armor"] = "Armadura de Halcón del Viento"
L["Leatherworking Mail Sets"] = "Sets de Mallas de Peletería"
L["Green Dragon Mail"] = "Malla de Dragón Verde"
L["Blue Dragon Mail"] = "Malla de Dragón Azul"
L["Black Dragon Mail"] = "Malla de Dragón Negro"
L["Scaled Draenic Armor"] = "Armadura Draénica Escamada"
L["Felscale Armor"] = "Armadura de Escama Vil"
L["Felstalker Armor"] = "Armadura de Acechador Vil"
L["Fury of the Nether"] = "Furia del Vacio"
L["Netherscale Armor"] = "Armadura de Escamas Abisales"
L["Netherstrike Armor"] = "Armadura de Golpe Abisal"    
L["Armorsmith"] = "Forjador de Armaduras"
L["Weaponsmith"] = "Forjador de Armas"
L["Dragonscale"] = "Escamas de Dragón"
L["Elemental"] = "Elemental"
L["Tribal"] = "Tribal"
L["Mooncloth"] = "Tela Lunar"
L["Shadoweave"] = "Tejido de Sombra"
L["Spellfire"] = "Fuego de Hechizo"
L["Gnomish"] = "Gnómica"
L["Goblin"] = "Goblin"
L["Apprentice"] = "Aprendiz"
L["Journeyman"] = "Oficial"
L["Expert"] = "Experto"
L["Artisan"] = "Artesano"
L["Master"] = "Maestro"

--Set & PVP
L["Superior Rewards"] = "Recompensas Superiores"
L["Epic Rewards"] = "Recompensas Épicas"
-- L["Lv 10-19 Rewards"] = "Recompensas Niveles 10-19"
-- L["Lv 20-29 Rewards"] = "Recompensas Niveles 20-29"
-- L["Lv 30-39 Rewards"] = "Recompensas Niveles 30-39"
-- L["Lv 40-49 Rewards"] = "Recompensas Niveles 40-49"
-- L["Lv 50-59 Rewards"] = "Recompensas Niveles 50-59"
-- L["Lv 60 Rewards"] = "Recompensas Nivel 60"
L["Lv %s Rewards"] = "Recompensas Nivel %s"
L["PVP Cloth Set"] = "Set de Tela JcJ"
L["PVP Leather Sets"] = "Set de Cuero JcJ"
L["PVP Mail Sets"] = "Set de Mallas JcJ"
L["PVP Plate Sets"] = "Set de Placas JcJ"
L["World PVP"] = "JcJ Global"
L["Hellfire Fortifications"] = "Fortificaciones de Fuego Infernal"  -- <<
L["Twin Spire Ruins"] = "Twin Spire Ruins"                             -- <<
L["Spirit Towers (Terrokar)"] = "Tour des esprits (Terrokar)"     -- <<
L["Halaa (Nagrand)"] = "Halaa (Nagrand)"
-- L["Arena Season 1"] = "Arena Temporada 1"
-- L["Arena Season 2"] = "Arena Temporada 2"
-- L["Arena Season 3"] = "Arena Temporada 3"
-- L["Arena Season 4"] = "Arena Temporada 4"
L["Arena Season %d"] = "Arena Temporada %d"
L["Weapons"] = "Armas"
L["Accessories"] = "Accesorios"
L["Level 70 Reputation PVP"] = "JcJ Reputación Nivel 70"
L["Level %d Honor PVP"] = "JcJ Honor Nivel %d"
L["Savage Gladiator\'s Weapons"] = "Armas de Gladiador indómito"
L["Deadly Gladiator\'s Weapons"] = "Armas de Gladiador mortífero"
L["Lake Wintergrasp"] = "Lago Conquista del Invierno"
L["Non Set Accessories"] = "Accesorios Independientes"
L["Non Set Cloth"] = "Armaduras de Tela Independientes"
L["Non Set Leather"] = "Armaduras de Cuero Independientes"
L["Non Set Mail"] = "Armaduras de Mallas Independientes"
L["Non Set Plate"] = "Armaduras de Placas Independientes"
L["Tier 0.5 Quests"] = "Tier 0.5 Misiones"
L["Tier %d Tokens"] = "Tier %d Insignias"
L["Blizzard Collectables"] = "Blizzard Colecionables"
L["WoW Collector Edition"] = "WoW Edición de Coleccionista"
L["BC Collector Edition (Europe)"] = "BC Edición de Coleccionista(Europa)"
L["Blizzcon 2005"] = "Blizzcon 2005"
L["Blizzcon 2007"] = "Blizzcon 2007"
L["Christmas Gift 2006"] = "Regalo de Navidad 2006"
L["Upper Deck"] = "Upper Deck"
L["Loot Card Items"] = "Objetos de Cartas Botin"
L["Heroic Mode Tokens"] = "Insignias Heróicas"
L["Fire Resistance Gear"] = "Equipo de Resistencia al Fuego"
L["Emblems of Valor"] = "Emblemas de Valor"
L["Emblems of Heroism"] = "Emblemas de Heroísmo"

L["Cloaks"] = "Capas"
L["Relics"] = "Reliquias"
L["World Drops"] = "Saqueos del Mundo"
L["Level 30-39"] = "Nivel 30-39"
L["Level 40-49"] = "Nivel 40-49"
L["Level 50-60"] = "Nivel 50-60"
L["Level 70"] = "Nivel 70"

-- Altoholic.Gathering : Mining 
L["Copper Vein"] = "Filón de Cobre"
L["Tin Vein"] = "Filón de Estaño"
L["Iron Deposit"] = "Depósito de Hierro"
L["Silver Vein"] = "Filón de Plata"
L["Gold Vein"] = "Filón de Oro"
L["Mithril Deposit"] = "Depósito de Mithril"
L["Ooze Covered Mithril Deposit"] = "Depósito de Mithril cubierto de Moco"
L["Truesilver Deposit"] = "Depósito de Veraplata"
L["Ooze Covered Silver Vein"] = "Filón de Plata cubierto de Moco"
L["Ooze Covered Gold Vein"] = "Filón de Oro Cubierto de Moco"
L["Ooze Covered Truesilver Deposit"] = "Depósito de Veraplata Cubierto de Moco"
L["Ooze Covered Rich Thorium Vein"] = "Filón de Torio Enriquecido Cubierto de Moco"
L["Ooze Covered Thorium Vein"] = "Filón de Torio Cubierto de Moco"
L["Small Thorium Vein"] = "Filón Pequeño de Torio"
L["Rich Thorium Vein"] = "Filón de Torio Enriquecido"
L["Hakkari Thorium Vein"] = "Filón de Torio de Hakkari"
L["Dark Iron Deposit"] = "Depósito de Hierro Negro"
L["Lesser Bloodstone Deposit"] = "Depósito de Sangrita Inferior"
L["Incendicite Mineral Vein"] = "Filón de Incendicita"
L["Indurium Mineral Vein"] = "Filón de Indurio"
L["Fel Iron Deposit"] = "Depósito de Hierro Vil"
L["Adamantite Deposit"] = "Depósito de Adamantita"
L["Rich Adamantite Deposit"] = "Depósito Rico de Adamantita"
L["Khorium Vein"] = "Filón de Korio"
L["Large Obsidian Chunk"] = "Trozo de Obsidiana Grande"
L["Small Obsidian Chunk"] = "Trozo de Obsidiana Pequeño"
L["Nethercite Deposit"] = "Depósito de abisalita"

-- Altoholic.Gathering : Herbalism
L["Peacebloom"] = "Flor de Paz"
L["Silverleaf"] = "HojaPlata"
L["Earthroot"] = "Raiz de Tierra"
L["Mageroyal"] = "Marregal"
L["Briarthorn"] = "Brezospina"
L["Swiftthistle"] = "CardoVeloz"
L["Stranglekelp"] = "Alga Estranguladora"
L["Bruiseweed"] = "Hierba Cardenal"
L["Wild Steelbloom"] = "Acerita Salvaje"
L["Grave Moss"] = "Musgo de Tumba"
L["Kingsblood"] = "Sangrerregia"
L["Liferoot"] = "Vidaraíz"
L["Fadeleaf"] = "Pálida"
L["Goldthorn"] = "Espina de Oro"
L["Khadgar's Whisker"] = "Mostacho de Khadgar"
L["Wintersbite"] = "Ivernalia"
L["Firebloom"] = "Flor de Fuego"
L["Purple Lotus"] = "Loto Cárdeno"
L["Wildvine"] = "Atriplex Salvaje"
L["Arthas' Tears"] = "Lagrimas de Arthas"
L["Sungrass"] = "Solea"
L["Blindweed"] = "Carolina"
L["Ghost Mushroom"] = "Champiñon Fantasma"
L["Gromsblood"] = "Gromsanguina"
L["Golden Sansam"] = "Sansam Dorado"
L["Dreamfoil"] = "Hojasueño"
L["Mountain Silversage"] = "Salviargenta de Montaña"
L["Plaguebloom"] = "Flor de la Peste"
L["Icecap"] = "Setelo"
L["Bloodvine"] = "Vid de Sangre"
L["Black Lotus"] = "Loto Negro"
L["Felweed"] = "Hierba Vil"
L["Dreaming Glory"] = "Gloria de Ensueño"
L["Terocone"] = "Teropiña"
L["Ancient Lichen"] = "Liquen Antiguo"
L["Bloodthistle"] = "Cardo de Sangre"
L["Mana Thistle"] = "Cardo de maná"
L["Netherbloom"] = "Flor Abisal"
L["Nightmare Vine"] = "Vid Pesadilla"
L["Ragveil"] = "Velada"
L["Flame Cap"] = "Copo de LLamas"
L["Fel Lotus"] = "Loto Vil"
L["Netherdust Bush"] = "Arbusto de Polvo Abisal"
-- L["Glowcap"] = true, 
-- L["Sanguine Hibiscus"] = true,
    

if GetLocale() == "esES" then
-- Altoholic.xml local
LEFT_HINT = "Botón izquierdo para |cFF00FF00abrir";
RIGHT_HINT = "Botón derecho para |cFF00FF00desplazar";

XML_ALTO_SHARING_HINT1 = "Introduce un nombre que sólo se usará para |cFF00FF00mostrar|r.\n"
                .. "Este nombre puede ser cualquiera,\n|cFF00FF00NO|r hace falta que sea un nombre real.\n\n"

XML_ALTO_SHARING_HINT2 = "Este campo |cFF00FF00no puede|r ser dejado en blanco."

XML_ALTO_TAB1 = "Resumen"
XML_ALTO_TAB2 = "Personajes"
XML_ALTO_TAB3 = "Buscar"
-- XML_ALTO_TAB4 = GUILD_BANK
XML_ALTO_TABOPTIONS = "Opciones"

XML_ALTO_SUMMARY_MENU1 = "Resumen de la Cuenta"
XML_ALTO_SUMMARY_MENU2 = "Bolsas"
-- XML_ALTO_SUMMARY_MENU3 = SKILLS
XML_ALTO_SUMMARY_MENU4 = "Actividad"
XML_ALTO_SUMMARY_MENU5 = "Miembros hermandad"
XML_ALTO_SUMMARY_MENU6 = "Habilidades hermandad"
XML_ALTO_SUMMARY_MENU7 = "Banco de hermandad"

XML_ALTO_SUMMARY_TEXT1 = "Petición de compartir cuenta"
XML_ALTO_SUMMARY_TEXT2 = "Click en este botón para pedir a un jugador\n"
                .. "que comparta su base de datos de Altoholic entera\n"
                .. "y añadirla a la tuya"
XML_ALTO_SUMMARY_TEXT3 = "Ambas partes han de activar la compartición de cuenta\nantes de usar esta característica (ver opciones)"
XML_ALTO_SUMMARY_TEXT4 = "Compartición de cuenta"

XML_ALTO_CHAR_DD1 = "Reino"
XML_ALTO_CHAR_DD2 = "Personaje"
XML_ALTO_CHAR_DD3 = "Ver"

XML_ALTO_SEARCH_COL1 = "Objeto / Ubicación"

XML_ALTO_GUILD_TEXT1 = "Oculta esta hermandad de la lista"

XML_ALTO_ACH_NOTSTARTED = "No iniciado"
XML_ALTO_ACH_STARTED = "Iniciado"

XML_ALTO_OPT_MENU1 = "General"
XML_ALTO_OPT_MENU2 = "Buscar"
XML_ALTO_OPT_MENU3 = "Correo"
XML_ALTO_OPT_MENU4 = "Minimapa"
XML_ALTO_OPT_MENU5 = "Tooltip"

XML_TEXT_1 = "Totales";
XML_TEXT_2 = "Buscar contenedores";
XML_TEXT_3 = "Niveles";
XML_TEXT_4 = "Rareza";
XML_TEXT_5 = "Tipo de equipo";
XML_TEXT_6 = "Reiniciar";
XML_TEXT_7 = "Buscar";

XML_ALTO_TEXT10 = "Nombre de cuenta"
XML_ALTO_TEXT11 = "Mandar petición de compartir cuenta a:"


--Options.xml
XML_ALTO_OPT_GENERAL1 = "Mostrar el maximo de XP reposado como 150%";
XML_ALTO_OPT_GENERAL2 = "Mostrar icono FuBar";
XML_ALTO_OPT_GENERAL3 = "Mostrar texto FuBar";
XML_ALTO_OPT_GENERAL4 = "Compartición de cuenta activado";
XML_ALTO_OPT_GENERAL5 = "Comunicación con hermandad activada";
XML_ALTO_OPT_GENERAL6 = "|cFFFFFFFFSi está |cFF00FF00activada|cFFFFFFFF, esta opción permitirá a otros usuarios\n"
                .. "de Altoholic enviarte peticiones para compartir cuenta.\n"
                .. "Se te pedirá confirmación cada vez que alguien solicite tu información.\n\n"
                .. "Si está |cFFFF0000desactivada|cFFFFFFFF, todas las peticiones serán automáticamente rechazadas.\n\n"
                .. "Consejo de seguridad: Actívalo sólo cuando necesites transferir datos,\ndesactívalo el resto del tiempo"
XML_ALTO_OPT_GENERAL7 = "|cFFFFFFFFSi está |cFF00FF00activada|cFFFFFFFF, esta opción permitirá a tus compañeros de hermandad\n"
                .. "ver tus alters y sus profesiones.\n\n"
                .. "Si está |cFFFF0000desactivada|cFFFFFFFF, no habrá comunicación con la hermandad."
XML_ALTO_OPT_GENERAL8 = "Autorizar automáticamente las actualizaciones el banco de la hermandad"
XML_ALTO_OPT_GENERAL9 = "|cFFFFFFFFSi está |cFF00FF00activada|cFFFFFFFF, esta opción permitirá a otros usuarios de Altoholic\n"
                .. "actualizar su información del banco de la hermandad con la tuya..\n\n"
                .. "Si está |cFFFF0000desactivada|cFFFFFFFF, se te pedirá confirmación\n"
                .. "antes de mandar ninguna información.\n\n"
                .. "Consejo de seguridad: desaciva esto si tienes permisos de oficial\n"
                .. "en pestañas del banco de la hermandad que no deben ser vistas por todos,\n"
                .. "y autoriza las peticiones manualmente"

XML_ALTO_OPT_SEARCH1 = "Comprobación automática |cFFFF0000(riesgo de desconexión)";
XML_ALTO_OPT_SEARCH2 = "|cFFFFFFFFSi un objeto no esta en la caché local de objetos\n"
                .. "y es encontrado mientras se realiza una búsqueda,\n"
                .. "Altoholic preguntará al servidor por 5 nuevos objetos.\n\n"
                .. "Esto mejorará gradualmente la consistencia de las busquedas,\n"
                .. "ya que habrá mas objetos en la cache de objetos.\n\n"
                .. "Aun así, hay un riesgo de desconexión al preguntar por un objeto\n"
                .. "si es un drop de una instancia de alto nivel.\n\n"
                .. "|cFF00FF00deshabilitar|r para evitar este riesgo";

XML_ALTO_OPT_SEARCH3 = "Ordenar saqueos en orden decreciente";
XML_ALTO_OPT_SEARCH4 = "Incluir objetos sin requerimientos de nivel";
XML_ALTO_OPT_SEARCH5 = "Incluir buzones de correo";
XML_ALTO_OPT_SEARCH6 = "Incluir bancos de hermandad";
XML_ALTO_OPT_SEARCH7 = "Incluir recetas conocidas";

XML_ALTO_OPT_MAIL1 = "Advertir cuando el correo expira en menos días que los indicados";
XML_ALTO_OPT_MAIL2 = "Advertencia de expiración del correo";
XML_ALTO_OPT_MAIL3 = "Analizar el contenido de los correos (marcarlos como leídos)";
XML_ALTO_OPT_MAIL4 = "Notificación de nuevo correo";
XML_ALTO_OPT_MAIL5 = "Serás avisado cuando un compañero de hermandad mande un correo a uno de tus alters.\n\n"
                .. "El contenido del correo se verá directamente sin tener que reconectar con ese personaje";

XML_ALTO_OPT_MINIMAP1 = "Mover para cambiar el ángulo del icono en el minimapa";
XML_ALTO_OPT_MINIMAP2 = "Angulo del icono del minimapa";
XML_ALTO_OPT_MINIMAP3 = "Mover para cambiar el angulo del icono en el minimapa";
XML_ALTO_OPT_MINIMAP4 = "Radio del icono del minimapa";
XML_ALTO_OPT_MINIMAP5 = "Mostrar icono del minimapa";

XML_ALTO_OPT_TOOLTIP1 = "Mostrar origen del objeto"; 
XML_ALTO_OPT_TOOLTIP2 = "Mostrar recuento de objetos por personaje";
XML_ALTO_OPT_TOOLTIP3 = "Mostrar recuento total de objetos";
XML_ALTO_OPT_TOOLTIP4 = "Mostrar recuento de objetos en el banco de la hermandad";
XML_ALTO_OPT_TOOLTIP5 = "Mostrar conocido/puede aprenderse por";
XML_ALTO_OPT_TOOLTIP6 = "Mostrar ID y nivel del objeto";
XML_ALTO_OPT_TOOLTIP7 = "Mostrar contadores en los nodos de recolección";
XML_ALTO_OPT_TOOLTIP8 = "Mostrar contadores de ambas facciones";
XML_ALTO_OPT_TOOLTIP9 = "Mostrar contadores de todas las cuentas";
XML_ALTO_OPT_TOOLTIP10 = "Include guild bank count in the total count";
end
