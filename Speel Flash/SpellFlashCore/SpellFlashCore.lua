local AddonName, AddonTable = ...
local L = AddonTable.Localize
LibStub:GetLibrary("BigLibTimer3"):Register(AddonTable)
SpellFlashCore = {}
local ButtonFrames = {}
local Buttons = {}
local Frames = {}
local BUTTONSREGISTERED = nil
local FRAMESREGISTERED = nil
local LOADING = true
if not SpellFlashCoreAddonConfig then
	SpellFlashCoreAddonConfig = {}
end


local COLORTABLE = {
	white = {r=1.0, g=1.0, b=1.0},
	yellow = YELLOW_FONT_COLOR,
	purple = {r=1.0, g=0.0, b=1.0},
	blue = {r=0.0, g=0.0, b=1.0},
	orange = ORANGE_FONT_COLOR,
	aqua = {r=0.0, g=1.0, b=1.0},
	green = GREEN_FONT_COLOR,
	red = RED_FONT_COLOR,
	pink = {r=0.9, g=0.4, b=0.4},
	gray = GRAY_FONT_COLOR,
}

AddonTable.PetActions = {
	Attack = "PET_ACTION_ATTACK",
	Follow = "PET_ACTION_FOLLOW",
	Stay = "PET_ACTION_WAIT",
	["Move To"] = "PET_ACTION_MOVE_TO",
	Aggressive = "PET_MODE_AGGRESSIVE",
	Defensive = "PET_MODE_DEFENSIVE",
	Passive = "PET_MODE_PASSIVE",
	PET_ACTION_ATTACK = "PET_ACTION_ATTACK",
	PET_ACTION_FOLLOW = "PET_ACTION_FOLLOW",
	PET_ACTION_WAIT = "PET_ACTION_WAIT",
	PET_ACTION_MOVE_TO = "PET_ACTION_MOVE_TO",
	PET_MODE_AGGRESSIVE = "PET_MODE_AGGRESSIVE",
	PET_MODE_DEFENSIVE = "PET_MODE_DEFENSIVE",
	PET_MODE_PASSIVE = "PET_MODE_PASSIVE",
	[PET_ACTION_ATTACK or "PET_ACTION_ATTACK"] = "PET_ACTION_ATTACK",
	[PET_ACTION_FOLLOW or "PET_ACTION_FOLLOW"] = "PET_ACTION_FOLLOW",
	[PET_ACTION_WAIT or "PET_ACTION_WAIT"] = "PET_ACTION_WAIT",
	[PET_ACTION_MOVE_TO or "PET_ACTION_MOVE_TO"] = "PET_ACTION_MOVE_TO",
	[PET_MODE_AGGRESSIVE or "PET_MODE_AGGRESSIVE"] = "PET_MODE_AGGRESSIVE",
	[PET_MODE_DEFENSIVE or "PET_MODE_DEFENSIVE"] = "PET_MODE_DEFENSIVE",
	[PET_MODE_PASSIVE or "PET_MODE_PASSIVE"] = "PET_MODE_PASSIVE",
}


local function Message(...)
	print("SpellFlashCore:", ...)
end

local function GetSpellName(GlobalSpellID, NoSubName)
	if type(GlobalSpellID) == "number" then
		local SpellName, SubName = GetSpellInfo(GlobalSpellID)
		if not AddonTable.OldBuild and not NoSubName and SubName and SubName ~= "" then
			return SpellName.."("..SubName..")"
		end
		return SpellName
	end
	return nil
end

local function BodyHasMetaTag(body)
	return body and body:match("#show") and (
		body:match("^ *#show *$")
		or body:match("\n *#show *$")
		or body:match("^ *#show *\n")
		or body:match("\n *#show *\n")
		or body:match("^ *#show ")
		or body:match("\n *#show ")
		or body:match("^ *#showtooltip *$")
		or body:match("\n *#showtooltip *$")
		or body:match("^ *#showtooltip *\n")
		or body:match("\n *#showtooltip *\n")
		or body:match("^ *#showtooltip ")
		or body:match("\n *#showtooltip ")
	)
end

