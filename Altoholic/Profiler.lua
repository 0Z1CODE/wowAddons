-- Simple code profiler, inspired by Chapter 1.14 (p120-130) of Game Programming Gems 1 
-- Ported from C++ to Lua by Thaoky. It will most likely evolve as my needs change.

local addon = Altoholic
addon.Profiler = {}

function addon.Profiler:Init() 
	self.Samples = self.Samples or {}
	addon.ClearTable(self.Samples)
	self.startProfile = GetTime()
	self.level = 0		-- for the code hierarchy, unused for now, but already valid, will be useful when Dumping into a real frame
	self.count = 0		-- to sort samples
end

function addon.Profiler:Begin(name)
	self.Samples[name] = self.Samples[name] or {}
	local p = self.Samples[name]
	
	p.startTime = GetTime() 
	if p.numPasses then						-- if numPasses exists, it's an existing entry, update it and exit
		p.numPasses = p.numPasses + 1
		return
	end

	p.accumulator = 0
	p.duration = 0
	p.numPasses = 1
	
	p.level = self.level
	self.level = self.level + 1
	self.count = self.count + 1
	p.position = self.count
end

function addon.Profiler:End(name)
	local p = self.Samples[name]
	if not p then return end
	
	p.duration = GetTime() - p.startTime 
	p.minTime = p.minTime or p.duration
	if p.duration < p.minTime then			-- new min ?
		p.minTime = p.duration
	end
	
	p.maxTime = p.maxTime or p.duration		-- new max ?
	if p.duration > p.maxTime then
		p.maxTime = p.duration
	end
	
	p.accumulator = p.accumulator + p.duration 
	self.level = self.level - 1
end

function addon.Profiler:Dump() 
	
	local view = {}
	
	for k, _ in pairs(self.Samples) do
		table.insert(view, k)
	end
	
	sort(view, function(a, b)
		local s = addon.Profiler.Samples
		local posA = s[a].position
		local posB = s[b].position
		return posA < posB
	end) 

	addon:Print("Profiler Samples") 
	addon:Print("   Avg   |   Min   |   Max   |  Num  |  Name") 
	for _, name in ipairs(view) do
		local v = self.Samples[name]
		addon:Print(format(" %.1f ms | %.1f ms | %.1f ms | %d | %s",
			(v.accumulator/v.numPasses)*1000, v.minTime*1000, v.maxTime*1000, v.numPasses, name))
	end 

end

function addon.Profiler:GetSampleDuration(name) 
	local p = self.Samples[name] 
	return p and p.duration or 0 
end

