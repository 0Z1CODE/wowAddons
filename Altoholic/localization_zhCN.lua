local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "zhCN" )

if not L then return end

-- Note: since 2.4.004 and the support of LibBabble, certain lines are commented, but remain there for clarity (especially those concerning the menu)
-- A lot of translations, especially those concerning the loot table, comes from atlas loot, credit goes to their team for gathering this info, I (Thaoky) simply took what I needed.

L["Death Knight"] = "死亡骑士"

-- note: these string are the ones found in item tooltips, make sure to respect the case when translating, and to distinguish them (like crit vs spell crit)
L["Increases healing done by up to %d+"] = "法术治疗提高%d+"
L["Increases damage and healing done by magical spells and effects by up to %d+"] = "提高法术和魔法效果所造成的治疗效果，最多%d+"
L["Increases attack power by %d+"] = "攻击强度提高%d+"
L["Restores %d+ mana per"] = "秒恢复(%d+)点法力值"
L["Classes: Shaman"] = "职业：萨满祭司"
L["Classes: Mage"] = "职业：法师"
L["Classes: Rogue"] = "职业：潜行者"
L["Classes: Hunter"] = "职业：猎人"
L["Classes: Warrior"] = "职业：战士"
L["Classes: Paladin"] = "职业：圣骑士"
L["Classes: Warlock"] = "职业：术士"
L["Classes: Priest"] = "职业：牧师"
L["Classes: Death Knight"] = "职业：死亡骑士"
L["Resistance"] = "抗性"

--skills
L["Class Skills"] = "职业技能" 
L["Professions"] = "专业"
L["Secondary Skills"] = "辅助技能"
L["Fishing"] = "钓鱼"
L["Riding"] = "骑术"
L["Herbalism"] = "草药学"
L["Mining"] = "采矿"
L["Skinning"] = "剥皮"
L["Lockpicking"] = "开锁"
L["Poisons"] = "毒药"
L["Beast Training"] = "野兽训练"
L["Inscription"] = "铭文"

--factions not in LibFactions or LibZone
L["Alliance Forces"] = "联盟部队"
L["Horde Forces"] = "部落部队"
L["Steamwheedle Cartel"] = "热砂港"
L["Other"] = "其他"

-- menu
L["Reputations"] = "声望"
L["Containers"] = "容器"
L["Guild Bank not visited yet (or not guilded)"] = "公会银行未访问(或你没加入任何公会)"
L["E-Mail"] = "邮件"
L["Quests"] = "任务"
L["Equipment"] = "装备"

--Altoholic.lua
L["Account"] = "账号"
L["Default"] = "默认"
L["Loots"] = "拾取"
L["Unknown"] = "未知"
L["has come online"] = "上线了。"
L["has gone offline"] = "下线了。"
L["Bank not visited yet"] = "尚未访问银行"
L["Levels"] = "级"
L["(has mail)"] = "(有新的邮件)"
L["(has auctions)"] = "(有新的拍卖行通知)"
L["(has bids)"] = "(有新的一口价货物)"

L["No rest XP"] = "无经验奖励"
L["Rested"] = "经验奖励"
L["Transmute"] = "转化"

L["Bags"] = "背包"
L["Bank"] = "银行"
L["AH"] = "拍卖行"				-- for auction house, obviously
L["Equipped"] = "已装备"
L["Mail"] = "邮件"
L["Mails %s(%d)"] = "邮件 %s(%d)"
L["Mails"] = "邮件"
L["Visited"] = "已访问"
L["Auctions %s(%d)"] = "拍卖行 %s(%d)"
L["Bids %s(%d)"] = "一口价 %s(%d)"
L[", "] = "，"
L["(Guild bank: "] = "(公会银行: "

L["Level"] = "等级"
L["Zone"] = "地区"
L["Rest XP"] = "奖励经验"

L["Source"] = "来源"
L["Total owned"] = "总计"
L["Already known by "] = "已学会："
L["Will be learnable by "] = "将学习："
L["Could be learned by "] = "可学习："

L["At least one recipe could not be read"] = "最少有一个配方未能读取"
L["Please open this window again"] = "请再次打开窗口"

