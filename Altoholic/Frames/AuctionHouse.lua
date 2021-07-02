local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local V = Altoholic.vars

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local ORANGE	= "|cFFFF7F00"
local RED		= "|cFFFF0000"
local TEAL		= "|cFF00FF9A"

Altoholic.AuctionHouse = {}

function Altoholic.AuctionHouse:UpdateAuctions()
	local c = Altoholic:GetCharacterTable()
	local VisibleLines = 7
	local frame = "AltoholicFrameAuctions"
	local entry = frame.."Entry"

	local player = V.CurrentAlt
	
	if c.AHCheckClientDate then
		-- new timestamps
		local localDate = format(L["Last visit: %s by %s"], GREEN..c.AHCheckClientDate..WHITE, GREEN..player)
		local localTime = format("%s%02d%s:%s%02d", GREEN, c.AHCheckClientHour, WHITE, GREEN, c.AHCheckClientMinute )
		AltoholicFrameAuctionsInfo1:SetText(localDate .. WHITE .. " @ " .. localTime)
		AltoholicFrameAuctionsInfo1:Show()
		
		if #c.auctions == 0 then
			AltoholicTabCharactersStatus:SetText(format(L["%s has no auctions"], player))
			Altoholic:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 41)
			return
		end
		AltoholicTabCharactersStatus:SetText("")

	else
		AltoholicFrameAuctionsInfo1:Hide()

		if #c.auctions == 0 then
			AltoholicTabCharactersStatus:SetText(format(L["%s has no auctions"], player))
			Altoholic:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 41)
			return
		else
			AltoholicTabCharactersStatus:SetText(AUCTIONS .. ": " .. player
					.. ", " .. L["last check "] .. Altoholic:GetDelayInDays(c.lastAHcheck).. L[" days ago"])
		end
	end

	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	
	for i=1, VisibleLines do
		local line = i + offset
		if line <= #c.auctions then
			local s = c.auctions[line]
			
			local itemName, _, itemRarity = GetItemInfo(s.id)
			_G[ entry..i.."Name" ]:SetText(select(4, GetItemQualityColor(itemRarity)) .. itemName)
			
			if not s.timeLeft then	-- secure this in case it is nil (may happen when other auction monitoring addons are present)
				s.timeLeft = 1
			elseif (s.timeLeft < 1) or (s.timeLeft > 4) then
				s.timeLeft = 1
			end
			
			_G[ entry..i.."TimeLeft" ]:SetText( TEAL .. _G["AUCTION_TIME_LEFT"..s.timeLeft] 
								.. " (" .. _G["AUCTION_TIME_LEFT"..s.timeLeft .. "_DETAIL"] .. ")")

			local bidder
			if s.AHLocation then
				bidder = L["Goblin AH"] .. "\n"
			else
				bidder = ""
			end
			
			if s.highBidder then
				bidder = bidder .. WHITE .. s.highBidder
			else
				bidder = bidder .. RED .. NO_BIDS
			end
			_G[ entry..i.."HighBidder" ]:SetText(bidder)
			
			_G[ entry..i.."Price" ]:SetText(Altoholic:GetMoneyString(s.startPrice) .. "\n"  
					.. GREEN .. BUYOUT .. ": " ..  Altoholic:GetMoneyString(s.buyoutPrice))
			_G[ entry..i.."ItemIconTexture" ]:SetTexture(GetItemIcon(s.id));
			if (s.count ~= nil) and (s.count > 1) then
				_G[ entry..i.."ItemCount" ]:SetText(s.count)
				_G[ entry..i.."ItemCount" ]:Show()
			else
				_G[ entry..i.."ItemCount" ]:Hide()
			end

			_G[ entry..i.."Item" ]:SetID(line)
			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end
	
	if #c.auctions < VisibleLines then
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleLines, VisibleLines, 41);
	else
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], #c.auctions, VisibleLines, 41);
	end
end

