local path = mod_loader.mods[modApi.currentMod].resourcePath
	modApi:appendAsset("img/units/aliens/undyingvek.png", path .."img/units/aliens/undyingvek.png")
	modApi:appendAsset("img/units/aliens/undyingvek_w.png", path .."img/units/aliens/undyingvek_w.png")
	modApi:appendAsset("img/units/aliens/undyingvek_a.png", path .."img/units/aliens/undyingvek_a.png")
	modApi:appendAsset("img/units/aliens/undyingvek_e.png", path .."img/units/aliens/undyingvek_e.png")
	modApi:appendAsset("img/units/aliens/undyingvek_d.png", path .."img/units/aliens/undyingvek_d.png")
	modApi:appendAsset("img/units/aliens/undyingvek2.png", path .."img/units/aliens/undyingvek2.png")
	modApi:appendAsset("img/units/aliens/undyingvek_w2.png", path .."img/units/aliens/undyingvek_w2.png")
	modApi:appendAsset("img/units/aliens/undyingvek_a2.png", path .."img/units/aliens/undyingvek_a2.png")
	modApi:appendAsset("img/units/aliens/undyingvek3.png", path .."img/units/aliens/undyingvek3.png")
	modApi:appendAsset("img/units/aliens/undyingvek_w3.png", path .."img/units/aliens/undyingvek_w3.png")
	modApi:appendAsset("img/units/aliens/undyingvek_a3.png", path .."img/units/aliens/undyingvek_a3.png")
	modApi:appendAsset("img/portraits/enemy/UndyingVekPortrait.png", path .."img/portraits/enemy/UndyingVekPortrait.png")
	
	modApi:appendAsset("img/effects/leechedblood.png", path .."img/effects/leechedblood.png")
	modApi:appendAsset("img/combat/icons/icon_revive.png", path .."img/combat/icons/icon_revive.png")
	Location["combat/icons/icon_revive.png"] = Point(-26,2)
	modApi:appendAsset("img/effects/undyingplague_U.png", path .."img/effects/undyingplague_U.png")
	modApi:appendAsset("img/effects/undyingplague_R.png", path .."img/effects/undyingplague_R.png")
	modApi:appendAsset("img/effects/undyingplague_D.png", path .."img/effects/undyingplague_D.png")
	modApi:appendAsset("img/effects/undyingplague_L.png", path .."img/effects/undyingplague_L.png")
		
	local a = ANIMS
	a.undyingvek = a.BaseUnit:new{Image = "units/aliens/undyingvek.png", PosX = -25, PosY = 1, Height = 1 }
	a.undyingvekw = a.undyingvek:new{Image = "units/aliens/undyingvek_w.png"}
	a.undyingveka = a.undyingvek:new{Image = "units/aliens/undyingvek_a.png", NumFrames = 4, Time = 0.3 }	--0.3/frame is default
	a.undyingvekd = a.undyingvek:new{Image = "units/aliens/undyingvek_d.png", NumFrames = 8, Time = 0.14, Loop = false }
	a.undyingveke = a.undyingvek:new{Image = "units/aliens/undyingvek_e.png", NumFrames = 10, Loop = false, Time = 0.15, Sound = "/enemy/shared/crawl_out" }
	a.undyingvek2 = a.undyingvek:new{Image = "units/aliens/undyingvek2.png"}
	a.undyingvek2w = a.undyingvekw:new{Image = "units/aliens/undyingvek_w2.png"}
	a.undyingvek2a = a.undyingveka:new{Image = "units/aliens/undyingvek_a2.png", Time = 0.5}				--meant to make it feel sluggish/weakened
	a.undyingvek2d = a.undyingvekd
	a.undyingvek2e = a.undyingveke
	a.undyingvek3 = a.undyingvek:new{Image = "units/aliens/undyingvek3.png"}
	a.undyingvek3w = a.undyingvekw:new{Image = "units/aliens/undyingvek_w3.png"}
	a.undyingvek3a = a.undyingveka:new{Image = "units/aliens/undyingvek_a3.png", Time = 0.7}
	a.undyingvek3d = a.undyingvekd
	a.undyingvek3e = a.undyingveke	
	
	
	a.undyingPlague_0 = Animation:new{
		Image = "effects/undyingplague_U.png",
		NumFrames = 8,
		Time = 0.06,
		PosX = -10,
		PosY = -4
	}

	a.undyingPlague_1 = Animation:new{
		Image = "effects/undyingplague_R.png",
		NumFrames = 8,
		Time = 0.06,
		PosX = -10,
		PosY = 11
	}

	a.undyingPlague_2 = Animation:new{
		Image = "effects/undyingplague_D.png",
		NumFrames = 8,
		Time = 0.06,
		PosX = -30,
		PosY = 11
	}

	a.undyingPlague_3 = Animation:new{
		Image = "effects/undyingplague_L.png",
		NumFrames = 8,
		Time = 0.06,
		PosX = -30,
		PosY = -4
	}


