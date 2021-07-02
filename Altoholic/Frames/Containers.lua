local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local V = Altoholic.vars

local GREEN		= "|cFF00FF00"

local BAGSBANK					= 1
local BAGSBANK_ALLINONE		= 2
local BAGSONLY					= 3
local BAGSONLY_ALLINONE		= 4
local BANKONLY					= 5
local BANKONLY_ALLINONE		= 6

Altoholic.Containers = {}

local ContainerViewLabels = {
	L["Bags"] .. " & " .. L["Bank"],
	L["Bags"] .. " & " .. L["Bank"] .. GREEN .. " (" .. L["All-in-one"] .. ")",
	L["Bags"],
	L["Bags"] .. GREEN .. " (" .. L["All-in-one"] .. ")",
	L["Bank"],
	L["Bank"] .. GREEN .. " (" .. L["All-in-one"] .. ")"
}

function AltoholicFrameContainers:Initialize()
	local mode = Altoholic.Options:Get("lastContainerView")
	mode = mode or 1
	
	UIDropDownMenu_SetSelectedValue(AltoholicFrameContainers_SelectContainerView, mode);
	UIDropDownMenu_SetText(AltoholicFrameContainers_SelectContainerView, ContainerViewLabels[mode])
	
	UIDropDownMenu_Initialize(AltoholicFrameContainers_SelectContainerView, function(self) 
		AltoholicFrameContainers:DropDownContainerView_Initialize()
	end)
	
	UIDropDownMenu_SetSelectedValue(AltoholicFrameContainers_SelectRarity, 0);
	UIDropDownMenu_SetText(AltoholicFrameContainers_SelectRarity, L["Any"])

	UIDropDownMenu_Initialize(AltoholicFrameContainers_SelectRarity, function(self) 
		AltoholicFrameContainers:DropDownRarity_Initialize()
	end)
	
	AltoholicFrameContainers:SetContainerView(mode)
end

function AltoholicFrameContainers:DropDownContainerView_Initialize() 
	local info = UIDropDownMenu_CreateInfo(); 
	
	for i = 1, #ContainerViewLabels do
		info.text = ContainerViewLabels[i]
		info.value = i
		info.func = AltoholicFrameContainers.ChangeContainerView
		info.checked = nil; 
		info.icon = nil; 
		UIDropDownMenu_AddButton(info, 1); 
	end
end

function AltoholicFrameContainers:ChangeContainerView()
	UIDropDownMenu_SetSelectedValue(AltoholicFrameContainers_SelectContainerView, self.value);
	
	Altoholic.Options:Set("lastContainerView", self.value)
	AltoholicFrameContainers:SetContainerView(self.value)
	AltoholicFrameContainers:Update();
end

function AltoholicFrameContainers:SetContainerView(view)
	view = view or 1
	if mod(view, 2) ~= 0 then	-- not an all-in-one view
		self.Update = self.UpdateSpread
		self:UpdateContainerCache()
		FauxScrollFrame_SetOffset( AltoholicFrameContainersScrollFrame, 0)
	else
		self.Update = self.UpdateAllInOne
	end
end

function AltoholicFrameContainers:DropDownRarity_Initialize() 
	local info = UIDropDownMenu_CreateInfo(); 
	
	info.text =  L["Any"]
	info.value = 0
	info.func = AltoholicFrameContainers.ChangeRarity
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 
	
	for i = 2, 6 do		-- Quality: 0 = poor .. 5 = legendary
		info.text = ITEM_QUALITY_COLORS[i].hex .. _G["ITEM_QUALITY"..i.."_DESC"]
		info.value = i
		info.func = AltoholicFrameContainers.ChangeRarity
		info.checked = nil; 
		info.icon = nil; 
		UIDropDownMenu_AddButton(info, 1); 
	end
end

function AltoholicFrameContainers:ChangeRarity()
	UIDropDownMenu_SetSelectedValue(AltoholicFrameContainers_SelectRarity, self.value);
	AltoholicFrameContainers:Update();
