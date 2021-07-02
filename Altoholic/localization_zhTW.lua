--zhTW locale file by 天明@眾星之子
local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "zhTW" )
if not L then return end

-- Note: since 2.4.004 and the support of LibBabble, certain lines are commented, but remain there for clarity (especially those concerning the menu)
-- A lot of translations, especially those concerning the loot table, comes from atlas loot, credit goes to their team for gathering this info, I (Thaoky) simply took what I needed.

L["Death Knight"] = "死亡騎士"

-- note: these string are the ones found in item tooltips, make sure to respect the case when translating, and to distinguish them (like crit vs spell crit)
L["Increases healing done by up to %d+"] = "使所有法術和魔法效果所做成的治療效果提高%d+點"
L["Increases damage and healing done by magical spells and effects by up to %d+"] = "使所有法術和魔法效果所做成的傷害效果提高%d+點"
L["Increases attack power by %d+"] = "提高攻擊強度%d+點"
L["Restores %d+ mana per"] = "每5秒恢復%d+點法力"
L["Classes: Shaman"] = "職業: 薩滿"
L["Classes: Mage"] = "職業: 法師"
L["Classes: Rogue"] = "職業: 盜賊"
L["Classes: Hunter"] = "職業: 獵人"
L["Classes: Warrior"] = "職業: 戰士"
L["Classes: Paladin"] = "職業: 聖騎士"
L["Classes: Warlock"] = "職業: 術士"
L["Classes: Priest"] = "職業: 牧師"
L["Classes: Death Knight"] = "職業: 死亡騎士"
L["Resistance"] = "抗性"

--skills
L["Class Skills"] = "Class Skills"
L["Professions"] = "專業技能"
L["Secondary Skills"] = "次要技能"
L["Fishing"] = "釣魚"
L["Riding"] = "騎術"
L["Herbalism"] = "草藥學"
L["Mining"] = "採礦"
L["Skinning"] = "剝皮"
L["Lockpicking"] = "開鎖"
L["Poisons"] = "毒藥"
L["Beast Training"] = "野獸訓練"
L["Inscription"] = "銘文學"

--factions not in LibFactions or LibZone
L["Alliance Forces"] = "聯盟部隊"
L["Horde Forces"] = "部落部隊"
L["Steamwheedle Cartel"] = "熱砂企業"
L["Other"] = "其他"

-- menu
L["Reputations"] = "聲望"
L["Containers"] = "容器"
L["Guild Bank not visited yet (or not guilded)"] = "公會金庫沒開啟過 (或沒有公會)"
L["E-Mail"] = "郵件"
L["Quests"] = "任務"
L["Equipment"] = "裝備"

--Altoholic.lua
L["Account"] = "帳戶"
L["Default"] = "預設"
L["Loots"] = "戰利品"
L["Unknown"] = "未知"
L["has come online"] = "上線了。"
L["has gone offline"] = "下線了。"
L["Bank not visited yet"] = "銀行沒有訪問過"
L["Levels"] = "等級"
L["(has mail)"] = "(有郵件)"
L["(has auctions)"] = "(有拍賣)"
L["(has bids)"] = "(有競標)"

L["No rest XP"] = "沒有充份休息經驗值"
L["Rested"] = "充份休息"
L["Transmute"] = "轉化"

L["Bags"] = "背包"
L["Bank"] = "銀行"
L["AH"] = "拍賣場"				-- for auction house, obviously
L["Equipped"] = "已裝備"
L["Mail"] = "郵件"
L["Mails %s(%d)"] = "郵件 %s(%d)"
L["Mails"] = "郵件"
L["Visited"] = "已到訪"
L["Auctions %s(%d)"] = "拍賣s %s(%d)"
L["Bids %s(%d)"] = "競標 %s(%d)"
L[", "] = "，"
L["(Guild bank: "] = "(公會金庫: "

L["Level"] = "等級"
L["Zone"] = "地區"
L["Rest XP"] = "充份休息經驗值"

L["Source"] = "來源"
L["Total owned"] = "總共擁有"
L["Already known by "] = "已經學會"
L["Will be learnable by "] = "這將以被誰學會:"
L["Could be learned by "] = "這可以被誰學會:"

L["At least one recipe could not be read"] = "最少有一個配方未被讀取"
L["Please open this window again"] = "請重啟這視窗"

