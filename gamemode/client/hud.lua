if SERVER then return end

local hud = {}

local function colour(col)
	return col.r, col.g, col.b, col.a
end

function hud:DrawBar(x, y, w, h, colors, value) //partly taken from https://maurits.tv/data/garrysmod/wiki/wiki.garrysmod.com/index1064.html
	surface.SetDrawColor( colour( colors.border ) )
	surface.DrawOutlinedRect( x, y, w, h )
 
	x = x + 1
	y = y + 1
	w = w - 2
	h = h - 2
 
	surface.SetDrawColor( colour( colors.background ) )
	surface.DrawRect( x, y, w, h );				-- draw background
 
	local width = w * math.Clamp( value, 0, 1 );		-- calc bar width
	surface.SetDrawColor( colour( colors.fill ) )
	surface.DrawRect( x, y, width, h )
end

function hud:DrawPanel(x, y, w, h, background)
	surface.SetDrawColor(background)
	surface.DrawRect(x, y, w, h)
end

local ScrW, ScrH = ScrW(), ScrH()
local variables = {
	marginL = 35,
	marginT = 35,
	marginB = ScrH - 35,
	marginR = ScrW - 35,
}

local default_colours = {
	healthbar = {
		border = Color(0, 0, 0, 255),
		fill = Color(130, 40, 42, 255),
		background = Color(114, 114, 114, 255),
	},

	staminabar = {
		border = Color(0, 0, 0, 255),
		fill = Color(82, 64, 196, 255),
		background = Color(114, 114, 114, 255),
	},

	hungerbar = {
		border = Color(0, 0, 0, 255),
		fill = Color(128, 186, 107, 255),
		background = Color(114, 114, 114, 255),
	},

	thirstbar = {
		border = Color(0, 0, 0, 255),
		fill = Color(46, 149, 193, 255),
		background = Color(114, 114, 114, 255),
	},
}

local hide = {
	CHudHealth = true,
	CHudBattery = true,
}

hook.Add("HUDShouldDraw", "hidedefaulthud", function(name)
	if hide[name] then return false end
end)

local function HUDPaint(name)

	hud:DrawPanel(variables.marginL, variables.marginB - 200, 250, 200, Color(255, 255, 255 ,255))
	hud:DrawBar(variables.marginL, variables.marginB, 250, 15, default_colours.healthbar, 0.5)
	hud:DrawBar(50, 75, 250, 15, default_colours.staminabar, 0.5)
	hud:DrawBar(50, 100, 250, 15, default_colours.hungerbar, 0.5)
	hud:DrawBar(50, 125, 250, 15, default_colours.thirstbar, 0.5)
end
hook.Add("HUDPaint", "drawHUD", HUDPaint)