Meta_UndyingVek = Pawn:new{
	Name = "Undying Vek",
	Portrait = "enemy/UndyingVekPortrait",
	Health = 4,
	MoveSpeed = 4,
	Image = "undyingvek",		
	SkillList = { "Meta_UndyingVekAtk" },
	SoundLocation = "/enemy/starfish_1/",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_FLESH,
	IsDeathEffect = true,
	Corpse = true,
	Massive = true,
}
AddPawn("Meta_UndyingVek")


function Meta_UndyingVek:GetDeathEffect(point)
	local ret = SkillEffect()
	local mission = GetCurrentMission()
	if not mission.KilledCount then mission.KilledCount = 0 end
	if mission.KilledCount < 2 then
		mission.KilledCount = mission.KilledCount + 1
		Board:GetPawn(point):SetInvisible(true)
		Board:AddAnimation(point, "undyingvekd", 6)
		modApi:scheduleHook(1170, function()
			Board:GetPawn(GetCurrentMission().Target):SetInvisible(false)
		end)
		Board:GetPawn(point):SetHealth(4 - mission.KilledCount)
		Board:GetPawn(point):SetMaxHealth(4 - mission.KilledCount)
		modApi:runLater(function() Board:GetPawn(point):SetCustomAnim("undyingvek"..mission.KilledCount + 1) end)
		--we use runLater because in a DeathEffect, even though there is a dead pawn (since it has Corpse), anims can't be applied to it
		--I imagine it's because it doesn't really use anims as a corpse?
		--so we wait for it to be done reviving, then it's a regular pawn and we can change its anim
		
		for dir = DIR_START, DIR_END do
			local curr2 = point + DIR_VECTORS[dir]
			local damage = SpaceDamage(curr2)
			damage.sAnimation = "undyingPlague_"..dir
			if Board:GetPawn(curr2) and Board:GetPawn(curr2):GetTeam() == TEAM_VEK then 
				damage.sScript = string.format([[
				local pawn = Board:GetPawn(%s)
				if pawn:GetTeam() == TEAM_VEK then 
					pawn:SetCorpse(true) 
					if pawn:IsDead() then pawn:SetHealth(2) else Board:DamageSpace(%s, 2) end
				end]], curr2:GetString(), curr2:GetString())
				
			end
			Board:DamageSpace(damage)
		end
		
		
	else
		Board:GetPawn(point):SetCorpse(false)
	end
	return ret
end

Meta_UndyingVekAtk = Skill:new{
	Name = "Undying Strike",
	Description = "Damages four tiles and propagates the Undying Plague, healing Vek and turning them undying.",
	Damage = 2,
	Class = "Enemy",
	Icon = "weapons/enemy_blobber2.png",
	LaunchSound = "",
	SoundId = "blobber_1", 
	SoundBase = "/enemy/starfish_1",
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(1,1),
		Building = Point(3,3),
		Target = Point(2,2),
		CustomPawn = "Meta_UndyingVek"
	}
}

function Meta_UndyingVekAtk:GetTargetScore(p1,p2)
	local effect = SkillEffect()
	
	local targetScore = 1
	for i = DIR_START, DIR_END do
		local p = p2 + DIR_VECTORS[i] + DIR_VECTORS[(i+1)%4]
		if Board:GetPawnTeam(p) == TEAM_PLAYER and not Board:GetPawn(p):IsDead() then targetScore = targetScore + 10 end
		if Board:IsBuilding(p) then targetScore = targetScore + 10 end
		local curr = p2 + DIR_VECTORS[i]
		if Board:GetPawn(curr) and Board:GetPawn(curr):GetTeam() == TEAM_VEK then 
			if Board:GetPawn(curr):IsDead() then			--revives dead Vek, very good
				targetScore = targetScore + 15
			elseif Board:GetPawn(curr):IsDamaged() then		--heals Vek, good
				targetScore = targetScore + 5
			else											--makes them undying, better than nothing
				targetScore = targetScore + 1				
			end
		end
	end
	return targetScore
