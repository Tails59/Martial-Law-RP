//PLUGIN.Title = "Economy"
//PLUGIN.Author = "Tails"
//PLUGIN.Purpose = "Economy for Martial-Law RP"

local meta = FindMetaTable("Player")

//Shared
local function isPlayer(ply)
	return IsValid(ply) and ply:IsPlayer()
end

local function convertToReadable(val)
	formatted, k = string.gsub(val, "^(-?%d+)(%d%d%d)", '%1,%2') //taken from the lua wiki because im no egyptian i cant read those hieroglyphics

	if (k==0) then
		return val
	end

	return formatted
end

function meta:getMoney(readable)
	if readable then
		return convertToReadable(self._Money)
	end

	return self.Money
end

//Client
if CLIENT then
	local ply = LocalPlayer()
	net.Receive("updateMoney", function()
		ply._Money = net.ReadInt()
	end)
end

//Server
if SERVER then
	local function onMoneyChange(ply)
		logAction(ply:Nick().." has had their money updated!")
		net.Start("updateMoney")
			net.WriteInt(ply._Money)
		net.Send(ply)
	end

	function meta:setMoney(val)
		self._Money = val
		self:onMoneyChange(self)
	end
end