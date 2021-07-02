-- 
-- Russian localization made by Hellbot & Interim @ EU Realms 
-- Перевод выполнен Хэлла и Интерим @ Азурегос 
--

local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "ruRU" )

if not L then return end

-- Note: since 2.4.004 and the support of LibBabble, certain lines are commented, but remain there for clarity (especially those concerning the menu)
-- A lot of translations, especially those concerning the loot table, comes from atlas loot, credit goes to their team for gathering this info, I (Thaoky) simply took what I needed.

L["Death Knight"] = "Рыцарь смерти" -- Female: same

-- note: these string are the ones found in item tooltips, make sure to respect the case when translating, and to distinguish them (like crit vs spell crit)
L["Increases healing done by up to %d+"] = "Увлечение исцеляющих эффектов на %d+"
L["Increases damage and healing done by magical spells and effects by up to %d+"] = "Увеличение урона и целительного действия магических заклинаний и эффектов не более чем на %d+"
L["Increases attack power by %d+"] = "Увеличивает силу атаку на %d+"
L["Restores %d+ mana per"] = "Восполнение %d+ маны раз в"
	
L["Classes: Shaman"] = "Классы: Шаман"
L["Classes: Mage"] = "Классы: Маг"
L["Classes: Rogue"] = "Классы: Разбойник"
L["Classes: Hunter"] = "Классы: Охотник"
L["Classes: Warrior"] = "Классы: Воин"
L["Classes: Paladin"] = "Классы: Паладин"
L["Classes: Warlock"] = "Классы: Чернокнижник"
L["Classes: Priest"] = "Классы: Жрец"
L["Classes: Death Knight"] = "Классы: Рыцарь смерти"
L["Resistance"] = "Устойчивость"

--skills
L["Class Skills"] = "Class Skills"
L["Professions"] = "Профессии"
L["Secondary Skills"] = "Разное"
L["Fishing"] = "Рыбная ловля"
L["Riding"] = "Верховая езда"
L["Herbalism"] = "Травничество"
L["Mining"] = "Горное дело"
L["Skinning"] = "Cнятие шкур"
L["Lockpicking"] = "Взлом замка"
L["Poisons"] = "Яды"
L["Beast Training"] = "Дрессировка"
L["Inscription"] = "Inscription"

--factions not in LibFactions or LibZone
L["Alliance Forces"] = "Силы Альянса"
L["Horde Forces"] = "Силы Орды"
L["Steamwheedle Cartel"] = "Картель Хитрая Шестеренка"
L["Other"] = "Другое"

-- menu
L["Reputations"] = "Репутация"
L["Containers"] = "Сумки"
L["Guild Bank not visited yet (or not guilded)"] = "Вы еще не посетили банк гильдии (или не состоите в гильдии"
L["E-Mail"] = "Почта"
L["Quests"] = "Задания"
L["Equipment"] = "Экипировка"

--Altoholic.lua
L["Account"] = "Account"
L["Default"] = "Default"
L["Loots"] = "предметов"
L["Unknown"] = "неизвестно"
L["has come online"] = "входит в игру"
L["has gone offline"] = "выходит из игры"
L["Bank not visited yet"] = "Вы еще не посещали банк"
L["Levels"] = "уровн(я,ей)"
L["(has mail)"] = "(у вас письмо)"
L["(has auctions)"] = "(есть аукционы)"
L["(has bids)"] = "(есть ставки)"

L["No rest XP"] = "Нет бодрости"
L["Rested"] = "бодрости"
L["Transmute"] = "Трансмутация"

L["Bags"] = "В сумках"
L["Bank"] = "В банке"
L["AH"] = "AH"				-- for auction house, obviously
L["Equipped"] = "Надето"
L["Mail"] = "В почте"
L["Mails %s(%d)"] = "Письма %s(%d)"
L["Mails"] = "Письма"
L["Visited"] = "Visited"
L["Auctions %s(%d)"] = "Аукционы %s(%d)"
L["Bids %s(%d)"] = "Ставки %s(%d)"
L[", "] = ", "						-- required for znCH
L["(Guild bank: "] = "(Банк гильдии: "

L["Level"] = "Уровень"
L["Zone"] = "Зона"
L["Rest XP"] = "Заряд бодрости"

L["Source"] = "Источник"
L["Total owned"] = "Общее количество"
L["Already known by "] = "Изучено: "
L["Will be learnable by "] = "Будет изучено: "
L["Could be learned by "] = "Может быть изучено: "

