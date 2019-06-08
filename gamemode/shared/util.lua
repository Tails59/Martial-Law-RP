function datetime()
	return os.date("%H:%M:%S - %d/%m/%Y" , os.time())
end

function date()
	return os.date("%d/%m/%Y", os.time())
end

function time()
	return os.date("%H:%M:%S", os.time())
end

function eachSecond()
	hook.Call("eachSecond")
	if not timer.Exists("eachSecond") then
		logFatal("eachSecond timer has failed, you've probably got a bad hook somewhere")
	end
end
timer.Create("eachSecond", 1, 0, eachSecond)

function eachTenthSecond()
	hook.Call("eachTenthSecond")
end
timer.Create("eachTenthSecond", 0.1, 0, eachTenthSecond)

local timerfailed = false
local function checkTimerValidity() //check if the timing functions are still running, a lot of the gm components will fail if not
	if timerfailed then return end
	if not timer.Exists("eachSecond") then
		logFatal(datetime().." eachSecond timer has failed, you've probably got a bad hook somewhere")
		timerfailed = true
	end

	if not timer.Exists("eachTenthSecond") then
		logFatal(datetime().." eachTenthSecond timer has failed, you've probably got a bad hook somewhere")
		timerfailed = true
	end
end
timer.Create("checkTimerValidity", 0.5, 0, checkTimerValidity)