local function RegisterButtons()
	BUTTONSREGISTERED = nil
	Buttons.Spell = {}
	Buttons.Macro = {}
	Buttons.Item = {}
	Frames.Spell = {}
	Frames.Macro = {}
	Frames.Item = {}
	SpellFlashCore.debug("-     Button Slots Found:")
	for i=1,120 do
		if HasAction(i) then
			local Type, ID = GetActionInfo(i)
			if Type == "macro" then
				if BodyHasMetaTag(GetMacroBody(ID)) then
					ID = tostring(ID)
					if not Buttons.Macro[ID] then
						Buttons.Macro[ID] = {}
					end
					tinsert(Buttons.Macro[ID], i)
				end
				SpellFlashCore.debug("Macro: "..GetActionText(i).." = "..i)
			elseif Type == "item" then
				local ItemName = GetItemInfo(ID)
				if not Buttons.Item[ItemName] then
					Buttons.Item[ItemName] = {}
				end
				tinsert(Buttons.Item[ItemName], i)
				SpellFlashCore.debug("Item: "..ItemName.." = "..i)
			elseif Type == "spell" then
			
				if AddonTable.OldBuild then
					ID = select(4, GetActionInfo(i))
				end
				
				local SpellName = GetSpellName(ID)
				if not Buttons.Spell[SpellName] then
					Buttons.Spell[SpellName] = {}
				end
				tinsert(Buttons.Spell[SpellName], i)
				SpellFlashCore.debug(SpellName.." = "..i)
			end
		end
	end
	if IsAddOnLoaded("ExtraBar") then
		local t = GetActiveTalentGroup()
		for b=1,4 do
			local i = 1
			local frame = _G["ExtraBar"..b.."Button"..i]
			while type(frame) == "table" do
				local Name = frame["set"..t.."name"]
				if type(Name) == "string" and Name ~= "" then
					local ID = frame["set"..t.."value"]
					local Type = frame["set"..t.."type"]
					if Type == "macro" then
						if BodyHasMetaTag(GetMacroBody(ID)) then
							ID = tostring(ID)
							if not Frames.Macro[ID] then
								Frames.Macro[ID] = {}
							end
							tinsert(Frames.Macro[ID], frame)
						end
						SpellFlashCore.debug("ExtraBar Macro: "..Name.." = Bar: "..b.." Button: "..i)
					elseif Type == "item" then
						if not Frames.Item[Name] then
							Frames.Item[Name] = {}
						end
						tinsert(Frames.Item[Name], frame)
						SpellFlashCore.debug("ExtraBar Item: "..Name.." = Bar: "..b.." Button: "..i)
					elseif Type == "spell" then
						local SpellName = GetSpellName(ID) or Name
						if not Frames.Spell[SpellName] then
							Frames.Spell[SpellName] = {}
						end
						tinsert(Frames.Spell[SpellName], frame)
						SpellFlashCore.debug("ExtraBar: "..SpellName.." = Bar: "..b.." Button: "..i)
					end
				end
				i = i + 1
				frame = _G["ExtraBar"..b.."Button"..i]
			end
		end
	end
	if IsAddOnLoaded("ButtonForge") then
		local i = 1
		local frame = _G["ButtonForge"..i]
		while type(frame) == "table" do
			if type(frame.ParentButton) == "table" then
				if frame.ParentButton.Mode == "macro" and type(frame.ParentButton.MacroName) == "string" and frame.ParentButton.MacroName ~= "" then
					local ID = frame.ParentButton.MacroIndex
					if BodyHasMetaTag(GetMacroBody(ID)) then
						ID = tostring(ID)
						if not Frames.Macro[ID] then
							Frames.Macro[ID] = {}
						end
						tinsert(Frames.Macro[ID], frame)
					end
					SpellFlashCore.debug("ButtonForge Macro: "..frame.ParentButton.MacroName.." = Button: "..i)
				elseif frame.ParentButton.Mode == "item" and type(frame.ParentButton.ItemName) == "string" and frame.ParentButton.ItemName ~= "" then
					if not Frames.Item[frame.ParentButton.ItemName] then
						Frames.Item[frame.ParentButton.ItemName] = {}
					end
					tinsert(Frames.Item[frame.ParentButton.ItemName], frame)
					SpellFlashCore.debug("ButtonForge Item: "..frame.ParentButton.ItemName.." = Button: "..i)
				elseif frame.ParentButton.Mode == "spell" and type(frame.ParentButton.SpellName) == "string" and frame.ParentButton.SpellName ~= "" then
					local SpellName = GetSpellName(frame.ParentButton.SpellId) or frame.ParentButton.SpellName
					if not Frames.Spell[SpellName] then
						Frames.Spell[SpellName] = {}
					end
					tinsert(Frames.Spell[SpellName], frame)
					SpellFlashCore.debug("ButtonForge: "..SpellName.." = Button: "..i)
				end
			end
			i = i + 1
			frame = _G["ButtonForge"..i]
		end
	end
	BUTTONSREGISTERED = 1
