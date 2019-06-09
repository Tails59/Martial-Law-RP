local player = FindMetaTable("Player")

function player:setExhausted(doIt)
	self:SetWalkSpeed(MLRP.Stats.WalkSpeed)
	if doIt or doIt == nil then
		self:SetRunSpeed(MLRP.Stats.ExhaustedRunSpeed)
		self:SetNW2Bool("MLRP.Exhausted", true)
	else
		self:SetRunSpeed(MLRP.Stats.RunSpeed)
		self:SetNW2Bool("MLRP.Exhausted", false)
	end
end

function player:setPropLimit(new)
	if new > MLRP.Props.MaxLimit then 
		logFail("Tried to set a prop limit greater than defined maximum!")
		return
	end
	self:SetNW2Int("MLRP.PropLimit", new)
end

function player:setWarrant(type)
	if not type == "arrest" or "search" or "impound" then
		logFail("Tried to set a player's warrant with an invalid warrant type!")
	end
	self:SetNW2String("MLRP.Warrant", type)
end

function player:addStamina(amt)
	self:SetNW2Int("MLRP.Stamina", math.Clamp(self:GetNW2Int("MLRP.Stamina", 0) + amt, 0, 100))
end

function player:removeStamina(amt)
	self:SetNW2Int("MLRP.Stamina", math.Clamp(self:GetNW2Int("MLRP.Stamina", 0) - amt, 0, 100))
end

function player:setStamina(amt)
	self:SetNW2Int("MLRP.Stamina", math.Clamp(amt, 0, 100))
end

function player:addHunger(amt)
	self:SetNW2Int("MLRP.Hunger", math.Clamp(self:GetNW2Int("MLRP.Hunger", 0) + amt, 0, 100))
end

function player:removeHunger(amt)
	self:SetNW2Int("MLRP.Hunger", math.Clamp(self:GetNW2Int("MLRP.Hunger", 0) - amt, 0, 100))
end

function player:setHunger(amt)
	self:SetNW2Int("MLRP.Hunger", math.Clamp(amt, 0, 100))
end

function player:addThirst(amt)
	self:SetNW2Int("MLRP.Thirst", math.Clamp(self:GetNW2Int("MLRP.Thirst", 0) + amt, 0, 100))
end

function player:removeThirst(amt)
	self:SetNW2Int("MLRP.Thirst", math.Clamp(self:GetNW2Int("MLRP.Thirst", 0) - amt, 0, 100))
end

function player:setThirst(amt)
	self:SetNW2Int("MLRP.Thirst", math.Clamp(amt, 0, 100))
end

function player:addPropToCount()
	self:SetNW2Int("MLRP.PropCount", self:getPropCount() + 1)
end

function player:removePropFromCount()
	self:SetNW2Int("MLRP.PropCount", self:getPropCount() - 1)
end	

function player:unWarrant()
	self:SetNW2String("MLRP.Warrant", nil)
end

function player:setRPName(name)
	local heckfinder;

	for k, v in pairs(MLRP.BadWords.BannedNames) do
		heckfinder, _ = string.find(string.lower(name), v)
		if heckfinder then
			return false
		end
	end
		
	self:SetNW2String("MLRP.RPName", name)
	return true
end