local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()

local V = Altoholic.vars
local THIS_ACCOUNT = "Default"
local WHITE		= "|cFFFFFFFF"
local TEAL		= "|cFF00FF9A"
local ORANGE	= "|cFFFF7F00"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

-- local SPELLID_ALCHEMY				= 2259
-- local SPELLID_BLACKSMITHING		= 3100
-- local SPELLID_COOKING				= 2550
-- local SPELLID_ENCHANTING			= 7411
-- local SPELLID_ENGINEERING			= 4036
-- local SPELLID_FIRSTAID				= 3279
-- local SPELLID_JEWELCRAFTING		= 25229
-- local SPELLID_LEATHERWORKING		= 2108
-- local SPELLID_TAILORING				= 3908
-- local SPELLID_INSCRIPTION			= 45357

-- These match the id's of the buttons in TabCharacters.xml
local VIEW_BAGS = 1
local VIEW_TALENTS = 2
local VIEW_MAILS = 3
local VIEW_QUESTS = 4
local VIEW_AUCTIONS = 5
local VIEW_BIDS = 6
local VIEW_COMPANIONS = 7
local VIEW_MOUNTS = 8
local VIEW_REP = 9
local VIEW_EQUIP = 10

local ICON_VIEW_BAGS = "Interface\\Buttons\\Button-Backpack-Up"
local ICON_VIEW_MAILS = "Interface\\Icons\\INV_Misc_Note_01"
local ICON_VIEW_QUESTS = "Interface\\Icons\\INV_Misc_Book_07"
local ICON_VIEW_AUCTIONS = "Interface\\Icons\\INV_Misc_Coin_01"
local ICON_VIEW_BIDS = "Interface\\Icons\\INV_Misc_Coin_03"
local ICON_VIEW_COMPANIONS = "Interface\\Icons\\INV_Box_Birdcage_01"
local ICON_VIEW_MOUNTS = "Interface\\Icons\\Ability_Mount_RidingHorse"
local ICON_VIEW_REP = "Interface\\Icons\\INV_BannerPVP_02"
local ICON_VIEW_EQUIP = "Interface\\Icons\\INV_Chest_Plate04"
local ICON_VIEW_TALENTS = "Interface\\Icons\\Spell_Nature_NatureGuardian"

local CharInfoButtons = {
	"AltoholicTabCharacters_Bags",
	"AltoholicTabCharacters_Talents",
	"AltoholicTabCharacters_Mails",
	"AltoholicTabCharacters_Quests",
	"AltoholicTabCharacters_Auctions",
	"AltoholicTabCharacters_Bids",
	"AltoholicTabCharacters_Pets",
	"AltoholicTabCharacters_Mounts",
	"AltoholicTabCharacters_Factions",
	"AltoholicTabCharacters_Equipment",
}

function AltoholicTabCharacters:Initialize()
	UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectRealm, V.CurrentAccount .."|".. V.CurrentRealm)
	UIDropDownMenu_SetText(AltoholicTabCharacters_SelectRealm, V.CurrentRealm)
	
	UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectChar, UnitName("player"));
	UIDropDownMenu_SetText(AltoholicTabCharacters_SelectChar, UnitName("player"))
	
	UIDropDownMenu_Initialize(AltoholicTabCharacters_SelectRealm, function(self) 
		AltoholicTabCharacters:SelectRealmDropDown_Initialize();
	end)
	
	UIDropDownMenu_Initialize(AltoholicTabCharacters_SelectChar, function(self) 
		AltoholicTabCharacters:SelectCharDropDown_Initialize();
	end)
end

