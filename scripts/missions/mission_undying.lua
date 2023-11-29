local mod = modApi.currentMod
local path = mod_loader.mods[mod].scriptPath
local this = {id = "Mission_Meta_Undying"}
local corpMissions = require(path .."corpMissions")
-- local corpIslandMissions = require(path .."corpIslandMissions")


Mission_Meta_Undying = Mission_Infinite:new{
	Name = "Undying Vek",
	Objectives = Objective("Kill the Undying Vek",1,1),
	Target = 0,
	GlobalSpawnMod = -1,
}

function Mission_Meta_Undying:StartMission()
	local pawn = PAWN_FACTORY:CreatePawn("Meta_UndyingVek")
	self.Target = pawn:GetId()
	Board:SpawnPawn(pawn)
end

function Mission_Meta_Undying:GetDestroyedCount()
	if not Board:IsPawnAlive(self.Target) then
		return 1
	end
	return 0
end

function Mission_Meta_Undying:UpdateObjectives()
	local status = not Board:IsPawnAlive(self.Target) and OBJ_COMPLETE or OBJ_STANDARD
	Game:AddObjective("Kill the Undying Vek",status)
end

function Mission_Meta_Undying:GetCompletedObjectives()
	if Board:IsPawnAlive(self.Target) then
		return self.Objectives:Failed()
	end
	return self.Objectives
end
--------------------------------------------------------------------

--------------------------------------------------------------------

function this:init(mod)	

end
function this:load(mod, options, version)
	LOG("_________loaded undying_________")
	corpMissions.Add_Missions_High("Mission_Meta_Undying")
end

return this