end

function AltoholicFrameContainers:UpdateContainerCache()
	local mode = UIDropDownMenu_GetSelectedValue(AltoholicFrameContainers_SelectContainerView)
	local c = Altoholic:GetCharacterTable()
	
	self.BagIndices = self.BagIndices or {}

	if #self.BagIndices > 0 then
		Altoholic:ClearTable(self.BagIndices)
	end
	
	local bagMin = 0
	local bagMax = 11
	
	-- bags : -2 (keyring) and 0 to 4
	-- bank: 5 to 11 and 100
	if mode == BAGSONLY then
		bagMax = 4			-- 0 to 4
	elseif mode == BANKONLY then
		bagMin = 5			-- 5 to 11
	end
	
	for bagID = bagMin, bagMax do
		if c.bag["Bag"..bagID] ~= nil then 
			self:UpdateBagIndices(bagID, c.bag["Bag"..bagID].size)
		end
	end
	
	if mode ~= BANKONLY then
		self:UpdateBagIndices(-2, 32)		-- KeyRing
	end
	
	if mode ~= BAGSONLY then
		if c.bag["Bag100"] ~= nil then 	-- if bank hasn't been visited yet, exit
			self:UpdateBagIndices(100, 28)
		end
	end
end

function AltoholicFrameContainers:UpdateBagIndices(bag, size)
	-- the BagIndices table will be used by self:Containers_Update to determine which part of a bag should be displayed on a given line
	-- ex: [1] = bagID = 0, from 1, to 12
	-- ex: [2] = bagID = 0, from 13, to 16

	local lowerLimit = 1

	while size > 0 do					-- as long as there are slots to process ..
		table.insert(self.BagIndices, { bagID=bag, from=lowerLimit} )
	
		if size <= 12 then			-- no more lines ? leave
			return
		else
			size = size - 12			-- .. or adjust counters
			lowerLimit = lowerLimit + 12
		end
	end
end