function Altoholic.AuctionHouse:UpdateBids()
	local c = Altoholic:GetCharacterTable()
	local VisibleLines = 7
	local frame = "AltoholicFrameAuctions"
	local entry = frame.."Entry"
	
	local player = V.CurrentAlt
	
	if c.AHCheckClientDate then
		-- new timestamps
		local localDate = format(L["Last visit: %s by %s"], GREEN..c.AHCheckClientDate..WHITE, GREEN..player)
		local localTime = format("%s%02d%s:%s%02d", GREEN, c.AHCheckClientHour, WHITE, GREEN, c.AHCheckClientMinute )
		AltoholicFrameAuctionsInfo1:SetText(localDate .. WHITE .. " @ " .. localTime)
		AltoholicFrameAuctionsInfo1:Show()
		AltoholicTabCharactersStatus:SetText("")
		
		if #c.bids == 0 then
			AltoholicTabCharactersStatus:SetText(format(L["%s has no bids"], player))
			Altoholic:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 41)
			return
		end

	else
		AltoholicFrameAuctionsInfo1:Hide()
	
		if #c.bids == 0 then
			AltoholicTabCharactersStatus:SetText(format(L["%s has no bids"], player))
			Altoholic:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 41)
			return
		else
			AltoholicTabCharactersStatus:SetText(BIDS .. ": " .. player
				.. ", " .. L["last check "] .. Altoholic:GetDelayInDays(c.lastAHcheck).. L[" days ago"])
		end
	end

	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	
	for i=1, VisibleLines do
		local line = i + offset
		if line <= #c.bids then
			local s = c.bids[line]
			
			local itemName, _, itemRarity = GetItemInfo(s.id)
			_G[ entry..i.."Name" ]:SetText(select(4, GetItemQualityColor(itemRarity)) .. itemName)
			
			_G[ entry..i.."TimeLeft" ]:SetText( TEAL .. _G["AUCTION_TIME_LEFT"..s.timeLeft] 
								.. " (" .. _G["AUCTION_TIME_LEFT"..s.timeLeft .. "_DETAIL"] .. ")")
			
			if s.AHLocation then
				_G[ entry..i.."HighBidder" ]:SetText(L["Goblin AH"] .. "\n" .. WHITE .. s.owner)
			else
				_G[ entry..i.."HighBidder" ]:SetText(WHITE .. s.owner)
			end
			
			_G[ entry..i.."Price" ]:SetText(ORANGE .. CURRENT_BID .. ": " .. Altoholic:GetMoneyString(s.bidPrice) .. "\n"  
					.. GREEN .. BUYOUT .. ": " ..  Altoholic:GetMoneyString(s.buyoutPrice))
			_G[ entry..i.."ItemIconTexture" ]:SetTexture(GetItemIcon(s.id));
			if (s.count ~= nil) and (s.count > 1) then
				_G[ entry..i.."ItemCount" ]:SetText(s.count)
				_G[ entry..i.."ItemCount" ]:Show()
			else
				_G[ entry..i.."ItemCount" ]:Hide()
			end

			_G[ entry..i.."Item" ]:SetID(line)
			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end
	
	if #c.bids < VisibleLines then
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleLines, VisibleLines, 41);
	else
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], #c.bids, VisibleLines, 41);
	end
end

function Altoholic.AuctionHouse:ScanBids()
	local self = Altoholic.AuctionHouse
	local c = Altoholic.ThisCharacter
	local numItems = GetNumAuctionItems("bidder")

	local AHZone
	local zone = GetRealZoneText()
	if (zone == BZ["Stranglethorn Vale"]) or		-- if it's a goblin AH .. save the value 1
		(zone == BZ["Tanaris"]) or
		(zone == BZ["Winterspring"]) then
		AHZone = 1
	end

	self:ClearEntries("bids", AHZone, UnitName("player"))
	
	c.lastAHcheck = time()
	
	if GetLocale() == "enUS" then				-- adjust this test if there's demand
		c.AHCheckClientDate = date("%m/%d/%Y")
	else
		c.AHCheckClientDate = date("%d/%m/%Y")
	end
	c.AHCheckClientHour = tonumber(date("%H"))
	c.AHCheckClientMinute = tonumber(date("%M"))
	
	if numItems == 0 then return end
	
	for i = 1, numItems do
		local itemName, _, itemCount, _, _, _,	_, 
			_, buyout, bidAmount, _, ownerName = GetAuctionItemInfo("bidder", i);
			
		if itemName then
			table.insert(c.bids, {
				id = Altoholic:GetIDFromLink(GetAuctionItemLink("bidder", i)),
				count = itemCount,
				AHLocation = AHZone,
				bidPrice = bidAmount,
				buyoutPrice = buyout,
				owner = ownerName,
				timeLeft = GetAuctionItemTimeLeft("bidder", i)
			} )
		end
	end
	
end

