local font = draw.CreateFont('Arial', 14);

callbacks.Register("Draw", function()
    if (watermark:GetValue() ~= true) then
        return
    end
    local lp = entities.GetLocalPlayer();
    local playerResources = entities.GetPlayerResources();

    -- do not edit above

    local divider = ' | ';
    local cheatName = 'AIMWARE.net ';
	local indexlp = client.GetLocalPlayerIndex()
    local userName = client.GetPlayerNameByIndex(indexlp);
    
	-- Do not edit below
    local delay;
    local tick;
	local fps = 'FPS: ';
  
local frame_rate = 0/10
local get_abs_fps = function()
    frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * globals.AbsoluteFrameTime()
    return math.floor((1 / frame_rate))
end
 
    if (lp ~= nil) then
        delay = 'delay: ' .. playerResources:GetPropInt("m_iPing", lp:GetIndex()) .. 'ms';
        tick = math.floor(lp:GetProp("localdata", "m_nTickBase") + 0x20) .. 'tick';
    end
    local watermarkText = cheatName .. divider .. userName .. divider;
    if (delay ~= nil) then
        watermarkText = watermarkText .. delay .. divider;
    end
    if (tick ~= nil) then
        watermarkText = watermarkText .. tick .. divider;
    end 
    watermarkText = watermarkText .. fps;
    draw.SetFont(font);
    local w, h = draw.GetTextSize(watermarkText);
    local weightPadding, heightPadding = 20, 15;
    local watermarkWidth = weightPadding + w;
    local start_x, start_y = draw.GetScreenSize();
    start_x, start_y = start_x - watermarkWidth - 20, start_y * 0.0225;
	draw.Color(0, 0, 0, 100);
    draw.FilledRect(start_x-25, start_y, start_x + watermarkWidth , start_y + h + heightPadding);
    draw.Color(255,255,255,255);
    draw.Text(start_x + weightPadding / 2-25, start_y + heightPadding / 2 + 1, watermarkText .. get_abs_fps()/10)
	draw.Color(200, 40, 40, 255);
	draw.FilledRect(start_x-25, start_y, start_x + watermarkWidth , start_y +2);
end)

------------------------------------------------------------
--DrawUI
------------------------------------------------------------
function DrawUI()
	watermark = gui.Checkbox(gui.Reference("Misc","General","Extra"),"watermark","Show Watermark",0);
	watermark:SetDescription("Shows watermark AIMWARE.net.");
end
DrawUI();