function AltoholicFrameContainers:UpdateSpread()
	local mode = UIDropDownMenu_GetSelectedValue(AltoholicFrameContainers_SelectContainerView)
	local rarity = UIDropDownMenu_GetSelectedValue(AltoholicFrameContainers_SelectRarity)
	local VisibleLines = 7
	local frame = "AltoholicFrameContainers"
	local entry = frame.."Entry"
	
	if #self.BagIndices == 0 then
		self:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 41)
		return
	end

	AltoholicTabCharactersStatus:SetText("")
	
	local c = Altoholic:GetCharacterTable()
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	
	for i=1, VisibleLines do
		local line = i + offset
		
		if line <= #self.BagIndices then
		
			local b = c.bag["Bag" .. self.BagIndices[line].bagID]
			
			local itemName = entry..i .. "Item1";
			if self.BagIndices[line].from == 1 then		-- if this is the first line for this bag .. draw bag icon
				local itemButton = _G[itemName];	
				if b.icon ~= nil then
					Altoholic:SetItemButtonTexture(itemName, b.icon);
				else		-- will be nill for bag 100
					Altoholic:SetItemButtonTexture(itemName, "Interface\\Icons\\INV_Box_03");
				end
							
				itemButton:SetID(self.BagIndices[line].bagID)

				itemButton:SetScript("OnEnter", function(self)
					local id = self:GetID()
					GameTooltip:SetOwner(self, "ANCHOR_LEFT");
					if id == -2 then
						GameTooltip:AddLine(KEYRING,1,1,1);
						GameTooltip:AddLine(L["32 Keys Max"],1,1,1);
					elseif id == 0 then
						GameTooltip:AddLine(BACKPACK_TOOLTIP,1,1,1);
						GameTooltip:AddLine(format(CONTAINER_SLOTS, 16, BAGSLOT),1,1,1);
						
					elseif id == 100 then
						GameTooltip:AddLine(L["Bank"],0.5,0.5,1);
						GameTooltip:AddLine(L["28 Slot"],1,1,1);
					else
						local r = Altoholic:GetRealmTable()
						GameTooltip:SetHyperlink( r.char[V.CurrentAlt].bag["Bag" .. id].link );
						if (id >= 5) and (id <= 11) then
							GameTooltip:AddLine(L["Bank bag"],0,1,0);
						end
					end
					GameTooltip:Show();
				end)
				_G[itemName .. "Count"]:Hide()
				
				_G[ itemName ]:Show()
			else
				_G[ itemName ]:Hide()
			end
			
			_G[ entry..i .. "Item2" ]:Hide()
			_G[ entry..i .. "Item2" ].id = nil
			_G[ entry..i .. "Item2" ].link = nil
			
			for j=3, 14 do
				local itemName = entry..i .. "Item" .. j;
				local itemButton = _G[itemName];
				local itemTexture = _G[itemName.."IconTexture"]
						
				Altoholic:CreateButtonBorder(itemButton)
				itemButton.border:Hide()
				itemTexture:SetDesaturated(0)
				
				local itemIndex = self.BagIndices[line].from - 3 + j
				
				if (itemIndex <= b.size) then 
					if b.ids[itemIndex] ~= nil then
						Altoholic:SetItemButtonTexture(itemName, GetItemIcon(b.ids[itemIndex]));
						
						if rarity ~= 0 then
							local _, _, itemRarity = GetItemInfo(b.ids[itemIndex])
							if itemRarity and itemRarity == rarity then
								local r, g, b = GetItemQualityColor(itemRarity)
								itemButton.border:SetVertexColor(r, g, b, 0.5)
								itemButton.border:Show()
							else
								itemTexture:SetDesaturated(1)
							end
						end
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
					
					local itemCooldown = _G[itemName .. "Cooldown"]
					local startTime = 0
					local duration = 0
					local	isEnabled = 0
					
					if b.cooldowns[itemIndex] then
						startTime, duration, isEnabled = strsplit("|", b.cooldowns[itemIndex])
						startTime = tonumber(startTime)
						duration = tonumber(duration)
						isEnabled = tonumber(isEnabled)
						
						local remaining = duration - (GetTime() - startTime)
						if remaining <= 0 then
							b.cooldowns[itemIndex] = nil
							startTime = 0
							duration = 0
							isEnabled = 0
						else
							itemButton.startTime = startTime
							itemButton.duration = duration
						end
					else
						itemButton.startTime = nil
						itemButton.duration = nil
					end
					
					CooldownFrame_SetTimer(itemCooldown, startTime, duration, isEnabled)
				
					itemButton:Show()
				else
					_G[ itemName ]:Hide()
					itemButton.id = nil
					itemButton.link = nil
					itemButton.startTime = nil
					itemButton.duration = nil
				end
			end
			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end
	
	if #self.BagIndices < VisibleLines then
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleLines, VisibleLines, 41);
	else
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], #self.BagIndices, VisibleLines, 41);
	end	
end	