L["At least one recipe could not be read"] = "Как минимум один рецепт не прочитан"
L["Please open this window again"] = "Пожалуйста откройте это окно снова"

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
L['search'] = "поиск"
L["Search in bags"] = "искать в сумках"
L['show'] = "показывать"
L["Shows the UI"] = "Показать интерфейс"
L['hide'] = "скрыть"
L["Hides the UI"] = "Скрыть интерфейс"
L['toggle'] = "переключить"
L["Toggles the UI"] = "Показать / скрыть интерфейс"
L["Altoholic:|r Usage = /altoholic search <item name>"] = "Altoholic:|r Usage = /altoholic search <item name>"

--AltoholicFu.lua
L["Left-click to"] = "Левый щелчок для"
L["open/close"] = "открыть / закрыть"

--AccountSummary.lua
L["View bags"] = "Показать сумки"
L["All-in-one"] = "объединить"
L["View mailbox"] = "Показать почту"
L["View quest log"] = "Показать журнал заданий"
L["View auctions"] = "Показать аукционы"
L["View bids"] = "Показать ставки"
L["Delete this Alt"] = "Удалить этого персонажа"
L["Cannot delete current character"] = "Нельзя удалить текущего персонажа"
L["Character %s successfully deleted"] = "Персонаж %s успешно удален"
L["Delete this Realm"] = "Delete this Realm"
L["Cannot delete current realm"] = "Cannot delete current realm"
L["Realm %s successfully deleted"] = "Realm %s successfully deleted"
L["Suggested leveling zone: "] = "Рекомендуемая зона: "
L["Arena points: "] = "Очки арены: "
L["Honor points: "] = "Очки чести: "
L["Right-Click for options"] = "Right-Click for options"
L["Average Item Level"] = "Average Item Level"

-- AuctionHouse.lua
L["%s has no auctions"] = "%s нет аукционов"
L["%s has no bids"] = "%s нет ставок"
L["last check "] = "последняя проверка"
L["Goblin AH"] = "Нейтральный аукцион"
L["Clear your faction's entries"] = "Стереть записи аукциона вашей фракции"
L["Clear goblin AH entries"] = "Стереть записи нейтрального аукциона"
L["Clear all entries"] = "Стереть все записи"

--BagUsage.lua
L["Totals"] = "Всего"
L["slots"] = "Ячеек"
L["free"] = "свободных"

--Containers.lua
L["32 Keys Max"] = "32 ключа максимум"
L["28 Slot"] = "28 ячеек"
L["Bank bag"] = "Сумки в банке"
L["Unknown link, please relog this character"] = "Неизвестная ссылка, пожалуйста перезайдите этим персонажем"

--Equipment.lua
L["Find Upgrade"] = "Найти лучший "
L["(based on iLvl)"] = "(основано на уровне предмета)"
L["Right-Click to find an upgrade"] = "Правый щелчок для поиска улучшений"
L["Tank"] = "Танк"
L["DPS"] = "Боец"
L["Balance"] = "Баланс"
L["Elemental Shaman"] = "Укротитель стихий"		-- shaman spec !
L["Heal"] = "Лекарь"

--GuildBank.lua
L["Last visit: %s by %s"] = "Last visit: %s by %s"
L["Local Time: %s   %sRealm Time: %s"] = "Local Time: %s   %sRealm Time: %s"

--Mails.lua
L[" has not visited his/her mailbox yet"] = " еще не читал(а) свою почту "
L["%s has no mail"] = "%s не получает писем" 
L[" has no mail, last check "] = " не получает писем, уже " 
L[" days ago"] = " дней"
L["Mail was last checked "] = "Последняя проверка почты "
L[" days"] = " дней назад"
L["Mail is about to expire on at least one character."] = "Mail is about to expire on at least one character."
L["Refer to the activity pane for more details."] = "Refer to the activity pane for more details."
L["Do you want to view it now ?"] = "Do you want to view it now ?"

--Quests.lua
L["No quest found for "] = "Не найдено задание для " -- ???
L["QuestID"] = "Индентификатор задания"
L["Are also on this quest:"] = "Этот квест также выполняют:"

--Recipes.lua
L["No data"] = "Нет данных"
L[" scan failed for "] = " сканирование не удалось для "

--Reputations.lua
L["Shift-Click to link this info"] = "Shift+Щелчок левой кнопкой мыши по ссылке для просмотра информации"
L[" is "] = " имеет репутацию "
L[" with "] = " с "

--Search.lua
L["Item Level"] = "Уровень предмета"
L[" results found (Showing "] = " предметов найдено (Отображено "
L["No match found!"] = "Нет совпадений"
L[" not found!"] = " не найден!"
L["Socket"] = "Гнездо"

--skills.lua
L["Rogue Proficiencies"] = "Специализация разбойника"
L["up to"] = "до"
L["at"] = "на"
L["and above"] = "и выше"
L["Suggestion"] = "Рекомендации"
L["Prof. 1"] = "Проф. 1"
L["Prof. 2"] = "Проф. 2"
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
L["Any"] = "Любое"
L["Miscellaneous"] = "Разное"
L["Fishing Poles"] = "Удочки"
L["This realm"] = "Этот мир"
L["All realms"] = "Все миры"
L["Loot tables"] = "Списки добычи"
L["This character"] = "This character"
L["This faction"] = "This faction"
L["Both factions"] = "Both factions"

