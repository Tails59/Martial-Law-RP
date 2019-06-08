//PLUGIN.Title = "Economy"
//PLUGIN.Author = "Tails"
//PLUGIN.Purpose = "Economy for Martial-Law RP"

local meta = FindMetaTable("Player")

//Shared
local function isPlayer(ply)
	return IsValid(ply) and ply:IsPlayer()
end

local function convertToReadable(val)
	local formatted, k = string.gsub(val, "^(-?%d+)(%d%d%d)", '%1,%2') //taken from the lua wiki because im no egyptian i cant read those hieroglyphics
	local newstr = "$"..formatted
	if (k==0) then
		return val
	end

	return newstr
end

function meta:getMoney(readable)
	if readable then
		return convertToReadable(self:GetNW2Int("MLRP.Money", 0))
	end

	return self:GetNW2Int("MLRP.Money", 0) //return the players money or 0 if nil (can sometimes be nil if the player has not connected before)
end

//Serverside
if SERVER then
	hook.Add("EntityNetworkedVarChanged", "moneyUpdated", function(ply, name, oldval, newval)
		if not IsValid(ply) or not ply:IsPlayer() then return end
		if name == "MLRP.Money" then
			oldval = oldval or "0"
			logAction(ply:Nick().." has had their money changed from "..oldval.." to "..newval)
		end
	end)

	function meta:setMoney(val)
		self:SetNW2Int("MLRP.Money", val)
	end

	function meta:addMoney(amt)
		self:setMoney(self:getMoney() + amt)
	end

	function meta:removeMoney(amt)
		if self:getMoney() - amt < 0 then //stops money going into the negatives
			self:setMoney(0)
			return
		end

		self:setMoney(self:getMoney() - amt)
	end

	//this function is for a player giving money to another player
	//not for giving 1 player money.
	//To give a player currency see meta:addMoney()
	function meta:giveMoney(target, amt)
		if self:canAfford(amt) then
			target:addMoney(amt)
			self:removeMoney(amt)
			return true
		end

		return false
	end

	function meta:canAfford(cost)
		if self:getMoney() >= tonumber(cost) then
			return true
		end

		return false
	end

	concommand.Add("addmoney", function(ply, command, args, argstr)
		ply:addMoney(tonumber(args[1]))
	end)
end