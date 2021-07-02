

function RR_GetEPGPGuildData()




	if RaidRoll_DB["EPGP"] == nil then RaidRoll_DB["EPGP"] = {} end
-- Setting up default Values
	RaidRoll_DB["DECAY_P"]  = 0		-- The decay (in %)
	RaidRoll_DB["EXTRAS_P"] = 0		-- Standby EPGP
	RaidRoll_DB["MIN_EP"]   = 2500		-- Min ep req to be eligable for loot
	RaidRoll_DB["BASE_GP"]  = 100		-- GP value you start with
	
	
	if RR_EPGPHasLoaded == true then
		RR_ReallyGetEPGPGuildData()
	end
end


function RR_GetEPGPCharacterData(character)

-- setup defaults
local PR = 0
local AboveThreshold = false
local EP = 0
local GP = 0


	if RR_EPGPHasLoaded == true then
		
		PR,AboveThreshold,EP,GP = RR_ReallyGetEPGPCharacterData(character)
		
	end
	
	return PR,AboveThreshold,EP,GP
	
end

function RR_EPGP_Setup()


	if RR_EPGPHasLoaded == true then
		local EPGP_Event = CreateFrame("Frame")
	 
		EPGP_Event:RegisterEvent("CHAT_MSG_RAID")
		EPGP_Event:RegisterEvent("CHAT_MSG_OFFICER")
		EPGP_Event:RegisterEvent("CHAT_MSG_GUILD")
		EPGP_Event:RegisterEvent("CHAT_MSG_ADDON")
		
		EPGP_Event:SetScript("OnEvent", EPGP_Event_Function)
	end
end


function EPGP_Event_Function(self, event, ...)
	local arg1, arg2, arg3, arg4, arg5, arg6 = ...;
	
	if arg1 ~= nil then
		GuildString = string.lower(arg1)
		
		if string.find(GuildString, "epgp") then 
			if RaidRoll_DB["debug"] == true then RR_Test("EPGP String Found, updating guild info") end
			if IsInGuild() then
				RR_GetEPGPGuildData()
				GuildRoster();
			end
		end
	end
end 