--loots.lua
--Instinct drop
L["Hard Mode"] = "Hard Mode"
L["Trash Mobs"] = "С монстров в инстансах"
L["Random Boss"] = "Случайный босс"
L["Druid Set"] = "Комплект друида"
L["Hunter Set"] = "Комплект охотника"
L["Mage Set"] = "Комплект мага"
L["Paladin Set"] = "Комплект паладина"
L["Priest Set"] = "Комплект жреца"
L["Rogue Set"] = "Комплект разбойника"
L["Shaman Set"] = "Комплект шамана"
L["Warlock Set"] = "Комплект чернокнижника"
L["Warrior Set"] = "Комлект воина"
L["Legendary Mount"] = "Легендарное ездовое животное"
L["Legendaries"] = "Легендарное"
L["Muddy Churning Waters"] = "Muddy Churning Waters"
L["Shared"] = "Общее"
L["Enchants"] = "Зачарования"
L["Rajaxx's Captains"] = "Rajaxx's Captains"
L["Class Books"] = "Классовые книги"
L["Quest Items"] = "Предмет задания"
L["Druid of the Fang (Trash Mob)"] = "Друид клыка"
L["Spawn Of Hakkar"] = "Порождение Хаккара"
L["Troll Mini bosses"] = "Тролли мини-боссы"
L["Henry Stern"] = "Генри Штерн"
L["Magregan Deepshadow"] = "Магреган Чернотень"
L["Tablet of Ryuneh"] = "Tablet of Ryun'eh"
L["Krom Stoutarm Chest"] = "Сундук Крома Крепкорука"
L["Garrett Family Chest"] = "Сундук семейства Гарретт"
L["Eric The Swift"] = "Eric The Swift"
L["Olaf"] = "Олаф"
L["Baelog's Chest"] = "Сундук Бейлога"
L["Conspicuous Urn"] = "Подозрительная урна"
L["Tablet of Will"] = "Tablet of Will"
L["Shadowforge Cache"] = "Тайник Кузни Теней"
L["Roogug"] = "Ругуг"
L["Aggem Thorncurse"] = "Аггем Терновое Проклятие"
L["Razorfen Spearhide"] = "Копьешкур из племени Иглошкурых"
L["Pyron"] = "Подчинитель Пирон"
L["Theldren"] = "Телдрен"
L["The Vault"] = "Хранилище"
L["Summoner's Tomb"] = "Summoner's Tomb"
L["Plans"] = "Планы"
L["Zelemar the Wrathful"] = "Зелемар Гневный"
L["Rethilgore"] = "Ретилгор"
L["Fel Steed"] = "Конь скверны"
L["Tribute Run"] = "Трибьют ран"
L["Shen'dralar Provisioner"] = "Шен'дралар (в ДМ !)"
L["Books"] = "Книги"
L["Trinkets"] = "Аксессуары"
L["Sothos & Jarien"] = "Сотос и Джариен"
L["Fel Iron Chest"] = "Сундук из оскверненного железа"
L[" (Heroic)"] = " (Героическая сложность)"
L["Yor (Heroic Summon)"] = "Йор (Вызов на героическом уровне сложности)"
L["Avatar of the Martyred"] = "Аватара Мученика"
L["Anzu the Raven God (Heroic Summon)"] = "Анзу (Вызов на героическом уровне сложности)"
L["Thomas Yance"] = "Томас Янс"
L["Aged Dalaran Wizard"] = "Даларанский старый волшебник"
L["Cache of the Legion"] = "Склад легиона"
L["Opera (Shared Drops)"] = "Опера (общий список добычи)"
L["Timed Chest"] = "Сундук за поход на время"
L["Patterns"] = "Рецепты"

--Rep
L["Token Hand-Ins"] = "Предметы для повышения репутации"
L["Items"] = "Предметы"
L["Beasts Deck"] = "Колода Зверей"
L["Elementals Deck"] = "Колода Элементалей"
L["Warlords Deck"] = "Колода Полководцев"
L["Portals Deck"] = "Колода Порталов"
L["Furies Deck"] = "Колода Ярости"
L["Storms Deck"] = "Колода Бурь"
L["Blessings Deck"] = "Колода Благословений"
L["Lunacy Deck"] = " Колода Безумия"
L["Quest rewards"] = "Награда за выполнения задания"
L["Shattrath"] = "Шаттрат"

