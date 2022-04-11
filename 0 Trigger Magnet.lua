
local ref = gui.Reference("Legitbot", "Triggerbot", "Toggle")
local magnet = gui.Checkbox(ref, "magnet_trg", "Magnet Trigger", false)

magnet:SetDescription("Pulls your crosshair towards the enemy")

local pressed = false
local old_val = { 
on_press = gui.GetValue("lbot.aim.fireonpress"),
autofire = gui.GetValue("lbot.aim.autofire")
}

callbacks.Register("Draw", function()
if magnet:GetValue() then
if gui.GetValue("lbot.trg.enable") then
if gui.GetValue("lbot.trg.key") ~= 0 or gui.GetValue("lbot.trg.autofire") then
if gui.GetValue("lbot.trg.autofire") or input.IsButtonDown(gui.GetValue("lbot.trg.key")) then
if pressed == false then
pressed = true
old_val.on_press = gui.GetValue("lbot.aim.fireonpress")
old_val.autofire = gui.GetValue("lbot.aim.autofire")
end
gui.SetValue("lbot.aim.fireonpress", false)
gui.SetValue("lbot.aim.autofire", true) 
else
if pressed then
pressed = false
gui.SetValue("lbot.aim.fireonpress", old_val.on_press)
gui.SetValue("lbot.aim.autofire", old_val.autofire)
end
end
end
end
end
end)