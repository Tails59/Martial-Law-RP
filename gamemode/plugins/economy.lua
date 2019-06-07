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

	return self:GetNW2Int("MLRP.Money", 0)
end

//Serverside
if SERVER then
	hook.Add("EntityNetworkedVarChanged", "moneyUpdated", function(ply, name, oldval, newval)
		if not IsValid(ply) or not ply:IsPlayer() then return end
		if not name == "MLRP.Money" then return end
		oldval = oldval or "0"
		logAction(ply:Nick().." has had their money updated from "..oldval.." to "..newval)
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

	function meta:canAfford(cost)
		if self:getMoney() >= tonumber(cost) then
			return true
		end

		return false
	end

	concommand.Add("addmoney",function(ply, name, args, strargs)
		print(ply:canAfford(args[1]))
	end)
end