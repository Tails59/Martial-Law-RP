
if CLIENT then
	
end

if SERVER then
	local lastDrain = 0
	hook.Add("eachSecond", "hungerDrain", function()
		if CurTime() > lastDrain + MLRP.Stats.HungerDrainTime then
			lastDrain = CurTime()
			for k, v in pairs(player.GetAll()) do
				if v:Alive() then
					v:removeHunger(2)
				end
			end
		end
	end)

	hook.Add("PlayerSpawn", "resetHungerOnSpawn", function(ply)
		ply:setHunger(100)
	end)
end