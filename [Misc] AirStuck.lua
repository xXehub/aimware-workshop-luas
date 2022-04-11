local ref = gui.Reference("Misc", "Movement", "Other")
local airstuck = gui.Keybox(ref, "ref_airstuck", "Airstuck Key", 0)

callbacks.Register("CreateMove", function(c)
local airstuck_key = airstuck:GetValue()
if airstuck_key == 0 then return end
if not input.IsButtonDown(airstuck_key) then return end

c.command_number = 0x00000
c.tick_count = 0x7F7FFFFF
end)