function AltoholicTabCharacters:UpdateViewIcons()
	
	local c = Altoholic:GetCharacterTable()
	
	if not c then
		for k, v in pairs(CharInfoButtons) do
			_G[v]:Hide()
		end
		AltoholicTabCharacters_Cooking:Hide()
		AltoholicTabCharacters_FirstAid:Hide()
		AltoholicTabCharacters_Prof1:Hide()
		AltoholicTabCharacters_Prof2:Hide()
		return
	end
	
	local size = 30
	
	-- ** Bags / Equipment / Quests **
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Bags", ICON_VIEW_BAGS, size, size)
	AltoholicTabCharacters_Bags.text = L["Containers"]
	AltoholicTabCharacters_Bags:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Equipment", ICON_VIEW_EQUIP, size, size)
	AltoholicTabCharacters_Equipment.text = L["Equipment"]
	AltoholicTabCharacters_Equipment:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Quests", ICON_VIEW_QUESTS, size, size)
	AltoholicTabCharacters_Quests.text = L["Quests"]
	AltoholicTabCharacters_Quests:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Talents", ICON_VIEW_TALENTS, size, size)
	AltoholicTabCharacters_Talents.text = TALENTS .. " & " .. GLYPHS
	AltoholicTabCharacters_Talents:Show()
	
	-- ** Auctions / Bids / Mails **
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Auctions", ICON_VIEW_AUCTIONS, size, size)
	if #c.auctions > 0 then
		AltoholicTabCharacters_AuctionsCount:SetText(#c.auctions)
		AltoholicTabCharacters_AuctionsCount:Show()
	else
		AltoholicTabCharacters_AuctionsCount:Hide()
	end
	AltoholicTabCharacters_Auctions.text = format(L["Auctions %s(%d)"], GREEN, #c.auctions)
	AltoholicTabCharacters_Auctions:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Bids", ICON_VIEW_BIDS, size, size)
	if #c.bids > 0 then
		AltoholicTabCharacters_BidsCount:SetText(#c.bids)
		AltoholicTabCharacters_BidsCount:Show()
	else
		AltoholicTabCharacters_BidsCount:Hide()
	end
	AltoholicTabCharacters_Bids.text = format(L["Bids %s(%d)"], GREEN, #c.bids)
	AltoholicTabCharacters_Bids:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Mails", ICON_VIEW_MAILS, size, size)
	local numMails = #c.mail + #c.mailCache
	if numMails > 0 then
		AltoholicTabCharacters_MailsCount:SetText(numMails)
		AltoholicTabCharacters_MailsCount:Show()
	else
		AltoholicTabCharacters_MailsCount:Hide()
	end
	AltoholicTabCharacters_Mails.text = format(L["Mails %s(%d)"], GREEN, numMails)
	AltoholicTabCharacters_Mails:Show()
	
	-- ** Pets / Mounts / Reputations **
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Pets", ICON_VIEW_COMPANIONS, size, size)
	if c.pets["CRITTER"] then
		AltoholicTabCharacters_PetsCount:SetText(#c.pets["CRITTER"])
		AltoholicTabCharacters_PetsCount:Show()
		AltoholicTabCharacters_Pets.text = format(COMPANIONS .. " %s(%d)", GREEN, #c.pets["CRITTER"])
	else
		AltoholicTabCharacters_PetsCount:Hide()
		AltoholicTabCharacters_Pets.text = format(COMPANIONS .. " %s(%d)", GREEN, 0)
	end
	AltoholicTabCharacters_Pets:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Mounts", ICON_VIEW_MOUNTS, size, size)
	if c.pets["MOUNT"] then
		AltoholicTabCharacters_MountsCount:SetText(#c.pets["MOUNT"])
		AltoholicTabCharacters_MountsCount:Show()
		AltoholicTabCharacters_Mounts.text = format(MOUNTS .. " %s(%d)", GREEN, #c.pets["MOUNT"])
	else
		AltoholicTabCharacters_MountsCount:Hide()
		AltoholicTabCharacters_Mounts.text = format(MOUNTS .. " %s(%d)", GREEN, 0)
	end
	AltoholicTabCharacters_Mounts:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Factions", ICON_VIEW_REP, size, size)
	AltoholicTabCharacters_Factions.text = L["Reputations"]
	AltoholicTabCharacters_Factions:Show()
	
	-- ** Professions **
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Cooking", Altoholic:GetSpellIcon(Altoholic.ProfessionSpellID[BI["Cooking"]]), size, size)
	AltoholicTabCharacters_Cooking.text = BI["Cooking"]
	AltoholicTabCharacters_Cooking:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_FirstAid", Altoholic:GetSpellIcon(Altoholic.ProfessionSpellID[BI["First Aid"]]), size, size)
	AltoholicTabCharacters_FirstAid.text = BI["First Aid"]
	AltoholicTabCharacters_FirstAid:Show()
	
	local prof1, prof2 = Altoholic:GetProfessions()

	if prof1 and Altoholic.ProfessionSpellID[prof1] then
		Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Prof1", Altoholic:GetSpellIcon(Altoholic.ProfessionSpellID[prof1]), size, size)
		AltoholicTabCharacters_Prof1.text = prof1
		AltoholicTabCharacters_Prof1:Show()
	else
		AltoholicTabCharacters_Prof1.text = nil
		AltoholicTabCharacters_Prof1:Hide()
	end
	
	if prof2 and Altoholic.ProfessionSpellID[prof2] then
		Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Prof2", Altoholic:GetSpellIcon(Altoholic.ProfessionSpellID[prof2]), size, size)
		AltoholicTabCharacters_Prof2.text = prof2
		AltoholicTabCharacters_Prof2:Show()
	else
		AltoholicTabCharacters_Prof2.text = nil
		AltoholicTabCharacters_Prof2:Hide()
	end
	
end

function AltoholicTabCharacters:ViewIcon_OnClick(self, button)
	AltoholicTabCharacters:StopAutoCastShine()
	AltoholicTabCharacters:StartAutoCastShine(self)
	
	local id = self:GetID()
	if id > 0 then
		AltoholicTabCharacters:ViewCharInfo(id, true)
		return
	end
	
	if self.text then		-- profession button
		AltoholicTabCharacters:ViewCharSkills(self.text)
	end
end

function AltoholicTabCharacters:StartAutoCastShine(button)
	local item = button:GetName()
	AutoCastShine_AutoCastStart(_G[ item .. "Shine" ]);
	self.LastButton = item
end

function AltoholicTabCharacters:StopAutoCastShine()
	-- stop autocast shine on the last button that was clicked
	if self.LastButton then
		AutoCastShine_AutoCastStop(_G[ self.LastButton .. "Shine" ]);
	end
end

function AltoholicTabCharacters:SelectRealmDropDown_Initialize()
	-- this account first ..
	for RealmName, _ in pairs(Altoholic.db.global.data[THIS_ACCOUNT]) do
		AltoholicTabCharacters:AddRealm(RealmName, THIS_ACCOUNT)
	end

	-- .. then all other accounts
	for AccountName, a in pairs(Altoholic.db.global.data) do
		if AccountName ~= THIS_ACCOUNT then
			for RealmName, _ in pairs(a) do
				AltoholicTabCharacters:AddRealm(RealmName, AccountName)
			end
		end
	end
end

function AltoholicTabCharacters:AddRealm(realm, account)
	local info = UIDropDownMenu_CreateInfo(); 

	info.text = GREEN .. account .. ": " .. WHITE.. realm
	info.value = account .."|" .. realm
	info.checked = nil; 
	info.func = function(self)
		local OldAccount = V.CurrentAccount
		local OldRealm = V.CurrentRealm
		V.CurrentAccount, V.CurrentRealm = strsplit("|", self.value)
		UIDropDownMenu_ClearAll(AltoholicTabCharacters_SelectRealm);
		UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectRealm, V.CurrentAccount .."|".. V.CurrentRealm)
		UIDropDownMenu_SetText(AltoholicTabCharacters_SelectRealm, GREEN .. V.CurrentAccount .. ": " .. WHITE.. V.CurrentRealm)
		
		if OldRealm and OldAccount then	-- clear the "select char" drop down if realm or account has changed
			if (OldRealm ~= V.CurrentRealm) or (OldAccount ~= V.CurrentAccount) then
				UIDropDownMenu_ClearAll(AltoholicTabCharacters_SelectChar);
				AltoholicTabCharactersStatus:SetText("")
				V.CurrentAlt = nil
				Altoholic.TradeSkills.CurrentProfession = nil
				Altoholic.Reputations:BuildView()
				
				AltoholicTabCharacters:HideAll()
				AltoholicTabCharacters:StopAutoCastShine()
				AltoholicFrameAchievements:Hide()
				AltoholicTabCharacters:UpdateViewIcons()
			end
		end
	end
	UIDropDownMenu_AddButton(info, 1); 
end

function AltoholicTabCharacters:SelectCharDropDown_Initialize()
	if not V.CurrentAccount or 
		not V.CurrentRealm then return end
	
	local info = UIDropDownMenu_CreateInfo(); 
	local r = Altoholic:GetRealmTable()
	
	for CharacterName, c in pairs(r.char) do
		info.text = CharacterName
		info.value = CharacterName
		info.func = AltoholicTabCharacters.ChangeAlt
		info.checked = nil; 
		UIDropDownMenu_AddButton(info, 1); 
	end
end

function AltoholicTabCharacters:ChangeAlt()
	local OldAlt = V.CurrentAlt
	
	UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectChar, self.value);
	V.CurrentAlt = self.value
	
	AltoholicTabCharacters:UpdateViewIcons()
	if (not OldAlt) or (OldAlt == V.CurrentAlt) then return end

	if (type(V.InfoType) == "string") or
		((type(V.InfoType) == "number") and (V.InfoType > VIEW_MOUNTS)) then		-- true if we're dealing with a profession
		Altoholic.TradeSkills.CurrentProfession = nil
		AltoholicTabCharacters:HideAll()
		AltoholicTabCharacters:StopAutoCastShine()
	else
		AltoholicTabCharacters:ShowCharInfo(V.InfoType)		-- self will show the same info from another alt (ex: containers/mail/ ..)
	end
end

function AltoholicTabCharacters:ViewCharInfo(index, autoCastDone)
	if not index then
		index = self.value
	end
	
	if not autoCastDone then
		AltoholicTabCharacters:StopAutoCastShine()
		AltoholicTabCharacters:StartAutoCastShine(_G[ CharInfoButtons[index] ] )
	end
	
	V.InfoType = index
	AltoholicTabCharacters:HideAll()
	AltoholicTabCharacters:SetMode(index)
	AltoholicTabCharacters:ShowCharInfo(index)
end

function AltoholicTabCharacters:ViewCharSkills(profession)
	local ts = Altoholic.TradeSkills
	ts.CurrentProfession = profession
	
	V.InfoType = profession
	AltoholicTabCharacters:HideAll()
	AltoholicTabCharacters:SetMode()
	
	ts.Recipes:ResetDropDownMenus()
	ts.Recipes:BuildView()
	AltoholicFrameRecipes:Show()
end

function AltoholicTabCharacters:ShowCharInfo(infoType)

	local c = Altoholic:GetCharacterTable()

	if infoType == VIEW_BAGS then
		Altoholic:ClearScrollFrame(_G[ "AltoholicFrameContainersScrollFrame" ], "AltoholicFrameContainersEntry", 7, 41)
		
		AltoholicFrameContainers:SetContainerView(Altoholic.Options:Get("lastContainerView"))
		AltoholicFrameContainers:Show()
		AltoholicFrameContainers:Update()
		
	elseif infoType == VIEW_TALENTS then
		AltoholicFrameTalents:Show()
		Altoholic.Talents:Update();
		
	elseif infoType == VIEW_MAILS then
		AltoholicFrameMail:Show()
		Altoholic.Mail:BuildView()
		Altoholic.Mail:Update()
	elseif infoType == VIEW_QUESTS then
		AltoholicFrameQuests:Show()
		Altoholic.Quests:Update();
	elseif infoType == VIEW_AUCTIONS then
		local ah = Altoholic.AuctionHouse
		ah.AuctionType = "auctions"
		ah.Update = ah.UpdateAuctions
		AltoholicFrameAuctions:Show()
		ah:Update();
	elseif infoType == VIEW_BIDS then
		local ah = Altoholic.AuctionHouse
		ah.AuctionType = "bids"
		ah.Update = ah.UpdateBids
		AltoholicFrameAuctions:Show()
		ah:Update();
	elseif infoType == VIEW_COMPANIONS then
		UIDropDownMenu_SetSelectedValue(AltoholicFramePets_SelectPetView, 1);
		UIDropDownMenu_SetText(AltoholicFramePets_SelectPetView, COMPANIONS)
		AltoholicFramePets:SetType("CRITTER")
		AltoholicFramePetsNormal:Show()
		AltoholicFramePetsAllInOne:Hide()
		AltoholicFramePets:Show()
	elseif infoType == VIEW_MOUNTS then
		UIDropDownMenu_SetSelectedValue(AltoholicFramePets_SelectPetView, 3);
		UIDropDownMenu_SetText(AltoholicFramePets_SelectPetView, MOUNTS)
		AltoholicFramePets:SetType("MOUNT")
		AltoholicFramePetsNormal:Show()
		AltoholicFramePetsAllInOne:Hide()
		AltoholicFramePets:Show()
	elseif infoType == VIEW_REP then
		AltoholicFrameClasses:Show()
		AltoholicFrameReputations:Show()
		Altoholic.Reputations:Update();	
	elseif infoType == VIEW_EQUIP then
		AltoholicFrameClasses:Show()
		AltoholicFrameEquipment:Show()
		Altoholic.Equipment:Update()	
	end
end

function AltoholicTabCharacters:HideAll()
	AltoholicFrameContainers:Hide()
	AltoholicFrameTalents:Hide()
	AltoholicFrameMail:Hide()
	AltoholicFrameQuests:Hide()
	AltoholicFrameAuctions:Hide()
	AltoholicFramePets:Hide()
	AltoholicFrameRecipes:Hide()
	AltoholicFrameReputations:Hide()
	AltoholicFrameEquipment:Hide()
	AltoholicFrameClasses:Hide()
end

function AltoholicTabCharacters:SetMode(mode)
	self.mode = mode
	
	for i = 1, 4 do 
		_G[ "AltoholicTabCharacters_Sort" .. i .. "Arrow"]:Hide()
		_G[ "AltoholicTabCharacters_Sort"..i ].ascendingSort = nil	-- not sorted by default
		_G[ "AltoholicTabCharacters_Sort"..i ]:Hide()
	end
	
	if not mode then return end		-- called without parameter for professions
	
	if mode == VIEW_MAILS then
		AltoholicTabCharacters_Sort1:SetText(MAIL_SUBJECT_LABEL)
		AltoholicTabCharacters_Sort2:SetText(FROM)
		AltoholicTabCharacters_Sort3:SetText(L["Expiry:"])
		
		AltoholicTabCharacters_Sort1:SetWidth(220)
		AltoholicTabCharacters_Sort2:SetWidth(140)
		AltoholicTabCharacters_Sort3:SetWidth(130)

		AltoholicTabCharacters_Sort1:SetScript("OnClick", function(self) 
			AltoholicTabCharacters:SortMails(self, "name") 
		end)
		AltoholicTabCharacters_Sort2:SetScript("OnClick", function(self) 
			AltoholicTabCharacters:SortMails(self, "from") 
		end)
		AltoholicTabCharacters_Sort3:SetScript("OnClick", function(self) 
			AltoholicTabCharacters:SortMails(self, "expiry") 
		end)

		AltoholicTabCharacters_Sort1:Show()
		AltoholicTabCharacters_Sort2:Show()
		AltoholicTabCharacters_Sort3:Show()

	
	elseif mode == VIEW_AUCTIONS then
		AltoholicTabCharacters_Sort1:SetText(HELPFRAME_ITEM_TITLE)
		AltoholicTabCharacters_Sort2:SetText(HIGH_BIDDER)
		AltoholicTabCharacters_Sort3:SetText(CURRENT_BID)
		
		AltoholicTabCharacters_Sort1:SetWidth(220)
		AltoholicTabCharacters_Sort2:SetWidth(160)
		AltoholicTabCharacters_Sort3:SetWidth(170)
		
		AltoholicTabCharacters_Sort1:SetScript("OnClick", function(self) 
			AltoholicTabCharacters:SortAuctions(self, "name") 
		end)
		AltoholicTabCharacters_Sort2:SetScript("OnClick", function(self) 
			AltoholicTabCharacters:SortAuctions(self, "highBidder") 
		end)
		AltoholicTabCharacters_Sort3:SetScript("OnClick", function(self) 
			AltoholicTabCharacters:SortAuctions(self, "buyoutPrice") 
		end)
		
		AltoholicTabCharacters_Sort1:Show()
		AltoholicTabCharacters_Sort2:Show()
		AltoholicTabCharacters_Sort3:Show()
	
	
	elseif mode == VIEW_BIDS then
		AltoholicTabCharacters_Sort1:SetText(HELPFRAME_ITEM_TITLE)
		AltoholicTabCharacters_Sort2:SetText(NAME)
		AltoholicTabCharacters_Sort3:SetText(CURRENT_BID)
		
		AltoholicTabCharacters_Sort1:SetWidth(220)
		AltoholicTabCharacters_Sort2:SetWidth(160)
		AltoholicTabCharacters_Sort3:SetWidth(170)

		AltoholicTabCharacters_Sort1:SetScript("OnClick", function(self) 
			AltoholicTabCharacters:SortBids(self, "name") 
		end)
		AltoholicTabCharacters_Sort2:SetScript("OnClick", function(self) 
			AltoholicTabCharacters:SortBids(self, "owner") 
		end)
		AltoholicTabCharacters_Sort3:SetScript("OnClick", function(self) 
			AltoholicTabCharacters:SortBids(self, "buyoutPrice") 
		end)

		AltoholicTabCharacters_Sort1:Show()
		AltoholicTabCharacters_Sort2:Show()
		AltoholicTabCharacters_Sort3:Show()
	end
end

function AltoholicTabCharacters:SortMails(self, field)

	for i = 1, 4 do 
		_G[ "AltoholicTabCharacters_Sort" .. i .. "Arrow"]:Hide()
	end
	
	local button = _G[ "AltoholicTabCharacters_Sort" .. self:GetID() .. "Arrow"]
	button:Show()
	
	if not self.ascendingSort then
		self.ascendingSort = true
		button:SetTexCoord(0, 0.5625, 1.0, 0);		-- arrow pointing up
	else
		self.ascendingSort = nil
		button:SetTexCoord(0, 0.5625, 0, 1.0);		-- arrow pointing down
	end

	Altoholic.Mail:BuildView(field, self.ascendingSort)
	Altoholic.Mail:Update()
end

function AltoholicTabCharacters:SortAuctions(self, field)

	for i = 1, 4 do 
		_G[ "AltoholicTabCharacters_Sort" .. i .. "Arrow"]:Hide()
	end
	
	local button = _G[ "AltoholicTabCharacters_Sort" .. self:GetID() .. "Arrow"]
	button:Show()
	
	if not self.ascendingSort then
		self.ascendingSort = true
		button:SetTexCoord(0, 0.5625, 1.0, 0);		-- arrow pointing up
	else
		self.ascendingSort = nil
		button:SetTexCoord(0, 0.5625, 0, 1.0);		-- arrow pointing down
	end

	local c = Altoholic:GetCharacterTable()
	
	if field == "name" then
		table.sort(c.auctions, function(a, b)
				local textA = GetItemInfo(a.id)
				local textB = GetItemInfo(b.id)
				
				if self.ascendingSort then
					return textA < textB
				else
					return textA > textB
				end
			end)
	
	elseif field == "highBidder" then
		table.sort(c.auctions, function(a, b)
				local textA, textB

				if a.highBidder then
					textA = a.highBidder
				else
					textA = ""
				end
				
				if b.highBidder then
					textB = b.highBidder
				else
					textB = ""
				end
		
				if self.ascendingSort then
					return textA < textB
				else
					return textA > textB
				end
			end)
	elseif field == "buyoutPrice" then
		table.sort(c.auctions, function(a, b)
				if self.ascendingSort then
					return a.buyoutPrice < b.buyoutPrice
				else
					return a.buyoutPrice > b.buyoutPrice
				end
			end)
	end

	Altoholic.AuctionHouse:UpdateAuctions()
end

function AltoholicTabCharacters:SortBids(self, field)

	for i = 1, 4 do 
		_G[ "AltoholicTabCharacters_Sort" .. i .. "Arrow"]:Hide()
	end
	
	local button = _G[ "AltoholicTabCharacters_Sort" .. self:GetID() .. "Arrow"]
	button:Show()
	
	if not self.ascendingSort then
		self.ascendingSort = true
		button:SetTexCoord(0, 0.5625, 1.0, 0);		-- arrow pointing up
	else
		self.ascendingSort = nil
		button:SetTexCoord(0, 0.5625, 0, 1.0);		-- arrow pointing down
	end

	local c = Altoholic:GetCharacterTable()
	
	if field == "name" then
		table.sort(c.bids, function(a, b)
				local textA = GetItemInfo(a.id)
				local textB = GetItemInfo(b.id)
				
				if self.ascendingSort then
					return textA < textB
				else
					return textA > textB
				end
			end)
	
	elseif field == "owner" then
		table.sort(c.bids, function(a, b)
				if self.ascendingSort then
					return a.owner < b.owner
				else
					return a.owner > b.owner
				end
			end)
	elseif field == "buyoutPrice" then
		table.sort(c.bids, function(a, b)
				if self.ascendingSort then
					return a.buyoutPrice < b.buyoutPrice
				else
					return a.buyoutPrice > b.buyoutPrice
				end
			end)
	end

	Altoholic.AuctionHouse:UpdateBids()
end