--World drop
L["Outdoor Bosses"] = "Боссы на континентах"
L["Highlord Kruul"] = "Highlord Kruul"
L["Bash'ir Landing"] = "Лагерь Баш'ир"
L["Skyguard Raid"] = "Отряд стражей небес"
L["Stasis Chambers"] = "Палаты стазиса"
L["Skettis"] = "Скеттис"
L["Darkscreecher Akkarai"] = "Темный Крикун Аккарай"
L["Karrog"] = "Каррог"
L["Gezzarak the Huntress"] = "Геззарак Охотница"
L["Vakkiz the Windrager"] = "Ваккиз Ветрояр"
L["Terokk"] = "Терокк"
L["Ethereum Prison"] = "Тюрьма братства Эфириум"
L["Armbreaker Huffaz"] = "Armbreaker Huffaz"
L["Fel Tinkerer Zortan"] = "Fel Tinkerer Zortan"
L["Forgosh"] = "Forgosh"
L["Gul'bor"] = "Gul'bor"
L["Malevus the Mad"] = "Malevus the Mad"
L["Porfus the Gem Gorger"] = "Porfus the Gem Gorger"
L["Wrathbringer Laz-tarash"] = "Wrathbringer Laz-tarash"
L["Abyssal Council"] = "Совет Бездны"
L["Crimson Templar (Fire)"] = "Багровый храмовник (Огненный)"
L["Azure Templar (Water)"] = "Лазурный храмовник (Водный)"
L["Hoary Templar (Wind)"] = "Седой храмовник (Воздушный)"
L["Earthen Templar (Earth)"] = "Земной храмовник (Земляной)"
L["The Duke of Cinders (Fire)"] = "Герцог Пепла (Огненный)"
L["The Duke of Fathoms (Water)"] = "Герцог Глубин (Водный)"
L["The Duke of Zephyrs (Wind)"] = "Герцог Ветров (Воздушный)"
L["The Duke of Shards (Earth)"] = "Герцог Осколков (Земляной)"
L["Elemental Invasion"] = "Вторжение стихий"
L["Gurubashi Arena"] = "Арена Гурубаши"
L["Booty Run"] = "Схватка за добычу на Арене Гурубаши"
L["Fishing Extravaganza"] = "Рыболовная феерия"
L["First Prize"] = "Первый приз"
L["Rare Fish"] = "Редкая рыба"
L["Rare Fish Rewards"] = "Награда за редкую рыбу"
L["Children's Week"] = "Детская неделя"
L["Love is in the air"] = "В воздухе витает любовь"
L["Gift of Adoration"] = "Дар дружбы"
L["Box of Chocolates"] = "Коробка  шоколадных конфет"
L["Hallow's End"] = "Тыквовин"
L["Various Locations"] = "В различных зонах"
L["Treat Bag"] = "Мешок с лакомствами"
L["Headless Horseman"] = "Всадник без головы "
L["Feast of Winter Veil"] = "Новый Год"
L["Smokywood Pastures Vendor"] = "Торговец Пастбищ Дымного Леса"
L["Gaily Wrapped Present"] = "Подарок в яркой упаковке"
L["Festive Gift"] = "Праздничный дар"
L["Winter Veil Gift"] = "Подарок на Зимний покров"
L["Gently Shaken Gift"] = "Слегка растрясенный дар"
L["Ticking Present"] = "Тикающий подарочек"
L["Carefully Wrapped Present"] = "Тщательно упакованный подарок"
L["Noblegarden"] = "Пасха"
L["Brightly Colored Egg"] = "Ярко раскрашеное яйцо"
L["Smokywood Pastures Extra-Special Gift"] = "Smokywood Pastures Extra-Special Gift"
L["Harvest Festival"] = "Фестиваль урожая" 
L["Food"] = "Еда"
L["Scourge Invasion"] = "Вторжение Плети"
L["Miscellaneous"] = "Разное"
L["Cloth Set"] = "Тряпичный комлект"
L["Leather Set"] = "Кожаный комплект"
L["Mail Set"] = "Кольчужный комлпект"
L["Plate Set"] = "Латы"
L["Balzaphon"] = "Балзафон"
L["Lord Blackwood"] = "Lord Blackwood"
L["Revanchion"] = "Revanchion"
L["Scorn"] = "Scorn"
L["Sever"] = "Sever"
L["Lady Falther'ess"] = "Леди Фалтер'есс"
L["Lunar Festival"] = "Лунный Фестиваль"
L["Fireworks Pack"] = "Пачка фейерверков"
L["Lucky Red Envelope"] = "Красный конверт Счастья"
L["Midsummer Fire Festival"] = "Midsummer Fire Festival"
L["Lord Ahune"] = "Повелитель Ахун"
L["Shartuul"] = "Шартуул"
L["Blade Edge Mountains"] = "Острогорье"
L["Brewfest"] = "Фестиваль пива"
L["Barleybrew Brewery"] = "Barleybrew Brewery"
L["Thunderbrew Brewery"] = "Thunderbrew Brewery"
L["Gordok Brewery"] = "Gordok Brewery"
L["Drohn's Distillery"] = "Винокурня Дрона"
L["T'chali's Voodoo Brewery"] = "Пивоваренный завод Тчали Вуду"