--Comm.lua
L["Sending account sharing request to %s"] = "向%s發送帳戶共享資料的要求"
L["Account sharing request received from %s"] = "收到%s的帳戶共享資料要求"
L["You have received an account sharing request\nfrom %s%s|r, accept it?"] = "你收到帳戶共享資料的要求\n要求者 %s%s|r, 接受嗎?"
L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"] = "%s警告:|r 如接受, %s所有|r 已知的資料\n會被 Altoholic 傳送給 %s%s|r (背包, 金錢, 等等..)"
L["Request rejected by %s"] = "要求被%s駁回"
L["%s is in combat, request cancelled"] = "%s在戰鬥中, 要求被駁回"
L["%s has disabled account sharing"] = "%s的帳戶共享資料功能關閉"
L["Table of content received (%d items)"] = "收到列表的內容(%d 物品)"
L["Sending reputations (%d of %d)"] = "發送聲望資料 (%d 之 %d)"
L["Sending currencies (%d of %d)"] = "發送金錢資料 (%d 之 %d)"
L["Sending guilds (%d of %d)"] = "發送公會資料 (%d 之 %d)"
L["Sending character %s (%d of %d)"] = "發送角色資料 %s (%d 之 %d)"
L["No reputations found"] = "沒找到聲望資料"
L["No currencies found"] = "沒找到金錢資料"
L["No guild found"] = "沒找到公會資料"
L["Transfer complete"] = "傳輸完成"
L["Reputations received !"] = "收到聲望資料!"
L["Currencies received !"] = "收到金錢資料!"
L["Guilds received !"] = "收到公會資料!"
L["Character %s received !"] = "角色%s已接收!"
L["Requesting item %d of %d"] = "物品要求 %d 之 %d"
L["Sending table of content (%d items)"] = "發送列表內容 (%d 物品)"
L["Guild bank tab %s successfully updated !"] = "%s公會金庫分頁已更新成功!"
L["%s has disabled guild communication"] = "%s關閉公會聯系"
L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"] = "%s%s|r 要求公會金庫分頁 %s%s|r\n要傳送這項資料嗎 ?"
L["%sWarning:|r make sure this user may view this information before accepting"] = "%s警告:|r 請確定此用戶可以查看分頁的資料才接受"
L["%s|r has received a mail from %s"] = "%s|r 已收到的郵件, 寄件者: %s"
L["Sending reference data: %s (%d of %d)"] = "發送相關資料: %s (%d of %d)"
L["Reference data not available"] = "無法提供相關資料"
L["Reference data received (%s) !"] = "收到相關的數據 (%s) !"
L["Waiting for %s to accept .."] = "正等待 %s 接收 .."

--GuildBankTabs.lua
L["Requesting %s information from %s"] = "要求%s資料,目標%s"
L["Guild Bank Remote Update"] = "公會金庫遙距更新"
L["Clicking this button will update\nyour local %s%s|r bank tab\nbased on %s%s's|r data"] = "點擊此按鈕將更新\n你本服的%s%s|r 公會金庫分頁\n基於 %s%s's|r 的資料"

--GuildMembers.lua
L["Left-click to see this character's equipment"] = "左鍵單擊來觀看這角色的裝備"
L["Click a character's AiL to see its equipment"] = "點擊角色的 AiL 來查看他的裝備"

--GuildProfessions.lua
L["Offline Members"] = "離線會員"
L["Left click to view"] = "Left click to view"
L["Shift+Left click to link"] = "Shift+Left click to link"

--Core.lua
L['search'] = '搜索'
L["Search in bags"] = '在背包中搜索'
L['show'] = '顯示'
L["Shows the UI"] = '顯示圖形介面'
L['hide'] = '隱藏'
L["Hides the UI"] = '隱藏圖形介面'
L['toggle'] = '切換'
L["Toggles the UI"] = '切換圖形介面的顯示/隱藏'
L["Altoholic:|r Usage = /altoholic search <item name>"] = "Altoholic:|r Usage = /altoholic search <item name>"

--AltoholicFu.lua
L["Left-click to"] = "左擊"
L["open/close"] = "開啟/關閉"

--AccountSummary.lua
L["View bags"] = "查看背包"
L["All-in-one"] = "單一撿視"
L["View mailbox"] = "查看郵件"
L["View quest log"] = "查看任務日誌"
L["View auctions"] = "查看拍賣"
L["View bids"] = "查看競標"
L["Delete this Alt"] = "刪除這角色"
L["Cannot delete current character"] = "不能刪除現有角色"
L["Character %s successfully deleted"] = "角色 %s 刪除成功"
L["Delete this Realm"] = "刪除此伺服器"
L["Cannot delete current realm"] = "不能刪除當前的伺服器"
L["Realm %s successfully deleted"] = "伺服器 %s 成功刪除"
L["Suggested leveling zone: "] = "建議升級的地區"
L["Arena points: "] = "兢技場分數"
L["Honor points: "] = "榮譽分數"
L["Right-Click for options"] = "右鍵點擊選單"
L["Average Item Level"] = "平均物品等級"

-- AuctionHouse.lua
L["%s has no auctions"] = "%s 沒有拍賣"
L["%s has no bids"] = "%s 沒有競標"
L["last check "] = "前次的撿查 "
L["Goblin AH"] = "中立拍賣場"
L["Clear your faction's entries"] = "清除現有陣營的項目"
L["Clear goblin AH entries"] = "清除中立拍賣場的項目"
L["Clear all entries"] = "清除所有的項目"

--BagUsage.lua
L["Totals"] = "總數"
L["slots"] = "空格"
L["free"] = "可用"

--Containers.lua
L["32 Keys Max"] = "32鎖匙最大數"
L["28 Slot"] = "28格"
L["Bank bag"] = "銀行包"
L["Unknown link, please relog this character"] = "不知名的連結, 請重登這角色"

--Equipment.lua
L["Find Upgrade"] = "找尋裝備升級"
L["(based on iLvl)"] = " (跟據物品等級iLvl)"
L["Right-Click to find an upgrade"] = "右擊來找尋裝備升級"
L["Tank"] = "坦"
L["DPS"] = "DPS"
L["Balance"] = "平衡"
L["Elemental Shaman"] = "元素"		-- shaman spec !
L["Heal"] = "治療"

--GuildBank.lua
L["Last visit: %s by %s"] = "最後一次訪問: %s 到訪者: %s"
L["Local Time: %s   %sRealm Time: %s"] = "本地時間: %s   %s伺服器時間: %s"