--Comm.lua
L["Sending account sharing request to %s"] = "向%s发送帐户共享的请求"
L["Account sharing request received from %s"] = "收到%s的帐户共享请求"
L["You have received an account sharing request\nfrom %s%s|r, accept it?"] = "你收到帐户共享请求\n请求者 %s%s|r, 接受吗?"
L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"] = "%s警告:|r 如接受, %s所有|r 已知的资料\n会被 Altoholic 传送给 %s%s|r (背包, 金钱, 等等..)"
L["Request rejected by %s"] = "请求被%s驳回"
L["%s is in combat, request cancelled"] = "%s在战斗中, 请求被驳回"
L["%s has disabled account sharing"] = "%s的帐户共享功能关闭"
L["Table of content received (%d items)"] = "收到列表的内容(%d 物品)"
L["Sending reputations (%d of %d)"] = "发送声望资料 (%d 之 %d)"
L["Sending currencies (%d of %d)"] = "发送金钱资料 (%d 之 %d)"
L["Sending guilds (%d of %d)"] = "发送公会资料 (%d 之 %d)"
L["Sending character %s (%d of %d)"] = "发送角色资料 %s (%d 之 %d)"
L["No reputations found"] = "没找到声望资料"
L["No currencies found"] = "没找到金钱资料"
L["No guild found"] = "没找到公会资料"
L["Transfer complete"] = "传输完成"
L["Reputations received !"] = "收到声望资料!"
L["Currencies received !"] = "收到金钱资料!"
L["Guilds received !"] = "收到公会资料!"
L["Character %s received !"] = "角色%s已接收!"
L["Requesting item %d of %d"] = "物品要求 %d 之 %d"
L["Sending table of content (%d items)"] = "发送列表内容 (%d 物品)"
L["Guild bank tab %s successfully updated !"] = "%s公会仓库分页已更新成功!"
L["%s has disabled guild communication"] = "%s关闭公会联系"
L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"] = "%s%s|r 要求公会仓库分页 %s%s|r\n要传送这项资料吗 ?"
L["%sWarning:|r make sure this user may view this information before accepting"] = "%s警告:|r 请确定此用户可以查看分页的资料才接受"
L["%s|r has received a mail from %s"] = "%s|r 已收到%s的邮件"
L["Sending reference data: %s (%d of %d)"] = "Sending reference data: %s (%d of %d)"
L["Reference data not available"] = "Reference data not available"
L["Reference data received (%s) !"] = "Reference data received (%s) !"
L["Waiting for %s to accept .."] = "Waiting for %s to accept .."

--GuildBankTabs.lua
L["Requesting %s information from %s"] = "请求%s资料,目标%s"
L["Guild Bank Remote Update"] = "公会仓库远程更新"
L["Clicking this button will update\nyour local %s%s|r bank tab\nbased on %s%s's|r data"] = "点击此按钮将更新\n你本服的%s%s|r 公会仓库分页\n基于 %s%s's|r 的资料"

--GuildMembers.lua
L["Left-click to see this character's equipment"] = "左键点击来观看这角色的装备"
L["Click a character's AiL to see its equipment"] = "点击角色的 AiL 来查看他的装备"

--GuildProfessions.lua
L["Offline Members"] = "下线成员"
L["Left click to view"] = "Left click to view"
L["Shift+Left click to link"] = "Shift+Left click to link"

--Core.lua
L['search'] = '搜索'
L["Search in bags"] = '在背包中搜索'
L['show'] = '显示'
L["Shows the UI"] = '显示图形界面'
L['hide'] = '隐藏'
L["Hides the UI"] = '隐藏图形界面'
L['toggle'] = '切换'
L["Toggles the UI"] = '切换图形界面的显示/隐藏'
L["Altoholic:|r Usage = /altoholic search <item name>"] = "Altoholic:|r 用法 = /altoholic search <物品名字>"

--AltoholicFu.lua
L["Left-click to"] = "左键点击"
L["open/close"] = "打开/关闭"

--AccountSummary.lua
L["View bags"] = "背包浏览"
L["All-in-one"] = "整合"
L["View mailbox"] = "邮箱浏览"
L["View quest log"] = "任务浏览"
L["View auctions"] = "浏览拍卖行"
L["View bids"] = "浏览一口价"
L["Delete this Alt"] = "删除该人物镜像"
L["Cannot delete current character"] = "无法删除当前人物镜像"
L["Character %s successfully deleted"] = "人物： %s 成功删除！"
L["Delete this Realm"] = "删除此服务器内容"
L["Cannot delete current realm"] = "无法删除当前服务器内容"
L["Realm %s successfully deleted"] = "服务器 %s 删除成功"
L["Suggested leveling zone: "] = "推荐升级地区: "
L["Arena points: "] = "竞技场点数: "
L["Honor points: "] = "荣誉点数: "
L["Right-Click for options"] = "右键点击打开选项"
L["Average Item Level"] = "平均物品等级"

-- AuctionHouse.lua
L["%s has no auctions"] = "%s 无拍卖行通知"
L["%s has no bids"] = "%s 无一口价货物"
L["last check "] = "上次检查于 "
L["Goblin AH"] = "地精拍卖行"
L["Clear your faction's entries"] = "清理你阵营的拍卖行的相关信息"
L["Clear goblin AH entries"] = "清理地精拍卖行的相关信息"
L["Clear all entries"] = "清理所有拍卖行的相关信息"

--BagUsage.lua
L["Totals"] = "总计"
L["slots"] = "格"
L["free"] = "空余"

--Containers.lua
L["32 Keys Max"] = "最大32格"
L["28 Slot"] = "28格"
L["Bank bag"] = "银行背包"
L["Unknown link, please relog this character"] = "未知链接，请重新登入角色"

--Equipment.lua
L["Find Upgrade"] = "发现更高级"
L["(based on iLvl)"] = "(基于物品等级)"
L["Right-Click to find an upgrade"] = "右键点击查找高端进阶装备"
L["Tank"] = "坦克"
L["DPS"] = "伤害输出"
L["Balance"] = "平衡"
L["Elemental Shaman"] = "元素"		-- shaman spec !
L["Heal"] = "治疗"

--GuildBank.lua
L["Last visit: %s by %s"] = "最后一次访问: %s 到访者: %s"
L["Local Time: %s   %sRealm Time: %s"] = "本地时间: %s   %s服务器时间: %s"

