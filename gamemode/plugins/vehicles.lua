if SERVER then
	function GM:PlayerEnteredVehicle(ply, veh)
		if IsValid(veh) and veh:GetDriver() == ply then
			net.Start("togglePetrolMeter")
				net.WriteEntity(veh)
				net.WriteBool(true)
			net.Send(ply)
		end
	end

	function GM:PlayerLeaveVehicle(ply, veh)
		if veh:GetDriver() == ply then
			net.Start("togglePetrolMeter")
				net.WriteEntity(veh)
				net.WriteBool(false)
			net.Send(ply)
		end
	end

	function GM:CanPlayerEnterVehicle(ply, veh)
		return true
		//return not(ply:isCuffed()) and veh:isLocked()
	end

	local function fuelfunction()
		for k, veh in pairs(ents.GetAll()) do
			if not veh:IsVehicle() or not veh:engineState() or not IsValid(veh:GetDriver()) then continue end //dont do anything if the engine is off or if there is no driver

			veh:takeFuel(MLRP.Veh.FuelEfficiency(veh))
		end
	end
	hook.Add("eachSecond", "vehicleFuelCheck", fuelfunction)
end