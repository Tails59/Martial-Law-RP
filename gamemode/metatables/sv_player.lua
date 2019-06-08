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