--craft
L["Crafted Weapons"] = "Оружие (Кузнечное дело)"
L["Master Swordsmith"] = "Мастер ковки клинков"
L["Master Axesmith"] = "Мастер школы топора"
L["Master Hammersmith"] = "Мастер школы Молота"
L["Blacksmithing (Lv 60)"] = "Кузнечное дело (уровень 60)"
L["Blacksmithing (Lv 70)"] = "Кузнечное дело (уровень 70)"
L["Engineering (Lv 60)"] = "Инженерное дело (уровень 60)"
L["Engineering (Lv 70)"] = "Инженерное дело (уровень 70)"
L["Blacksmithing Plate Sets"] = "Латы (Кузнечное дело)"
L["Imperial Plate"] = "Имперские латы"
L["The Darksoul"] = "Темная душа"
L["Fel Iron Plate"] = "Латы из оскверненного железа"
L["Adamantite Battlegear"] = "Адамантитовая броня"
L["Flame Guard"] = "Пламенный Страж"
L["Enchanted Adamantite Armor"] = "Зачарованная адамантитовая броня"
L["Khorium Ward"] = "Кориевая Опека"
L["Faith in Felsteel"] = "Верность оскверненной стали"
L["Burning Rage"] = "Пламенная ярость"
L["Blacksmithing Mail Sets"] = "Кольчуга (Кузнечное дело)"
L["Bloodsoul Embrace"] = "Объятия Кровавого Духа"
L["Fel Iron Chain"] = "Кольчуга из оскверненного железа"
L["Tailoring Sets"] = "Тряпичная броня (Портняжное дело)"
L["Bloodvine Garb"] = "Одеяния Кровавой Лозы"
L["Netherweave Vestments"] = "Одеяния из ткани Пустоты"
L["Imbued Netherweave"] = "Прочная ткань Пустоты"
L["Arcanoweave Vestments"] = "Одеяния из тайной ткани"
L["The Unyielding"] = "Непреклонность"
L["Whitemend Wisdom"] = "Мудрость Белого целителя"
L["Spellstrike Infusion"] = "Разящее колдовство"
L["Battlecast Garb"] = "Одеяния Боевого заклятья"
L["Soulcloth Embrace"] = "Объятия ткани Душ"
L["Primal Mooncloth"] = "Изначальная луноткань"
L["Shadow's Embrace"] = "Объятия Тени"
L["Wrath of Spellfire"] = "Гнев Чародейского огня"
L["Leatherworking Leather Sets"] = "Кожаные доспехи (Кожевенное дело)"
L["Volcanic Armor"] = "Вулканические доспехи"
L["Ironfeather Armor"] = "Железноперые доспехи"
L["Stormshroud Armor"] = "Доспехи Грозового покрова"
L["Devilsaur Armor"] = "Доспехи из кожи девизавра"
L["Blood Tiger Harness"] = "Доспехи Кровавого тигра"
L["Primal Batskin"] = "Простая шкура нетопыря"
L["Wild Draenish Armor"] = "Доспехи дренейского дикаря"
L["Thick Draenic Armor"] = "Утолщенные дренейские доспехи"
L["Fel Skin"] = "Кожа Скверны"
L["Strength of the Clefthoof"] = "Сила копытня"
L["Primal Intent"] = "Изначальная цель"
L["Windhawk Armor"] = "Доспехи Ветроястреба"
L["Leatherworking Mail Sets"] = "Кольчуга (Кожевенное дело)"
L["Green Dragon Mail"] = "Кольчуга Зеленого дракона"
L["Blue Dragon Mail"] = "Кольчуга Синего дракона"
L["Black Dragon Mail"] = "Кольчуга Черного дракона"
L["Scaled Draenic Armor"] = "Чешуйчатые дренейские доспехи"
L["Felscale Armor"] = "Доспехи Чешуи Скверны"
L["Felstalker Armor"] = "Доспехи Темного следопыта"
L["Fury of the Nether"] = "Ярость Пустоты"
L["Netherscale Armor"] = "Доспехи из чешуи дракона Пустоты"
L["Netherstrike Armor"] = "Доспехи удара Пустоты"
L["Armorsmith"] = "Бронник"
L["Weaponsmith"] = "Оружейник"
L["Dragonscale"] = "Школа чешуи драконов"
L["Elemental"] = "Сила стихий"
L["Tribal"] = "Традиции предков"
L["Mooncloth"] = "Шитье из луноткани"
L["Shadoweave"] = "Шитье из тенеткани"
L["Spellfire"] = "Шитье из чароткани"
L["Gnomish"] = "Гномский механик"
L["Goblin"] = "Гоблинский механик"
L["Apprentice"] = "Ученик"
L["Journeyman"] = "Подмастерье"
L["Expert"] = "Умелец"
L["Artisan"] = "Искусник"
L["Master"] = "Мастер"

