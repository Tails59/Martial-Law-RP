if SERVER then

function GM:PlayerEnteredVehicle(ply, veh)
print(ply:Nick().." entered ")
end

function GM:CanPlayerEnterVehicle(ply, veh)	
	return not(ply:isCuffed()) and veh:isLocked()
end

end