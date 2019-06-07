function eachTenthSecond()
	hook.Call("eachTenthSecond")
end
timer.Create("eachTenthSecond", 0.1, 0, eachTenthSecond)

function eachSecond()
	hook.Call("eachSecond")
end
timer.Create("eachSecond", 1, 0, eachSecond)