--Mails.lua
L[" has not visited his/her mailbox yet"] = " 尚未访问其邮箱"
L["%s has no mail"] = "%s 无邮件"
L[" has no mail, last check "] = " 无邮件，上次访问于 "
L[" days ago"] = " 天前"
L["Mail was last checked "] = "邮箱上次访问于 "
L[" days"] = " 天"
L["Mail is about to expire on at least one character."] = "至少一个角色的邮件即将到期."
L["Refer to the activity pane for more details."] = "更多信息请查看现用的方框."
L["Do you want to view it now ?"] = "现在想查看吗?"

--Quests.lua
L["No quest found for "] = "未发现任务："
L["QuestID"] = "任务编号"
L["Are also on this quest:"] = "有相同任务: "

--Recipes.lua
L["No data"] = "无数据"
L[" scan failed for "] = " 扫描失败于 "

--Reputations.lua
L["Shift-Click to link this info"] = "Shift+点击链接此信息"
L[" is "] = " 为 "
L[" with "] = " 对 "

--Search.lua
L["Item Level"] = "物品等级"
L[" results found (Showing "] = " 个结果 (显示 "
L["No match found!"] = "未发现匹配的!"
L[" not found!"] = " 未发现!"
L["Socket"] = "插槽"

--skills.lua
L["Rogue Proficiencies"] = "潜行者专有技能"
L["up to"] = "升到"
L["at"] = "在"
L["and above"] = "及以上"
L["Suggestion"] = "建议"
L["Prof. 1"] = "商业技能"
L["Prof. 2"] = "辅助技能"
L["Grey"] = "灰色"
L["All cooldowns are up"] = "所有冷却已完成"

-- TabSummary.lua
L["All accounts"] = "所有账户"

-- TabCharacters.lua
L["Cannot link another realm's tradeskill"] = "不能使用其它服务器的专业技能连结"
L["Cannot link another account's tradeskill"] = "不能使用其它帐户的专业技能连结"
L["Invalid tradeskill link"] = "无效的技能连结"
L["Expiry:"] = "到期:"

-- TabGuildBank.lua
L["N/A"] = "暂不提供"
L["Delete Guild Bank?"] = "删除公会仓库吗?"
L["Guild %s successfully deleted"] = "公会仓库 %s 删除成功"

-- TabSearch.lua
L["Any"] = "所有"
L["Miscellaneous"] = "杂项"
L["Fishing Poles"] = "鱼竿"
L["This realm"] = "仅搜索该服务器"		-- please update these 3 string to display "this realm" instead of "search this realm" ...
L["All realms"] = "搜索所有服务器"
L["Loot tables"] = "搜索掉落列表"
L["This character"] = "This character"
L["This faction"] = "This faction"
L["Both factions"] = "Both factions"

--loots.lua
--Instinct drop
L["Hard Mode"] = "Hard Mode"
L["Trash Mobs"] = "小怪掉落"
L["Random Boss"] = "随机首领"
L["Druid Set"] = "德鲁伊套装"
L["Hunter Set"] = "猎人套装"
L["Mage Set"] = "法师套装"
L["Paladin Set"] = "圣骑士套装"
L["Priest Set"] = "牧师套装"
L["Rogue Set"] = "潜行者套装"
L["Shaman Set"] = "萨满祭司套装"
L["Warlock Set"] = "术士套装"
L["Warrior Set"] = "战士套装"
L["Legendary Mount"] = "史诗坐骑"
L["Legendaries"] = "传说装备"
L["Muddy Churning Waters"] = "混浊的水"
L["Shared"] = "共享掉落"
L["Enchants"] = "附魔"
L["Rajaxx's Captains"] = "拉贾克斯将军的随从"
L["Class Books"] = "职业书籍"
L["Quest Items"] = "任务物品"
L["Druid of the Fang (Trash Mob)"] = "尖牙德鲁伊(小怪)"
L["Spawn Of Hakkar"] = "哈卡的后代"
L["Troll Mini bosses"] = "巨魔小首领"
L["Henry Stern"] = "亨利·斯特恩"
L["Magregan Deepshadow"] = "马格雷甘·深影"
L["Tablet of Ryuneh"] = "雷乌纳石板"
L["Krom Stoutarm Chest"] = "克罗姆·粗臂的箱子"
L["Garrett Family Chest"] = "加瑞特家族的箱子"
L["Eric The Swift"] = "埃瑞克"
L["Olaf"] = "奥拉夫"
L["Baelog's Chest"] = "巴尔洛戈的箱子"
L["Conspicuous Urn"] = "明显的墓碑"
L["Tablet of Will"] = "意志石板"
L["Shadowforge Cache"] = "暗炉储藏室"
L["Roogug"] = "鲁古格"
L["Aggem Thorncurse"] = "阿格姆"
L["Razorfen Spearhide"] = "剃刀沼泽刺鬃守卫"
L["Pyron"] = "征服者派隆"
L["Theldren"] = "塞尔德林"
L["The Vault"] = "宝窟"
L["Summoner's Tomb"] = "召唤者之墓"
L["Plans"] = "设计图"
L["Zelemar the Wrathful"] = "愤怒者塞雷玛尔"
L["Rethilgore"] = "雷希戈尔"
L["Fel Steed"] = "地狱战马"
L["Tribute Run"] = "贡品出产"
L["Shen'dralar Provisioner"] = "辛德拉圣职者"
L["Books"] = "书籍"
L["Trinkets"] = "饰品"
L["Sothos & Jarien"] = "索托斯和亚雷恩"
L["Fel Iron Chest"] = "魔铁宝箱"
L[" (Heroic)"] = "(英雄模式)"
L["Yor (Heroic Summon)"] = "尤尔(英雄模式召唤)"
L["Avatar of the Martyred"] = "殉难者的化身"
L["Anzu the Raven God (Heroic Summon)"] = "安苏，乌鸦之王(英雄模式召唤)"
L["Thomas Yance"] = "托马斯·杨斯"
L["Aged Dalaran Wizard"] = "老迈的达拉然巫师"
L["Cache of the Legion"] = "军团储藏室"
L["Opera (Shared Drops)"] = "剧场(共享掉落)"
L["Timed Chest"] = "限时宝箱"
L["Patterns"] = "图样"

