include("include.lua")
AddCSLuaFile("include.lua")

function GM:ShutDown()
	logWarn(datetime().." -- Server shutting down")
	//refund contraband and stuff
	logSuccess(datetime().." -- Server shut down successfully")
end

function GM:GetFallDamage(ply, speed)
	return speed/35
end

//function GM:PlayerSpawn()
//end
