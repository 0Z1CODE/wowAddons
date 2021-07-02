
local MajorVersion = "BigLibTimer3"
local BigLibTimer = LibStub:NewLibrary(MajorVersion, tonumber("42") or 99999999999999)
if not BigLibTimer then return end

BigLibTimer.API = {}

function BigLibTimer:Register(handler)
	if type(handler) ~= "table" then
		handler = {}
	end
	handler[MajorVersion] = {}
	handler[MajorVersion].TimerFrame = CreateFrame("Frame")
	handler[MajorVersion].TimerFrame:Hide()
	handler[MajorVersion].TIMER = {}
	handler[MajorVersion].TimerFrame:SetScript("OnUpdate", function() BigLibTimer:OnUpdate(handler) end)
	for key in pairs(BigLibTimer.API) do
		handler[key] = function(...) return BigLibTimer.API[key](...) end
	end
	return handler
end

function BigLibTimer:OnUpdate(handler)
	local TIMER = handler[MajorVersion].TIMER
	if next(TIMER) then
		if not handler[MajorVersion].Running then
			handler[MajorVersion].Running = true
			for Name in pairs(TIMER) do
				if TIMER and TIMER[Name] and not TIMER[Name].Running and TIMER[Name].Seconds <= GetTime() then
					if TIMER[Name].Function then
						TIMER[Name].Function(unpack(TIMER[Name].Args))
						if TIMER and TIMER[Name] and TIMER[Name].Seconds <= GetTime() then
							if TIMER[Name].RepeatSeconds > 0 then
								TIMER[Name].Seconds = GetTime() + TIMER[Name].RepeatSeconds
							else
								TIMER[Name] = nil
							end
						end
					elseif TIMER[Name].RepeatSeconds > 0 then
						TIMER[Name].Seconds = GetTime() + TIMER[Name].RepeatSeconds
					else
						TIMER[Name] = nil
					end
				end
			end
			if not next(TIMER) then
				handler[MajorVersion].TimerFrame:Hide()
			end
			handler[MajorVersion].Running = false
		end
	elseif not handler[MajorVersion].Running then
		handler[MajorVersion].TimerFrame:Hide()
	end
end

function BigLibTimer.API:SetTimer(Name, Seconds, RepeatSeconds, Function, ...)
	local TIMER = self[MajorVersion].TIMER
	if type(Name) == "string" and TIMER then
		TIMER[Name] = {}
		TIMER[Name].Running = true
		if type(Seconds) == "number" and Seconds > 0 then
			TIMER[Name].Seconds = GetTime() + Seconds
		else
			TIMER[Name].Seconds = 0
		end
		if type(RepeatSeconds) == "number" then
			TIMER[Name].RepeatSeconds = RepeatSeconds
		else
			TIMER[Name].RepeatSeconds = 0
		end
		if type(Function) == "function" then
			TIMER[Name].Function = Function
			TIMER[Name].Args = {...}
		end
		if TIMER[Name].Seconds == 0 and TIMER[Name].Function then
			Function(...)
			if TIMER and TIMER[Name] and TIMER[Name].Seconds <= GetTime() then
				if TIMER[Name].RepeatSeconds > 0 then
					TIMER[Name].Seconds = GetTime() + TIMER[Name].RepeatSeconds
				else
					TIMER[Name] = nil
				end
			end
		end
		if TIMER and TIMER[Name] then
			TIMER[Name].Running = false
			self[MajorVersion].TimerFrame:Show()
		end
	end
end

function BigLibTimer.API:ReplaceTimer(Name, Seconds, RepeatSeconds, Function, ...)
	local TIMER = self[MajorVersion].TIMER
	if type(Name) == "string" and TIMER[Name] then
		if type(Seconds) == "number" and Seconds > 0 then
			TIMER[Name].Seconds = GetTime() + Seconds
		elseif Seconds then
			TIMER[Name].Seconds = 0
		end
		if type(RepeatSeconds) == "number" then
			TIMER[Name].RepeatSeconds = RepeatSeconds
		elseif RepeatSeconds then
			TIMER[Name].RepeatSeconds = 0
		end
		if type(Function) == "function" then
			TIMER[Name].Function = Function
			TIMER[Name].Args = {...}
		elseif Function then
			TIMER[Name].Function = nil
		end
		return true
	end
	return false
end

function BigLibTimer.API:ClearTimer(Name, Search)
	local TIMER = self[MajorVersion].TIMER
	local found = false
	if type(Name) == "string" then
		if Search then
			for key in pairs(TIMER) do
				if key:match(Name) and ( TIMER[key].RepeatSeconds > 0 or TIMER[key].Seconds - GetTime() > 0 ) then
					TIMER[key] = nil
					found = true
				end
			end
		elseif TIMER[Name] and ( TIMER[Name].RepeatSeconds > 0 or TIMER[Name].Seconds - GetTime() > 0 ) then
			TIMER[Name] = nil
			return true
		end
	end
	return found
end

function BigLibTimer.API:ClearAllTimers()
	self[MajorVersion].TIMER = {}
end

function BigLibTimer.API:IsTimer(Name, Search)
	local TIMER = self[MajorVersion].TIMER
	if type(Name) == "string" then
		if Search then
			for key in pairs(TIMER) do
				if key:match(Name) and ( TIMER[key].RepeatSeconds > 0 or TIMER[key].Seconds - GetTime() > 0 ) then
					return true
				end
			end
		elseif TIMER[Name] and ( TIMER[Name].RepeatSeconds > 0 or TIMER[Name].Seconds - GetTime() > 0 ) then
			return true
		end
	end
	return false
end

function BigLibTimer.API:GetTimer(Name)
	local TIMER = self[MajorVersion].TIMER
	if type(Name) == "string" and TIMER[Name] then
		local TimeRemaining = TIMER[Name].Seconds - GetTime()
		if TimeRemaining > 0 then
			return TimeRemaining
		end
	end
	return 0
end

function BigLibTimer.API:UnRegister()
	if type(self) == "table" and type(self[MajorVersion]) == "table" then
		if type(self[MajorVersion].TimerFrame) == "table" then
			self[MajorVersion].TimerFrame:Hide()
		end
		self[MajorVersion] = nil
		for key in pairs(BigLibTimer.API) do
			self[key] = nil
		end
	end
end