--Rep
L["Token Hand-Ins"] = "上缴物品交换"
L["Items"] = "物品"
L["Beasts Deck"] = "野兽套牌"
L["Elementals Deck"] = "元素套牌"
L["Warlords Deck"] = "督军套牌"
L["Portals Deck"] = "入口套牌"
L["Furies Deck"] = "报复套牌"
L["Storms Deck"] = "风暴套牌"
L["Blessings Deck"] = "祝福套牌"
L["Lunacy Deck"] = "愚人套牌"
L["Quest rewards"] = "任务奖励"
L["Shattrath"] = "沙塔斯城"

--World drop
L["Outdoor Bosses"] = "户外首领"
L["Highlord Kruul"] = "魔王库鲁尔"
L["Bash'ir Landing"] = "巴什伊尔码头"
L["Skyguard Raid"] = "天空卫队团队任务"
L["Stasis Chambers"] = "阿尔法静止间"
L["Skettis"] = "斯克提斯"
L["Darkscreecher Akkarai"] = "黑暗尖啸者阿克卡莱"
L["Karrog"] = "卡尔洛格"
L["Gezzarak the Huntress"] = "猎手吉萨拉克"
L["Vakkiz the Windrager"] = "风怒者瓦克奇斯"
L["Terokk"] = "泰罗克"
L["Ethereum Prison"] = "复仇军监牢"
L["Armbreaker Huffaz"] = "断臂者霍法斯"
L["Fel Tinkerer Zortan"] = "魔能工匠索尔坦"
L["Forgosh"] = "弗尔高什"
L["Gul'bor"] = "古尔博"
L["Malevus the Mad"] = "疯狂的玛尔弗斯"
L["Porfus the Gem Gorger"] = "掘钻者波弗斯"
L["Wrathbringer Laz-tarash"] = "天罚使者拉塔莱什"
L["Abyssal Council"] = "深渊议会"
L["Crimson Templar (Fire)"] = "赤红圣殿骑士(火)"
L["Azure Templar (Water)"] = "碧蓝圣殿骑士(水)"
L["Hoary Templar (Wind)"] = "苍白圣殿骑士(风)"
L["Earthen Templar (Earth)"] = "土色圣殿骑士(地)"
L["The Duke of Cinders (Fire)"] = "灰烬公爵(火)"
L["The Duke of Fathoms (Water)"] = "深渊公爵(水)"
L["The Duke of Zephyrs (Wind)"] = "微风公爵(风)"
L["The Duke of Shards (Earth)"] = "碎石公爵(地)"
L["Elemental Invasion"] = "元素入侵"
L["Gurubashi Arena"] = "古拉巴什竞技场"
L["Booty Run"] = "宝箱争夺战"
L["Fishing Extravaganza"] = "荆棘谷钓鱼大赛"
L["First Prize"] = "第一名奖励"
L["Rare Fish"] = "稀有鱼类"
L["Rare Fish Rewards"] = "稀有鱼类奖励"
L["Children's Week"] = "儿童周"
L["Love is in the air"] = "爱情的气息"
L["Gift of Adoration"] = "爱慕的礼物"
L["Box of Chocolates"] = "一盒巧克力"
L["Hallow's End"] = "万圣节"
L["Various Locations"] = "多个地点"
L["Treat Bag"] = "糖果包"
L["Headless Horseman"] = "无头骑士"
L["Feast of Winter Veil"] = "冬幕节"
L["Smokywood Pastures Vendor"] = "烟林牧场商人"
L["Gaily Wrapped Present"] = "微微震动的礼物"
L["Festive Gift"] = "节日礼物"
L["Winter Veil Gift"] = "冬幕节的礼物"
L["Gently Shaken Gift"] = "精美的礼品"
L["Ticking Present"] = "条纹礼物盒"
L["Carefully Wrapped Present"] = "精心包裹的礼物"
L["Noblegarden"] = "贵族的花园"
L["Brightly Colored Egg"] = "明亮的彩蛋"
L["Smokywood Pastures Extra-Special Gift"] = "烟林牧场的超级特殊礼物"
L["Harvest Festival"] = "收获节"
L["Food"] = "食物"
L["Scourge Invasion"] = "天灾入侵"
L["Miscellaneous"] = "杂项"
L["Cloth Set"] = "布甲套装"
L["Leather Set"] = "皮甲套装"
L["Mail Set"] = "链甲套装"
L["Plate Set"] = "板甲套装"
L["Balzaphon"] = "巴尔萨冯"
L["Lord Blackwood"] = "布莱克伍德公爵"
L["Revanchion"] = "雷瓦克安"
L["Scorn"] = "瑟克恩"
L["Sever"] = "塞沃尔"
L["Lady Falther'ess"] = "法瑟蕾丝夫人"
L["Lunar Festival"] = "新年"
L["Fireworks Pack"] = "春节烟花包"
L["Lucky Red Envelope"] = "红包"
L["Midsummer Fire Festival"] = "仲夏焰火节"
L["Lord Ahune"] = "埃霍恩"
L["Shartuul"] = "沙图尔"
L["Blade Edge Mountains"] = "刀锋山"
L["Brewfest"] = "美酒节"
L["Barleybrew Brewery"] = "美酒节日酒桶"
L["Thunderbrew Brewery"] = "雷酒节日酒桶"
L["Gordok Brewery"] = "戈多克节日酒桶"
L["Drohn's Distillery"] = "德罗恩的节日佳酿酒桶"
L["T'chali's Voodoo Brewery"] = "塔卡里的节日巫毒酒桶"