--Mails.lua
L[" has not visited his/her mailbox yet"] = "沒有訪問過他/她的郵箱"
L["%s has no mail"] = "%s 沒有郵件"
L[" has no mail, last check "] = "沒有郵件, 最後檢查 "
L[" days ago"] = " 日前."
L["Mail was last checked "] = "郵件最後一次檢查是 "
L[" days"] = " 日."
L["Mail is about to expire on at least one character."] = "至少有一個角色的郵件即將到期."
L["Refer to the activity pane for more details."] = "詳細請參照活躍度."
L["Do you want to view it now ?"] = "你想立即查看嗎 ?"

--Quests.lua
L["No quest found for "] = "沒有找到任務: "
L["QuestID"] = "任務ID"
L["Are also on this quest:"] = "也有這個任務:"

--Recipes.lua
L["No data"] = "無資料"
L[" scan failed for "] = "掃描失敗: "

--Reputations.lua
L["Shift-Click to link this info"] = "Shift-左擊來連結這資訊"
L[" is "] = " 是 "
L[" with "] = " 和 "

--Search.lua
L["Item Level"] = "物品等級"
L[" results found (Showing "] = " 結果被找出 (顯示)"
L["No match found!"] = "未找到相應!"
L[" not found!"] = "*沒找到"
L["Socket"] = "插糟"

--skills.lua
L["Rogue Proficiencies"] = "盜賊熟練度"
L["up to"] = "最高至"
L["at"] = "在"
L["and above"] = "及以上"
L["Suggestion"] = "建議"
L["Prof. 1"] = "專業1"
L["Prof. 2"] = "專業2"
L["Grey"] = "灰色"
L["All cooldowns are up"] = "所有冷卻已完成"

-- TabSummary.lua
L["All accounts"] = "所有帳戶"

-- TabCharacters.lua
L["Cannot link another realm's tradeskill"] = "不能使用其它伺服器的技能連結"
L["Cannot link another account's tradeskill"] = "不能使用其它帳戶的技能連結"
L["Invalid tradeskill link"] = "無效的技能連結"
L["Expiry:"] = "Expiry:"

-- TabGuildBank.lua
L["N/A"] = "N/A"
L["Delete Guild Bank?"] = "刪除公會金庫嗎?"
L["Guild %s successfully deleted"] = "公會金庫 %s 刪除成功"

-- TabSearch.lua
L["Any"] = "任何"
L["Miscellaneous"] = "其他"
L["Fishing Poles"] = "魚竿"
L["This realm"] = "只搜索這伺服器"		-- please update these 3 string to display "this realm" instead of "search this realm" ...
L["All realms"] = "搜索所有伺服器"
L["Loot tables"] = "搜索物品掉落表"
L["This character"] = "這角色"
L["This faction"] = "這陣營聲望"
L["Both factions"] = "這兩個陣營聲望"

--loots.lua
--Instinct drop
L["Hard Mode"] = "Hard Mode"
L["Trash Mobs"] = "一般怪物"
L["Random Boss"] = "隨機首領"
L["Druid Set"] = "德魯伊套裝"
L["Hunter Set"] = "獵人套裝"
L["Mage Set"] = "法師套裝"
L["Paladin Set"] = "聖騎士套裝"
L["Priest Set"] = "牧師套裝"
L["Rogue Set"] = "盜賊套裝"
L["Shaman Set"] = "薩滿套裝"
L["Warlock Set"] = "術士套裝"
L["Warrior Set"] = "戰士套裝"
L["Legendary Mount"] = "傳說坐騎"
L["Legendaries"] = "傳說物品"
L["Muddy Churning Waters"] = "混濁的水"
L["Shared"] = "隨機掉落"
L["Enchants"] = "公式"
L["Rajaxx's Captains"] = "拉賈克斯的上尉們"
L["Class Books"] = "職業技能書"
L["Quest Items"] = "任務物品"
L["Druid of the Fang (Trash Mob)"] = "尖牙德魯伊 (小怪)"
L["Spawn Of Hakkar"] = "哈卡的後代"
L["Troll Mini bosses"] = "食人妖小頭目"
L["Henry Stern"] = "亨利·斯特恩"
L["Magregan Deepshadow"] = "馬格雷甘·深影"
L["Tablet of Ryuneh"] = "雷烏納石板"
L["Krom Stoutarm Chest"] = "克羅姆·蒼臂的寶藏"
L["Garrett Family Chest"] = "加勒特的家族寶藏"
L["Eric The Swift"] = "『迅捷』艾利克"
L["Olaf"] = "奧拉夫"
L["Baelog's Chest"] = "巴爾洛戈的箱子"
L["Conspicuous Urn"] = "顯眼的石罐"
L["Tablet of Will"] = "意志石板"
L["Shadowforge Cache"] = "破碎項鍊上的紅寶石"
L["Roogug"] = "魯古格"
L["Aggem Thorncurse"] = "阿格姆"
L["Razorfen Spearhide"] = "剃刀沼澤刺鬃守衛"
L["Pyron"] = "征服者派隆"
L["Theldren"] = "瑟爾倫"
L["The Vault"] = "黑色寶庫"
L["Summoner's Tomb"] = "召喚者之墓"
L["Plans"] = "黑暗神廟卷軸"
L["Zelemar the Wrathful"] = "憤怒者塞雷瑪爾"
L["Rethilgore"] = "雷希戈爾"
L["Fel Steed"] = "地獄戰馬"
L["Tribute Run"] = "貢品"
L["Shen'dralar Provisioner"] = "辛德拉聖職者"
L["Books"] = "書籍"
L["Trinkets"] = "飾品"
L["Sothos & Jarien"] = "索索斯及賈林"
L["Fel Iron Chest"] = "魔鐵箱"
L[" (Heroic)"] = " (英雄)"
L["Yor (Heroic Summon)"] = "約兒 (英雄模式召喚)"
L["Avatar of the Martyred"] = "馬丁瑞德的化身"
L["Anzu the Raven God (Heroic Summon)"] = "安祖·烏鴉之神(英雄模式召喚)"
L["Thomas Yance"] = "湯瑪斯·陽斯"
L["Aged Dalaran Wizard"] = "年邁的達拉然巫師"
L["Cache of the Legion"] = "軍團儲藏箱"
L["Opera (Shared Drops)"] = "歌劇院 (隨機掉落)"
L["Timed Chest"] = "限時任務獎勵箱子"
L["Patterns"] = "卷軸"

