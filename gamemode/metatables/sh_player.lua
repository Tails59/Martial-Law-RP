local player = FindMetaTable("Player")

function player:getStamina()
	return self:GetNW2Int("MLRP.Stamina", 0)
end

function player:getHunger()
	return self:GetNW2Int("MLRP.Hunger", 0)
end

function player:getThirst()
	return self:GetNW2Int("MLRP.Thirst", 0)
end

function player:getRPName()
	return self:GetNW2String("MLRP.RPName", "FIRSTNAME  LASTNAME")
end

function player:hasWarrant()
	return self:GetNW2String("MLRP.Warrant", nil)
end

function player:getMaxProps()
	return self:GetNW2Int("MLRP.Proplimit", 100)
end

function player:getPropCount()
	return self:GetNW2Int("MLRP.PropCount", 0)
end

function player:isCuffed()
	return self:GetNW2Bool("MLRP.Handcuffed", false)
end
