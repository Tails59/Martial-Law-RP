
if CLIENT then
	
end

if SERVER then
	local lastDrain = 0
	hook.Add("eachSecond", "thirstDrain", function()
		if CurTime() > lastDrain + MLRP.Stats.ThirstDrainTime then
			lastDrain = CurTime()
			for k, v in pairs(player.GetAll()) do
				if v:Alive() then
					v:removeThirst(3)
				end
			end
		end
	end)

	hook.Add("PlayerSpawn", "resetThirstOnSpawn", function(ply)
		print("test")
		ply:setThirst(100)
	end)
end