--craft
L["Crafted Weapons"] = "制作的武器"
L["Master Swordsmith"] = "宗师级铸剑"
L["Master Axesmith"] = "宗师级铸斧"
L["Master Hammersmith"] = "宗师级铸锤"
L["Blacksmithing (Lv 60)"] = "锻造(60级)"
L["Blacksmithing (Lv 70)"] = "锻造(70级)"
L["Engineering (Lv 60)"] = "工程学(60级)"
L["Engineering (Lv 70)"] = "工程学(70级)"
L["Blacksmithing Plate Sets"] = "锻造板甲套装"
L["Imperial Plate"] = "君王板甲"
L["The Darksoul"] = "黑暗之魂"
L["Fel Iron Plate"] = "魔铁板甲"
L["Adamantite Battlegear"] = "精金战甲"
L["Flame Guard"] = "烈焰卫士"
L["Enchanted Adamantite Armor"] = "魔化精金套装"
L["Khorium Ward"] = "氪金套装"
L["Faith in Felsteel"] = "魔钢的信仰"
L["Burning Rage"] = "钢铁之怒"
L["Blacksmithing Mail Sets"] = "锻造链甲套装"
L["Bloodsoul Embrace"] = "血魂的拥抱"
L["Fel Iron Chain"] = "魔铁链甲"
L["Tailoring Sets"] = "裁缝套装"
L["Bloodvine Garb"] = "血藤"
L["Netherweave Vestments"] = "灵纹套装"
L["Imbued Netherweave"] = "魔化灵纹套装"
L["Arcanoweave Vestments"] = "奥法交织套装"
L["The Unyielding"] = "不屈的力量"
L["Whitemend Wisdom"] = "白色治愈"
L["Spellstrike Infusion"] = "法术打击"
L["Battlecast Garb"] = "战斗施法套装"
L["Soulcloth Embrace"] = "灵魂布之拥"
L["Primal Mooncloth"] = "原始月布"
L["Shadow's Embrace"] = "暗影之拥"
L["Wrath of Spellfire"] = "魔焰之怒"
L["Leatherworking Leather Sets"] = "制皮皮甲套装"
L["Volcanic Armor"] = "火山"
L["Ironfeather Armor"] = "铁羽护甲"
L["Stormshroud Armor"] = "雷暴"
L["Devilsaur Armor"] = "魔暴龙护甲"
L["Blood Tiger Harness"] = "血虎"
L["Primal Batskin"] = "原始蝙蝠皮套装"
L["Wild Draenish Armor"] = "野性德莱尼套装"
L["Thick Draenic Armor"] = "厚重德莱尼套装"
L["Fel Skin"] = "魔能之肤"
L["Strength of the Clefthoof"] = "裂蹄之力"
L["Primal Intent"] = "原始打击"
L["Windhawk Armor"] = "风鹰"
L["Leatherworking Mail Sets"] = "制皮链甲套装"
L["Green Dragon Mail"] = "绿龙锁甲"
L["Blue Dragon Mail"] = "蓝龙锁甲"
L["Black Dragon Mail"] = "黑龙锁甲"
L["Scaled Draenic Armor"] = "缀鳞德拉诺套装"
L["Felscale Armor"] = "魔鳞套装"
L["Felstalker Armor"] = "魔能猎手"
L["Fury of the Nether"] = "虚空之怒"
L["Netherscale Armor"] = "虚空之鳞"
L["Netherstrike Armor"] = "虚空打击"
L["Armorsmith"] = "防具锻造"
L["Weaponsmith"] = "武器锻造"
L["Dragonscale"] = "龙鳞"
L["Elemental"] = "元素"
L["Tribal"] = "部族"
L["Mooncloth"] = "月布"
L["Shadoweave"] = "暗纹"
L["Spellfire"] = "魔焰"
L["Gnomish"] = "侏儒"
L["Goblin"] = "地精"
L["Apprentice"] = "初级"
L["Journeyman"] = "中级"
L["Expert"] = "高级"
L["Artisan"] = "专家级"
L["Master"] = "宗师级"

