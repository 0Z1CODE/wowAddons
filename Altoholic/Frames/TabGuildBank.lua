local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local V = Altoholic.vars
local WHITE		= "|cFFFFFFFF"
local TEAL		= "|cFF00FF9A"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

function AltoholicTabGuildBank:SelectGuildDropDown_Initialize()
	local info = UIDropDownMenu_CreateInfo(); 

	for AccountName, a in pairs(Altoholic.db.global.data) do
		for RealmName, r in pairs(a) do
			for GuildName, _ in pairs(r.guild) do
				info.text = GREEN .. GuildName .. WHITE .. " (" .. RealmName 
								.." / ".. YELLOW .. AccountName ..  WHITE.. ")"
				info.value = AccountName .."|" .. RealmName .."|".. GuildName
				info.checked = nil; 
				info.func = function(self) AltoholicTabGuildBank:ChangeGuild(self) end
				UIDropDownMenu_AddButton(info, 1); 
			end
		end
	end
end

function AltoholicTabGuildBank:ChangeGuild(self)
	local account, realm, guildname = strsplit("|", self.value)

	UIDropDownMenu_ClearAll(AltoholicTabGuildBank_SelectGuild);
	UIDropDownMenu_SetSelectedValue(AltoholicTabGuildBank_SelectGuild, account .."|" .. realm .."|".. guildname)
	UIDropDownMenu_SetText(AltoholicTabGuildBank_SelectGuild, GREEN .. guildname .. WHITE .. " (" .. realm .. ")")

	AltoholicTabGuildBank:LoadGuild(account, realm, guildname)
end

function AltoholicTabGuildBank:LoadGuild(account, realm, name)
	local guild = Altoholic.db.global.data[account][realm].guild[name]
	AltoGuildBank:Hide()
	for i = 1, 6 do
		_G[ "AltoholicTabGuildBankMenuItem"..i ]:UnlockHighlight();
		local t = guild.bank[i]
		if t.name then
			_G[ "AltoholicTabGuildBankMenuItem" .. i ]:SetText(WHITE .. t.name)
		else
			_G[ "AltoholicTabGuildBankMenuItem" .. i ]:SetText(YELLOW .. L["N/A"])
		end
		_G[ "AltoholicTabGuildBankMenuItem" .. i ]:Show()
	end
	
	AltoholicTabGuildBank_HideInTooltip:SetChecked(guild.hideInTooltip)
	AltoholicTabGuildBankMoney:SetText(MONEY .. ": " .. Altoholic:GetMoneyString(guild.bankmoney))
end

function AltoholicTabGuildBank:HideGuild(self)

	local value = UIDropDownMenu_GetSelectedValue(AltoholicTabGuildBank_SelectGuild)
	if not value then return end
	
	local account, realm, guildname = strsplit("|", value)
	local guild = Altoholic.db.global.data[account][realm].guild[guildname]
	
	if self:GetChecked() then 
		guild.hideInTooltip = true
	else
		guild.hideInTooltip = nil
	end
end

function AltoholicTabGuildBank:DeleteGuild()
	AltoMsgBox.ButtonHandler = AltoholicTabGuildBank.ButtonHandler
	local value = UIDropDownMenu_GetSelectedValue(AltoholicTabGuildBank_SelectGuild)
	if not value then return end
	
	local _, realm, guildname = strsplit("|", value)
	
	AltoMsgBox_Text:SetText(L["Delete Guild Bank?"] .. "\n" .. GREEN .. guildname .. WHITE .. " (" .. realm .. ")")
	AltoMsgBox:Show()
end

function AltoholicTabGuildBank:ButtonHandler(button)
	AltoMsgBox.ButtonHandler = nil		-- prevent any other call to msgbox from coming back here
	if not button then return end
	
	local value = UIDropDownMenu_GetSelectedValue(AltoholicTabGuildBank_SelectGuild)
	local account, realm, guildname = strsplit("|", value)
	local guild = Altoholic.db.global.data[account][realm].guild

	for i=1, 6 do
		_G[ "AltoholicTabGuildBankMenuItem"..i ]:Hide()
	end
	
	AltoholicTabGuildBankInfo1:SetText("")
	AltoholicTabGuildBankInfo2:SetText("")
	AltoholicTabGuildBankMoney:SetText("")
	
	AltoGuildBank:Hide()
	Altoholic:ClearTable(guild[guildname])	-- clear all content for this guild ..
	guild[guildname] = nil						-- .. then the guild entry itself
	UIDropDownMenu_ClearAll(AltoholicTabGuildBank_SelectGuild);
	
	Altoholic:Print(format( L["Guild %s successfully deleted"], guildname))
end