--Rep
L["Token Hand-Ins"] = "可兌換的獎勵"
L["Items"] = "物品"
L["Beasts Deck"] = "野獸套卡"
L["Elementals Deck"] = "元素套卡"
L["Warlords Deck"] = "督軍套卡"
L["Portals Deck"] = "傳送門套卡"
L["Furies Deck"] = "狂怒套卡"
L["Storms Deck"] = "風暴套卡"
L["Blessings Deck"] = "祝福套卡"
L["Lunacy Deck"] = "失心套卡"
L["Quest rewards"] = "任務獎勵"
L["Shattrath"] = "薩塔"

--World drop
L["Outdoor Bosses"] = "野外首領"
L["Highlord Kruul"] = "卡魯歐領主"
L["Bash'ir Landing"] = "貝許爾平台"
L["Skyguard Raid"] = "禦天者空防"
L["Stasis Chambers"] = "貝許爾的靜止密室"
L["Skettis"] = "司凱堤斯"
L["Darkscreecher Akkarai"] = "黑暗尖叫者阿卡萊"
L["Karrog"] = "凱羅格"
L["Gezzarak the Huntress"] = "女獵人吉札拉"
L["Vakkiz the Windrager"] = "風怒者瓦奇茲"
L["Terokk"] = "泰洛克"
L["Ethereum Prison"] = "伊斯利恩監獄"
L["Armbreaker Huffaz"] = "斷臂者霍法茲"
L["Fel Tinkerer Zortan"] = "惡魔工匠祖坦"
L["Forgosh"] = "弗古斯"
L["Gul'bor"] = "古柏爾"
L["Malevus the Mad"] = "狂怒者馬拉弗斯"
L["Porfus the Gem Gorger"] = "寶石吞噬者波弗斯"
L["Wrathbringer Laz-tarash"] = "憤怒使者拉茲泰拉西"
L["Abyssal Council"] = "深淵議會"
L["Crimson Templar (Fire)"] = "赤紅聖殿騎士 (火)"
L["Azure Templar (Water)"] = "碧藍聖殿騎士 (水)"
L["Hoary Templar (Wind)"] = "蒼白聖殿騎士 (風)"
L["Earthen Templar (Earth)"] = "土色聖殿騎士 (土)"
L["The Duke of Cinders (Fire)"] = "辛德爾公爵 (火)"
L["The Duke of Fathoms (Water)"] = "深淵公爵 (水)"
L["The Duke of Zephyrs (Wind)"] = "微風公爵 (風)"
L["The Duke of Shards (Earth)"] = "碎石公爵 (土)"
L["Elemental Invasion"] = "元素入侵"
L["Gurubashi Arena"] = "古拉巴什競技場"
L["Booty Run"] = "藏寶競技"
L["Fishing Extravaganza"] = "釣魚大賽"
L["First Prize"] = "頭獎"
L["Rare Fish"] = "稀有魚類"
L["Rare Fish Rewards"] = "稀有釣魚獎勵"
L["Children's Week"] = "兒童週"
L["Love is in the air"] = "愛就在你我身邊"
L["Gift of Adoration"] = "愛慕之禮"
L["Box of Chocolates"] = "巧克力盒"
L["Hallow's End"] = "復活節"
L["Various Locations"] = "多個地方"
L["Treat Bag"] = "糖果包"
L["Headless Horseman"] = "無頭騎士"
L["Feast of Winter Veil"] = "冬幕節"
L["Smokywood Pastures Vendor"] = "燻木牧場商人"
L["Gaily Wrapped Present"] = "精心包裝的禮物"
L["Festive Gift"] = "節慶禮物"
L["Winter Veil Gift"] = "冬幕節禮物"
L["Gently Shaken Gift"] = "輕輕搖晃過的禮物"
L["Ticking Present"] = "滴答作響的禮物"
L["Carefully Wrapped Present"] = "仔細包裝的禮物"
L["Noblegarden"] = "彩蛋節"
L["Brightly Colored Egg"] = "彩蛋"
L["Smokywood Pastures Extra-Special Gift"] = "燻木牧場的超特別禮物"
L["Harvest Festival"] = "收穫節"
L["Food"] = "食物"
L["Scourge Invasion"] = "天譴軍團"
L["Miscellaneous"] = "雜項"
L["Cloth Set"] = "布甲套裝"
L["Leather Set"] = "皮甲套裝"
L["Mail Set"] = "鎖甲套裝"
L["Plate Set"] = "鎧甲套裝"
L["Balzaphon"] = "巴爾薩馮"
L["Lord Blackwood"] = "黑木公爵"
L["Revanchion"] = "雷瓦克安"
L["Scorn"] = "瑟克恩"
L["Sever"] = "塞沃爾"
L["Lady Falther'ess"] = "法瑟蕾絲夫人"
L["Lunar Festival"] = "新年節"
L["Fireworks Pack"] = "煙火包"
L["Lucky Red Envelope"] = "幸運紅包袋"
L["Midsummer Fire Festival"] = "仲夏火燄節慶"
L["Lord Ahune"] = "艾胡恩"
L["Shartuul"] = "夏圖歐"
L["Blade Edge Mountains"] = "劍刃山脈"
L["Brewfest"] = "啤酒節"
L["Barleybrew Brewery"] = "麥酒釀造廠"
L["Thunderbrew Brewery"] = "雷霆啤酒釀造廠"
L["Gordok Brewery"] = "戈多克綠酒釀造廠"
L["Drohn's Distillery"] = "德羅恩的釀酒廠"
L["T'chali's Voodoo Brewery"] = "提洽里的巫毒釀酒廠"