--Set & PVP
L["Superior Rewards"] = "Наилучшие награды"
L["Epic Rewards"] = "Эпические награды"
-- L["Lv 10-19 Rewards"] = "Награды 10-19 уровня"
-- L["Lv 20-29 Rewards"] = "Награды 20-29 уровня"
-- L["Lv 30-39 Rewards"] = "Награды 30-39 уровня"
-- L["Lv 40-49 Rewards"] = "Награды 40-49 уровня"
-- L["Lv 50-59 Rewards"] = "Награды 50-59 уровня"
-- L["Lv 60 Rewards"] = "Награды на 60-й уровень"
L["Lv %s Rewards"] = "Награды %s уровня"
L["PVP Cloth Set"] = "Тряпичный ПвП комплект"
L["PVP Leather Sets"] = "Кожаный ПвП комплект"
L["PVP Mail Sets"] = "Кольчужный ПвП комлект"
L["PVP Plate Sets"] = "Латный ПвП комлект"
L["World PVP"] = "Мировое ПвП"
L["Hellfire Fortifications"] = "Штурмовые укрепления"
L["Twin Spire Ruins"] = "Руины Двух Шпилей"
L["Spirit Towers (Terrokar)"] = "Spirit Towers (Лес Террокар)"
L["Halaa (Nagrand)"] = "Халаа (Награнд)"
L["Arena Season %d"] = "Арена (сезон %d)"
L["Weapons"] = "Оружие"
L["Accessories"] = "Аксессуары"
L["Level 70 Reputation PVP"] = "За репутацию (70 уровень)"
L["Level %d Honor PVP"] = "За очки доблести (%d уровень)"
L["Savage Gladiator\'s Weapons"] = "Оружие свирепого гладиатора"
L["Deadly Gladiator\'s Weapons"] = "Оружие Deadly Gladiator"
L["Lake Wintergrasp"] = "Озеро Ледяных Оков"
L["Non Set Accessories"] = "Аксессуары (не из комплекта)"
L["Non Set Cloth"] = "Тряпичная броня (не из комплекта)"
L["Non Set Leather"] = "Кожаные доспехи (не из комлекта)"
L["Non Set Mail"] = "Кольчужные доспехи (не из комлекта)"
L["Non Set Plate"] = "Латы (не из комлекта)"
L["Tier 0.5 Quests"]= "Комплект ранга 0.5"
L["Tier %d Tokens"] = "Талисманы комплекта ранга %d"
L["Blizzard Collectables"] = "Blizzard Collectables"
L["WoW Collector Edition"] = "Коллекционое издание WoW"
L["BC Collector Edition (Europe)"] = "Коллекционое издание WOW:TBC"
L["Blizzcon 2005"] = "Blizzcon 2005"
L["Blizzcon 2007"] = "Blizzcon 2007"
L["Christmas Gift 2006"] = "Рождественский подарок 2006"
L["Upper Deck"] = "Upper Deck"
L["Loot Card Items"] = "Loot Card Items"
L["Heroic Mode Tokens"] = "За Знаки справедливости"
L["Fire Resistance Gear"] = "Экипировка с устойчивостью к огню"
L["Emblems of Valor"] = "Emblems of Valor"
L["Emblems of Heroism"] = "Emblems of Heroism"

L["Cloaks"] = "Плащи"
L["Relics"] = "Реликвии"
L["World Drops"] = "С кого угодно"
L["Level 30-39"] = "Уровень 30-39"
L["Level 40-49"] = "Уровень 40-49"
L["Level 50-60"] = "Уровень 50-60"
L["Level 70"] = "Уровень 70"

