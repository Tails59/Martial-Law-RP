//Some of this code is taken from Hexahedronic's BaseWars gamemode. You can find it at: https://github.com/hexahedronic/basewars
//The includeClient, loadFileClient and includeServer functions are all taken from BaseWars.

DeriveGamemode("sandbox")

local function includeClient(File)
	include(File)
	if SERVER then
		AddCSLuaFile(File)
	end
end

local function loadFileClient(File)
	if CLIENT then
		include(File)
	else
		AddCSLuaFile(File)
	end
end

local function includeServer(file)
	if SERVER then
		include(file)
	end
end

do
	includeClient("config.lua")
	includeClient("client/hud.lua")
end

do
	includeServer("server/nwstrings.lua")
	includeServer("plugins/logs.lua")
	includeServer("plugins/economy.lua")
	includeServer("mysql.lua")
end