--craft
L["Crafted Weapons"] = "精製裝備武器"
L["Master Swordsmith"] = "鑄劍大師"
L["Master Axesmith"] = "鑄斧大師"
L["Master Hammersmith"] = "鑄錘大師"
L["Blacksmithing (Lv 60)"] = "鍛造 (Lv 60)"
L["Blacksmithing (Lv 70)"] = "鍛造 (Lv 70)"
L["Engineering (Lv 60)"] = "工程學 (Lv 60)"
L["Engineering (Lv 70)"] = "工程學 (Lv 70)"
L["Blacksmithing Plate Sets"] = "鍛造鎧甲套裝"
L["Imperial Plate"] = "帝王鎧甲"
L["The Darksoul"] = "黑暗之魂"
L["Fel Iron Plate"] = "魔鐵鎧甲"
L["Adamantite Battlegear"] = "堅鋼戰甲"
L["Flame Guard"] = "烈焰套裝"
L["Enchanted Adamantite Armor"] = "附魔堅鋼護甲"
L["Khorium Ward"] = "克銀結界"
L["Faith in Felsteel"] = "信仰魔鋼"
L["Burning Rage"] = "燃燒狂怒"
L["Blacksmithing Mail Sets"] = "鍛造鎖甲套裝"
L["Bloodsoul Embrace"] = "血魂的擁抱"
L["Fel Iron Chain"] = "魔鐵鍊甲"
L["Tailoring Sets"] = "裁縫套裝"
L["Bloodvine Garb"] = "血藤之服"
L["Netherweave Vestments"] = "幽紋套裝"
L["Imbued Netherweave"] = "魔染幽紋套裝"
L["Arcanoweave Vestments"] = "奧紋套裝"
L["The Unyielding"] = "不屈套裝"
L["Whitemend Wisdom"] = "白癒智慧"
L["Spellstrike Infusion"] = "法擊套裝"
L["Battlecast Garb"] = "戰放服裝"
L["Soulcloth Embrace"] = "靈魂布的擁抱"
L["Primal Mooncloth"] = "原始月布"
L["Shadow's Embrace"] = "暗影的擁抱"
L["Wrath of Spellfire"] = "魔焰之怒"
L["Leatherworking Leather Sets"] = "製皮套裝"
L["Volcanic Armor"] = "火山護甲"
L["Ironfeather Armor"] = "鐵羽護甲"
L["Stormshroud Armor"] = "雷暴護甲"
L["Devilsaur Armor"] = "魔暴龍護甲"
L["Blood Tiger Harness"] = "血虎套索"
L["Primal Batskin"] = "原始蝙蝠皮套裝"
L["Wild Draenish Armor"] = "狂野德萊尼護甲"
L["Thick Draenic Armor"] = "厚德萊尼護甲"
L["Fel Skin"] = "惡魔皮膚"
L["Strength of the Clefthoof"] = "裂蹄力量"
L["Primal Intent"] = "原始之意套裝"
L["Windhawk Armor"] = "風之隼護甲"
L["Leatherworking Mail Sets"] = "製皮鎖甲套裝"
L["Green Dragon Mail"] = "綠龍鎖甲"
L["Blue Dragon Mail"] = "藍龍鎖甲"
L["Black Dragon Mail"] = "黑龍鎖甲"
L["Scaled Draenic Armor"] = "德萊尼鱗護甲"
L["Felscale Armor"] = "魔鱗護甲"
L["Felstalker Armor"] = "惡魔捕獵者套裝"
L["Fury of the Nether"] = "虛空之怒套裝"
L["Netherscale Armor"] = "虛空鱗護甲"
L["Netherstrike Armor"] = "地擊套裝"
L["Armorsmith"] = "鑄甲大師"
L["Weaponsmith"] = "武器大師"
L["Dragonscale"] = "龍鱗製皮"
L["Elemental"] = "元素製皮"
L["Tribal"] = "部族製皮"
L["Mooncloth"] = "月布專精"
L["Shadoweave"] = "暗影布專精"
L["Spellfire"] = "魔法布專精"
L["Gnomish"] = "地精工程學"
L["Goblin"] = "哥布林工程學"
L["Apprentice"] = "初級"
L["Journeyman"] = "中級"
L["Expert"] = "高級"
L["Artisan"] = "專家級"
L["Master"] = "大師級"

