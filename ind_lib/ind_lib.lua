local w, h = draw.GetScreenSize()

local font_names = {
	[0] = "Tahoma",
	[1] = "Verdana"
}

i = 0

local ref = gui.Reference("Visuals")
local tab = gui.Tab(ref, "tab_ind_opt", "Indicators Settings")
local gb = gui.Groupbox(tab, "Size", 15, 15, 300, 900)
local gb_1 = gui.Groupbox(tab, "Position", 325, 15, 300, 900)

local fnt_name = gui.Combobox(gb, "fnt_name", "Font Name", "Tahoma", "Verdana")
local fnt_size = gui.Slider(gb, "fnt_size", "Font Size", 27, 12, 48)
local fnt_weight = gui.Slider(gb, "fnt_weight", "Font Weight", 600, 100, 4000)

local xpos = gui.Slider(gb_1, "xpos", "X Position", 15, 0, w)
local ypos = gui.Slider(gb_1, "ypos", "Y Position", h/4*3, 0, h)
local dist = gui.Slider(gb_1, "dist", "Distance", 50, 0, 100)

fnt_name:SetDescription("Sets font name for the indicators")
fnt_size:SetDescription("Sets font size for the indicators")
fnt_weight:SetDescription("Sets font weight for the indicators")

xpos:SetDescription("Sets X Position for the indicators")
ypos:SetDescription("Sets starting Y Positiong for the indicators")
dist:SetDescription("Sets distance between each indicators")

local font = draw.CreateFont(font_names[fnt_name:GetValue()], fnt_size:GetValue(), fnt_weight:GetValue())

local obj = {}

Indicator = {text = "", color = {255, 255, 255, 255}, visible = true, drawCircle = false, circleP = 0, circleT = 1, circleR = 1, circleX = 0, circleY = 0}

Indicator.font = {
	name = font_names[fnt_name:GetValue()],
	size = fnt_size:GetValue(),
	weight = fnt_weight:GetValue()
}

function Indicator:New(text, color, visible)
	i = i + 1
	obj[i] = {}
	setmetatable(obj[i], self)
	self.__index = self
	self.text = text or ""
	self.color = color or {255, 255, 255, 255}
	self.visible = visible

	return obj[i]
end

function Indicator:Add(text, color, visible)
	local a = Indicator:New(text, color, visible)
	a:SetText(text)
	a:SetColor(color)
	a:SetVisible(visible)
	return a
end

function Indicator:SetText(text)
	self.text = text
end

function Indicator:SetColor(color)
	self.color = color
end

function Indicator:SetVisible(vis)
	self.visible = vis
end

function Indicator:SetDrawCircle(drawCircle)
	self.drawCircle = drawCircle
end

function Indicator:DrawCircle(x, y, radius, thickness, percentage)
	self.drawCircle = true
	self.circleX = x
	self.circleY = y
	self.circleR = radius
	self.circleT = thickness
	self.circleP = percentage
end

callbacks.Register("Draw", "Font Updater", function()
	local pLocal = entities.GetLocalPlayer()
	if not pLocal then return end
	if not pLocal:IsAlive() then return end

	if Indicator.font.name ~= fnt_name:GetValue() or Indicator.font.size ~= fnt_size:GetValue() or Indicator.font.weight ~= fnt_weight:GetValue() then
		Indicator.font = {
			name = font_names[fnt_name:GetValue()],
			size = fnt_size:GetValue(),
			weight = fnt_weight:GetValue()
		}
		font = draw.CreateFont(font_names[fnt_name:GetValue()], fnt_size:GetValue(), fnt_weight:GetValue())
	end
end)
	
callbacks.Register("Draw", "Draw Indicators", function()
	local pLocal = entities.GetLocalPlayer()
	if not pLocal then return end
	if not pLocal:IsAlive() then return end

	local temp = {}

	local y = ypos:GetValue()

	draw.SetFont(font)

	for i = 1, #obj do
		if obj[i].visible then
			table.insert(temp, obj[i])
		end
	end

	for i = 1, #temp do
		local __ind = temp[i]
		if __ind.visible then
			draw.Color(28, 28, 28, 50)
			draw.Color(unpack(__ind.color))
			draw.Text(xpos:GetValue(), y, __ind.text)
			if __ind.drawCircle then
				for i = 0, 360 / 100 * __ind.circleP do
			        --local angle = ((i - 90) % 360) * math.pi / 180
			        local angle = i * math.pi / 180
			        draw.Color(210, 210, 210, 255)
			        local ptx, pty = __ind.circleX + __ind.circleR * math.cos(angle), y + __ind.circleY + __ind.circleR * math.sin(angle)
			        local ptx_, pty_ = __ind.circleX + (__ind.circleR-__ind.circleT) * math.cos(angle), y + __ind.circleY + (__ind.circleR-__ind.circleT) * math.sin(angle)
			        draw.Line(ptx, pty, ptx_, pty_)
			    end
			    for i = 360 / 100 * __ind.circleP + 1, 360 do
			        --local angle = ((i - 90) % 360) * math.pi / 180
			        local angle = i * math.pi / 180
			        draw.Color(45, 45, 45, 45)
			        local ptx, pty = __ind.circleX + __ind.circleR * math.cos(angle), y + __ind.circleY + __ind.circleR * math.sin(angle)
			        local ptx_, pty_ = __ind.circleX + (__ind.circleR-__ind.circleT) * math.cos(angle), y + __ind.circleY + (__ind.circleR-__ind.circleT) * math.sin(angle)
			        draw.Line(ptx, pty, ptx_, pty_)
			    end
			end
		    y = y - dist:GetValue()
		end
	end
end)
