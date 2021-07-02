local AddonName, AddonTable = ...
local L = AddonTable.Localize
AddonTable.Castable = {}
AddonTable.VehicleCastable = {}
AddonTable.ItemCastable = {}
local s = SpellFlashAddon

local OptionsFrameTemplate = "SpellFlashAddon_OptionsFrameTemplate1"

local OptionsFrameName = AddonName.."_SpellFlashAddonOptionsFrame"

SpellFlashAddon[OptionsFrameName.."_UpdateScriptSliderText"] = function(self)
	if self and self:IsVisible() then
		local Value = self:GetValue()
		if type(AddonTable.Spam[Value]) ~= "table" or type(AddonTable.Spam[Value].Function) ~= "function" then
			Value = 1
		end
		_G[OptionsFrameName.."_ScriptSliderTitleLabel"]:SetText(AddonTable.Spam[Value].Title or "")
		_G[OptionsFrameName.."_ScriptSliderDescriptionLabel"]:SetText(AddonTable.Spam[Value].Description or "")
		_G[OptionsFrameName.."_ScriptSliderValueLabel"]:SetText(""..Value)
	end
end

local OptionsFrame = CreateFrame("Frame", OptionsFrameName, nil, OptionsFrameTemplate)

if L["Spell Flashing"] == "Spell Flashing" and SpellFlashAddonOptionsFrame_SpellFlashingText and SpellFlashAddonOptionsFrame_SpellFlashingText:GetText() ~= "Spell Flashing" then
	L["Spell Flashing"] = SpellFlashAddonOptionsFrame_SpellFlashingText:GetText()
end
for _, Frame in next,{OptionsFrame:GetChildren()} do
	if Frame:GetObjectType() == "FontString" then
		local text = Frame:GetText()
		if text and text ~= "" then
			Frame:SetText(L[text])
		end
	else
		for _, Frame in next,{Frame:GetRegions()} do
			if Frame:GetObjectType() == "FontString" then
				local text = Frame:GetText()
				if text and text ~= "" then
					Frame:SetText(L[text])
				end
			end
		end
	end
end
_G[OptionsFrameName.."TitleString"]:SetText(select(2, GetAddOnInfo(AddonName)).." "..GetAddOnMetadata(AddonName, "Version"))

OptionsFrame.okay = function()
	if _G[OptionsFrameName.."_SpellFlashing"]:GetChecked() then
		s.SetModuleConfig(AddonName, "spell_flashing_off", nil)
	else
		s.SetModuleConfig(AddonName, "spell_flashing_off", true)
	end
	if type(AddonTable.Spam) == "table" and type(AddonTable.Spam[1]) == "table" and type(AddonTable.Spam[1].Function) == "function" then
		local Value = _G[OptionsFrameName.."_ScriptSlider"]:GetValue()
		if Value == 1 or type(AddonTable.Spam[Value]) ~= "table" or type(AddonTable.Spam[Value].Function) ~= "function" then
			Value = nil
		end
		s.SetModuleConfig(AddonName, "script_number", Value)
	end
end

OptionsFrame.default = function()
	s.ClearAllModuleConfigs(AddonName)
end

OptionsFrame.refresh = function()
	_G[OptionsFrameName.."_SpellFlashing"]:SetChecked(not s.GetModuleConfig(AddonName, "spell_flashing_off"))
	if type(AddonTable.Spam) == "table" and type(AddonTable.Spam[1]) == "table" and type(AddonTable.Spam[1].Function) == "function" then
		_G[OptionsFrameName.."_ScriptSlider"]:Show()
		_G[OptionsFrameName.."_ScriptSliderTitle"]:Show()
		_G[OptionsFrameName.."_ScriptSliderDescription"]:Show()
		_G[OptionsFrameName.."_ScriptSliderMinValue"]:Show()
		_G[OptionsFrameName.."_ScriptSliderMaxValue"]:Show()
		_G[OptionsFrameName.."_ScriptSliderValue"]:Show()
		local MaxValue = getn(AddonTable.Spam)
		_G[OptionsFrameName.."_ScriptSlider"]:SetMinMaxValues(1, MaxValue)
		_G[OptionsFrameName.."_ScriptSliderMinValueLabel"]:SetText("1")
		_G[OptionsFrameName.."_ScriptSliderMaxValueLabel"]:SetText(""..MaxValue)
		local Value = s.GetModuleConfig(AddonName, "script_number") or 1
		if type(AddonTable.Spam[Value]) ~= "table" or type(AddonTable.Spam[Value].Function) ~= "function" then
			Value = 1
		end
		_G[OptionsFrameName.."_ScriptSlider"]:SetValue(Value)
		_G[OptionsFrameName.."_ScriptSliderTitleLabel"]:SetText(AddonTable.Spam[Value].Title or "")
		_G[OptionsFrameName.."_ScriptSliderDescriptionLabel"]:SetText(AddonTable.Spam[Value].Description or "")
		_G[OptionsFrameName.."_ScriptSliderValueLabel"]:SetText(""..Value)
	end
end

OptionsFrame.parent = select(2, GetAddOnInfo("SpellFlash"))
OptionsFrame.name = select(2, GetAddOnInfo(AddonName))

InterfaceOptions_AddCategory(OptionsFrame)