function AltoholicFrameContainers:UpdateAllInOne()

	local mode = UIDropDownMenu_GetSelectedValue(AltoholicFrameContainers_SelectContainerView)
	local rarity = UIDropDownMenu_GetSelectedValue(AltoholicFrameContainers_SelectRarity)
	local VisibleLines = 7
	local frame = "AltoholicFrameContainers"
	local entry = frame.."Entry"
	
	AltoholicTabCharactersStatus:SetText("")
	
	local c = Altoholic:GetCharacterTable()
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	
	local minSlotIndex = offset * 14
	local currentSlotIndex = 0		-- this indexes the non-empty slots
	local i = 1
	local j = 1
	
	for BagName, b in pairs (c.bag) do
		local HideThisBag
		
		-- bags : -2 (keyring) and 0 to 4
		-- bank: 5 to 11 and 100
		if mode == BAGSONLY_ALLINONE then
			local bagNum = tonumber(string.sub(BagName, 4))
			if bagNum > 4 then
				HideThisBag = true
			end
		elseif mode == BANKONLY_ALLINONE then
			local bagNum = tonumber(string.sub(BagName, 4))
			if bagNum < 5 then
				HideThisBag = true
			end
		end
		
		if not HideThisBag then
			for k, itemID in pairs (b.ids) do
				currentSlotIndex = currentSlotIndex + 1
				if (currentSlotIndex > minSlotIndex) and (i <= VisibleLines) then
					local itemName = entry..i .. "Item" .. j;
					local itemButton = _G[itemName];
					local itemTexture = _G[itemName.."IconTexture"]
					
					Altoholic:CreateButtonBorder(itemButton)
					itemButton.border:Hide()
					
					Altoholic:SetItemButtonTexture(itemName, GetItemIcon(itemID));
					itemTexture:SetDesaturated(0)
					
					if rarity ~= 0 then
						local _, _, itemRarity = GetItemInfo(itemID)
						if itemRarity and itemRarity == rarity then
							local r, g, b = GetItemQualityColor(itemRarity)
							itemButton.border:SetVertexColor(r, g, b, 0.5)
							itemButton.border:Show()
						else
							itemTexture:SetDesaturated(1)
						end
					end
					
					itemButton.id = itemID
					itemButton.link = b.links[k]
					itemButton:SetScript("OnEnter", function(self) 
							Altoholic:Item_OnEnter(self)
						end)
				
					local itemCount = _G[itemName .. "Count"]
					if (b.counts[k] == nil) or (b.counts[k] < 2)then
						itemCount:Hide();
					else
						itemCount:SetText(b.counts[k]);
						itemCount:Show();
					end
					
					local itemCooldown = _G[itemName .. "Cooldown"]
					local startTime = 0
					local duration = 0
					local	isEnabled = 0
					
					if b.cooldowns[k] then
						startTime, duration, isEnabled = strsplit("|", b.cooldowns[k])
						startTime = tonumber(startTime)
						duration = tonumber(duration)
						isEnabled = tonumber(isEnabled)
						
						local remaining = duration - (GetTime() - startTime)
						if remaining <= 0 then
							b.cooldowns[k] = nil
							startTime = 0
							duration = 0
							isEnabled = 0
						else
							itemButton.startTime = startTime
							itemButton.duration = duration
						end
					else
						itemButton.startTime = nil
						itemButton.duration = nil
					end
					
					CooldownFrame_SetTimer(itemCooldown, startTime, duration, isEnabled)

			
					_G[ itemName ]:Show()
					
					j = j + 1
					if j > 14 then
						j = 1
						i = i + 1
					end
				end
			end
		end
	end
	
	while i <= VisibleLines do
		while j <= 14 do
			_G[ entry..i .. "Item" .. j ]:Hide()
			_G[ entry..i .. "Item" .. j ].id = nil
			_G[ entry..i .. "Item" .. j ].link = nil
			_G[ entry..i .. "Item" .. j ].startTime = nil
			_G[ entry..i .. "Item" .. j ].duration = nil
			j = j + 1
		end
	
		j = 1
		i = i + 1
	end
	
	for i=1, VisibleLines do
		_G[ entry..i ]:Show()
	end

	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], ceil(currentSlotIndex / 14), VisibleLines, 41);
end

function Altoholic:Item_OnEnter(frame)
	if not frame.id then return end
	
	GameTooltip:SetOwner(frame, "ANCHOR_LEFT");
	
	if not frame.link then								-- if there's no full item link .. get it
		frame.link = select(2, GetItemInfo(frame.id) )
	end
	if not frame.link then	-- still not valid ?
		GameTooltip:AddLine(L["Unknown link, please relog this character"],1,1,1);
	else
		GameTooltip:SetHyperlink(frame.link);
	end
	GameTooltip:Show();
end