--Set & PVP
L["Superior Rewards"] = "精良奖励"
L["Epic Rewards"] = "史诗奖励"
-- L["Lv 10-19 Rewards"] = "10~19级奖励"
-- L["Lv 20-29 Rewards"] = "20-29级奖励"
-- L["Lv 30-39 Rewards"] = "30-39级奖励"
-- L["Lv 40-49 Rewards"] = "40-49级奖励"
-- L["Lv 50-59 Rewards"] = "50-59级奖励"
-- L["Lv 60 Rewards"] = "60级奖励"
L["Lv %s Rewards"] = "%s级奖励"
L["PVP Cloth Set"] = "PVP布甲套装"
L["PVP Leather Sets"] = "PVP皮甲套装"
L["PVP Mail Sets"] = "PVP链甲套装"
L["PVP Plate Sets"] = "PVP板甲套装"
L["World PVP"] = "世界PVP"
L["Hellfire Fortifications"] = "地狱火半岛的工事"
L["Twin Spire Ruins"] = "双塔废墟"
L["Spirit Towers (Terrokar)"] = "灵魂之塔(泰罗卡森林,白骨荒野)"
L["Halaa (Nagrand)"] = "哈兰(纳格兰)"
-- L["Arena Season 1"] = "竞技场第一季"
-- L["Arena Season 2"] = "竞技场第二季"
-- L["Arena Season 3"] = "竞技场第三季"
-- L["Arena Season 4"] = "竞技场第四季"
L["Arena Season %d"] = "Arena Season %d"
L["Weapons"] = "武器"
L["Accessories"] = "配件"
L["Level 70 Reputation PVP"] = "70级PVP声望装"
L["Level %d Honor PVP"] = "%d级PVP荣誉装"
L["Savage Gladiator\'s Weapons"] = "凶残角斗士的武器"
L["Deadly Gladiator\'s Weapons"] = "致命角斗士的武器"
L["Lake Wintergrasp"] = "Lake Wintergrasp"
L["Non Set Accessories"] = "非套装配件"
L["Non Set Cloth"] = "非套装布甲"
L["Non Set Leather"] = "非套装皮甲"
L["Non Set Mail"] = "非套装链甲"
L["Non Set Plate"] = "非套装板甲"
L["Tier 0.5 Quests"] = "T0.5任务换取"
L["Tier %d Tokens"] = "T%d(换取,遗忘胜利者系列)"
L["Blizzard Collectables"] = "暴雪收藏品"
L["WoW Collector Edition"] = "魔兽世界收藏版"
L["BC Collector Edition (Europe)"] = "燃烧的远征收藏版(欧洲版)"
L["Blizzcon 2005"] = "暴雪嘉年华2005"
L["Blizzcon 2007"] = "暴雪嘉年华2007"
L["Christmas Gift 2006"] = "圣诞礼物2006"
L["Upper Deck"] = "桌面纸牌"
L["Loot Card Items"] = "稀有纸牌物品"
L["Heroic Mode Tokens"] = "公正徽章换取"
L["Fire Resistance Gear"] = "火抗套装"
L["Emblems of Valor"] = "勇气纹章"
L["Emblems of Heroism"] = "英雄纹章"

L["Cloaks"] = "披风"
L["Relics"] = "圣物"
L["World Drops"] = "世界掉落"
L["Level 30-39"] = "30-39级"
L["Level 40-49"] = "40-49级"
L["Level 50-60"] = "50-60级"
L["Level 70"] = "70级"

-- Altoholic.Gathering : Mining
L["Copper Vein"] = "铜矿"
L["Tin Vein"] = "锡矿"
L["Iron Deposit"] = "铁矿石"
L["Silver Vein"] = "银矿"
L["Gold Vein"] = "金矿石"
L["Mithril Deposit"] = "秘银矿脉"
L["Ooze Covered Mithril Deposit"] = "软泥覆盖的秘银矿脉"
L["Truesilver Deposit"] = "真银矿石"
L["Ooze Covered Silver Vein"] = "软泥覆盖的银矿脉"
L["Ooze Covered Gold Vein"] = "软泥覆盖的金矿脉"
L["Ooze Covered Truesilver Deposit"] = "软泥覆盖的真银矿脉"
L["Ooze Covered Rich Thorium Vein"] = "软泥覆盖的富瑟银矿脉"
L["Ooze Covered Thorium Vein"] = "软泥覆盖的瑟银矿脉"
L["Small Thorium Vein"] = "瑟银矿脉"
L["Rich Thorium Vein"] = "富瑟银矿"
L["Hakkari Thorium Vein"] = "哈卡莱瑟银矿脉"
L["Dark Iron Deposit"] = "黑铁矿脉"
L["Lesser Bloodstone Deposit"] = "次级血石矿脉"
L["Incendicite Mineral Vein"] = "火岩矿脉"
L["Indurium Mineral Vein"] = "精铁矿脉"
L["Fel Iron Deposit"] = "魔铁矿脉"
L["Adamantite Deposit"] = "精金矿脉"
L["Rich Adamantite Deposit"] = "富精金矿脉"
L["Khorium Vein"] = "氪金矿脉"
L["Large Obsidian Chunk"] = "大型黑曜石碎块"
L["Small Obsidian Chunk"] = "小型黑曜石碎块"
L["Nethercite Deposit"] = "虚空矿脉"