end

function Meta_UndyingVekAtk:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	return ret
end

function Meta_UndyingVekAtk:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	for dir = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[dir] + DIR_VECTORS[(dir+1)%4]
		local damage = SpaceDamage(curr, self.Damage)
		damage.sAnimation = "explostarfish_"..dir
		damage.sSound = self.SoundBase.."/attack"
		ret:AddQueuedDamage(damage)
		local curr2 = p1 + DIR_VECTORS[dir]
		local damage = SpaceDamage(curr2)
		damage.sImageMark = "combat/icons/icon_revive.png"
		damage.sAnimation = "undyingPlague_"..dir
		if Board:GetPawn(curr2) and Board:GetPawn(curr2):GetTeam() == TEAM_VEK then 
			damage.sScript = string.format([[
			local pawn = Board:GetPawn(%s)
			if pawn:GetTeam() == TEAM_VEK then 
				pawn:SetCorpse(true) 
				if pawn:IsDead() then pawn:SetHealth(2) else Board:DamageSpace(%s, 2) end
			end]], curr2:GetString(), curr2:GetString())
			
		end
		ret:AddQueuedDamage(damage)
	end
	return ret
end

------VAMPIRIC------

local path = mod_loader.mods[modApi.currentMod].resourcePath
	modApi:appendAsset("img/units/aliens/vampiricvek.png", path .."img/units/aliens/vampiricvek.png")
	-- modApi:appendAsset("img/units/aliens/vampiricvek_w.png", path .."img/units/aliens/vampiricvek_w.png")
	modApi:appendAsset("img/units/aliens/vampiricvek_a.png", path .."img/units/aliens/vampiricvek_a.png")
	modApi:appendAsset("img/units/aliens/vampiricvek_e.png", path .."img/units/aliens/vampiricvek_e.png")
	modApi:appendAsset("img/units/aliens/vampiricvek_d.png", path .."img/units/aliens/vampiricvek_d.png")
	modApi:appendAsset("img/portraits/enemy/VampiricVekPortrait.png", path .."img/portraits/enemy/VampiricVekPortrait.png")
	
	modApi:appendAsset("img/combat/icons/icon_revive.png", path .."img/combat/icons/icon_revive.png")
		
	a.vampiricvek = a.BaseUnit:new{Image = "units/aliens/vampiricvek.png", PosX = -25, PosY = -10, Height = 1 }
	-- a.vampiricvekw = a.vampiricvek:new{Image = "units/aliens/vampiricvek_w.png"}
	a.vampiricveka = a.vampiricvek:new{Image = "units/aliens/vampiricvek_a.png", NumFrames = 6 }
	a.vampiricvekd = a.vampiricvek:new{Image = "units/aliens/vampiricvek_d.png", NumFrames = 8, Time = 0.14, Loop = false }
	a.vampiricveke = a.vampiricvek:new{Image = "units/aliens/vampiricvek_e.png", NumFrames = 10, Loop = false, Time = 0.15, Sound = "/enemy/shared/crawl_out" }

	modApi:appendAsset("img/units/mission/stakeunit.png", path .."img/units/mission/stakeunit.png")
	modApi:appendAsset("img/units/mission/stakeunit_a.png", path .."img/units/mission/stakeunit_a.png")
	modApi:appendAsset("img/units/mission/stakeunit_revup.png", path .."img/units/mission/stakeunit_revup.png")
	modApi:appendAsset("img/units/mission/stakeunit_broken.png", path .."img/units/mission/stakeunit_broken.png")
	
	a.stakeunit = a.BaseUnit:new{Image = "units/mission/stakeunit.png", PosX = -20, PosY = -21, Height = 1 }
	a.stakeunita = a.stakeunit:new{Image = "units/mission/stakeunit_a.png", NumFrames = 4, Time = 0.6 }
	a.stakeunitrevup = a.stakeunit:new{Image = "units/mission/stakeunit_revup.png", NumFrames = 4, Time = 0.3 }
	
	modApi:appendAsset("img/weapons/Stake.png", path .."img/weapons/Stake.png")
	modApi:appendAsset("img/weapons/RevUp.png", path .."img/weapons/RevUp.png")