function Altoholic.AuctionHouse:ScanAuctions()
	local self = Altoholic.AuctionHouse
	local c = Altoholic.ThisCharacter
	local numItems = GetNumAuctionItems("owner")

	local AHZone
	local zone = GetRealZoneText()
	if (zone == BZ["Stranglethorn Vale"]) or		-- if it's a goblin AH .. save the value 1
		(zone == BZ["Tanaris"]) or
		(zone == BZ["Winterspring"]) then
		AHZone = 1
	end	

	self:ClearEntries("auctions", AHZone, UnitName("player"))
	
	c.lastAHcheck = time()
	if numItems == 0 then return end
	
	for i = 1, numItems do
		local itemName, _, itemCount, _, _, _,	minBid, 
			_, buyout, _,	highBidderName = GetAuctionItemInfo("owner", i);

		if itemName then
			table.insert(c.auctions, {
				id = Altoholic:GetIDFromLink(GetAuctionItemLink("owner", i)),
				count = itemCount,
				AHLocation = AHZone,
				highBidder = highBidderName,
				startPrice = minBid,
				buyoutPrice = buyout,
				timeLeft = GetAuctionItemTimeLeft("owner", i)
			} )
		end
	end
	
end

function Altoholic.AuctionHouse:GetItemCount(searchedID)
	local c = Altoholic.CountCharacter
	
	if #c.auctions == 0 then return 0 end	-- fast exit if no auctions
	
	local count = 0
	for k, v in pairs (c.auctions) do
		if (v.id == searchedID) then 
			count = count + (v.count or 1)
		end 
	end

	return count
end

function Altoholic.AuctionHouse:ClearEntries(AHType, AHZone, character)
	-- AHType = "auctions" or "bids" (the name of the table in the DB)
	-- AHZone = nil for player faction, or 1 for goblin
	
	local r = Altoholic.ThisRealm
	local c = r.char[character]
	
	for i = #c[AHType], 1, -1 do			-- parse backwards to avoid messing up the index
		if c[AHType][i].AHLocation == AHZone then
			table.remove(c[AHType], i)
		end
	end
end

function Altoholic.AuctionHouse:RightClickMenu_OnLoad()
	local info = UIDropDownMenu_CreateInfo(); 

	info.text		= WHITE .. L["Clear your faction's entries"]
	info.value		= 1
	info.func		= Altoholic_ClearPlayerAHEntries;
	UIDropDownMenu_AddButton(info, 1); 

	info.text		= WHITE .. L["Clear goblin AH entries"]
	info.value		= 2
	info.func		= Altoholic_ClearPlayerAHEntries;
	UIDropDownMenu_AddButton(info, 1); 
	
	info.text		= WHITE .. L["Clear all entries"]
	info.value		= 3
	info.func		= Altoholic_ClearPlayerAHEntries;
	UIDropDownMenu_AddButton(info, 1); 
end

function Altoholic_ClearPlayerAHEntries(self)
	local c = Altoholic:GetCharacterTable()
	
	local ahType = Altoholic.AuctionHouse.AuctionType
	
	if (self.value == 1) or (self.value == 3) then	-- clean this faction's data
		for i = #c[ahType], 1, -1 do
			if c[ahType][i].AHLocation == nil then
				table.remove(c[ahType], i)
			end
		end
	end
	
	if (self.value == 2) or (self.value == 3) then	-- clean goblin AH
		for i = #c[ahType], 1, -1 do
			if c[ahType][i].AHLocation == 1 then
				table.remove(c[ahType], i)
			end
		end
	end
	
	Altoholic.AuctionHouse:Update();
end

-- *** EVENT HANDLERS ***

function Altoholic.AuctionHouse:OnShow()
	local self = Altoholic.AuctionHouse
	self.isOpen = true
	Altoholic:RegisterEvent("AUCTION_HOUSE_CLOSED", self.OnClose)
	Altoholic:RegisterEvent("AUCTION_BIDDER_LIST_UPDATE", self.ScanBids)
	Altoholic:RegisterEvent("AUCTION_OWNED_LIST_UPDATE", self.ScanAuctions)
end

function Altoholic.AuctionHouse:OnClose()
	local self = Altoholic.AuctionHouse
	self.isOpen = nil
	Altoholic:UnregisterEvent("AUCTION_HOUSE_CLOSED")
	Altoholic:UnregisterEvent("AUCTION_OWNED_LIST_UPDATE")
	Altoholic:UnregisterEvent("AUCTION_BIDDER_LIST_UPDATE")
end