end

local function RegisterFrames()
	FRAMESREGISTERED = nil
	ButtonFrames.Action = {}
	ButtonFrames.Pet = {}
	ButtonFrames.Form = {}
	ButtonFrames.Vehicle = {}
	local frame = EnumerateFrames()
	while frame do
		if frame.IsProtected and frame.GetObjectType and frame.GetScript and frame:GetObjectType() == "CheckButton" and frame:IsProtected() then
			local script = frame:GetScript("OnClick")
			if script == ShapeshiftButton1:GetScript("OnClick") or tostring(frame:GetName()):match("^DominosClassButton%d+$") then
				tinsert(ButtonFrames.Form, frame)
			elseif script == PetActionButton1:GetScript("OnClick") then
				tinsert(ButtonFrames.Pet, frame)
			elseif script == VehicleMenuBarActionButton1:GetScript("OnClick") then
				tinsert(ButtonFrames.Vehicle, frame)
			elseif script == ActionButton1:GetScript("OnClick") or tostring(frame:GetName()):match("^BT4Button%d+$") then
				tinsert(ButtonFrames.Action, frame)
			end
		end
		frame = EnumerateFrames(frame)
	end
	FRAMESREGISTERED = 1
end

function SpellFlashCore.FlashFrame(frame, color, size, brightness, blink)
	if frame and frame:IsVisible() then
		if blink and frame:GetName() and not UIFrameIsFading(frame) then
			UIFrameFlash(frame, 0, 0.2, 0.2, true, 0, 0)
		end
		if not frame.SpellFlashCoreAddonFlashFrame then
			frame.SpellFlashCoreAddonFlashFrame = CreateFrame("Frame", nil, frame)
			frame.SpellFlashCoreAddonFlashFrame:Hide()
			frame.SpellFlashCoreAddonFlashFrame:SetAllPoints(frame)
			frame.SpellFlashCoreAddonFlashFrame.FlashTexture = frame.SpellFlashCoreAddonFlashFrame:CreateTexture(nil, "OVERLAY")
			frame.SpellFlashCoreAddonFlashFrame.FlashTexture:SetTexture("Interface\\Cooldown\\star4")
			frame.SpellFlashCoreAddonFlashFrame.FlashTexture:SetPoint("CENTER", frame.SpellFlashCoreAddonFlashFrame, "CENTER")
			frame.SpellFlashCoreAddonFlashFrame.FlashTexture:SetBlendMode("ADD")
			frame.SpellFlashCoreAddonFlashFrame:SetAlpha(1)
			frame.SpellFlashCoreAddonFlashFrame.UpdateInterval = 0.02
			frame.SpellFlashCoreAddonFlashFrame.TimeSinceLastUpdate = 0
			frame.SpellFlashCoreAddonFlashFrame:SetScript("OnUpdate", function(self, elapsed)
				self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed
				if self.TimeSinceLastUpdate >= self.UpdateInterval then
					local modifier = self.FlashModifier
					self.FlashModifier = modifier - modifier * self.TimeSinceLastUpdate
					self.TimeSinceLastUpdate = 0
					local alpha = self.FlashModifier * self.FlashBrightness
					if modifier < 0.1 or alpha <= 0 then
						self:Hide()
					else
						self.FlashTexture:SetHeight(modifier * self:GetHeight() * self.FlashSize)
						self.FlashTexture:SetWidth(modifier * self:GetWidth() * self.FlashSize)
						self.FlashTexture:SetAlpha(alpha)
					end
				end
			end)
		end
		frame.SpellFlashCoreAddonFlashFrame.FlashModifier = 1
		frame.SpellFlashCoreAddonFlashFrame.FlashSize = (size or 240) / 100
		frame.SpellFlashCoreAddonFlashFrame.FlashBrightness = (brightness or 100) / 100
		frame.SpellFlashCoreAddonFlashFrame.FlashTexture:SetAlpha(1 * frame.SpellFlashCoreAddonFlashFrame.FlashBrightness)
		frame.SpellFlashCoreAddonFlashFrame.FlashTexture:SetHeight(frame.SpellFlashCoreAddonFlashFrame:GetHeight() * frame.SpellFlashCoreAddonFlashFrame.FlashSize)
		frame.SpellFlashCoreAddonFlashFrame.FlashTexture:SetWidth(frame.SpellFlashCoreAddonFlashFrame:GetWidth() * frame.SpellFlashCoreAddonFlashFrame.FlashSize)
		if type(color) == "table" then
			frame.SpellFlashCoreAddonFlashFrame.FlashTexture:SetVertexColor(color.r or 1, color.g or 1, color.b or 1)
		elseif type(color) == "string" then
			local color = COLORTABLE[color:lower()]
			if color then
				frame.SpellFlashCoreAddonFlashFrame.FlashTexture:SetVertexColor(color.r or 1, color.g or 1, color.b or 1)
			else
				frame.SpellFlashCoreAddonFlashFrame.FlashTexture:SetVertexColor(1, 1, 1)
			end
		else
			frame.SpellFlashCoreAddonFlashFrame.FlashTexture:SetVertexColor(1, 1, 1)
		end
		frame.SpellFlashCoreAddonFlashFrame:Show()
		return true
	end
	return false
