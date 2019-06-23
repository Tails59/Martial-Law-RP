local showMeter = showMeter or false
local ply
local colours = {
	fuel = {
	fill = Color(244, 194, 66, 255),
	background = Color(114, 114, 114, 255),
	},
	health = {
		fill = Color(130, 40, 42, 200),
		background = Color(114, 114, 114, 150),
	},
}
local fuel, health = 0, 0
local ScrW, ScrH = ScrW(), ScrH()
local veh = nil

local function colour(col) //returns things
	return col.r, col.g, col.b, col.a
end

//Checks for this are done serverside and networked only if valid
local fuel_icon = Material("hudicons/fuel_icon.png")
local healthbar_icon = Material("hudicons/vehiclehealth_icon.png")
local warning_icon = Material("hudicons/warning.png")
local function drawVehicleHud()
	if not showMeter then return end
	if not veh then return end

	//Fuel Gauge
	ply = ply or LocalPlayer()
	local x, y, w, h = ScrW/2 - 0.22*ScrW/2, ScrH - 35 - 0.1*ScrH, 0.22*ScrW, 0.03*ScrH
	
	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect(x, y, w, h)

	x = x + 4
	y = y + 4
	w = w - 8
	h = h - 8
	 
	surface.SetDrawColor(colour(colours.fuel.background))
	surface.DrawRect( x, y, w, h )
	
	//fuel = Lerp(2.5 * FrameTime(), fuel, veh:getFuel()/100)
	//using lerp to draw the change in the fuel bar is a bit pointless since it moves down in such small increments, but i left it if you want anyway
	fuel = veh:getFuel()/100 //just comment out this line and uncomment the one above to switch
	surface.SetDrawColor( colour(colours.fuel.fill))
	surface.DrawRect( x, y, w * fuel, h)

	surface.SetMaterial(fuel_icon)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawTexturedRect(ScrW/2 - 25/2 + 3, ScrH-35 - 0.1*ScrH + 3, 20,25)

	//Vehicle Health Bar
	x, y, w, h = ScrW/2 - 0.22*ScrW/2, 46, 0.22*ScrW, 0.035*ScrH
	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect(x, y, w, h)

	x = x + 4
	y = y + 4
	w = w - 8
	h = h - 8
	 
	surface.SetDrawColor(colour(colours.health.background))
	surface.DrawRect( x, y, w, h )
	 
	health = Lerp(2.5 * FrameTime(), health, veh:Health()/100)
	surface.SetDrawColor( colour(colours.health.fill))
	surface.DrawRect( x, y, w * health, h)

	surface.SetMaterial(healthbar_icon)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(ScrW/2 - 25/2-6, y+2, 35,25)

	local function drawWarningSign()
		surface.SetDrawColor(255, 255, 255, 255)
		if veh:Health() < 25 then
			surface.SetDrawColor(255, 0, 0, 255)
		end
		if veh:Health() < 50 then
			surface.SetMaterial(warning_icon)
			surface.DrawTexturedRect(ScrW/2 + 0.22*ScrW/2 + 5, y, 30,25)
		end

		surface.SetDrawColor(255, 255, 255, 255)
		if veh:getFuel() < 15 then
			surface.SetDrawColor(255, 0, 0, 255)
		end
		if veh:getFuel() < 30 then
			surface.SetMaterial(warning_icon)
			surface.DrawTexturedRect(ScrW/2 + 0.22*ScrW/2 + 5, ScrH - 35 - 0.1*ScrH, 30,25)
		end
	end
	if veh:Health() < 50 then drawWarningSign() end
end
hook.Add("HUDPaint", "drawPetrolMeter", drawVehicleHud)

local function togglePetrolMeter()
	veh = net.ReadEntity() or nil
	showMeter = net.ReadBool()
end
net.Receive("togglePetrolMeter", togglePetrolMeter)