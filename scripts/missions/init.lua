
local this = {}
local scriptPath = mod_loader.mods[modApi.currentMod].scriptPath
local path = scriptPath .."missions/"
local personality = require(scriptPath .."personality")

local function file_exists(name)
	local f = io.open(name, "r")
	if f then io.close(f) return true else return false end
end

local function loadDialog(file)
	local name = file:sub(1, -5)
	
	if file_exists(file) then
	--	LOG("loading dialog from '".. file .."'")
		local dialog = require(name)
		
		for person, t in pairs(dialog) do
	--		LOG("adding ".. person)
			personality.AddDialog(Personality[person], t, false)
		end
	else
	--	LOG("unable to find dialog file '".. file .."'")
	end
end
-------------------------------

local function loadMissionDialog(missionId, file)
	local name = file:sub(1, -5)
	
	if file_exists(file) then
	--	LOG("loading dialog from '".. file .."'")
		local dialog = require(name)
		
		for person, t in pairs(dialog) do
			personality.AddMissionDialog(Personality[person], missionId, t)
		end
	else
	--	LOG("unable to find dialog file '".. file .."'")
	end
end

local missions = {
	"mission_undying",
	"mission_vampiric",
	"mission_explosive",
	"mission_volatile",
}


function this:init(mod)
	for _, mission in ipairs(missions) do
		local options = mod_loader.currentModContent[modApi:getCurrentMod().id].options
		if options["Enable_"..mission] and options["Enable_"..mission].enabled then
			self[mission] = require(path .. mission)
			self[mission]:init(mod)
		else
			LOG("disabled "..mission)
		end
	end
end

function this:load(mod, options, version)
	-- require(path .."voice_units"):load()
	-- loadDialog(path .. "extra_dialog.lua")
	
	for _, mission in ipairs(missions) do
		if options["Enable_"..mission] and options["Enable_"..mission].enabled then
			self[mission]:load(mod, options, version)
			loadMissionDialog(self[mission].id, path .. mission .."_dialog.lua")
		end
	end
end

return this