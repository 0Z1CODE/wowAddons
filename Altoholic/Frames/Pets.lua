local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local V = Altoholic.vars

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local PETS_PER_PAGE = 12

Altoholic.Pets = {}

-- Retrieved from http://www.wowhead.com/?spells=-5
local MountList = {			-- updated April 17, 2009
	-- these are spellID's
	458, 459, 468, 470, 471, 472, 578, 579, 580, 581, 3363, 6648, 6653, 6654, 6777, 6896, 6897, 6898, 
	6899, 8394, 8395, 8980, 10789, 10793, 10795, 10796, 10798, 10799, 10873, 10969, 15779, 15780, 15781, 
	16055, 16056, 16058, 16059, 16060, 16080, 16081, 16082, 16083, 16084, 17229, 17450, 17453, 17454, 
	17455, 17456, 17458, 17459, 17460, 17461, 17462, 17463, 17464, 17465, 17481, 18363, 18989, 18990, 
	18991, 18992, 22717, 22718, 22719, 22720, 22721, 22722, 22723, 22724, 23219, 23220, 23221, 23222, 
	23223, 23225, 23227, 23228, 23229, 23238, 23239, 23240, 23241, 23242, 23243, 23246, 23247, 23248, 
	23249, 23250, 23251, 23252, 23338, 23509, 23510, 24242, 24252, 25953, 26054, 26055, 26056, 26656, 
	28828, 29059, 30174, 32235, 32239, 32240, 32242, 32243, 32244, 32245, 32246, 32289, 32290, 32292, 
	32295, 32296, 32297, 32345, 33630, 33660, 34406, 34407, 34790, 34795, 34896, 34897, 34898, 34899, 
	35018, 35020, 35022, 35025, 35027, 35028, 35710, 35711, 35712, 35713, 35714, 36702, 37015, 39315, 
	39316, 39317, 39318, 39319, 39798, 39800, 39801, 39802, 39803, 40192, 41252, 41513, 41514, 41515, 
	41516, 41517, 41518, 42776, 42777, 42781, 43688, 43810, 43899, 43900, 43927, 44151, 44153, 44317, 
	44744, 46197, 46199, 46628, 47037, 48025, 48027, 48954, 49193, 49322, 49378, 49379, 50869, 50870, 
	51412, 51960, 54729, 54753, 55531, 58615, 58983, 59567, 59568, 59569, 59570, 59571, 59572, 59573, 
	59650, 59785, 59788, 59791, 59793, 59797, 59799, 59802, 59804, 59810, 59811, 59961, 59976, 59996, 
	60002, 60021, 60024, 60025, 60114, 60116, 60118, 60119, 60136, 60140, 60424, 61229, 61230, 61294, 
	61309, 61425, 61442, 61444, 61446, 61447, 61451, 61465, 61467, 61469, 61470, 61996, 61997, 62048,
	
	-- Argent Tournament 3.1
	64656, 63639, 63641, 63635, 33653, 63232, 63643, 63636, 63640, 63642, 63638, 64731, 64977, 64658,
	64657, 63844,
}

