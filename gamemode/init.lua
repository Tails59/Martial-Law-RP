include("include.lua")
AddCSLuaFile("include.lua")

do
	game.ConsoleCommand("sv_voiceenable 1\n")
	game.ConsoleCommand("sv_alltalk 1\n")
	game.ConsoleCommand("mp_falldamage 1\n")
	game.ConsoleCommand("sbox_godmode 0\n")
end

function GM:Initialize()
	print("----------------------\n")
	logAction(datetime() .. " - Server starting up\n")
	print("----------------------\n")
end

function GM:ShutDown()
	print("----------------------")
	logWarn(datetime().." -- Server shutting down")
	print("----------------------")
	//refund contraband and stuff
	print("----------------------")
	logSuccess(datetime().." -- Server shut down successfully")
	print("----------------------")
end

function GM:GetFallDamage(ply, speed)
	return speed/35
end

local lvoiceradius = MLRP.Config.VoiceRadius * MLRP.Config.VoiceRadius
function GM:PlayerCanHearPlayersVoice(listener, player)
	if not (player:IsValid() and listener:IsValid()) then return end

	if player:Alive() and player:GetPos():DistToSqr(listener:GetPos()) <= lvoiceradius then
		return true
	end

	return false
end

function GM:PlayerCanArrest(ply, target)
	if target:hasWarrant() == "arrest" then
		logAction(ply, " arrested ", target, ".")
		return true
	end

	arista.logs.event(arista.logs.E.DEBUG, arista.logs.E.ARREST, ply, " tried (and failed) to arrest ", target, ".")
	ply:notify("AL_PLAYER_NO_WARRANT", target:Name())

	return false
end

function GM:PlayerSpawnProp(ply, model, ent)
	if ply:getPropCount() >= ply:getMaxProps() then return end
	if MLRP.Props.BannedProps[model] then
		logAction(ply:Nick().." tried to spawn a banned prop!")
		return false
	end


end


