local mod = modApi.currentMod
local path = mod_loader.mods[mod].scriptPath
local resourcepath = mod_loader.mods[mod].resourcePath
local this = {id = "Mission_Meta_DeadTanks"}
local corpMissions = require(path .."corpMissions")
-- local corpIslandMissions = require(path .."corpIslandMissions")

modApi:appendAsset("img/combat/deadtankice.png", resourcepath .."img/combat/deadtankice.png")
modApi:appendAsset("img/combat/deadtankacid.png", resourcepath .."img/combat/deadtankacid.png")

local freezetankeffect = SpaceDamage(1)
freezetankeffect.sScript = string.format([[
local loc
for _, tile in ipairs(Board)
	if Board:GetItem(tile) == "Meta_DeadTankFreeze" then loc = tile LOG("found tank") break end
end
if loc then 
	local pawn = Board:GetPawn(loc)
	if pawn and pawn:GetTeam() == TEAM_PLAYER and pawn:IsMech() then pawn:AddWeapon("TankMission_FreezeWeapon") end
else
	LOG("not found")
end]])

Meta_DeadTankFreeze = { Image = "combat/deadtankice.png", Damage = freezetankeffect, Tooltip = "Meta_Freeze_Tank_Tooltip", Icon = "combat/deadtankice.png", UsedImage = ""}


local acidtankeffect = SpaceDamage(1)
acidtankeffect.sScript = string.format([[
local loc
for _, tile in ipairs(Board)
	if Board:GetItem(tile) == "Meta_DeadTankAcid" then loc = tile LOG("found tank") break end
end
if loc then 
	local pawn = Board:GetPawn(loc)
	if pawn and pawn:GetTeam() == TEAM_PLAYER and pawn:IsMech() then pawn:AddWeapon("TankMission_AcidWeapon") end
else
	LOG("not found")
end]])

Meta_DeadTankAcid = { Image = "combat/deadtankacid.png", Damage = acidtankeffect, Tooltip = "Meta_Acid_Tank_Tooltip", Icon = "combat/deadtankacid.png", UsedImage = ""}

TILE_TOOLTIPS = {
	Meta_Freeze_Tank_Tooltip = {"Dead Freeze Tank", "A destroyed freeze tank. Step on it with a mech to get its weapon."},
	Meta_Acid_Tank_Tooltip = {"Dead A.C.I.D. Tank", "A destroyed A.C.I.D. tank. Step on it with a mech to get its weapon."},
}

Mission_Meta_DeadTanks = Mission_Infinite:new{
	Name = "Avenge the Fallen",
	Objectives = { Objective("Freeze 2 Vek",1), Objective("Use A.C.I.D. on 2 Vek", 1),  }, 
	FrozenVek = 0,
	AcidVek = 0,		--increased by the weapons' SkillEffect
}

function Mission_Meta_DeadTanks:StartMission()
	local ret = {}
	
	local start = Point(3,1)
	
	local choices = {}
	for i = start.x, (start.x + 2) do
		for j = start.y, (start.y + 5) do
			if not Board:IsBlocked(Point(i, j), PATH_GROUND) then choices[#choices+1] = Point(i,j) end
		end
	end
	Board:SetItem(random_removal(choices), "Meta_DeadTankFreeze")
	Board:SetItem(random_removal(choices), "Meta_DeadTankAcid")
end


-- function Mission_Meta_DeadTanks:UpdateObjectives()
	-- local status = not Board:IsPawnAlive(self.Target) and OBJ_COMPLETE or OBJ_STANDARD
	-- Game:AddObjective("Kill the DeadTanks Vek",status)
-- end

function Mission_Meta_DeadTanks:GetCompletedObjectives()
	-- if Board:IsPawnAlive(self.Target) then
		-- return self.Objectives:Failed()
	-- end
	return self.Objectives
end
--------------------------------------------------------------------

--------------------------------------------------------------------

function this:init(mod)	

end

function this:load(mod, options, version)
	LOG("_________loaded tanks_________")
	corpMissions.Add_Missions_High("Mission_Meta_DeadTanks")
end

return this