Altoholic.Pets.MountToSpellID = {			-- updated April 17, 2009
	-- [itemID] = spellID
	[1132] = 580,
	[2411] = 470,
	[2414] = 472,
	[5655] = 6648,
	[5656] = 458,
	[5665] = 6653,
	[5668] = 6654,
	[5864] = 6777,
	[5872] = 6899,
	[5873] = 6898,
	[8563] = 10873,
	[8586] = 16084,
	[8588] = 8395,
	[8589] = 10795,
	[8591] = 10796,
	[8592] = 10799,
	[8595] = 10969,
	[8629] = 10793,
	[8631] = 8394,
	[8632] = 10789,
	[12302] = 16056,
	[12303] = 16055,
	[12330] = 16080,
	[12351] = 16081,
	[12353] = 16083,
	[12354] = 16082,
	[13086] = 17229,
	[13317] = 17450,
	[13321] = 17453,
	[13322] = 17454,
	[13326] = 15779,
	[13327] = 17459,
	[13328] = 17461,
	[13329] = 17460,
	[13331] = 17462,
	[13332] = 17463,
	[13333] = 17464,
	[13334] = 17465,
	[13335] = 17481,
	[15277] = 18989,
	[15290] = 18990,
	[15292] = 18991,
	[15293] = 18992,
	[18241] = 22717,
	[18245] = 22724,
	[18247] = 22718,
	[18766] = 23221,
	[18767] = 23219,
	[18772] = 23225,
	[18773] = 23223,
	[18774] = 23222,
	[18776] = 23227,
	[18777] = 23229,
	[18778] = 23228,
	[18785] = 23240,
	[18786] = 23238,
	[18787] = 23239,
	[18788] = 23241,
	[18789] = 23242,
	[18790] = 23243,
	[18791] = 23246,
	[18793] = 23247,
	[18794] = 23249,
	[18795] = 23248,
	[18796] = 23250,
	[18797] = 23251,
	[18798] = 23252,
	[18902] = 23338,
	[19029] = 23509,
	[19030] = 23510,
	[19872] = 24242,
	[19902] = 24252,
	[21176] = 26656,
	[25470] = 32235,
	[25471] = 32239,
	[25472] = 32240,
	[25473] = 32242,
	[25474] = 32243,
	[25475] = 32244,
	[25476] = 32245,
	[25477] = 32246,
	[25527] = 32289,
	[25528] = 32290,
	[25529] = 32292,
	[25531] = 32295,
	[25532] = 32296,
	[25533] = 32297,
	[28481] = 34406,
	[28915] = 39316,
	[28927] = 34795,
	[28936] = 33660,
	[29102] = 34896,
	[29103] = 34897,
	[29105] = 34899,
	[29220] = 35020,
	[29221] = 35022,
	[29222] = 35018,
	[29223] = 35025,
	[29224] = 35027,
	[29228] = 34790,
	[29229] = 34898,
	[29465] = 22719,
	[29467] = 22720,
	[29470] = 22722,
	[29471] = 22723,
	[29472] = 22721,
	[29743] = 35711,
	[29744] = 35710,
	[29745] = 35713,
	[29746] = 35712,
	[29747] = 35714,
	[30480] = 36702,
	[30609] = 37015,
	[31829] = 39315,
	[31831] = 39317,
	[31833] = 39318,
	[31835] = 39319,
	[32314] = 39798,
	[32316] = 39801,
	[32317] = 39800,
	[32318] = 39802,
	[32319] = 39803,
	[32458] = 40192,
	[32768] = 41252,
	[32857] = 41513,
	[32858] = 41514,
	[32859] = 41515,
	[32860] = 41516,
	[32861] = 41517,
	[32862] = 41518,
	[33224] = 42776,
	[33225] = 42777,
	[33809] = 43688,
	[33976] = 43899,
	[33977] = 43900,
	[33999] = 43927,
	[34092] = 44744,
	[34129] = 35028,
	[35513] = 46628,
	[35906] = 48027,
	[37012] = 48025,
	[37676] = 49193,
	[38576] = 51412,
	[44707] = 61294,	 -- Reins of the Green Proto-Drake (Oracles)
	
	-- Argent Tournament 3.1
	[46101] = 64656,
	[45590] = 63639,
	[45592] = 63641,
	[45593] = 63635,
	[45591] = 33653,
	[45125] = 63232,
	[45597] = 63643,
	[45586] = 63636,
	[45595] = 63640,
	[45596] = 63642,
	[45589] = 63638,
	[46109] = 64731,
	[46308] = 64977,
	[46099] = 64658,
	[46100] = 64657,
	[45725] = 63844,
}

local CompanionList = {			-- updated April 17, 2009
	4055, 10673, 10674, 10675, 10676, 10677, 10678, 10679, 10680, 10681, 10682, 10683, 10684, 
	10685, 10686, 10687, 10688, 10695, 10696, 10697, 10698, 10699, 10700, 10701, 10702, 10703, 
	10704, 10705, 10706, 10707, 10708, 10709, 10710, 10711, 10712, 10713, 10714, 10715, 10716, 
	10717, 10718, 10719, 10720, 10721, 12243, 13548, 15048, 15049, 15067, 15648, 15999, 16450, 
	17468, 17469, 17567, 17707, 17708, 17709, 19363, 19772, 23428, 23429, 23430, 23431, 23432, 
	23530, 23531, 23811, 24696, 24985, 24986, 24987, 24988, 24989, 24990, 25018, 25162, 25849, 
	26010, 26045, 26067, 26391, 26529, 26533, 26541, 27241, 27570, 28487, 28505, 28738, 28739, 
	28740, 28871, 30152, 30156, 32298, 33050, 33057, 35156, 35157, 35239, 35907, 35909, 35910, 
	35911, 36027, 36028, 36029, 36031, 36034, 39181, 39709, 40319, 40405, 40549, 40613, 40614, 
	40634, 40990, 42609, 43697, 43698, 43918, 44369, 45048, 45082, 45125, 45127, 45174, 45175, 
	45890, 46425, 46426, 46599, 48406, 48408, 49964, 51716, 51851, 52615, 53082, 53316, 53768, 
	54187, 55068, 58636, 59250, 61348, 61349, 61350, 61351, 61357, 61472, 61855, 61991,
	
	-- Argent Tournament 3.1
	62562, 62746, 62609, 62508, 62513, 62516, 62564, 62674, 62542, 63712, 62561, 62491, 62510,
	64351,
}