-- Altoholic.Gathering : Mining
L["Copper Vein"] = "Медная Жила"
L["Tin Vein"] = "Оловянная Жила"
L["Iron Deposit"] = "Залежь Железа"
L["Silver Vein"] = "Серебрянная Жила"
L["Gold Vein"] = "Золотая Жила"
L["Mithril Deposit"] = "Митриловые залежи"
L["Ooze Covered Mithril Deposit"] = "Покрытые слизью мифриловые залежи"
L["Truesilver Deposit"] = "Залежи истинного серебра"
L["Ooze Covered Silver Vein"] = "Покрытая слизью серебряння жила"
L["Ooze Covered Gold Vein"] = "Покрытая слизью золотая жила"
L["Ooze Covered Truesilver Deposit"] = "Покрытые слизью залежи истинного серебра"
L["Ooze Covered Rich Thorium Vein"] = "Покрытая слизью богатая ториевая жила"
L["Ooze Covered Thorium Vein"] = "Покрытая слизью ториевая жила"
L["Small Thorium Vein"] = "Малая ториевая жила"
L["Rich Thorium Vein"] = "Богатая ториевая жила"
L["Hakkari Thorium Vein"] = "Hakkari Thorium Vein"
L["Dark Iron Deposit"] = "Залежи Темной Стали"
L["Lesser Bloodstone Deposit"] = "Малое месторождение кровавого камня"
L["Incendicite Mineral Vein"] = "Ароматитовая жила"
L["Indurium Mineral Vein"] = "Индарилиевая жила"
L["Fel Iron Deposit"] = "Месторождение оскверненного железа"
L["Adamantite Deposit"] = "Залежи адамантита"
L["Rich Adamantite Deposit"] = "Богатые залежи адамантита"
L["Khorium Vein"] = "Кориевая жила"
L["Large Obsidian Chunk"] = "Large Obsidian Chunk"
L["Small Obsidian Chunk"] = "Small Obsidian Chunk"
L["Nethercite Deposit"] = "Месторождение хаотита"

-- Altoholic.Gathering : Herbalism
L["Peacebloom"] = "Мироцвет"
L["Silverleaf"] = "Сребролист"
L["Earthroot"] = "Землекорень"
L["Mageroyal"] = "Магороза"
L["Briarthorn"] = "Остротерн"
L["Swiftthistle"] = "Быстрорепей"
L["Stranglekelp"] = "Удавник"
L["Bruiseweed"] = "Синячник"
L["Wild Steelbloom"] = "Дикий сталецвет"
L["Grave Moss"] = "Могильный мох"
L["Kingsblood"] = "Королевская кровь"
L["Liferoot"] = "Жизнекорень"
L["Fadeleaf"] = "Бледнолист"
L["Goldthorn"] = "Златошип"
L["Khadgar's Whisker"] = "Кадгаров ус"
L["Wintersbite"] = "Зимник"
L["Firebloom"] = "Огнецвет"
L["Purple Lotus"] = "Пурпурный лотос"
L["Wildvine"] = "Дикий виноград"
L["Arthas' Tears"] = "Слезы Артаса"
L["Sungrass"] = "Солнечник"
L["Blindweed"] = "Слепырник"
L["Ghost Mushroom"] = "Призрачная поганка"
L["Gromsblood"] = "Кровь Грома"
L["Golden Sansam"] = "Золотой сансам"
L["Dreamfoil"] = "Снолист"
L["Mountain Silversage"] = "Горный серебряный шалфей"
L["Plaguebloom"] = "Чумоцвет"
L["Icecap"] = "Льдяник"
L["Bloodvine"] = "Кровавая лоза"
L["Black Lotus"] = "Черный лотос"
L["Felweed"] = "Скверноплевел"
L["Dreaming Glory"] = "Соннославник"
L["Terocone"] = "Терошишка"
L["Ancient Lichen"] = "Древний лишайник"
L["Bloodthistle"] = "Кровопийка"
L["Mana Thistle"] = "Манрепейник"
L["Netherbloom"] = "Пустоцвет"
L["Nightmare Vine"] = "Лозный кошмарник"
L["Ragveil"] = "Кисейница"
L["Flame Cap"] = "Огнеголовик"
L["Fel Lotus"] = "Оскверненный лотос"
L["Netherdust Bush"] = "Пыльник хаотический"

L["Glowcap"] = "Glowcap"
L["Sanguine Hibiscus"] = "Кровавый гибискус"


if GetLocale() == "ruRU" then
-- Altoholic.xml local
LEFT_HINT = "Щелкните левой кнопкой мыши чтобы |cFF00FF00открыть";
RIGHT_HINT = "Щелкните правой кнопкой мыши чтобы  |cFF00FF00перетащить";

XML_ALTO_SHARING_HINT1 = "Enter an account name that will be\nused for |cFF00FF00display|r purposes only.\n"
				.. "This name can be anything you like,\nit does |cFF00FF00NOT|r have to be the real account name.\n\n"
XML_ALTO_SHARING_HINT2 = "This field |cFF00FF00cannot|r be left empty."

XML_ALTO_TAB1 = "Сводная информация"
XML_ALTO_TAB2 = "Персонажи"
XML_ALTO_TAB3 = "Поиск"
-- XML_ALTO_TAB4 = GUILD_BANK
XML_ALTO_TABOPTIONS = "Настройки"

