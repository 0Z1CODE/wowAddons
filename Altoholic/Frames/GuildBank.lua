local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

Altoholic.GuildBank = {}

function Altoholic.GuildBank:DrawTab(tabID)

	local selectedGuild = UIDropDownMenu_GetSelectedValue(AltoholicTabGuildBank_SelectGuild)
	if not selectedGuild then return end		-- not defined yet ? exit.

	if not AltoGuildBank:IsVisible() then
		AltoGuildBank:Show()
	end
	
	local faction, realm, guildName = strsplit("|", selectedGuild)
	local guild	= Altoholic.db.global.data[faction][realm].guild[guildName]
	
	if not tabID then		
		-- will be nil when clicking on the guild bank tab for the first time, so find the first available one
		-- called in OnShow (tabguildbank.xml)
		for i=1, 6 do
			if guild.bank[i].name then
				tabID = i
				
				for i=1, 6 do 
					_G[ "AltoholicTabGuildBankMenuItem"..i ]:UnlockHighlight();
				end
				_G[ "AltoholicTabGuildBankMenuItem"..tabID ]:LockHighlight();
				break
			end
		end
	end
	
	if not tabID then return end	-- no tab found ? exit
	
	local b = guild.bank[tabID]
	if not b.name then return end	-- tab not yet scanned ? exit
	
	local entry = "GuildBankEntry"
	
	AltoholicTabGuildBankInfo1:SetText(format(L["Last visit: %s by %s"], GREEN..b.ClientDate..WHITE, GREEN..b.visitedBy))
	local localTime, realmTime
	localTime = format("%s%02d%s:%s%02d", GREEN, b.ClientHour, WHITE, GREEN, b.ClientMinute )
	realmTime = format("%s%02d%s:%s%02d", GREEN, b.ServerHour, WHITE, GREEN, b.ServerMinute )
	AltoholicTabGuildBankInfo2:SetText(format(L["Local Time: %s   %sRealm Time: %s"], localTime, WHITE, realmTime))
	
	for i=1, 7 do
	
		local from = mod(i, 7)
		if from == 0 then from = 7 end
	
		for j=14, 1, -1 do
			local itemName = entry..i .. "Item" .. j;
			local itemButton = _G[itemName];
			
			local itemIndex = from + ((j - 1) * 7)
			if b.ids[itemIndex] ~= nil then
				Altoholic:SetItemButtonTexture(itemName, GetItemIcon(b.ids[itemIndex]));
			else
				Altoholic:SetItemButtonTexture(itemName, "Interface\\PaperDoll\\UI-Backpack-EmptySlot");
			end
			
			itemButton.id = b.ids[itemIndex]
			itemButton.link = b.links[itemIndex]
				itemButton:SetScript("OnEnter", function(self) 
						Altoholic:Item_OnEnter(self)
					end)
			
			local itemCount = _G[itemName .. "Count"]
			if (b.counts[itemIndex] == nil) or (b.counts[itemIndex] < 2)then
				itemCount:Hide();
			else
				itemCount:SetText(b.counts[itemIndex]);
				itemCount:Show();
			end
		
			_G[ itemName ]:Show()
		end
		_G[ entry..i ]:Show()
	end
end

function Altoholic.GuildBank:Scan()
	-- only the current tab can be updated
	local guild = Altoholic:GetThisGuild()
	local tabID = GetCurrentGuildBankTab()
	local t = guild.bank[tabID]						-- t = current tab
	
	local bUpdateUI
	if not t.name then		-- if the guild tab isn't known yet, request a UI update after the scan
		bUpdateUI = true		
	end
	
	guild.bankmoney = GetGuildBankMoney()
	guild.faction = UnitFactionGroup("player")
	t.name = GetGuildBankTabInfo(tabID)
	t.visitedBy = UnitName("player")
	t.ClientTime = time()
	if GetLocale() == "enUS" then				-- adjust this test if there's demand
		t.ClientDate = date("%m/%d/%Y")
	else
		t.ClientDate = date("%d/%m/%Y")
	end
	t.ClientHour = tonumber(date("%H"))
	t.ClientMinute = tonumber(date("%M"))
	t.ServerHour, t.ServerMinute = GetGameTime()
	
	for slotID = 1, 98 do
		t.ids[slotID] = nil
		t.counts[slotID] = nil
		t.links[slotID] = nil
		
		local link = GetGuildBankItemLink(tabID, slotID)
		if link ~= nil then
			t.ids[slotID] = Altoholic:GetIDFromLink(link)

			-- if any of these differs from 0, there's an enchant or a jewel, so save the full link
			if Altoholic:GetEnchantInfo(link) then		-- 1st return value = isEnchanted
				t.links[slotID] = link
			end
			
			local _, count = GetGuildBankItemInfo(tabID, slotID)
			if (count ~= nil) and (count > 1)  then
				t.counts[slotID] = count	-- only save the count if it's > 1 (to save some space since a count of 1 is extremely redundant)
			end
		end
	end
	
	if not bUpdateUI then return end
	
	for i = 1, 6 do
		_G[ "AltoholicTabGuildBankMenuItem"..i ]:UnlockHighlight();
		t = guild.bank[i]
		if t.name then
			_G[ "AltoholicTabGuildBankMenuItem" .. i ]:SetText(WHITE .. t.name)
		else
			_G[ "AltoholicTabGuildBankMenuItem" .. i ]:SetText(YELLOW .. L["N/A"])
		end
		_G[ "AltoholicTabGuildBankMenuItem" .. i ]:Show()
	end
end

-- *** EVENT HANDLERS ***

function Altoholic.GuildBank:OnOpen()
	Altoholic:RegisterEvent("GUILDBANKFRAME_CLOSED", Altoholic.GuildBank.OnClose)
	Altoholic:RegisterEvent("GUILDBANKBAGSLOTS_CHANGED", Altoholic.GuildBank.Scan)
end

function Altoholic.GuildBank:OnClose()
	Altoholic:UnregisterEvent("GUILDBANKFRAME_CLOSED")
	Altoholic:UnregisterEvent("GUILDBANKBAGSLOTS_CHANGED")
	
	local g = Altoholic:GetThisGuild()
	
	for k, v in ipairs(g.bank) do
		Altoholic.Comm.Guild:Broadcast(14, {		-- MSG_GUILD_BANKUPDATEINFO = 14
					name = v.name,
					ClientDate = v.ClientDate,
					ClientHour = v.ClientHour,
					ClientMinute = v.ClientMinute,
					ServerHour = v.ServerHour,
					ServerMinute = v.ServerMinute
				})
	end
end