end

local function FlashActionButton(button, color, size, brightness, blink)
	if FRAMESREGISTERED and button then
		for _, frame in ipairs(ButtonFrames.Action) do
			if frame.action == button or frame._state_action == button then
				SpellFlashCore.FlashFrame(frame, color, size, brightness, blink)
			end
		end
	end
end


local function OnEvent(self, event, ...)
	local arg = {...}
	if event == "ACTIONBAR_SHOWGRID" then
			
			BUTTONSREGISTERED = nil
			
	elseif event == "ACTIONBAR_HIDEGRID" or event == "LEARNED_SPELL_IN_TAB" or event == "CHARACTER_POINTS_CHANGED" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "UPDATE_MACROS" then
			
			FRAMESREGISTERED = nil
			AddonTable:SetTimer("RegisterFrames", 0.5, 0, RegisterFrames)
			BUTTONSREGISTERED = nil
			AddonTable:SetTimer("RegisterButtons", 1, 0, RegisterButtons)
			
	elseif event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE" then
			
			if arg[1] == "player" then
				FRAMESREGISTERED = nil
				AddonTable:SetTimer("RegisterFrames", 0.5, 0, RegisterFrames)
			end
			
	elseif event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_ALIVE" then
			
			if LOADING then
				AddonTable:SetTimer("RegisterFrames", 2, 0, RegisterFrames)
				AddonTable:SetTimer("RegisterButtons", 2, 0, RegisterButtons)
				LOADING = nil
			end
			
	elseif event == "ADDON_LOADED" then
			
			if arg[1] == AddonName then
				if not SpellFlashCoreAddonConfig then
					SpellFlashCoreAddonConfig = {}
				elseif SpellFlashCoreAddonConfig.DebugEvents then
					for event in pairs(SpellFlashCoreAddonConfig.DebugEvents) do
						SpellFlashCore.RegisterDebugEvent(event)
					end
				end
			end
			
	end
