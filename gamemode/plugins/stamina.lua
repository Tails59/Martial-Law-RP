
if CLIENT then
	
end

if SERVER then
	hook.Add("KeyPress", "JumpStaminaAdjust", function(ply, key)
		if ply:Alive() then
			if ply:IsOnGround() and key == IN_JUMP then
				ply:removeStamina(MLRP.Stats.JumpDrain)
			end
		end
	end)
	
	hook.Add("eachSecond", "staminaRecover", function()
		for k, v in pairs(player.GetAll()) do
			if v:Alive() then
				v:addStamina(2)
			end
		end
	end)

	hook.Add("PlayerSpawn", "resetStaminaOnSpawn", function(ply)
		ply:setStamina(100)
	end)
end