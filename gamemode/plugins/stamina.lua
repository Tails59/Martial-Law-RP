
if CLIENT then
	
end

if SERVER then
	local function getRechargeRate(ply)
		if ply:GetVelocity():Length() > 0 then //if the player is moving, their stamina recovers slower
			return 2
		end

		return 5 // if they're stationary, it recovers faster
	end

	hook.Add("StartCommand", "JumpStaminaDisable", function(ply, cmd)
		if not ply:Alive() then return end

		if ply:GetNW2Bool("MLRP.Exhausted", false) and cmd:KeyDown(IN_JUMP) then
			cmd:RemoveKey(IN_JUMP)
		end
	end)

	hook.Add("KeyPress", "JumpStaminaAdjust", function(ply, key)
		if ply:Alive() then
			if ply:IsOnGround() and key == IN_JUMP then
				if ply:GetNW2Bool("MLRP.Exhausted", false) then return end
				ply:removeStamina(MLRP.Stats.JumpDrain)
			end
		end
	end)
	
	hook.Add("eachSecond", "staminaThingsEachSecond", function()
		for k, ply in pairs(player.GetAll()) do
			if ply:GetNW2Int("MLRP.Stamina", 0) <=1 then
				ply:setExhausted(true)
			end

			if ply:GetNW2Bool("MLRP.Exhausted", false) && ply:GetNW2Int("MLRP.Stamina", 0) >= 50 then //un-exhaust the player when they get back to 50 stamina
				ply:setExhausted(false)
			end

			if ply:IsOnGround() and ply:KeyDown(IN_SPEED) and ply:GetVelocity():Length() > 0 and not ply:GetNW2Bool("MLRP.Exhausted") then
				ply:removeStamina(5)
				return
			end

			if ply:Alive() then
				ply:addStamina(getRechargeRate(ply))
			end
		end
	end)

	hook.Add("PlayerSpawn", "resetStaminaOnSpawn", function(ply)
		ply:setStamina(100)
	end)
end