end
local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("ADDON_LOADED")
EventFrame:RegisterEvent("ACTIONBAR_HIDEGRID")
EventFrame:RegisterEvent("ACTIONBAR_SHOWGRID")
EventFrame:RegisterEvent("LEARNED_SPELL_IN_TAB")
EventFrame:RegisterEvent("CHARACTER_POINTS_CHANGED")
EventFrame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
EventFrame:RegisterEvent("UPDATE_MACROS")
EventFrame:RegisterEvent("UNIT_ENTERED_VEHICLE")
EventFrame:RegisterEvent("UNIT_EXITED_VEHICLE")
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
EventFrame:RegisterEvent("PLAYER_ALIVE")
EventFrame:SetScript("OnEvent", OnEvent)


local function SlashHandler(msg)
	if msg:lower():match("event") then
		if msg:lower():match("unregister%s+all%s+event") or msg:lower():match("remove%s+all%s+event") then
			if SpellFlashCoreAddonConfig.DebugEvents then
				for event in pairs(SpellFlashCoreAddonConfig.DebugEvents) do
					SpellFlashCore.UnregisterDebugEvent(event)
					Message("-", event)
				end
			end
		else
			local event = msg:match("[Ee][Vv][Ee][Nn][Tt]%s+(%S+)%s*$")
			if event then
				if msg:lower():match("unregister%s+event%s+%S+%s*$") or msg:lower():match("remove%s+event%s+%S+%s*$") then
					if SpellFlashCoreAddonConfig.DebugEvents then
						SpellFlashCore.UnregisterDebugEvent(event)
						Message("-", event)
					end
				else
					SpellFlashCore.RegisterDebugEvent(event)
					Message("+", event)
				end
			end
		end
	elseif msg:lower():match("debug") then
		if msg:lower():match("on") then
			Message(L["debug is enabled"])
			SpellFlashCoreAddonConfig.Debug = true
		elseif msg:lower():match("off") then
			Message(L["debug is disabled"])
			SpellFlashCoreAddonConfig.Debug = nil
		elseif SpellFlashCoreAddonConfig.Debug then
			Message(L["debug is disabled"])
			SpellFlashCoreAddonConfig.Debug = nil
		else
			Message(L["debug is enabled"])
			SpellFlashCoreAddonConfig.Debug = true
		end
	elseif msg:lower():match("reset.*all") or msg:lower():match("clear.*all") or msg:lower():match("delete.*all") then
		if SpellFlashCoreAddonConfig.DebugEvents then
			for event in pairs(SpellFlashCoreAddonConfig.DebugEvents) do
				SpellFlashCore.UnregisterDebugEvent(event)
				Message("-", event)
			end
		end
		SpellFlashCoreAddonConfig = {}
		Message(L["all settings cleared"])
	end
end
SlashCmdList.SpellFlashCoreAddon = SlashHandler
SLASH_SpellFlashCoreAddon1 = "/spellflashcore"
SLASH_SpellFlashCoreAddon2 = "/sfcore"
SLASH_SpellFlashCoreAddon3 = "/sfc"


local DebugCount = 0
--- This will dump the value of msg to the default chat window if debug mode has been enabled.
-- Debug slash command: /spellflashcore debug
-- @param msg String that will be sent to the default chat window.
function SpellFlashCore.debug(...)
	if SpellFlashCoreAddonConfig.Debug and select("#", ...) > 0 then
		DebugCount = DebugCount + 1
		print("["..DebugCount.."]  ", ...)
	end
end


