local mod = modApi.currentMod
local path = mod_loader.mods[mod].scriptPath
local this = {id = "Mission_Meta_Vampiric"}
local corpMissions = require(path .."corpMissions")
-- local corpIslandMissions = require(path .."corpIslandMissions")


Mission_Meta_Vampiric = Mission_Infinite:new{
	Name = "Vampiric Vek",
	Objectives = Objective("Kill the Vampiric Vek",1,1),
	Target = 0
}

function Mission_Meta_Vampiric:StartMission()
	local pawn = PAWN_FACTORY:CreatePawn("Meta_VampiricVek")
	self.Target = pawn:GetId()
	Board:SpawnPawn(pawn)
	Board:AddPawn(PAWN_FACTORY:CreatePawn("Meta_Stake"))--, "deployment"))
end

function Mission_Meta_Vampiric:NextTurn()
	LOG("next turn")
	if Game:GetTeamTurn() == TEAM_ENEMY then
		LOG("enemy turn")
		if Board:IsPawnAlive(self.Target) then
			local vampire = Board:GetPawn(self.Target)
			local space = vampire:GetSpace()
			local targets = extract_table(general_DiamondTarget(space, 3))
			local totalHealing = 0
			local neededHealing = vampire:GetMaxHealth() - vampire:GetHealth()
			-- LOG(neededHealing)
			local ret = SkillEffect()
			for k = 1, #targets do
				-- Board:Ping(targets[k], COLOR_RED)
				local pawn = Board:GetPawn(targets[k])
				-- if pawn then LOG(targets[k]:GetString(), tostring(pawn:GetTeam() == TEAM_ENEMY), totalHealing, neededHealing, tostring(pawn:IsDead())) end
				if pawn and pawn:GetTeam() == TEAM_ENEMY and totalHealing < neededHealing and not pawn:IsDead() and pawn:GetId() ~= self.Target then
					-- LOG("found pawn in "..targets[k]:GetString())
					-- Board:DamageSpace(targets[k], 1)
					-- Board:DamageSpace(space, -1)
					-- Board:Ping(targets[k], COLOR_BLACK)
					ret:AddDamage(SpaceDamage(targets[k], 1))
					ret:AddArtillery(targets[k], SpaceDamage(space, -1), "effects/leechedblood.png", NO_DELAY)
					
					totalHealing = totalHealing + 1
				end
			end
			Board:AddEffect(ret)
		end
	end
end

function Mission_Meta_Vampiric:GetDestroyedCount()
	if not Board:IsPawnAlive(self.Target) then
		return 1
	end
	return 0
end

function Mission_Meta_Vampiric:UpdateObjectives()
	local status = not Board:IsPawnAlive(self.Target) and OBJ_COMPLETE or OBJ_STANDARD
	Game:AddObjective("Kill the Vampiric Vek",status)
end

function Mission_Meta_Vampiric:GetCompletedObjectives()
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
	LOG("_________loaded vampiric_________")
	corpMissions.Add_Missions_High("Mission_Meta_Vampiric")
end

return this