Altoholic.Pets.CompanionToSpellID = {		-- updated April 17, 2009
	[4401] = 4055,
	[8485] = 10673,
	[8486] = 10674,
	[8487] = 10676,
	[8488] = 10678,
	[8489] = 10679,
	[8490] = 10677,
	[8491] = 10675,
	[8492] = 10683,
	[8494] = 10682,
	[8495] = 10684,
	[8496] = 10680,
	[8497] = 10711,
	[8498] = 10698,
	[8499] = 10697,
	[8500] = 10707,
	[8501] = 10706,
	[10360] = 10714,
	[10361] = 10716,
	[10392] = 10717,
	[10393] = 10688,
	[10394] = 10709,
	[10398] = 12243,
	[10822] = 10695,
	[11023] = 10685,
	[11026] = 10704,
	[11027] = 10703,
	[11110] = 13548,
	[11474] = 15067,
	[11825] = 15048,
	[11826] = 15049,
	[12185] = 17567,
	[12264] = 15999,
	[12529] = 16450,
	[13582] = 17709,
	[13583] = 17707,
	[13584] = 17708,
	[15996] = 19772,
	[19450] = 23811,
	[20371] = 24696,
	[20769] = 25162,
	[21277] = 26010,
	[21305] = 26541,
	[22114] = 27241,
	[22235] = 27570,
	[22781] = 28505,
	[23002] = 28738,
	[23007] = 28739,
	[23015] = 28740,
	[23713] = 30156,
	[25535] = 32298,
	[27445] = 33050,
	[29363] = 35156,
	[29364] = 35239,
	[29901] = 35907,
	[29902] = 35909,
	[29903] = 35910,
	[29904] = 35911,
	[29953] = 36027,
	[29956] = 36028,
	[29957] = 36029,
	[29958] = 36031,
	[29960] = 36034,
	[30360] = 24988,
	[31760] = 39181,
	[32233] = 39709,
	[32498] = 40405,
	[32588] = 40549,
	[32616] = 40614,
	[32617] = 40613,
	[32622] = 40634,
	[33154] = 42609,
	[33816] = 43697,
	[33818] = 43698,
	[33993] = 43918,
	[34425] = 45048,
	[34478] = 45082,
	[34492] = 45125,
	[34493] = 45127,
	[34535] = 10696,
	[34955] = 45890,
	[35349] = 46425,
	[35350] = 46426,
	[35504] = 46599,
	[38050] = 49964,
	[38628] = 51716,
	[39286] = 52615,
	[39656] = 53082,
	[40653] = 40990,
	[44819] = 61855,
	
	-- The Oracles
	[39898] = 61351,
	[44721] = 61350,
	[39896] = 61348,
	[39899] = 61349,
	
	-- Argent Tournament 3.1
	[44984] = 62562,
	[45022] = 62746,
	[44998] = 62609,
	[44970] = 62508,
	[44973] = 62513,
	[44974] = 62516,
	[44982] = 62564,
	[45002] = 62674,
	[44980] = 62542,
	[45606] = 63712,
	[44983] = 62561,
	[44965] = 62491,
	[44971] = 62510,
	[44822] = 10716,
	[45942] = 64351,
}