--- This is a function to discover if a specified spell is able to be found on the action bars to be flashed.
-- @param SpellName String of the localized spell name or the global ID number.
-- @param NoMacros If true will skip checking for macros.
-- @return Boolean indicating if a specified spell is able to be found on the action bars to be flashed.
function SpellFlashCore.Flashable(SpellName, NoMacros)
	if FRAMESREGISTERED and BUTTONSREGISTERED then
		local SpellName, FirstName = SpellName
		if type(SpellName) == "number" then
			if AddonTable.OldBuild then
				SpellName = GetSpellName(SpellName)
				FirstName = SpellName
			else
				FirstName, SpellName = GetSpellInfo(SpellName)
				if SpellName and SpellName ~= "" then
					SpellName = FirstName.."("..SpellName..")"
				else
					SpellName = FirstName
				end
			end
		else
			FirstName = SpellName
		end
		if type(SpellName) == "string" and SpellName ~= "" then
			if Buttons.Spell[SpellName] or Buttons.Item[SpellName] or Frames.Spell[SpellName] or Frames.Item[SpellName] then
				return true
			elseif not NoMacros and ( GetSpellInfo(SpellName) or GetItemCount(SpellName) > 0 ) then
				local SpellTexture = GetSpellTexture(SpellName)
				local ItemTexture = GetItemIcon(SpellName)
				for n in pairs(Buttons.Macro) do
					local name, MacroTexture, body = GetMacroInfo(tonumber(n))
					if ( MacroTexture == SpellTexture or MacroTexture == ItemTexture ) and body and body:lower():find(FirstName:lower(),nil,true) then
						return true
					end
				end
				for n in pairs(Frames.Macro) do
					local name, MacroTexture, body = GetMacroInfo(tonumber(n))
					if ( MacroTexture == SpellTexture or MacroTexture == ItemTexture ) and body and body:lower():find(FirstName:lower(),nil,true) then
						return true
					end
				end
			end
		end
	end
	return false
end

--- This is used to flash an action bar spell.
-- @param SpellName String of the localized spell name or the global ID number.
-- @param color Will accept color tables {r=1.0, g=1.0, b=1.0} or a string with the name of a color that has already been defined by this addon. May be nil for White.
-- @param size Number representing the percent size of the flash. If nil will use a default value.
-- @param brightness Number from 0 to 100 representing the percent brightness of the flash. If nil will use 100.
-- @param NoMacros If true will not flash macros.
function SpellFlashCore.FlashAction(SpellName, color, size, brightness, blink, NoMacros)
	if FRAMESREGISTERED and BUTTONSREGISTERED then
		local SpellName, FirstName = SpellName
		if type(SpellName) == "number" then
			if AddonTable.OldBuild then
				SpellName = GetSpellName(SpellName)
				FirstName = SpellName
			else
				FirstName, SpellName = GetSpellInfo(SpellName)
				if SpellName and SpellName ~= "" then
					SpellName = FirstName.."("..SpellName..")"
				else
					SpellName = FirstName
				end
			end
		else
			FirstName = SpellName
		end
		if type(SpellName) == "string" and SpellName ~= "" then
			if Buttons.Spell[SpellName] then
				for _, button in ipairs(Buttons.Spell[SpellName]) do
					FlashActionButton(button, color, size, brightness, blink)
				end
			end
			if Buttons.Item[SpellName] then
				for _, button in ipairs(Buttons.Item[SpellName]) do
					FlashActionButton(button, color, size, brightness, blink)
				end
			end
			if Frames.Spell[SpellName] then
				for _, frame in ipairs(Frames.Spell[SpellName]) do
					SpellFlashCore.FlashFrame(frame, color, size, brightness, blink)
				end
			end
			if Frames.Item[SpellName] then
				for _, frame in ipairs(Frames.Item[SpellName]) do
					SpellFlashCore.FlashFrame(frame, color, size, brightness, blink)
				end
			end
			if not NoMacros and ( GetSpellInfo(SpellName) or GetItemCount(SpellName) > 0 ) then
				local SpellTexture = GetSpellTexture(SpellName)
				local ItemTexture = GetItemIcon(SpellName)
				for n, v in pairs(Buttons.Macro) do
					local name, MacroTexture, body = GetMacroInfo(tonumber(n))
					if ( MacroTexture == SpellTexture or MacroTexture == ItemTexture ) and body and body:lower():find(FirstName:lower(),nil,true) then
						for _, button in ipairs(v) do
							FlashActionButton(button, color, size, brightness, blink)
						end
					end
				end
				for n, v in pairs(Frames.Macro) do
					local name, MacroTexture, body = GetMacroInfo(tonumber(n))
					if ( MacroTexture == SpellTexture or MacroTexture == ItemTexture ) and body and body:lower():find(FirstName:lower(),nil,true) then
						for _, frame in ipairs(v) do
							SpellFlashCore.FlashFrame(frame, color, size, brightness, blink)
						end
					end
				end
			end
		end
	end