XML_ALTO_SUMMARY_MENU1 = "Отчет"
XML_ALTO_SUMMARY_MENU2 = "Сумки"
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

XML_ALTO_CHAR_DD1 = "Игровой мир"
XML_ALTO_CHAR_DD2 = "Персонаж"
XML_ALTO_CHAR_DD3 = "Просмотр"

XML_ALTO_SEARCH_COL1 = "Предметы / Нахождение"

XML_ALTO_GUILD_TEXT1 = "Hide this guild in the tooltip"

XML_ALTO_ACH_NOTSTARTED = "Not started"
XML_ALTO_ACH_STARTED = "Started"

XML_ALTO_OPT_MENU1 = "Общее"
XML_ALTO_OPT_MENU2 = "Поиск"
XML_ALTO_OPT_MENU3 = "Почта"
XML_ALTO_OPT_MENU4 = "Мини-карта"
XML_ALTO_OPT_MENU5 = "Подсказка"

XML_TEXT_1 = "Всего";
XML_TEXT_2 = "Поиск по сумкам";
XML_TEXT_3 = "Параметры уровня";
XML_TEXT_4 = "Качество";
XML_TEXT_5 = "Ячейка снаряжения";
XML_TEXT_6 = "Сброс";
XML_TEXT_7 = "Поиск";

XML_ALTO_TEXT10 = "Account Name"
XML_ALTO_TEXT11 = "Send account sharing request to:"

--Options.xml
XML_ALTO_OPT_GENERAL1 = "Максимальную бодрость показывать как 150%";
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

XML_ALTO_OPT_SEARCH1 = "Запрашивать информацию о предмете у сервера |cFFFF0000(риск отключения от сервера)";
XML_ALTO_OPT_SEARCH2 = "|cFFFFFFFFЕсли предмет не найден в локальном кэше клиента, но обнаружен во время поиска,\n"
			  .. "Altoholic попытается запросить информацию о предмете у сервера (не более 5 за раз).\n\n"
			  .. "Это значительно улучшает эффективность работы, поскольку больше количество предметов\n"
			  .. "будет включено в кэш клиента. Однако существует риск отключения от сервера, если запрощеный\n"
			  .. "предмет является добычей из инстанса слишком высогого уровня, недоступного этому серверу.\n\n"
			  .. "|cFF00FF00Не включайте|r если не хотите рисковать.";
XML_ALTO_OPT_SEARCH3 = "Сортировать предметы в порядке убывания";
XML_ALTO_OPT_SEARCH4 = "Включая предметы без требований к уровню";
XML_ALTO_OPT_SEARCH5 = "Включая содержимое почтовых ящиков";
XML_ALTO_OPT_SEARCH6 = "Включая содержимое банков гильдии";
XML_ALTO_OPT_SEARCH7 = "Включая изученные рецепты";

XML_ALTO_OPT_MAIL1 = "Предупреждать об истечении срока хранения почты за указаное время";
XML_ALTO_OPT_MAIL2 = "Сообщать об истечении срока хранения почты";
XML_ALTO_OPT_MAIL3 = "Просматривать почту (отмечает как прочитаную)";
XML_ALTO_OPT_MAIL4 = "New mail notification";
XML_ALTO_OPT_MAIL5 = "Be informed when a guildmate sends a mail to one of my alts.\n\n"
				.. "Mail content is directly visible without having to reconnect the character";


XML_ALTO_OPT_MINIMAP1 = "Изменяет местположение иконки относительно мини-карты";
XML_ALTO_OPT_MINIMAP2 = "Расположение иконки на мини-карте";
XML_ALTO_OPT_MINIMAP3 = "Изменяет отступ иконки от мини-карты";
XML_ALTO_OPT_MINIMAP4 = "Отступ иконки от мини-карты";
XML_ALTO_OPT_MINIMAP5 = "Показывать иконку на мини-карте";

XML_ALTO_OPT_TOOLTIP1 = "Указывать источник происхождения предмета";
XML_ALTO_OPT_TOOLTIP2 = "Показывать количество предметов у каждого персонажа";
XML_ALTO_OPT_TOOLTIP3 = "Показывать общее количество предметов";
XML_ALTO_OPT_TOOLTIP4 = "Включая количество предметов в банке гильдии";
XML_ALTO_OPT_TOOLTIP5 = "Включая изученные / доступные для изучения рецепты";
XML_ALTO_OPT_TOOLTIP6 = "Show item ID and item Level";
XML_ALTO_OPT_TOOLTIP7 = "Show counters on gathering nodes";
XML_ALTO_OPT_TOOLTIP8 = "Show counters for both factions";
XML_ALTO_OPT_TOOLTIP9 = "Show counters for all accounts";
XML_ALTO_OPT_TOOLTIP10 = "Include guild bank count in the total count";
end
