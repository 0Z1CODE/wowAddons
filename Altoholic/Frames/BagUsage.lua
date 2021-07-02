local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local V = Altoholic.vars

local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"
local GOLD		= "|cFFFFD700"
local CYAN		= "|cFF1CFAFE"

function Altoholic:BagUsage_Update()
	local VisibleLines = 14
	local frame = "AltoholicFrameBagUsage"
	local entry = frame.."Entry"
	
	if #Altoholic.CharacterInfo == 0 then
		-- added these 2 lines to make sur that the table is correct when the user gets here. 
		-- For some reason, a few users get a empty window..only an empty table could cuase this
		self:BuildCharacterInfoTable()
		self:BuildCharacterInfoView()
	
		if #Altoholic.CharacterInfo == 0 then
			-- if by any chance the table is still empty, then draw an empty frame
			self:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 18)
			return
		end
	end	
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawRealm
	local CurrentAccount, CurrentRealm
	local i=1
	
	for _, line in pairs(Altoholic.CharacterInfoView) do
		local s = Altoholic.CharacterInfo[line]
		local lineType = mod(s.linetype, 3)
		
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if lineType == INFO_REALM_LINE then								-- then keep track of counters
				CurrentAccount = s.account
				CurrentRealm = s.realm
				if s.isCollapsed == false then
					DrawRealm = true
				else
					DrawRealm = false
				end
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif DrawRealm then
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			end
		else		-- line will be displayed
			if lineType == INFO_REALM_LINE then
				CurrentAccount = s.account
				CurrentRealm = s.realm
				if s.isCollapsed == false then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawRealm = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawRealm = false
				end
				_G[entry..i.."Collapse"]:Show()
				_G[entry..i.."Name"]:SetWidth(300)
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 25, 0)
				_G[entry..i.."NameNormalText"]:SetWidth(300)
				if s.account == "Default" then	-- saved as default, display as localized.
					_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s|r)", s.realm, WHITE, GREEN, L["Default"]))
				else
					local r = Altoholic:GetRealmTable(CurrentRealm, CurrentAccount)
					if r and r.lastAccountSharing then
						_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s %s%s|r)", s.realm, WHITE, GREEN, s.account, YELLOW, r.lastAccountSharing))
					else
						_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s|r)", s.realm, WHITE, GREEN, s.account))
					end
				end
				_G[entry..i.."Level"]:SetText("")
				_G[entry..i.."FreeBags"]:SetText("")
				_G[entry..i.."FreeBank"]:SetText("")
				_G[entry..i.."BagSlotsNormalText"]:SetText("")
				_G[entry..i.."BankSlotsNormalText"]:SetText("")
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			elseif DrawRealm then
				if (lineType == INFO_CHARACTER_LINE) then
					local c = self.db.global.data[CurrentAccount][CurrentRealm].char[s.name]
				
					local icon
					if c.faction == "Alliance" then
						icon = self:TextureToFontstring("Interface\\Icons\\INV_BannerPVP_02", 18, 18) .. " "
					else
						icon = self:TextureToFontstring("Interface\\Icons\\INV_BannerPVP_01", 18, 18) .. " "
					end
					
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(170)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 10, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(170)
					_G[entry..i.."NameNormalText"]:SetText(icon .. format("%s%s (%s)", self:GetClassColor(c.englishClass), s.name, c.class))
					_G[entry..i.."Level"]:SetText(GREEN .. c.level)
				
					_G[entry..i.."FreeBags"]:SetText(GREEN .. c.numFreeBagSlots)
					_G[entry..i.."FreeBank"]:SetText(GREEN .. c.numFreeBankSlots)

					_G[entry..i.."BagSlotsNormalText"]:SetJustifyH("LEFT")
					_G[entry..i.."BankSlotsNormalText"]:SetJustifyH("LEFT")
					
					-- Normal bags
					_G[entry..i.."BagSlotsNormalText"]:SetText(format("%s/%s|r/%s|r/%s|r/%s |r(%s|r)",
						c.bag["Bag0"].size,
						WHITE .. (c.bag["Bag1"] and (c.bag["Bag1"].size) or 0),
						WHITE .. (c.bag["Bag2"] and (c.bag["Bag2"].size) or 0),
						WHITE .. (c.bag["Bag3"] and (c.bag["Bag3"].size) or 0),
						WHITE .. (c.bag["Bag4"] and (c.bag["Bag4"].size) or 0),
						CYAN .. c.numBagSlots))
					
					-- Bank bags
					if c.numBankSlots < 28 then
						_G[entry..i.."BankSlotsNormalText"]:SetText(L["Bank not visited yet"])
					else
						_G[entry..i.."BankSlotsNormalText"]:SetText(format("%s/%s|r/%s|r/%s|r/%s|r/%s|r/%s|r/%s |r(%s|r)",
							28,
							WHITE .. (c.bag["Bag5"] and (c.bag["Bag5"].size) or 0),
							WHITE .. (c.bag["Bag6"] and (c.bag["Bag6"].size) or 0),
							WHITE .. (c.bag["Bag7"] and (c.bag["Bag7"].size) or 0),
							WHITE .. (c.bag["Bag8"] and (c.bag["Bag8"].size) or 0),
							WHITE .. (c.bag["Bag9"] and (c.bag["Bag9"].size) or 0),
							WHITE .. (c.bag["Bag10"] and (c.bag["Bag10"].size) or 0),
							WHITE .. (c.bag["Bag11"] and (c.bag["Bag11"].size) or 0),
							CYAN .. c.numBankSlots))
					end
				elseif (lineType == INFO_TOTAL_LINE) then
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(200)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(200)
					_G[entry..i.."NameNormalText"]:SetText(L["Totals"])
					_G[entry..i.."Level"]:SetText(s.level)
					_G[entry..i.."FreeBags"]:SetText(WHITE .. s.freeBagSlots)
					_G[entry..i.."FreeBank"]:SetText(WHITE .. s.freeBankSlots)
					_G[entry..i.."BagSlotsNormalText"]:SetText(WHITE .. s.bagSlots .. " |r" .. L["slots"])
					_G[entry..i.."BagSlotsNormalText"]:SetJustifyH("CENTER")
					_G[entry..i.."BankSlotsNormalText"]:SetText(WHITE .. s.bankSlots .. " |r" .. L["slots"])
					_G[entry..i.."BankSlotsNormalText"]:SetJustifyH("CENTER")
				end
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			end
		end
	end
	
	while i <= VisibleLines do
		_G[ entry..i ]:SetID(0)
		_G[ entry..i ]:Hide()
		i = i + 1
	end

	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleCount, VisibleLines, 18);