end

--- This is used to flash a vehicle bar spell.
-- @param SpellName String of the localized spell name or the global ID number.
-- @param color Will accept color tables {r=1.0, g=1.0, b=1.0} or a string with the name of a color that has already been defined by this addon. May be nil for White.
-- @param size Number representing the percent size of the flash. If nil will use a default value.
-- @param brightness Number from 0 to 100 representing the percent brightness of the flash. If nil will use 100.
function SpellFlashCore.FlashVehicle(SpellName, color, size, brightness, blink)
	if FRAMESREGISTERED and UnitHasVehicleUI("player") then
		local SpellName = SpellName
		if type(SpellName) == "number" then
			SpellName = GetSpellName(SpellName)
		end
		if type(SpellName) == "string" and SpellName ~= "" then
			local ID
			for i=121,126 do
				
				if AddonTable.OldBuild then
					ID = select(4, GetActionInfo(i))
				else
					ID = select(2, GetActionInfo(i))
				end
				
				if ID and GetSpellName(ID) == SpellName then
					for _, frame in ipairs(ButtonFrames.Vehicle) do
						if frame.action == i or frame._state_action == i then
							SpellFlashCore.FlashFrame(frame, color, size, brightness, blink)
						end
					end
					for _, frame in ipairs(ButtonFrames.Action) do
						if frame.action == i or frame._state_action == i then
							SpellFlashCore.FlashFrame(frame, color, size, brightness, blink)
						end
					end
				end
			end
		end
	end
end

--- This is used to flash a pet bar spell.
-- @param SpellName String of the localized spell name or the global ID number.
-- @param color Will accept color tables {r=1.0, g=1.0, b=1.0} or a string with the name of a color that has already been defined by this addon. May be nil for White.
-- @param size Number representing the percent size of the flash. If nil will use a default value.
-- @param brightness Number from 0 to 100 representing the percent brightness of the flash. If nil will use 100.
function SpellFlashCore.FlashPet(SpellName, color, size, brightness, blink)
	if FRAMESREGISTERED then
		local SpellName = SpellName
		if type(SpellName) == "number" then
			SpellName = GetSpellName(SpellName)
		end
		if type(SpellName) == "string" and SpellName ~= "" then
			for n = 1, NUM_PET_ACTION_SLOTS do
				local name, subtext = GetPetActionInfo(n)
				if not AddonTable.OldBuild and subtext and subtext ~= "" then
					name = name.."("..subtext..")"
				end
				if ( AddonTable.PetActions[SpellName] or SpellName ) == name then
					for _, frame in ipairs(ButtonFrames.Pet) do
						if frame:GetID() == n then
							SpellFlashCore.FlashFrame(frame, color, size, brightness, blink)
						end
					end
				end
			end
		end
	end
end

--- This is used to flash a stance, form, presence, aura or aspect bar spell.
-- @param SpellName String of the localized spell name or the global ID number.
-- @param color Will accept color tables {r=1.0, g=1.0, b=1.0} or a string with the name of a color that has already been defined by this addon. May be nil for White.
-- @param size Number representing the percent size of the flash. If nil will use a default value.
-- @param brightness Number from 0 to 100 representing the percent brightness of the flash. If nil will use 100.
function SpellFlashCore.FlashForm(SpellName, color, size, brightness, blink)
	if FRAMESREGISTERED then
		local SpellName = SpellName
		if type(SpellName) == "number" then
			SpellName = GetSpellName(SpellName, 1)
		end
		if type(SpellName) == "string" and SpellName ~= "" then
			for n=1,GetNumShapeshiftForms() do
				if select(2,GetShapeshiftFormInfo(n)) == SpellName then
					for _, frame in ipairs(ButtonFrames.Form) do
						if frame:GetID() == n then
							SpellFlashCore.FlashFrame(frame, color, size, brightness, blink)
						end
					end
				end
			end
		end
	end
end


