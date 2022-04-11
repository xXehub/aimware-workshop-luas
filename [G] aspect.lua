local aspect_ratio_table = {};  
local REF = gui.Reference("MISC", "Enhancement")
local aspect_misc = gui.Groupbox(REF, "AspectRatio", 16, 710, 297)
local aspect_ratio_check = gui.Checkbox(aspect_misc, "aspect_ratio_check", "Aspect Ratio Changer", false);
local aspect_ratio_reference = gui.Slider(aspect_misc, "aspect_ratio_reference", "Force aspect ratio", 100, 1, 199)
local function gcd(m, n)    while m ~= 0 do   m, n = math.fmod(n, m), m;
end  
return n
end

local function set_aspect_ratio(aspect_ratio_multiplier)
local screen_width, screen_height = draw.GetScreenSize();   local aspectratio_value = (screen_width*aspect_ratio_multiplier)/screen_height;
    if aspect_ratio_multiplier == 1 or not aspect_ratio_check:GetValue() then  aspectratio_value = 0;   end
        client.SetConVar( "r_aspectratio", tonumber(aspectratio_value), true);   end

local function on_aspect_ratio_changed()
local screen_width, screen_height = draw.GetScreenSize();
for i=1, 200 do   local i2=i*0.01;    i2 = 2 - i2;   local divisor = gcd(screen_width*i2, screen_height);    if screen_width*i2/divisor < 100 or i2 == 1 then   aspect_ratio_table[i] = screen_width*i2/divisor .. ":" .. screen_height/divisor;  end  end
local aspect_ratio = aspect_ratio_reference:GetValue()*0.01;  aspect_ratio = 2 - aspect_ratio;   set_aspect_ratio(aspect_ratio);   end
callbacks.Register('Draw', "Aspect Ratio" ,on_aspect_ratio_changed)