Meta_VampiricVek = Pawn:new{
	Name = "Vampiric Vek",
	Portrait = "enemy/VampiricVekPortrait",
	Health = 5,
	MoveSpeed = 4,
	Flying = true,
	Image = "vampiricvek",		
	SkillList = { "Meta_VampiricVekAtk" },
	SoundLocation = "/enemy/moth_1/",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_FLESH,
	IsDeathEffect = true,
	Corpse = true,
}
AddPawn("Meta_VampiricVek")

function Meta_VampiricVek:GetDeathEffect(point)
	local ret = SkillEffect()
	local mission = GetCurrentMission()
	if not mission.Staked then
		Board:GetPawn(point):SetHealth(2)
	else
		Board:GetPawn(point):SetCorpse(false)
	end
	return ret
end

Meta_VampiricVekAtk = MothAtk2:new{
	Name = "Repelling Pellets",
	Description = "Fires a pushing artillery shot at a target.",
	Damage = 3,
}

Meta_Stake = Pawn:new{
	Name = "Vek Impaler",
	Corporate = true,
	Health = 2,
	MoveSpeed = 2,
	Image = "stakeunit",		
	SkillList = { "Meta_StakeAtk", "Meta_StakeBuff" },
	SoundLocation = "/support/civilian_artillery/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
}
AddPawn("Meta_Stake")

Meta_StakeAtk = Skill:new{   
	PathSize = INT_MAX,
	ZoneTargeting = ZONE_DIR,
	Name = "Impale",
	Description = "Charge in a line, damaging the first unit met. Charge through slain units.",
	Icon = "weapons/Stake.png",
	Damage = 1,---USED FOR TOOLTIPS
	Class = "",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,1),
		Enemy2 = Point(2,2),
		Target = Point(2,2),
		CustomPawn = "Meta_Stake",
	}	
}
function Meta_StakeAtk:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		ret:push_back(point + DIR_VECTORS[i])
	end
	return ret
end

function Meta_StakeAtk:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	local pathing = PATH_PROJECTILE
	local doDamage = true
	local target = p1 + DIR_VECTORS[direction]
	local damageAmount = 1
	if Board:GetPawn(p1):IsBoosted() then damageAmount = 2 end
	ret:AddScript(string.format("Board:GetPawn(%s):SetMoveSpeed(2)", p1:GetString()))
	ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "stakeunit"))
	while true do
		if Board:IsBlocked(target, pathing) and not Board:GetPawn(target) then break end
		if Board:GetPawn(target) and Board:GetPawn(target):GetHealth() > damageAmount then break end
		if not Board:IsValid(target + DIR_VECTORS[direction]) then break end
		target = target + DIR_VECTORS[direction]
	end
	local distance = p1:Manhattan(target)
	
	if not Board:IsBlocked(target,pathing) then -- dont attack an empty edge square, just run to the edge
		-- doDamage = false
		target = target + DIR_VECTORS[direction]
	end

	-- local damage = SpaceDamage(target, self.Damage)
	-- damage.sSound = self.ImpactSound
	
	if distance == 1 then --and doDamage 
		ret:AddMelee(p1,SpaceDamage(target, 1), NO_DELAY)
	else
		local move = PointList()
		move:push_back(p1)
		move:push_back(target - DIR_VECTORS[direction])
		
		-- ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), NO_DELAY)--FULL_DELAY)
		ret:AddCharge(move, NO_DELAY)--FULL_DELAY)

		local temp = p1 
		while temp ~= target  do 
			
			if Board:GetPawn(temp) and temp ~= p1 then
				ret:AddDamage(SpaceDamage(temp, 1))
				if Board:GetPawn(temp):GetType() == "Meta_VampiricVek" and Board:GetPawn(temp):GetHealth() <= damageAmount then 
					ret:AddScript("GetCurrentMission().Staked = true") 
				end
			end
			-- ret:AddBounce(temp,-3)
			temp = temp + DIR_VECTORS[direction]
			if temp ~= target then
				ret:AddDelay(0.06)
			end
		end
		ret:AddDamage(SpaceDamage(target, 1))
	end
	return ret