local DebugEventFrame = CreateFrame("Frame")
DebugEventFrame.LastEventTime = 0
DebugEventFrame:SetScript("OnEvent", function(self, event, ...)
	if SpellFlashCoreAddonConfig.Debug then
		local t = GetTime()
		SpellFlashCore.debug("event:  "..event)
		SpellFlashCore.debug("       Time:  "..t.."  -  "..self.LastEventTime.."  =  "..( t - self.LastEventTime ))
		self.LastEventTime = t
		local n = select("#", ...)
		if n > 0 then
			local arg = {...}
			for i=1,n do
				if type(arg[i]) ~= "nil" then
					SpellFlashCore.debug("       arg"..i.." = "..type(arg[i])..": "..tostring(arg[i]))
				end
			end
		end
	end
end)

--- This will register an event for debugging purposes.
-- Debug slash command: /spellflashcore debug
-- Debug event slash command: /spellflashcore event EVENT_NAME
-- @param event Event string name to register.
function SpellFlashCore.RegisterDebugEvent(event)
	DebugEventFrame:RegisterEvent(event)
	if not SpellFlashCoreAddonConfig.DebugEvents then
		SpellFlashCoreAddonConfig.DebugEvents = {}
	end
	SpellFlashCoreAddonConfig.DebugEvents[event] = true
end

--- This will unregister an event for debugging purposes.
-- Debug slash command: /spellflashcore debug
-- Debug event slash command: /spellflashcore unregister event EVENT_NAME
-- @param event Event string name to unregister.
function SpellFlashCore.UnregisterDebugEvent(event)
	DebugEventFrame:UnregisterEvent(event)
	if SpellFlashCoreAddonConfig.DebugEvents then
		SpellFlashCoreAddonConfig.DebugEvents[event] = nil
		if not next(SpellFlashCoreAddonConfig.DebugEvents) then
			SpellFlashCoreAddonConfig.DebugEvents = nil
		end
	end
end




-- This is used for testing purposes only
-- Example: SpellFlashCore.SaveAllFrameNameStringsIntoATable(SpellFlashAddonConfig)
function SpellFlashCore.SaveAllFrameNameStringsIntoATable(TABLE)
	if type(TABLE) == "table" then
		local s = "ALL DETECTABLE FRAME STRINGS"
		TABLE[s] = {}
		local frame = EnumerateFrames()
		while frame do
			if frame:GetName() then
				if frame.IsProtected and frame.GetObjectType and frame.GetScript and frame:GetObjectType() == "CheckButton" and frame:IsProtected() then
					local script = frame:GetScript("OnClick")
					if not TABLE[s].Buttons then
						TABLE[s].Buttons = {}
					end
					if script == ShapeshiftButton1:GetScript("OnClick") then
						if not TABLE[s].Buttons.Form then
							TABLE[s].Buttons.Form = {}
						end
						TABLE[s].Buttons.Form[frame:GetName()] = "form"
					elseif script == PetActionButton1:GetScript("OnClick") then
						if not TABLE[s].Buttons.Pet then
							TABLE[s].Buttons.Pet = {}
						end
						TABLE[s].Buttons.Pet[frame:GetName()] = "pet"
					elseif script == VehicleMenuBarActionButton1:GetScript("OnClick") then
						if not TABLE[s].Buttons.Vehicle then
							TABLE[s].Buttons.Vehicle = {}
						end
						TABLE[s].Buttons.Vehicle[frame:GetName()] = "vehicle"
					elseif script == ActionButton1:GetScript("OnClick") then
						if not TABLE[s].Buttons.Action then
							TABLE[s].Buttons.Action = {}
						end
						TABLE[s].Buttons.Action[frame:GetName()] = "action"
					else
						if not TABLE[s].Buttons.Other then
							TABLE[s].Buttons.Other = {}
						end
						TABLE[s].Buttons.Other[frame:GetName()] = "other"
					end
				else
					if not TABLE[s].Any then
						TABLE[s].Any = {}
					end
					TABLE[s].Any[frame:GetName()] = "any"
				end
			end
			frame = EnumerateFrames(frame)
		end
	end
end