end	

function Altoholic_BagUsage_OnEnter(self)
	local line = self:GetParent():GetID()
	local s = Altoholic.CharacterInfo[line]
	
	if mod(s.linetype, 3) ~= INFO_CHARACTER_LINE then		
		return
	end
	
	local c = Altoholic:GetCharacterTableByLine(line)
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	AltoTooltip:AddLine(Altoholic:GetClassColor(c.englishClass) .. s.name,1,1,1);
	AltoTooltip:AddLine(L["Level"] .. " " .. GREEN .. c.level .. " |r".. c.race .. " " .. c.class,1,1,1);
	AltoTooltip:AddLine(" ",1,1,1);

	local id = self:GetID()
	local numSlots
	local numFree = 0
	
	if id == 1 then		-- 1 for player bags, 2 for bank bags
		AltoTooltip:AddLine(GOLD .. "16 |r" .. L["slots"] .. " (" .. GREEN 
			.. c.bag["Bag0"].freeslots .. "|r " .. L["free"] .. ") [" .. BACKPACK_TOOLTIP .. "]",1,1,1);
				
		for i = 1, 4 do
			local b = c.bag["Bag"..i]
			if b and b.link then
				local bag
				if (b.bagtype == 0) then
					bag = ""
				else
					bag = YELLOW .. "(" .. Altoholic:GetBagTypeString(b.bagtype) .. ")"
				end

				AltoTooltip:AddLine(GOLD .. b.size .. " |r" .. L["slots"] .. " ("  .. GREEN
						.. b.freeslots ..  "|r " ..L["free"] .. ") " .. b.link .. " " .. bag ,1,1,1);
			end
		end
		numSlots = c.numBagSlots
		numFree = c.numFreeBagSlots
	elseif c.numBankSlots < 28 then
		AltoTooltip:AddLine(L["Bank not visited yet"],1,1,1);
		AltoTooltip:Show();	
		return
	else
		AltoTooltip:AddLine(GOLD .. "28 |r" .. L["slots"] .. " (" .. GREEN 
						.. c.bag["Bag100"].freeslots ..  "|r " .. L["free"] .. ") [" .. L["Bank"] .. "]",1,1,1);
		for i = 5, 11 do
			local b = c.bag["Bag"..i]
			if b and b.link then
				local bag
				if (b.bagtype == 0) then
					bag = ""
				else
					bag = YELLOW .. "(" .. Altoholic:GetBagTypeString(b.bagtype) .. ")"
				end
			
				AltoTooltip:AddLine(GOLD .. b.size .. " |r" .. L["slots"] .. " ("  .. GREEN
						.. b.freeslots ..  "|r " ..L["free"] .. ") " .. b.link .. " " .. bag ,1,1,1);
			end
		end
		numSlots = c.numBankSlots
		numFree = c.numFreeBankSlots
	end
	
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(CYAN .. numSlots .. " |r" .. L["slots"] .. " ("  .. GREEN .. numFree .. "|r " ..L["free"] .. ") ",1,1,1);
	AltoTooltip:Show();	
end

function Altoholic:GetBagTypeString(bagType)
	if bagType == 0 then
		return ""
	elseif bagType == 1 then
		return BI["Quiver"]
	elseif bagType == 2 then
		return BI["Ammo Pouch"]
	elseif bagType == 4 then
		return BI["Soul Bag"]
	elseif bagType == 8 then
		return BI["Leatherworking Bag"]
	elseif bagType == 16 then
		return BI["Inscription Bag"]
	elseif bagType == 32 then
		return BI["Herb Bag"]
	elseif bagType == 64 then
		return BI["Enchanting Bag"]
	elseif bagType == 128 then
		return BI["Engineering Bag"]
	elseif bagType == 512 then
		return BI["Gem Bag"]
	elseif bagType == 1024 then
		return BI["Mining Bag"]
	end
	return L["Unknown"]
end
