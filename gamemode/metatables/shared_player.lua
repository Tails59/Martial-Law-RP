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

if CLIENT then
	
end

if SERVER then
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
		print(self:getHunger())
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
end