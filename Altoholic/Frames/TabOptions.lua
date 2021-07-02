local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local GREEN		= "|cFF00FF00"

Altoholic.Options = {}

function Altoholic.Options:RestoreToUI()
	local O = Altoholic.db.global.options
	
	AltoholicTabOptionsFrame1_RestXPMode:SetChecked(O.RestXPMode)
	AltoholicTabOptionsFrame1_ShowFubarIcon:SetChecked(O.FuBarIconShown)
	AltoholicTabOptionsFrame1_ShowFubarText:SetChecked(O.FuBarTextShown)
	AltoholicTabOptionsFrame1_GuildBankAutoUpdate:SetChecked(O.GuildBankAutoUpdate)
	AltoholicTabOptionsFrame1_AccSharingComm:SetChecked(O.AccSharingHandlerEnabled)
	AltoholicTabOptionsFrame1_GuildComm:SetChecked(O.GuildHandlerEnabled)

	-- set communication handlers according to user settings.
	if O.AccSharingHandlerEnabled == 1 then
		Altoholic.Comm.Sharing:SetMessageHandler("ActiveHandler")
	else
		Altoholic.Comm.Sharing:SetMessageHandler("EmptyHandler")
	end
	
	if O.GuildHandlerEnabled == 1 then
		Altoholic.Comm.Guild:SetMessageHandler("ActiveHandler")
	else
		Altoholic.Comm.Guild:SetMessageHandler("EmptyHandler")
	end
	
	AltoholicTabOptionsFrame2_SearchAutoQuery:SetChecked(O.SearchAutoQuery)
	AltoholicTabOptionsFrame2_SortDescending:SetChecked(O.SortDescending)
	AltoholicTabOptionsFrame2_IncludeNoMinLevel:SetChecked(O.IncludeNoMinLevel)
	AltoholicTabOptionsFrame2_IncludeMailbox:SetChecked(O.IncludeMailbox)
	AltoholicTabOptionsFrame2_IncludeGuildBank:SetChecked(O.IncludeGuildBank)
	AltoholicTabOptionsFrame2_IncludeRecipes:SetChecked(O.IncludeRecipes)
	AltoholicTabOptionsFrame2LootInfo:SetText(GREEN .. O.TotalLoots .. "|r " .. L["Loots"] .. " / "
										.. GREEN .. O.UnknownLoots .. "|r " .. L["Unknown"])

	AltoholicTabOptionsFrame3_SliderMailExpiry:SetValue(O.MailWarningThreshold)
	AltoholicTabOptionsFrame3_CheckMailExpiry:SetChecked(O.CheckMailExpiry)
	AltoholicTabOptionsFrame3_ScanMailBody:SetChecked(O.ScanMailBody)
	AltoholicTabOptionsFrame3_GuildMailWarning:SetChecked(O.GuildMailWarning)
	
	AltoholicTabOptionsFrame4_SliderAngle:SetValue(O.MinimapIconAngle)
	AltoholicTabOptionsFrame4_SliderRadius:SetValue(O.MinimapIconRadius)
	AltoholicTabOptionsFrame4_ShowMinimap:SetChecked(O.ShowMinimap)

	AltoholicTabOptionsFrame5Source:SetChecked(O.TooltipSource)
	AltoholicTabOptionsFrame5Count:SetChecked(O.TooltipCount)
	AltoholicTabOptionsFrame5Total:SetChecked(O.TooltipTotal)
	AltoholicTabOptionsFrame5GuildBank:SetChecked(O.TooltipGuildBank)
	AltoholicTabOptionsFrame5GuildBankCount:SetChecked(O.TooltipGuildBankCount)
	AltoholicTabOptionsFrame5RecipeInfo:SetChecked(O.TooltipRecipeInfo)
	AltoholicTabOptionsFrame5ItemID:SetChecked(O.TooltipItemID)
	AltoholicTabOptionsFrame5GatheringNode:SetChecked(O.TooltipGatheringNode)
	AltoholicTabOptionsFrame5CrossFaction:SetChecked(O.TooltipCrossFaction)
	AltoholicTabOptionsFrame5MultiAccount:SetChecked(O.TooltipMultiAccount)
end

function Altoholic:UpdateMinimapIconCoords()
	-- Thanks to Atlas for this code, modified to fit this addon's requirements though
	local xPos, yPos = GetCursorPosition() 
	local left, bottom = Minimap:GetLeft(), Minimap:GetBottom() 

	xPos = left - xPos/UIParent:GetScale() + 70 
	yPos = yPos/UIParent:GetScale() - bottom - 70 

	local O = self.db.global.options
	O.MinimapIconAngle = math.deg(math.atan2(yPos, xPos))

	if(O.MinimapIconAngle < 0) then
		O.MinimapIconAngle = O.MinimapIconAngle + 360
	end
	AltoholicTabOptionsFrame4_SliderAngle:SetValue(O.MinimapIconAngle)
end

function Altoholic:MoveMinimapIcon()
	local O = self.db.global.options
	
	AltoholicMinimapButton:SetPoint(	"TOPLEFT", "Minimap", "TOPLEFT",
		54 - (O.MinimapIconRadius * cos(O.MinimapIconAngle)),
		(O.MinimapIconRadius * sin(O.MinimapIconAngle)) - 55	);
end

function Altoholic.Options:Get(name)
	return Altoholic.db.global.options[name]
end

function Altoholic.Options:Set(name, value)
	if Altoholic.db == nil then return end
	Altoholic.db.global.options[name] = value
end

function Altoholic.Options:Toggle(self, option)
	if self:GetChecked() then 
		Altoholic.Options:Set(option, 1)
	else
		Altoholic.Options:Set(option, 0)
	end
end
