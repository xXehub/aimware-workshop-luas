local group = gui.Groupbox(gui.Reference("Visuals", "Local"), "Extra Indicators", 328, 284, 296)
local radiussl = gui.Slider(group, "hi_rad", "Radius", 30, 10, 100)
local thicknesssl = gui.Slider(group, "hi_thickness", "Thickness", 6, 1, 50)
local bgcp = gui.ColorPicker(group, "hi_bgclr", "Background Color", 0,0,0,100)
local icp = gui.ColorPicker(group, "hi_iclr", "Indicator Color", 255,75,15,255)
local shiftind = gui.Checkbox(group, "hi_shift", "Shift On Shot Indicator", 1)
local dtind = gui.Checkbox(group, "hi_dt", "Double Tap Indicator", 1)
local attind = gui.Checkbox(group, "hi_at", "At Targets Indicator", 1)
local aeind = gui.Checkbox(group, "hi_ae", "At Edge Indicator", 1)
local fklag = gui.Checkbox(group, "hi_fklag", "Fake lag Indicator", 1)
local fkdck = gui.Checkbox(group, "hi_fkdck", "Fake Duck Indicator", 1)

local font = draw.CreateFont("Calibri", 22, 1000)

local function circle()

    local lp = entities.GetLocalPlayer()

    if lp ~= nil and gui.GetValue("rbot.master") then

        local headpos = lp:GetHitboxPosition(0)
        local origin = lp:GetAbsOrigin()
        local angle = (headpos - origin):Angles()
        local cam_angle = engine.GetViewAngles()
        local diff = cam_angle.y - angle.y

        local radius = radiussl:GetValue()
        local thickness = thicknesssl:GetValue()
        local bgr, bgg, bgb, bga = bgcp:GetValue()
        local ir, ig, ib, ia = icp:GetValue()
        if thickness > radius then
            thickness = radius
        end

        local ang = (diff * -1)/8
        if ang < 0 then ang = 22.5 + (22.5 - math.abs(ang)) end
        
        local x, y = draw.GetScreenSize()
        x = x/2
        y = y/2

        for steps = 1, 45, 1 do

            local sin_cur = math.sin(math.rad(steps * 8 + 180))
            local sin_old = math.sin(math.rad(steps * 8 - 8 + 180))
            local cos_cur = math.cos(math.rad(steps * 8 + 180))
            local cos_old = math.cos(math.rad(steps * 8 - 8 + 180))
            
            local cur_point = nil;
            local old_point = nil;

            cur_point = {x + sin_cur * radius, y + cos_cur * radius};    
            old_point = {x + sin_old * radius, y + cos_old * radius};

            local cur_point2 = nil;
            local old_point2 = nil;

            cur_point2 = {x + sin_cur * (radius - thickness), y + cos_cur * (radius - thickness)};    
            old_point2 = {x + sin_old * (radius - thickness), y + cos_old * (radius - thickness)};
            
            if steps >= ang - 2 and steps <= ang + 2 then
                draw.Color(ir, ig, ib, ia)
            else
                draw.Color(bgr, bgg, bgb, bga)
            end

            if ang - 2 < 0 and steps >= 45 + (ang - 2) then
                draw.Color(ir, ig, ib, ia)
            end
            if ang + 2 > 45 and steps <= (ang + 2) - 45 then
                draw.Color(ir, ig, ib, ia)
            end

            draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], old_point2[1], old_point2[2])
            draw.Triangle(cur_point2[1], cur_point2[2], old_point2[1], old_point2[2], cur_point[1], cur_point[2])    
        
        end

        local offset = 0
        draw.SetFont(font)

        if shiftind:GetValue() then
            offset = offset + 1
            if gui.GetValue("rbot.antiaim.condition.shiftonshot") then
                draw.Color(ir, ig, ib, ia)
            else
                draw.Color(bgr, bgg, bgb, bga)
            end
            draw.TextShadow(x - draw.GetTextSize("SHIFT ON-SHOT")/2, y + radius + offset * 18, "SHIFT ON-SHOT")
        end

        if dtind:GetValue() then
            offset = offset + 1
            if gui.GetValue("rbot.accuracy.weapon.asniper.doublefire") ~= 0 then
                draw.Color(ir, ig, ib, ia)
            else
                draw.Color(bgr, bgg, bgb, bga)
            end
            draw.TextShadow(x - draw.GetTextSize("DOUBLE TAP")/2, y + radius + offset * 18, "DOUBLE TAP")
        end

        if attind:GetValue() then
            offset = offset + 1
            if gui.GetValue("rbot.antiaim.advanced.autodir.targets") then
                draw.Color(ir, ig, ib, ia)
            else
                draw.Color(bgr, bgg, bgb, bga)
            end
            draw.TextShadow(x - draw.GetTextSize("DOUBLE TAP")/2, y + radius + offset * 18, "AT TARGETS")
        end
        
        if aeind:GetValue() then
            offset = offset + 1
            if gui.GetValue("rbot.antiaim.advanced.autodir.edges") then
                draw.Color(ir, ig, ib, ia)
            else
                draw.Color(bgr, bgg, bgb, bga)
            end
            draw.TextShadow(x - draw.GetTextSize("DOUBLE TAP")/2, y + radius + offset * 18, "AT EDGE")
        end
        if fklag:GetValue() then
            offset = offset + 1
            if gui.GetValue("misc.fakelag.enable") == true then
                draw.Color(ir, ig, ib, ia)
            else
                draw.Color(bgr, bgg, bgb, bga)
            end
            draw.TextShadow(x - draw.GetTextSize("DOUBLE TAP")/2, y + radius + offset * 18, "FAKE LAG")
        end
          
        if fkdck:GetValue() then
            offset = offset + 1
            local fkdck_key = gui.GetValue("rbot.antiaim.extra.fakecrouchkey")

        if input.IsButtonDown(fkdck_key) then
            draw.Color(ir, ig, ib, ia)
            else
                draw.Color(bgr, bgg, bgb, bga)
            end
            draw.TextShadow(x - draw.GetTextSize("DOUBLE TAP")/2, y + radius + offset * 18, "FAKE DUCK")
        end
    end
end

callbacks.Register("Draw", circle)