end

Meta_StakeBuff = SelfTarget:new{   
	Name = "Rev Up",
	Description = "Prepare to attack, increasing movement range and damage.",
	Icon = "weapons/RevUp.png",
	Damage = 0,---USED FOR TOOLTIPS
	Class = "",
	TipImage = {
		Unit = Point(2,2),
		Target = Point(2,2),
		CustomPawn = "Meta_Stake",
	}	
}
function Meta_StakeBuff:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "stakeunitrevup"))
	ret:AddScript(string.format("Board:GetPawn(%s):SetMoveSpeed(4)", p1:GetString()))
	ret:AddScript(string.format("modApi:runLater(function() Board:GetPawn(%s):SetBoosted(true) end)", p1:GetString()))
	return ret
end



-------------Explosive-------------

	modApi:appendAsset("img/units/aliens/explosivedigger.png", path .."img/units/aliens/explosivedigger.png")
	modApi:appendAsset("img/units/aliens/explosivedigger_a.png", path .."img/units/aliens/explosivedigger_a.png")
	modApi:appendAsset("img/units/aliens/explosivedigger_e.png", path .."img/units/aliens/explosivedigger_e.png")
	modApi:appendAsset("img/units/aliens/explosivedigger_d.png", path .."img/units/aliens/explosivedigger_d.png")
	modApi:appendAsset("img/portraits/enemy/ExplosiveDiggerPortrait.png", path .."img/portraits/enemy/ExplosiveDiggerPortrait.png")
	a.explosivedigger = a.BaseUnit:new{Image = "units/aliens/explosivedigger.png", PosX = -22, PosY = 5, Height = 1 }
	a.explosivediggera = a.explosivedigger:new{Image = "units/aliens/explosivedigger_a.png", NumFrames = 4 }
	a.explosivediggerd = a.explosivedigger:new{Image = "units/aliens/explosivedigger_d.png", NumFrames = 8, Time = 0.14, Loop = false }
	a.explosivediggere = a.explosivedigger:new{Image = "units/aliens/explosivedigger_e.png", NumFrames = 10, Loop = false, Time = 0.15, Sound = "/enemy/shared/crawl_out" }


Meta_ExplosiveDigger =
	{
		Name = "Explosive Digger",
		Portrait = "enemy/ExplosiveDiggerPortrait",
		Health = 3,
		MoveSpeed = 3,
		Armor = true,
		Image = "explosivedigger", 
		SkillList = { "ExplosiveDiggerAtk" },  
		SoundLocation = "/enemy/digger_1/",
		DefaultTeam = TEAM_ENEMY,
		ImpactMaterial = IMPACT_INSECT
	}

AddPawn("Meta_ExplosiveDigger")

ExplosiveDiggerAtk = DiggerAtk1:new{
	Damage = 1,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Building = Point(3,2),
		Target = Point(2,2),
		CustomPawn = "Meta_ExplosiveDigger"
	}
}

function ExplosiveDiggerAtk:GetTargetArea(point)
	ret = PointList()
	ret:push_back(point)
	return ret
end

function ExplosiveDiggerAtk:GetTargetScore(p1, p2)
	local score = 0
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		if Board:IsBlocked(curr,PATH_PROJECTILE) then 
			if Board:GetPawn(curr) then
				if Board:GetPawn(curr):GetTeam() == Board:GetPawn(p1):GetTeam() then
					score = score + self.ScoreFriendlyDamage
				else
					score = score + self.ScoreEnemy
				end
			elseif Board:IsBuilding(curr) then
				score = score + self.ScoreBuilding
			else
				score = score + self.ScoreNothing
			end
		elseif Board:GetTerrain(curr) ~= TERRAIN_WATER and Board:GetTerrain(curr) ~= TERRAIN_HOLE and not Board:IsPod(curr) then
			for j = DIR_START, DIR_END do
				local curr2 = p1 + DIR_VECTORS[i] + DIR_VECTORS[j]
				if curr2 == p1 then
					score = score + self.ScoreNothing
				elseif Board:GetPawn(curr) then
					if Board:GetPawn(curr):GetTeam() == Board:GetPawn(p1):GetTeam() then
						score = score + self.ScoreFriendlyDamage
					else
						score = score + self.ScoreEnemy
					end
				elseif Board:IsBuilding(curr) then
					score = score + self.ScoreBuilding
				else
					score = score + self.ScoreNothing
				end
			end
		end		
	end
	return score
