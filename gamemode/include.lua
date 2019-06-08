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

do
	addClient("client/hud.lua")
end

do
	addShared("config.lua")
	addShared("shared.lua")
	addShared("shared/util.lua")
	addShared("plugins/logs.lua")
	addShared("items.lua")

	addShared("plugins/stamina.lua")
	addShared("plugins/hunger.lua")
	addShared("plugins/thirst.lua")
	addShared("plugins/economy.lua")
	
	addShared("metatables/shared_player.lua")
end

do
	addServer("metatables/sv_player.lua")
	addServer("mysql.lua")
end