-- Altoholic.Gathering : Herbalism
L["Peacebloom"] = "宁神花"
L["Silverleaf"] = "银叶草"
L["Earthroot"] = "地根草"
L["Mageroyal"] = "魔皇草"
L["Briarthorn"] = "石南草"
L["Swiftthistle"] = "雨燕草"
L["Stranglekelp"] = "荆棘藻"
L["Bruiseweed"] = "跌打草"
L["Wild Steelbloom"] = "野钢花"
L["Grave Moss"] = "墓地苔"
L["Kingsblood"] = "皇血草"
L["Liferoot"] = "活根草"
L["Fadeleaf"] = "枯叶草"
L["Goldthorn"] = "金棘草"
L["Khadgar's Whisker"] = "卡德加的胡须"
L["Wintersbite"] = "冬刺草"
L["Firebloom"] = "火焰花"
L["Purple Lotus"] = "紫莲花"
L["Wildvine"] = "野葡萄藤"
L["Arthas' Tears"] = "阿尔萨斯之泪"
L["Sungrass"] = "太阳草"
L["Blindweed"] = "盲目草"
L["Ghost Mushroom"] = "幽灵菇"
L["Gromsblood"] = "格罗姆之血"
L["Golden Sansam"] = "黄金参"
L["Dreamfoil"] = "梦叶草"
L["Mountain Silversage"] = "山鼠草"
L["Plaguebloom"] = "瘟疫花"
L["Icecap"] = "冰盖草"
L["Bloodvine"] = "血藤"
L["Black Lotus"] = "黑莲花"
L["Felweed"] = "魔草"
L["Dreaming Glory"] = "梦露花"
L["Terocone"] = "泰罗果"
L["Ancient Lichen"] = "远古苔"
L["Bloodthistle"] = "血蓟"
L["Mana Thistle"] = "法力蓟"
L["Netherbloom"] = "虚空花"
L["Nightmare Vine"] = "噩梦藤"
L["Ragveil"] = "邪雾草"
L["Flame Cap"] = "烈焰菇"
L["Fel Lotus"] = "魔莲花"
L["Netherdust Bush"] = "灵尘灌木丛"
L["Glowcap"] = "亮顶蘑菇"
L["Sanguine Hibiscus"] = "红色木槿"

	
if GetLocale() == "zhCN" then
-- Altoholic.xml local
LEFT_HINT = "左键点击|cFF00FF00打开";
RIGHT_HINT = "右键点击|cFF00FF00拖拽";

XML_ALTO_SHARING_HINT1 = "输入一个账户名称\n仅用作 |cFF00FF00显示|r .\n"
				.. "可任意名称,\n并 |cFF00FF00不需要|r 是真实的账户名称.\n\n"
XML_ALTO_SHARING_HINT2 = "这栏 |cFF00FF00不能|r be 留空."

XML_ALTO_TAB1 = "概要"
XML_ALTO_TAB2 = "人物"
XML_ALTO_TAB3 = "搜索"
-- XML_ALTO_TAB4 = GUILD_BANK
XML_ALTO_TABOPTIONS = "选项"

XML_ALTO_SUMMARY_MENU1 = "账号统计"
XML_ALTO_SUMMARY_MENU2 = "背包用量"
-- XML_ALTO_SUMMARY_MENU3 = SKILLS
XML_ALTO_SUMMARY_MENU4 = "活跃度"
XML_ALTO_SUMMARY_MENU5 = "公会成员"
XML_ALTO_SUMMARY_MENU6 = "公会技能"
XML_ALTO_SUMMARY_MENU7 = "公会银行标签"

XML_ALTO_SUMMARY_TEXT1 = "账户共享请求"
XML_ALTO_SUMMARY_TEXT2 = "点击此按钮来询问玩家\n"
				.. "是否共享整个Altoholic数据库\n"
				.. "并将其添加到自己的数据库"
XML_ALTO_SUMMARY_TEXT3 = "双方都必须启用账户共享\n来使用此功能 (参考选项)"
XML_ALTO_SUMMARY_TEXT4 = "账户共享"

XML_ALTO_CHAR_DD1 = "服务器"
XML_ALTO_CHAR_DD2 = "人物"
XML_ALTO_CHAR_DD3 = "浏览"

XML_ALTO_SEARCH_COL1 = "物品 / 地点"

XML_ALTO_GUILD_TEXT1 = "在提示信息里隐藏这个公会仓库的显示"

XML_ALTO_ACH_NOTSTARTED = "未启动"
XML_ALTO_ACH_STARTED = "已启动"

XML_ALTO_OPT_MENU1 = "一般"
XML_ALTO_OPT_MENU2 = "搜索"
XML_ALTO_OPT_MENU3 = "邮件"
XML_ALTO_OPT_MENU4 = "小地图"
XML_ALTO_OPT_MENU5 = "提示"

XML_TEXT_1 = "总计";
XML_TEXT_2 = "搜索容器";
XML_TEXT_3 = "等级范围";
XML_TEXT_4 = "稀有度";
XML_TEXT_5 = "装备位置";
XML_TEXT_6 = "重置";
XML_TEXT_7 = "搜索";

