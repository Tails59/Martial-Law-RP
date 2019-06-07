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
end
timer.Create("eachSecond", 1, 0, eachSecond)

function eachTenthSecond()
	hook.Call("eachTenthSecond")
end
timer.Create("eachTenthSecond", 0.1, 0, eachTenthSecond)