function Altoholic:Item_OnClick(frame, button)
	if not frame.id then return end
	
	if not frame.link then
		frame.link = select(2, GetItemInfo(frame.id) )
	end
	if not frame.link then return end		-- still not valid ? exit
	
	if ( button == "LeftButton" ) and ( IsControlKeyDown() ) then
		DressUpItemLink(frame.link);
	elseif ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		if ( ChatFrameEditBox:IsShown() ) then
			ChatFrameEditBox:Insert(frame.link);
		else
			AltoholicFrame_SearchEditBox:SetText(GetItemInfo(frame.link))
		end
	end
end

-- *** Scanning functions ***

function Altoholic.Containers:Scan(bagID)
	local c = Altoholic.ThisCharacter
	local b = c.bag["Bag" .. bagID]

	for slotID = 1, b.size do
		b.ids[slotID] = nil
		b.counts[slotID] = nil
		b.links[slotID] = nil
		b.cooldowns[slotID] = nil
		
		local link = GetContainerItemLink(bagID, slotID)
		if link ~= nil then
			b.ids[slotID] = Altoholic:GetIDFromLink(link)
		
			-- if any of these differs from 0, there's an enchant or a jewel, so save the full link
			if Altoholic:GetEnchantInfo(link) then		-- 1st return value = isEnchanted
				b.links[slotID] = link
			end
		
			local _, count = GetContainerItemInfo(bagID, slotID)
			if (count ~= nil) and (count > 1)  then
				b.counts[slotID] = count	-- only save the count if it's > 1 (to save some space since a count of 1 is extremely redundant)
			end
		end
		
		local startTime, duration, isEnabled = GetContainerItemCooldown(bagID, slotID)
		if startTime and startTime > 0 then
			b.cooldowns[slotID] = startTime .."|".. duration .. "|" .. 1
		end
	end
end

function Altoholic.Containers:ScanBag(bagID)
	if bagID < 0 then return end

	local c = Altoholic.ThisCharacter
	local b = c.bag["Bag" .. bagID]
	
	if bagID == 0 then	-- Bag 0	
		b.icon = "Interface\\Buttons\\Button-Backpack-Up";
		b.link = nil;
	else						-- Bags 1 through 11
		b.icon = GetInventoryItemTexture("player", ContainerIDToInventoryID(bagID))
		b.link = GetInventoryItemLink("player", ContainerIDToInventoryID(bagID))
	end
	b.freeslots, b.bagtype = GetContainerNumFreeSlots(bagID)
	b.size = GetContainerNumSlots(bagID)
	self:Scan(bagID)
end

function Altoholic.Containers:ScanKeyRing()
	local c = Altoholic.ThisCharacter
	local b = c.bag["Bag-2"]
	
	b.size = GetContainerNumSlots(-2)
	b.icon = "Interface\\Icons\\INV_Misc_Key_14";
	b.link = nil
	self:Scan(-2)
end

function Altoholic.Containers:ScanPlayerBags()
	for bagID = 0, 4 do
		self:ScanBag(bagID)
	end
	self:ScanKeyRing()
	self:ScanBagSlotsInfo()
end

function Altoholic.Containers:ScanBank()
	local c = Altoholic.ThisCharacter
	local b = c.bag["Bag100"]
	b.size = 28
	b.freeslots, b.bagtype = GetContainerNumFreeSlots(-1)		-- -1 = player bank
	
	for slotID = 40, 67 do
		local index = slotID-39		-- 28 bank slots = inventory slot id 40 to 67, so subtract 39
		b.ids[index] = nil
		b.counts[index] = nil
		b.links[index] = nil		
		b.cooldowns[index] = nil		
		
		local link = GetInventoryItemLink("player", slotID)	
		if link ~= nil then
			b.ids[index] = Altoholic:GetIDFromLink(link)
			
			-- if any of these differs from 0, there's an enchant or a jewel, so save the full link
			if Altoholic:GetEnchantInfo(link) then		-- 1st return value = isEnchanted
				b.links[index] = link
			end
			
			local count = GetInventoryItemCount("player", slotID)
			if (count ~= nil) and (count > 1)  then
				b.counts[index] = count	-- only save the count if it's > 1 (to save some space since a count of 1 is extremely redundant)
			end
			
			local startTime, duration, isEnabled = GetInventoryItemCooldown("player", slotID)
			if startTime and startTime > 0 then
				b.cooldowns[index] = startTime .."|".. duration .. "|" .. 1
			end
		end
	end
	
	self:ScanBankSlotsInfo()
