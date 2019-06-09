//Some of this code is taken from Hexahedronic's BaseWars gamemode. You can find it at: https://github.com/hexahedronic/basewars
//The includeClient, loadFileClient and includeServer functions are all taken from BaseWars.

DeriveGamemode("sandbox")

local function addShared(File)
	include(File)
	if SERVER then
		AddCSLuaFile(File)
	end
end

local function addClient(File)
	if CLIENT then
		include(File)
	else
		AddCSLuaFile(File)
	end
end

local function addServer(file)
	if SERVER then
		include(file)
	end
end

local function addMetatableFolder()
	local path = MLRP.GMFolder.."/gamemode/metatables/"
	
	local files, folders = file.Find(path.."*", "GAME")

	local type
	for k, v in pairs(files) do
		type = string.sub(v, 1, 2)

		if type == "cl" then
			addClient("metatables/"..v)
		elseif type == "sv" then
			addServer("metatables/"..v)
		else
			addShared("metatables/"..v)
		end
	end
end

do
	addClient("client/vgui/hud.lua")
	addClient("client/vgui/notify.lua")
end

do
	addShared("config.lua")
	addShared("items.lua")
	
	addMetatableFolder()
	addShared("shared.lua")
	addShared("shared/util.lua")
	addShared("plugins/logs.lua")
	

	addShared("plugins/stamina.lua")
	addShared("plugins/hunger.lua")
	addShared("plugins/thirst.lua")
	addShared("plugins/economy.lua")
	addShared("plugins/vehicles.lua")
	
	//addShared("metatables/shared_player.lua")
end

do
	//addServer("metatables/sv_player.lua")
	addServer("mysql.lua")
end


