local vehicle = FindMetaTable("Vehicle")

function vehicle:setFuel(new)
	self:SetNW2Float("MLRP.Fuel", new)
	return new < 1 //return whether the vehicle is driveable or not
end

function vehicle:addFuel(amt)
	self:SetNW2Float("MLRP.Fuel", self:getFuel() + amt)
	return self:getFuel() < 1 //return whether the vehicle is driveable or not
end

function vehicle:takeFuel(amt)
	self:SetNW2Float("MLRP.Fuel", self:getFuel() - amt)
	return self:getFuel() < 1 //return whether the vehicle is driveable or not
end