function Altoholic_Pets_OnEnter(self)
	if not self.spellID then return end
	
	AltoTooltip:SetOwner(self, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	AltoTooltip:SetHyperlink("spell:" ..self.spellID);
	AltoTooltip:Show();
end

function Altoholic_Pets_OnClick(self)
	self:SetChecked(true);
	
	local parent = self:GetParent():GetParent()
	local offset = (parent.CurrentPage-1) * PETS_PER_PAGE
	parent.selectedID = offset + self:GetID()
	parent:UpdatePets()
end

function AltoholicFramePets:Initialize()
	UIDropDownMenu_SetSelectedValue(AltoholicFramePets_SelectPetView, 1);
	UIDropDownMenu_SetText(AltoholicFramePets_SelectPetView, COMPANIONS)

	UIDropDownMenu_Initialize(AltoholicFramePets_SelectPetView, function(self) 
		AltoholicFramePets:DropDownPets_Initialize()
	end)
end

function AltoholicFramePets:DropDownPets_Initialize()
	local info = UIDropDownMenu_CreateInfo(); 
	
	info.text =  COMPANIONS
	info.value = 1
	info.func = AltoholicFramePets.ChangePetView
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 
	
	info.text =  COMPANIONS .. GREEN .. " (" .. L["All-in-one"] .. ")"
	info.value = 2
	info.func = AltoholicFramePets.ChangePetView
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 
	
	info.text =  MOUNTS
	info.value = 3
	info.func = AltoholicFramePets.ChangePetView
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 
	
	info.text =  MOUNTS .. GREEN .. " (" .. L["All-in-one"] .. ")"
	info.value = 4
	info.func = AltoholicFramePets.ChangePetView
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 
end

function AltoholicFramePets:ChangePetView()
	UIDropDownMenu_SetSelectedValue(AltoholicFramePets_SelectPetView, self.value);
	
	if (self.value == 1) or (self.value == 3) then
		AltoholicFrameClasses:Hide()
		AltoholicFramePetsNormal:Show()
		AltoholicFramePetsAllInOne:Hide()
	else
		AltoholicFrameClasses:Show()
		AltoholicFramePetsNormal:Hide()
		AltoholicFramePetsAllInOne:Show()
	end
	
	AltoholicFramePets:Show()
	
	if self.value == 1 then
		AltoholicFramePets:SetType("CRITTER")
	elseif self.value == 2 then
		table.sort(CompanionList, function(a, b)
					local textA = GetSpellInfo(a) or ""
					local textB = GetSpellInfo(b) or ""
					return textA < textB
				end)
		AltoholicFramePets:UpdatePetsAllInOne()
	elseif self.value == 3 then
		AltoholicFramePets:SetType("MOUNT")
	elseif self.value == 4 then
		table.sort(MountList, function(a, b)
					local textA = GetSpellInfo(a) or ""
					local textB = GetSpellInfo(b) or ""
					return textA < textB
				end)
		AltoholicFramePets:UpdatePetsAllInOne()
	end
end

function AltoholicFramePets:SetType(petType)
	self.selectedID = 1
	self.PetType = petType
	self:SetPage(1)
end

function AltoholicFramePets:SetPage(pageNum)
	self.CurrentPage = pageNum
	
	local c = Altoholic:GetCharacterTable()
	local p = c.pets[self.PetType]
	
	if self.CurrentPage == 1 then
		AltoholicFramePetsNormalPrevPage:Disable()
	else
		AltoholicFramePetsNormalPrevPage:Enable()
	end
	
	local maxPages
	if p then
		maxPages = ceil(#p / PETS_PER_PAGE)
		if maxPages == 0 then
			maxPages = 1
		end
	else
		maxPages = 1
	end
	
	if self.CurrentPage == maxPages then
		AltoholicFramePetsNormalNextPage:Disable()
	else
		AltoholicFramePetsNormalNextPage:Enable()
	end
	
	AltoholicFramePetsNormal_PageNumber:SetText(format(MERCHANT_PAGE_NUMBER, self.CurrentPage, maxPages ))
	self:UpdatePets()
end

function AltoholicFramePets:UpdatePets()
	local c = Altoholic:GetCharacterTable()
	local p = c.pets[self.PetType]
	
	if not p or (#p == 0) then		-- added this test as simply addressing the table seems to make it grow, I'd assume this is due to AceDB magic value ['*'].
		for i = 1, PETS_PER_PAGE do
			local button = _G["AltoholicFramePetsNormal_Button" .. i];
		
			if self.PetType == "MOUNT" then
				button:SetDisabledTexture([[Interface\PetPaperDollFrame\UI-PetFrame-Slots-Mounts]])
			else
				button:SetDisabledTexture([[Interface\PetPaperDollFrame\UI-PetFrame-Slots-Companions]])
			end
			button:Disable();
			button:SetChecked(false);
		end
		return
	end
	
	local offset = (self.CurrentPage-1) * PETS_PER_PAGE
	
	for i = 1, PETS_PER_PAGE do
		local index = offset + i
		local button = _G["AltoholicFramePetsNormal_Button" .. i];
		
		local name, spellID, icon, modelID
		if p[index] then
			name, spellID, icon, modelID = strsplit("|", p[index])
		end
		
		if icon and spellID then						-- if there's a pet  .. texture & enable it
			button:SetNormalTexture("Interface\\Icons\\" .. icon);	
			button:Enable()
			button.spellID = spellID 
		else
			button.spellID = nil
			if self.PetType == "MOUNT" then
				button:SetDisabledTexture([[Interface\PetPaperDollFrame\UI-PetFrame-Slots-Mounts]])
			else
				button:SetDisabledTexture([[Interface\PetPaperDollFrame\UI-PetFrame-Slots-Companions]])
			end
			button:Disable();
		end

		modelID = tonumber(modelID)
		if self.selectedID and (index == self.selectedID) and modelID then
			button:SetChecked(true);		-- check only if it's the selected button and it has a model id
			AltoholicFramePetsNormal_PetName:SetText(name)
			AltoholicFramePetsNormal_ModelFrame:SetCreature(modelID);
		else
			button:SetChecked(false);
		end
	end
end

function AltoholicFramePets:UpdatePetsAllInOne()
	local VisibleLines = 8
	local frame = "AltoholicFramePetsAllInOne"
	local entry = frame.."Entry"
		
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local r = Altoholic:GetRealmTable()
	
	local mode = UIDropDownMenu_GetSelectedValue(AltoholicFramePets_SelectPetView);
	local numItems, petType
	
	if mode == 2 then
		numItems = #CompanionList
		petType = "CRITTER"
	elseif mode == 4 then
		numItems = #MountList
		petType = "MOUNT"
	end
	
	for i=1, VisibleLines do
		local line = i + offset
		if line <= numItems then	-- if the line is visible
			local spellID

			if mode == 2 then
				spellID = CompanionList[line]
			elseif mode == 4 then
				spellID = MountList[line]
			end
			
			local petName, _, petTexture = GetSpellInfo(spellID)
			
			if petName then
				_G[entry..i.."Name"]:SetText(WHITE .. petName)
				_G[entry..i.."Name"]:SetJustifyH("LEFT")
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
			else
				DEFAULT_CHAT_FRAME:AddMessage(spellID)
			end
			
			local j = 1
			for CharacterName, c in pairs(r.char) do
				local itemName = entry.. i .. "Item" .. j;
				local itemButton = _G[itemName]
				local itemTexture = _G[itemName .. "_Background"]
				
				itemButton:SetScript("OnEnter", Altoholic_Pets_OnEnter)
	
				itemTexture:SetTexture(petTexture)
				
				local isPetKnown
				
				if c.pets[petType] then
					-- isPetKnown will remain nil if the table is not valid, which is the expected behavior
					for _, v in pairs(c.pets[petType]) do
						local _, petSpellID = strsplit("|", v)
						if tonumber(petSpellID) == spellID then
							isPetKnown = true
							break
						end
					end
				end
				
				if isPetKnown then
					itemTexture:SetVertexColor(1.0, 1.0, 1.0);
					_G[itemName .. "Name"]:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t")
				else
					itemTexture:SetVertexColor(0.4, 0.4, 0.4);
					_G[itemName .. "Name"]:SetText("\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t")
				end

				itemButton.spellID = spellID
				itemButton:Show()
				
				j = j + 1
			end
			
			while j <= 10 do
				_G[ entry.. i .. "Item" .. j ]:Hide()
				_G[ entry.. i .. "Item" .. j ].spellID = nil
				j = j + 1
			end
			
			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end

	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], numItems, VisibleLines, 41);
end


function Altoholic.Pets:OnChange()
	-- this event is triggered too often for our needs, some filtering is required  to avoid scanning pet data too often
	if arg1 ~= "player" then return end
	
	local name = UnitName("pet")
	if not name or name == UNKNOWN then	return end		-- if there's a usable pet name ..
	
	local self = Altoholic.Pets
	if not self.CurrentPetName then		-- not set ? initial scan
		self.CurrentPetName = name
		self:ScanHunter()
	elseif self.CurrentPetName ~= name then	-- already set, has it changed ? re-scan
		self.CurrentPetName = name
		self:ScanHunter()
	end
end

function Altoholic.Pets:ScanHunter()
	-- this is a specific function to scan hunter pet talents
--	DEFAULT_CHAT_FRAME:AddMessage("Scanning Pet " .. self.CurrentPetName)
end
