AddCSLuaFile()
local vehicle = FindMetaTable("Vehicle")

function vehicle:isChair()
	for k, v in pairs(MLRP.Props.Chairs) do
		if v == self:GetModel() then
			return true
		end
	end

	return false
end

function vehicle:checkIfMLRPVeh()
	local eee = MLRP.Item.Items[self.Name] or false
	print(eee)
	return MLRP.Item.Items[self.Name] or false
end

function vehicle:validDriver()
	local driver = self:GetDriver()

	return IsValid(driver)
end

function vehicle:isTouchable(ply)
	return (CLIENT or not self:validDriver()) and (ply:IsAdmin() or self:isChair())
end

function vehicle:isLocked()
	return self:GetNW2Bool("MLRP.VehicleLocked", false)
end

function vehicle:isUndriveable()
	return self:Health() <= 0
end

function vehicle:engineState()
	return self:GetNW2Bool("MLRP.Engine", true)
end

function vehicle:getFuel()
	return self:GetNW2Float("MLRP.Fuel", 100) //fuel is stored as a float because its more efficient to network as a float than it is to calculate the integer decrease serverside
end

function vehicle:toggleEngine()
	self:SetNW2Bool("MLRP.Engine", not self:GetNW2Bool("MLRP.Engine"))
	return self:GetNW2Bool("MLRP.Engine") //return whether the engine is on or off
end