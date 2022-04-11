local ref = gui.Reference("Visuals")
local tab = gui.Tab(ref, "loa_fog_tab", "Fog Color")
local box = gui.Groupbox(tab, "Fog Settings", 15, 15, 605, 500)
local color = gui.ColorPicker(box, "lua_fog_color", "Fog Color", 255, 255, 255, 255)
local distance = gui.Slider(box, "lua_fog_distance", "Fog Distance", 0, 0, 9999)
local density = gui.Slider(box, "lua_fog_density", "Fog Density", 0, 0, 100)

callbacks.Register("Draw", function() 
  if (entities.GetLocalPlayer() ~= nil and engine.GetServerIP() ~= nil and engine.GetMapName() ~= nil) then
    r,g,b = color:GetValue();
    local fixed = r.." "..g.." "..b
    
    if (client.GetConVar("fog_override") ~= 1) then
      client.SetConVar("fog_override", 1, true)
    end

    if (client.GetConVar("fog_color") ~= fixed) then
      client.SetConVar("fog_color", fixed, true);
    end

    if (client.GetConVar("fog_end") ~= distance:GetValue()) then
      client.SetConVar("fog_start", 0, true)
      client.SetConVar("fog_end", distance:GetValue(), true)
    end

    if (client.GetConVar("fog_maxdensity") ~= density:GetValue()) then
      client.SetConVar("fog_maxdensity", density:GetValue(), true)
    end
  end
end)