--Set & PVP
L["Superior Rewards"] = "精良獎勵"
L["Epic Rewards"] = "史詩獎勵"
-- L["Lv 10-19 Rewards"] = "10~19級獎勵"
-- L["Lv 20-29 Rewards"] = "20-29級獎勵"
-- L["Lv 30-39 Rewards"] = "30-39級獎勵"
-- L["Lv 40-49 Rewards"] = "40-49級獎勵"
-- L["Lv 50-59 Rewards"] = "50-59級獎勵"
-- L["Lv 60 Rewards"] = "60級獎勵"
L["Lv %s Rewards"] = "%s級獎勵"
L["PVP Cloth Set"] = "PVP布甲套裝"
L["PVP Leather Sets"] = "PVP皮甲套裝"
L["PVP Mail Sets"] = "PVP鎖甲套裝"
L["PVP Plate Sets"] = "PVP鎧甲套裝"
L["World PVP"] = "世界PVP"
L["Hellfire Fortifications"] = "地獄火半島防禦"
L["Twin Spire Ruins"] = "雙塔廢墟"
L["Spirit Towers (Terrokar)"] = "靈魂哨塔(泰羅卡森林,白骨荒野)"
L["Halaa (Nagrand)"] = "哈刺(納格蘭)"
-- L["Arena Season 1"] = "競技場第一季"
-- L["Arena Season 2"] = "競技場第二季"
-- L["Arena Season 3"] = "競技場第三季"
-- L["Arena Season 4"] = "競技場第四季"
L["Arena Season %d"] = "競技場第 %d 季"
L["Weapons"] = "武器"
L["Accessories"] = "配件"
L["Level 70 Reputation PVP"] = "70級PVP聲望裝"
L["Level %d Honor PVP"] = "%d級PVP榮譽裝"
L["Savage Gladiator\'s Weapons"] = "蠻荒鬥士\'s 武器"
L["Deadly Gladiator\'s Weapons"] = "致命鬥士\'s 武器"
L["Lake Wintergrasp"] = "冬握湖"
L["Non Set Accessories"] = "非套裝配件"
L["Non Set Cloth"] = "非套裝布甲"
L["Non Set Leather"] = "非套裝皮甲"
L["Non Set Mail"] = "非套裝鎖甲"
L["Non Set Plate"] = "非套裝鎧甲"
L["Tier 0.5 Quests"] = "T0.5任務"
L["Tier %d Tokens"] = "T%d代換品"
L["Blizzard Collectables"] = "暴雪收藏品"
L["WoW Collector Edition"] = "魔獸世界收藏版"
L["BC Collector Edition (Europe)"] = "燃燒的遠征收藏版(歐洲版)"
L["Blizzcon 2005"] = "暴雪嘉年華2005"
L["Blizzcon 2007"] = "暴雪嘉年華2007"
L["Christmas Gift 2006"] = "聖誕禮物2006"
L["Upper Deck"] = "桌面紙牌"
L["Loot Card Items"] = "稀有紙牌物品"
L["Heroic Mode Tokens"] = "正義徽章"
L["Fire Resistance Gear"] = "火抗套裝"
L["Emblems of Valor"] = "勇氣紋章"
L["Emblems of Heroism"] = "英雄紋章"

L["Cloaks"] = "披風"
L["Relics"] = "聖物"
L["World Drops"] = "世界掉落"
L["Level 30-39"] = "30-39級"
L["Level 40-49"] = "40-49級"
L["Level 50-60"] = "50-60級"
L["Level 70"] = "70級"

-- Altoholic.Gathering : Mining 
L["Copper Vein"] = "銅礦"
L["Tin Vein"] = "錫礦"
L["Iron Deposit"] = "鐵礦石"
L["Silver Vein"] = "銀礦"
L["Gold Vein"] = "金礦石"
L["Mithril Deposit"] = "秘銀礦脈"
L["Ooze Covered Mithril Deposit"] = "軟泥覆蓋的秘銀礦脈"
L["Truesilver Deposit"] = "真銀礦石"
L["Ooze Covered Silver Vein"] = "軟泥覆蓋的銀礦脈"
L["Ooze Covered Gold Vein"] = "軟泥覆蓋的金礦脈"
L["Ooze Covered Truesilver Deposit"] = "軟泥覆蓋的真銀礦脈"
L["Ooze Covered Rich Thorium Vein"] = "軟泥覆蓋的富瑟銀礦脈"
L["Ooze Covered Thorium Vein"] = "軟泥覆蓋的瑟銀礦脈"
L["Small Thorium Vein"] = "瑟銀礦脈"
L["Rich Thorium Vein"] = "富瑟銀礦"
L["Hakkari Thorium Vein"] = "哈卡萊瑟銀礦脈"
L["Dark Iron Deposit"] = "黑鐵礦脈"
L["Lesser Bloodstone Deposit"] = "次級血石礦脈"
L["Incendicite Mineral Vein"] = "火岩礦脈"
L["Indurium Mineral Vein"] = "精鐵礦脈"
L["Fel Iron Deposit"] = "魔鐵礦床"
L["Adamantite Deposit"] = "堅鋼礦床"
L["Rich Adamantite Deposit"] = "豐沃的堅鋼礦床"
L["Khorium Vein"] = "克銀礦脈"
L["Large Obsidian Chunk"] = "大型黑曜石礦"
L["Small Obsidian Chunk"] = "小型黑曜石礦"
L["Nethercite Deposit"] = "虛空傳喚礦床"