XML_ALTO_TEXT10 = "账户名称"

XML_ALTO_TEXT11 = "发送账户共享请求到:"

--Options.xml
XML_ALTO_OPT_GENERAL1 = "最大奖励经验显示为150%";
XML_ALTO_OPT_GENERAL2 = "显示FuBar图标";
XML_ALTO_OPT_GENERAL3 = "显示FuBar文字";
XML_ALTO_OPT_GENERAL4 = "启用账号共享";
XML_ALTO_OPT_GENERAL5 = "启用工会交流";
XML_ALTO_OPT_GENERAL6 = "|cFFFFFFFF当 |cFF00FF00启用|cFFFFFFFF时, 这选项允许其他Altoholic用户\n"
				.. "向你发送帐户共享请求.\n\n"     ---注意, 相较与原lua文件有多出个“\n”
				.. "任何时候玩家请求你信息都必须得到你的确认.\n\n"      ----新版多的命令
				.. "当 |cFFFF0000关闭|cFFFFFFFF时, 所有帐户共享请求会被拒.\n\n"
				.. "安全性提示: 只有当您需要实际的数据传输时才启用,\n反之请关闭它"
XML_ALTO_OPT_GENERAL7 = "|cFFFFFFFF当 |cFF00FF00启用|cFFFFFFFF时, 这选项会让你公会的公会成员\n"
				.. "看见你的小号和其专业技能.\n\n"
				.. "当 |cFFFF0000关闭|cFFFFFFFF时, 将不会有任何公会联系."
XML_ALTO_OPT_GENERAL8 = "自动授权公会仓库更新"
XML_ALTO_OPT_GENERAL9 = "|cFFFFFFFF当 |cFF00FF00启用|cFFFFFFFF时, 此选项将允许其他Altoholic用户\n"
				.. "与你的公会仓库资料作自动更新.\n\n"
				.. "当 |cFFFF0000关闭|cFFFFFFFF时, 发送任何信息\n"
				.. "之前将需要您的确认.\n\n"
				.. "安全提示：如果您有公会管理的权利请关闭\n"
				.. "有查看限制的公会金库分页来防止被任何人观看,\n"
				.. "如需要同步时请用手动授权."

XML_ALTO_OPT_SEARCH1 = "自动向服务器查询|cFFFF0000(可能会掉线！)";
XML_ALTO_OPT_SEARCH2 = "|cFFFFFFFF如果一个不在本地缓存中物品\n"
				.. "被在搜索物品时被搜索到，\n"
				.. "Altoholic将会尝试以5个每次的频率向服务器查询。\n\n"
				.. "这将会逐渐的改进搜索的效率，\n"
				.. "因为越来越多的物品将被保存到物品缓存中。\n\n"
				.. "当然，向服务器查询物品时有掉线的风险，\n"
				.. "特别是那些没有被完全推倒的首领！\n\n"
				.. "|cFF00FF00禁用|r以防止发生这类现象。";
XML_ALTO_OPT_SEARCH3 = "拾取按照逆序排列";
XML_ALTO_OPT_SEARCH4 = "包含没有等级要求的物品";
XML_ALTO_OPT_SEARCH5 = "包括邮箱";
XML_ALTO_OPT_SEARCH6 = "包括公会银行";
XML_ALTO_OPT_SEARCH7 = "包括已知配方";

XML_ALTO_OPT_MAIL1 = "在邮件过期前多少天进行警告";
XML_ALTO_OPT_MAIL2 = "邮件过期警告";
XML_ALTO_OPT_MAIL3 = "扫描邮件内容(标记为已读)";
XML_ALTO_OPT_MAIL4 = "新邮件提示";
XML_ALTO_OPT_MAIL5 = "通知我如果有工会成员发送邮件给小号.\n\n"
				.. "邮件内容直接可视而不必联系该角色";

XML_ALTO_OPT_MINIMAP1 = "移动迷你地图图标的角度";
XML_ALTO_OPT_MINIMAP2 = "迷你地图图标角度";
XML_ALTO_OPT_MINIMAP3 = "移动迷你地图图标的半径";
XML_ALTO_OPT_MINIMAP4 = "迷你地图图标半径";
XML_ALTO_OPT_MINIMAP5 = "显示迷你地图图标";

XML_ALTO_OPT_TOOLTIP1 = "显示物品来源";
XML_ALTO_OPT_TOOLTIP2 = "显示每个人物的物品数量";
XML_ALTO_OPT_TOOLTIP3 = "显示物品总计数量";
XML_ALTO_OPT_TOOLTIP4 = "包括公会银行内的物品";
XML_ALTO_OPT_TOOLTIP5 = "包括已学习/可学习：";
XML_ALTO_OPT_TOOLTIP6 = "显示物品ID和物品等级";
XML_ALTO_OPT_TOOLTIP7 = "在采集点上显示数量";
XML_ALTO_OPT_TOOLTIP8 = "显示双方的声望数值";
XML_ALTO_OPT_TOOLTIP9 = "显示所有账户的数值";
XML_ALTO_OPT_TOOLTIP10 = "Include guild bank count in the total count";
end