end

function ExplosiveDiggerAtk:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	
	for dir = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[dir]
		if not Board:IsBlocked(curr,PATH_PROJECTILE) and Board:GetTerrain(curr) ~= TERRAIN_WATER and Board:GetTerrain(curr) ~= TERRAIN_HOLE and not Board:IsPod(curr) then
			local damage = SpaceDamage(curr)
			damage.sPawn = "Meta_DiggerBombRock"
			damage.sSound = "/enemy/"..self.SoundId.."/attack_queued"
			ret:AddDamage(damage)
		end
		local damage = SpaceDamage(p1 + DIR_VECTORS[dir],self.Damage)
		
		damage.sAnimation = "explorocker_"..dir
		damage.sSound = "/enemy/"..self.SoundId.."/attack"
		ret:AddQueuedDamage(damage)
	end	
	return ret
end	

Meta_DiggerBombRock = {		--only here because normal explosive rocks damage through armor and I don't want that
	Name = "Explosive Rock",
	Health = 1,
	Neutral = true,
	MoveSpeed = 0,
	Image = "rock2",
	SoundLocation = "/support/bombrock/",
	IsPortrait = false,
	DefaultTeam = TEAM_NONE,
	ImpactMaterial = IMPACT_ROCK,
	IsDeathEffect= true,
}
AddPawn("Meta_DiggerBombRock")

function Meta_DiggerBombRock:GetDeathEffect(point)
	local ret = SkillEffect()
	for dir = DIR_START, DIR_END do
		local exploDamage = SpaceDamage(point + DIR_VECTORS[dir], 1)
		exploDamage.sAnimation = "exploout2_"..dir
		ret:AddDamage(exploDamage) 
	end
	return ret
end


-----------Volatile Bouncer------

modApi:appendAsset("img/units/aliens/volatilebouncer.png", path .."img/units/aliens/volatilebouncer.png")
modApi:appendAsset("img/units/aliens/volatilebouncer_a.png", path .."img/units/aliens/volatilebouncer_a.png")
modApi:appendAsset("img/units/aliens/volatilebouncer_e.png", path .."img/units/aliens/volatilebouncer_e.png")
modApi:appendAsset("img/units/aliens/volatilebouncer_d.png", path .."img/units/aliens/volatilebouncer_d.png")
modApi:appendAsset("img/weapons/Tranq.png", path .."img/weapons/Tranq.png")
modApi:appendAsset("img/effects/shotup_tranquilizer.png", path .."img/effects/shotup_tranquilizer.png")
modApi:appendAsset("img/effects/sleepanim.png", path .."img/effects/sleepanim.png")
modApi:appendAsset("img/portraits/enemy/VolatileBouncerPortrait.png", path .."img/portraits/enemy/VolatileBouncerPortrait.png")
a.volatilebouncer = a.BaseUnit:new{Image = "units/aliens/volatilebouncer.png", PosX = -23, PosY = 4, Height = 1 }
a.volatilebouncera = a.volatilebouncer:new{Image = "units/aliens/volatilebouncer_a.png", NumFrames = 4 }
a.volatilebouncerd = a.volatilebouncer:new{Image = "units/aliens/volatilebouncer_d.png", NumFrames = 8, Time = 0.14, Loop = false }
a.volatilebouncere = a.volatilebouncer:new{Image = "units/aliens/volatilebouncer_e.png", NumFrames = 10, Loop = false, Time = 0.15, Sound = "/enemy/shared/crawl_out" }

a.sleepAnim = Animation:new{ 	
	Image = "effects/sleepanim.png",
	PosX = -20, PosY = -5,
	NumFrames = 7,
	Time = 0.2,
	Loop = true
}

