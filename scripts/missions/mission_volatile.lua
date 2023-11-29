local mod = modApi.currentMod
local path = mod_loader.mods[mod].scriptPath
local this = {id = "Mission_Meta_Volatile"}
local corpMissions = require(path .."corpMissions")


Mission_Meta_Volatile = Mission_Infinite:new{
	Name = "Volatile Vek",
	Objectives = Objective("Capture the Volatile Vek",1,1),
	Target = 0
}

function Mission_Meta_Volatile:StartMission()
	local pawn = PAWN_FACTORY:CreatePawn("Meta_VolatileBouncer")
	self.Target = pawn:GetId()
	Board:SpawnPawn(pawn)
	Board:AddPawn(PAWN_FACTORY:CreatePawn("Meta_SleepHeli"))
end

function Mission_Meta_Volatile:UpdateObjectives()
	local status 
	if Board:GetPawn(self.Target) then
		status = (not Board:GetPawn(self.Target):IsPowered()) and OBJ_COMPLETE or OBJ_STANDARD
	else
		status = OBJ_FAILED
	end
	Game:AddObjective("Capture the Volatile Vek",status)
end

function Mission_Meta_Volatile:GetCompletedObjectives()
	if not Board:GetPawn(self.Target) then return self.Objectives:Failed() end
	if Board:GetPawn(self.Target):IsPowered() then return self.Objectives:Failed() end
	return self.Objectives
end
--------------------------------------------------------------------

--------------------------------------------------------------------

function this:init(mod)	

end

function this:load(mod, options, version)
	LOG("_________loaded volatile_________")
	corpMissions.Add_Missions_High("Mission_Meta_Volatile")
end

return this