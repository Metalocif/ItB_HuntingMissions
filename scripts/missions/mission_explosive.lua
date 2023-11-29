local mod = modApi.currentMod
local path = mod_loader.mods[mod].scriptPath
local this = {id = "Mission_Meta_Explosive"}
local corpMissions = require(path .."corpMissions")
-- local corpIslandMissions = require(path .."corpIslandMissions")


Mission_Meta_Explosive = Mission_Infinite:new{
	Name = "Explosive Vek",
	Objectives = Objective("Kill the Explosive Vek",1,1),
	Target = 0,
	BlockedUnits = {"Jelly_Explode", "Dung", "Blobber"},
}

function Mission_Meta_Explosive:StartMission()
	local pawn = PAWN_FACTORY:CreatePawn("Meta_ExplosiveDigger")
	self.Target = pawn:GetId()
	Board:SpawnPawn(pawn)
	Board:AddPawn(PAWN_FACTORY:CreatePawn("Deploy_ShieldTankB"))--, "deployment"))
end


function Mission_Meta_Explosive:GetDestroyedCount()
	if not Board:IsPawnAlive(self.Target) then
		return 1
	end
	return 0
end

function Mission_Meta_Explosive:UpdateObjectives()
	local status = not Board:IsPawnAlive(self.Target) and OBJ_COMPLETE or OBJ_STANDARD
	Game:AddObjective("Kill the Explosive Vek",status)
end

function Mission_Meta_Explosive:GetCompletedObjectives()
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
	LOG("_________loaded explosive_________")
	corpMissions.Add_Missions_High("Mission_Meta_Explosive")
end

return this