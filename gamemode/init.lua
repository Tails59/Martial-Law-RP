include("include.lua")
AddCSLuaFile("include.lua")

function serverTenthSecond()
	hook.Call("serverTenthSecond")
end
timer.Create("serverTenthSecond", 0.1, 0, serverTenthSecond)