Meta_VolatileBouncer = Pawn:new{
	Name = "Volatile Bouncer",
	Image = "volatilebouncer",
	Portrait = "enemy/VolatileBouncerPortrait",
	SkillList = { "BouncerAtk2" },
	MoveSpeed = 3,
	Health = 3,
	Armor = true,
	Explodes = true,
	SoundLocation = "/enemy/bouncer_1/",
	DefaultTeam = TEAM_ENEMY,
	ImpactMaterial = IMPACT_INSECT
}
AddPawn("Meta_VolatileBouncer")


Meta_SleepHeli = Pawn:new{
	Name = "Soporific Heli",
	Corporate = true,
	Health = 1,
	MoveSpeed = 3,
	Flying = true,
	Image = "HeliSupport1",		
	SkillList = { "Meta_SleepTossAtk" },
	SoundLocation = "/support/support_drone/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
}
AddPawn("Meta_Trapper")


Meta_SleepTossAtk = Skill:new{   
	PathSize = 1,
	ZoneTargeting = ZONE_DIR,
	Name = "Tranquilizer Toss",
	Description = "Toss powerful tranquilizers at a weakened unit, putting it to sleep.",
	Icon = "weapons/Tranq.png",
	Damage = 1,---USED FOR TOOLTIPS
	Class = "",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,1),
		Enemy2 = Point(2,2),
		Target = Point(2,2),
		CustomPawn = "Meta_Trapper",
	}	
}

function Meta_SleepTossAtk:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		if Board:GetPawn(curr) and Board:GetPawn(curr):GetHealth() == 1 then ret:push_back(curr) end
		curr = point + DIR_VECTORS[i] + DIR_VECTORS[(i+1)%4]
		if Board:GetPawn(curr) and Board:GetPawn(curr):GetHealth() == 1 then ret:push_back(curr) end
	end
	return ret
end

local customAnim = require(mod_loader.mods[modApi.currentMod].scriptPath .."libs/customAnim")

function Meta_SleepTossAtk:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2)
	damage.sScript = string.format("Board:GetPawn(%s):SetPowered(false)", p2:GetString())	
	ret:AddArtillery(p1, damage, "effects/shotup_tranquilizer.png", PROJ_DELAY)
	ret:AddScript(string.format("Board:GetPawn(%s):ClearQueued()", p2:GetString()))
	ret:AddScript(string.format("CustomAnim:add(%s, %q)", Board:GetPawn(p2):GetId(), "sleepAnim"))
	return ret
end

-----------Dead Tanks------------

-- TankMission_FreezeWeapon = Skill:new{
	-- Damage = 0,
	-- PathSize = 8,
	-- Name = "Scavenged Freeze Cannon",
	-- Description = "Freezes a target at a distance.",
	-- TipImage = {
		-- Unit = Point(2,2),
		-- Enemy = Point(2,1),
		-- Building = Point(3,2),
		-- Target = Point(2,2),
		-- CustomPawn = "PunchMech"
	-- }
-- }

-- function TankMission_FreezeWeapon:GetSkillEffect(p1, p2)
	-- local target = GetProjectileEnd(p1, p2)
	-- local damage = SpaceDamage(target)
	-- damage.iFreeze = 1
	-- ret:AddDamage(damage)
	-- if Board:GetPawn(target) and Board:GetPawn(target):GetTeam() == TEAM_ENEMY then ret:AddScript("GetCurrentMission().FrozenVek = GetCurrentMission().FrozenVek + 1") end
-- end

-- TankMission_AcidWeapon = Skill:new{
	-- Damage = 0,
	-- PathSize = 8,
	-- Name = "Scavenged A.C.I.D. Cannon",
	-- Description = "Applies A.C.I.D. on a target at a distance.",
	-- TipImage = {
		-- Unit = Point(2,2),
		-- Enemy = Point(2,1),
		-- Building = Point(3,2),
		-- Target = Point(2,2),
		-- CustomPawn = "PunchMech"
	-- }
-- }

-- function TankMission_AcidWeapon:GetSkillEffect(p1, p2)
	-- local target = GetProjectileEnd(p1, p2)
	-- local damage = SpaceDamage(target)
	-- damage.iAcid = 1
	-- ret:AddDamage(damage)
	-- if Board:GetPawn(target) and Board:GetPawn(target):GetTeam() == TEAM_ENEMY then ret:AddScript("GetCurrentMission().AcidVek = GetCurrentMission().AcidVek + 1") end
-- end