-- Altoholic.Gathering : Herbalism
L["Peacebloom"] = "寧神花"
L["Silverleaf"] = "銀葉草"
L["Earthroot"] = "地根草"
L["Mageroyal"] = "魔皇草"
L["Briarthorn"] = "石南草"
L["Swiftthistle"] = "雨燕草"
L["Stranglekelp"] = "荊棘藻"
L["Bruiseweed"] = "跌打草"
L["Wild Steelbloom"] = "野鋼花"
L["Grave Moss"] = "墓地苔"
L["Kingsblood"] = "皇血草"
L["Liferoot"] = "活根草"
L["Fadeleaf"] = "枯葉草"
L["Goldthorn"] = "金棘草"
L["Khadgar's Whisker"] = "卡德加的鬍鬚"
L["Wintersbite"] = "冬刺草"
L["Firebloom"] = "火焰花"
L["Purple Lotus"] = "紫蓮花"
L["Wildvine"] = "野葡萄藤"
L["Arthas' Tears"] = "阿薩斯之淚"
L["Sungrass"] = "太陽草"
L["Blindweed"] = "盲目草"
L["Ghost Mushroom"] = "鬼魂菇"
L["Gromsblood"] = "格羅姆之血"
L["Golden Sansam"] = "黃金蔘"
L["Dreamfoil"] = "夢葉草"
L["Mountain Silversage"] = "山鼠草"
L["Plaguebloom"] = "瘟疫花"
L["Icecap"] = "冰蓋草"
L["Bloodvine"] = "血藤"
L["Black Lotus"] = "黑蓮花"
L["Felweed"] = "魔獄草"
L["Dreaming Glory"] = "譽夢草"
L["Terocone"] = "泰魯草"
L["Ancient Lichen"] = "古老青苔"
L["Bloodthistle"] = "血薊"
L["Mana Thistle"] = "法力薊"
L["Netherbloom"] = "虛空花"
L["Nightmare Vine"] = "夢魘根"
L["Ragveil"] = "拉格維花"
L["Flame Cap"] = "火帽花"
L["Fel Lotus"] = "魔獄蓮花"
L["Netherdust Bush"] = "虛空之塵灌木叢"

-- L["Glowcap"] = true,
-- L["Sanguine Hibiscus"] = true,	


if GetLocale() == "zhTW" then
-- Altoholic.xml local
LEFT_HINT = "左鍵 |cFF00FF00開啟";
RIGHT_HINT = "右鍵 |cFF00FF00拖曳";

XML_ALTO_SHARING_HINT1 = "輸入帳戶名稱\n用作|cFF00FF00識別而已|r .\n"
				.. "這個名稱可以隨你歡喜,\n並 |cFF00FF00不需要|r 是真實的帳戶名稱.\n\n"
XML_ALTO_SHARING_HINT2 = "這欄 |cFF00FF00不能|r 留空."

XML_ALTO_TAB1 = "摘要"
XML_ALTO_TAB2 = "角色"
XML_ALTO_TAB3 = "搜尋"
-- XML_ALTO_TAB4 = GUILD_BANK
XML_ALTO_TABOPTIONS = "選項"

XML_ALTO_SUMMARY_MENU1 = "帳戶摘要"
XML_ALTO_SUMMARY_MENU2 = "背包使用度"
-- XML_ALTO_SUMMARY_MENU3 = SKILLS
XML_ALTO_SUMMARY_MENU4 = "活躍度"
XML_ALTO_SUMMARY_MENU5 = "公會成員"
XML_ALTO_SUMMARY_MENU6 = "公會技能"
XML_ALTO_SUMMARY_MENU7 = "公會金庫分頁"

XML_ALTO_SUMMARY_TEXT1 = "要求帳戶共享資料"
XML_ALTO_SUMMARY_TEXT2 = "按一下這個按鈕來詢問玩家\n"
				.. "要求分享Altoholic的數據庫\n"
				.. "並將其添加到您自己數據庫內"
XML_ALTO_SUMMARY_TEXT3 = "雙方都必須啟用帳戶共享\n來使用此功能 (請參考選項)"
XML_ALTO_SUMMARY_TEXT4 = "帳戶共享"

XML_ALTO_CHAR_DD1 = "伺服器"
XML_ALTO_CHAR_DD2 = "角色"
XML_ALTO_CHAR_DD3 = "顯示"

XML_ALTO_SEARCH_COL1 = "物品 / 地點"

XML_ALTO_GUILD_TEXT1 = "在提示框隱藏這公會金庫的顯示"

XML_ALTO_ACH_NOTSTARTED = "尚未啟動"
XML_ALTO_ACH_STARTED = "已啟動"

XML_ALTO_OPT_MENU1 = "一般"
XML_ALTO_OPT_MENU2 = "搜尋"
XML_ALTO_OPT_MENU3 = "郵件"
XML_ALTO_OPT_MENU4 = "小地圖"
XML_ALTO_OPT_MENU5 = "提示"