end

function Altoholic.Containers:ScanBagSlotsInfo()
	local c = Altoholic.ThisCharacter
	
	c.numBagSlots = 0
	c.numFreeBagSlots = 0

	for bagID = 0, 4 do
		local b = c.bag["Bag" .. bagID]
		c.numBagSlots = c.numBagSlots + b.size
		c.numFreeBagSlots = c.numFreeBagSlots + b.freeslots
	end
end

function Altoholic.Containers:ScanBankSlotsInfo()
	local c = Altoholic.ThisCharacter
	
	c.numBankSlots = 28
	c.numFreeBankSlots = c.bag["Bag100"].freeslots

	for bagID = 5, 11 do
		local b = c.bag["Bag" .. bagID]
		c.numBankSlots = c.numBankSlots + b.size
		c.numFreeBankSlots = c.numFreeBankSlots + b.freeslots
	end
end

function Altoholic.Containers:GetItemCount(searchedID)
	local c = Altoholic.CountCharacter
	local bagCount = 0
	local bankCount = 0
	
	for BagName, b in pairs(c.bag) do
		for slotID=1, b.size do
			local id = b.ids[slotID]
			
			if (id) and (id == searchedID) then
				local itemCount = b.counts[slotID] or 1
				
				if (BagName == "Bag100") then
					bankCount = bankCount + itemCount
				elseif (BagName == "Bag-2") then
					bagCount = bagCount + itemCount
				else
					local bagNum = tonumber(string.sub(BagName, 4))
					if (bagNum >= 0) and (bagNum <= 4) then
						bagCount = bagCount + itemCount
					else
						bankCount = bankCount + itemCount
					end			
				end		
			end
		end
	end
	
	return bagCount, bankCount
end


-- *** EVENT HANDLERS ***

function Altoholic.Containers:OnBagUpdate(bag)
	if bag < 0 then
		return
	end
	
	V.ToolTipCachedItemID = nil		-- putting this at NIL will force a tooltip refresh in self:ProcessToolTip
	
	local self = Altoholic.Containers
	if (bag >= 5) and (bag <= 11) and not self.isBankOpen then
		return
	end
	
	if Altoholic.Mail.isOpen then	-- if a bag is updated while the mailbox is opened, this means an attachment has been taken.
		Altoholic.Mail:Scan()		-- I could not hook TakeInboxItem because mailbox content is not updated yet
	end
	
	if bag == 0 then					-- bag is 0 for both the keyring and the original backpack
		self:ScanKeyRing()
	end
	self:ScanBag(bag)
end

function Altoholic.Containers:OnBankOpened()
	local self = Altoholic.Containers
	for bagID = 5, 11 do
		self:ScanBag(bagID)
	end
	self:ScanBank()
	self.isBankOpen = true
	Altoholic:RegisterEvent("BANKFRAME_CLOSED", self.OnBankClosed)
	Altoholic:RegisterEvent("PLAYERBANKSLOTS_CHANGED", self.OnBankSlotsChanged)
end

function Altoholic.Containers:OnBankClosed()
	Altoholic.Containers.isBankOpen = nil
	Altoholic:UnregisterEvent("BANKFRAME_CLOSED")
	Altoholic:UnregisterEvent("PLAYERBANKSLOTS_CHANGED")
end

function Altoholic.Containers:OnBankSlotsChanged(slotID)
	local self = Altoholic.Containers
	-- from top left to bottom right, slotID = 1 to 28for main slots, and 29 to 35 for the additional bags
	if (slotID >= 29) and (slotID <= 35) then
		self:ScanBag(slotID - 24)		-- bagID for bank bags goes from 5 to 11, so slotID - 24
	else
		self:ScanBank()
	end
end
