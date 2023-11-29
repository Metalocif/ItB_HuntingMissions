-- local mod = mod_loader.mods[modApi.currentMod]
-- local path = mod_loader.mods[mod].scriptPath
-- local corpMissions = require(path .."corpMissions")

local mod = {
	id = "Meta_HuntingMissions",
	name = "Hunting Missions",
	description = "Adds four new missions where the objective is to hunt a special Vek.",
	version = "1.0",
	modApiVersion = "2.9.2",
	icon = "img/mod_icon.png",
	dependencies = {
        modApiExt = "1.21",
        easyEdit = "2.0.6",
	},
}

--Things I want to add to this mod:
--Traps (you have a helper unit that lays traps, you have to trap Vek; unfortunately I couldn't get it to work whatsoever because damage.sScripts doesn't work on mines???


function mod:init()
	require(self.scriptPath .."missions/mission_undying")
	require(self.scriptPath .."missions/mission_vampiric")
	require(self.scriptPath .."missions/mission_explosive")
	require(self.scriptPath .."missions/mission_volatile")
	require(self.scriptPath .."pawns")
	require(self.scriptPath .."missions/mission_undying_dialog")
	require(self.scriptPath .."missions/mission_vampiric_dialog")
	require(self.scriptPath .."missions/mission_explosive_dialog")
	require(self.scriptPath .."missions/mission_volatile_dialog")
	modApi:appendAssets("img/strategy/mission/", "img/strategy/mission/", "")
	modApi:appendAssets("img/strategy/mission/small/", "img/strategy/mission/small/", "")
	local scriptPath = self.scriptPath
	local resourcePath = self.resourcePath

	self.modApiExt = require(scriptPath .."modApiExt/modApiExt")
	self.modApiExt:init()
		
	self.missions = require(scriptPath .."missions/init")
	self.missions:init(self)	

	local corpMissions = require(scriptPath .."corpMissions")
	-- corpMissions.Add_Missions_High("Mission_Meta_Vampiric")
	-- corpMissions.Add_Missions_High("Mission_Meta_Undying")
	-- corpMissions.Add_Missions_High("Mission_Meta_Explosive")
	-- corpMissions.Add_Missions_High("Mission_Meta_Volatile")
end

function mod:load(options, version)
	local scriptPath = self.scriptPath
	self.modApiExt:load(self, options, version)
	self.missions:load(self, options, version)
	require(scriptPath .."libs/menu"):load()
	require(scriptPath .."libs/selected"):load()
	require(scriptPath .."libs/highlighted"):load()
end


function mod:metadata()
	modApi:addGenerationOption(
		"Enable_mission_undying",
		"Enable the Undying Vek mission",
		"Check to allow the Undying Vek mission to be added to islands (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_mission_vampiric",
		"Enable the Vampiric Vek mission",
		"Check to allow the Vampiric Vek mission to be added to islands (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_mission_explosive",
		"Enable the Explosive Vek mission",
		"Check to allow the Explosive Vek mission to be added to islands (default: true).",
		{ enabled = true }
	)
	modApi:addGenerationOption(
		"Enable_mission_volatile",
		"Enable the Volatile Vek mission",
		"Check to allow the Volatile Vek mission to be added to islands (default: true).",
		{ enabled = true }
	)
end

local function init(self)
	meta_missions_modApiExt = require(self.scriptPath.."modApiExt/modApiExt"):init()
end

return mod