XML_TEXT_1 = "總數";
XML_TEXT_2 = "搜索容器";
XML_TEXT_3 = "等級範圍";
XML_TEXT_4 = "稀有";
XML_TEXT_5 = "設備格";
XML_TEXT_6 = "重置";
XML_TEXT_7 = "搜索";

XML_ALTO_TEXT10 = "帳戶名稱"
XML_ALTO_TEXT11 = "發送帳戶共享資料的要求:"

--Options.xml
XML_ALTO_OPT_GENERAL1 = "充份休息經驗值以150%來顯示";
XML_ALTO_OPT_GENERAL2 = "顯示圖示";
XML_ALTO_OPT_GENERAL3 = "顯示文字";
XML_ALTO_OPT_GENERAL4 = "啟用帳戶共享";
XML_ALTO_OPT_GENERAL5 = "啟用公會聯系";
XML_ALTO_OPT_GENERAL6 = "|cFFFFFFFF當 |cFF00FF00啟用|cFFFFFFFF時, 這選項會讓共它Altoholic用家\n"
				.. "可向你發送帳戶資料要求.\n\n"
				.. "當 |cFFFF0000關閉|cFFFFFFFF時, 所有帳戶資料要求會被拒.\n\n"
				.. "安全性提示: 只有當您需要實際的數據傳輸時才啟用,\n反之請關閉它"
XML_ALTO_OPT_GENERAL7 = "|cFFFFFFFF當 |cFF00FF00啟用|cFFFFFFFF時, 這選項會讓你公會的會友\n"
				.. "看見你的分身和其專業技能.\n\n"
				.. "當 |cFFFF0000關閉|cFFFFFFFF時, 將不會有任何公會聯系."
XML_ALTO_OPT_GENERAL8 = "自動授權公會金庫更新"
XML_ALTO_OPT_GENERAL9 = "|cFFFFFFFF當 |cFF00FF00啟用|cFFFFFFFF時, 此選項將允許其他Altoholic用戶\n"
				.. "與你的公會金庫資料作自動更新.\n\n"
				.. "當 |cFFFF0000關閉|cFFFFFFFF時, 發送任何信息\n"
				.. "之前將需要您的確認.\n\n"
				.. "安全提示：如果您有公會理事的權利請關閉\n"
				.. "有查看限制的公會金庫分頁來防止被任何人觀看,\n"
				.. "如需要同步時請用手動受權."

XML_ALTO_OPT_SEARCH1 = "自動向伺服器查詢 |cFFFF0000(有可能導至斷線)";
XML_ALTO_OPT_SEARCH2 = "|cFFFFFFFF當物品不在本機的內存時\n"
				.. "當在搜索表裡找到,\n"
				.. "Altoholic 將試圖查詢服務器下5個新項目.\n\n"
				.. "這將逐步完善的一致性搜查,\n"
				.. "隨著越來越多的項目都可以在本機的內存時.\n\n"
				.. "如查詢的物品是一件非常高級的副本掉落\n"
				.. "極有可能導至斷線.\n\n"
				.. "|cFF00FF00關閉|r 這選項可避免這種情況發生";
XML_ALTO_OPT_SEARCH3 = "戰利品排序";
XML_ALTO_OPT_SEARCH4 = "包括沒等級要求的物品";
XML_ALTO_OPT_SEARCH5 = "包括郵箱";
XML_ALTO_OPT_SEARCH6 = "包括公會金庫";
XML_ALTO_OPT_SEARCH7 = "包括已學的配方";

XML_ALTO_OPT_MAIL1 = "當郵件屆滿少過此值的日數時發出警告";
XML_ALTO_OPT_MAIL2 = "郵件屆滿警告";
XML_ALTO_OPT_MAIL3 = "掃描郵件內容 (標記為己讀取)";
XML_ALTO_OPT_MAIL4 = "新郵件通知";
XML_ALTO_OPT_MAIL5 = "當公會成員發送了一封郵件給我的一個角色會發出通知.\n\n"
				.. "郵件內容是直接可見而不必重新登錄該角色";

XML_ALTO_OPT_MINIMAP1 = "移動來改變小地圖圖示的角度";
XML_ALTO_OPT_MINIMAP2 = "小地圖圖示角度";
XML_ALTO_OPT_MINIMAP3 = "移動來改變小地圖圖示的半徑距離";
XML_ALTO_OPT_MINIMAP4 = "小地圖圖示半徑距離";
XML_ALTO_OPT_MINIMAP5 = "顯示小地圖圖示";

XML_ALTO_OPT_TOOLTIP1 = "顯示物品來源";
XML_ALTO_OPT_TOOLTIP2 = "顯示每個角色的物品數量";
XML_ALTO_OPT_TOOLTIP3 = "顯示物品總數量";
XML_ALTO_OPT_TOOLTIP4 = "包括公會金庫";
XML_ALTO_OPT_TOOLTIP5 = "包括已學會/可被學會";
XML_ALTO_OPT_TOOLTIP6 = "顯示物品ID和物品等級ILVL";
XML_ALTO_OPT_TOOLTIP7 = "在採集點上顯示數量";
XML_ALTO_OPT_TOOLTIP8 = "顯示兩方的聲望數值";
XML_ALTO_OPT_TOOLTIP9 = "顯示所有帳戶的數值";
XML_ALTO_OPT_TOOLTIP10 = "總數包括公會金庫計數";
end
