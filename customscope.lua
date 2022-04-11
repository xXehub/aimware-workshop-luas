--©thekorol
function DrawUI()
MENU = gui.Reference("Visuals","Other");
GBOX = gui.Groupbox(MENU, "Scope Crosshair", 328,286,296,0);
CHECKBOXENABLE = gui.Checkbox(GBOX,"scope_crosshair.enable", "Enable" , true);
SLIDERLENGHT = gui.Slider(GBOX, "scope_crosshair.length", "Length", 150, 50, 300);
SLIDERTHICKNESS = gui.Slider(GBOX, "scope_crosshair.thickness", "Thickness", 1, 1, 3);
COLORLINE = gui.ColorPicker(GBOX,"scope_crosshair.clr", "Color" ,66, 134,244,255);
end

function crosshair()

    local enbl = CHECKBOXENABLE:GetValue();
	local lngth = SLIDERLENGHT:GetValue();
	local thcknss = SLIDERTHICKNESS:GetValue();
	local clr1,clr2,clr3,clr4 = COLORLINE:GetValue();

    hLocalPlayer = entities.GetLocalPlayer();
    is_scope = hLocalPlayer:GetPropBool("m_bIsScoped");
    if not hLocalPlayer then return end 
    if is_scope and enbl then
        x,y = draw.GetScreenSize();

        client.SetConVar("cl_drawhud", "0",true);
        gui.SetValue("esp.other.noscopeoverlay",false);
	gui.SetValue("esp.other.crosshair",false);
		
        gradientH(x/2,y/2,x/2+lngth,y/2-thcknss,{ clr1,clr2,clr3,clr4 }, true);
        gradientH(x/2-lngth,y/2,x/2,y/2-thcknss,{ clr1,clr2,clr3,clr4 }, false);
		gradientV(x/2,y/2,thcknss,lngth,{ 255, 255, 255,0 },{ clr1,clr2,clr3,clr4 },true);
	    gradientV(x/2,y/2,thcknss,lngth,{ 255, 255, 255,0 },{ clr1,clr2,clr3,clr4 },false);
    else
        client.SetConVar("cl_drawhud", "1",true);
	gui.SetValue("esp.other.noscopeoverlay",true);
    end
end

function gradientH(x1, y1, x2, y2,col1, left)
    local w = x2 - x1
    local h = y2 - y1
 
    for i = 0, w do
        local a = (i / w) * 200
        local r, g, b = col1[1], col1[2], col1[3];
        draw.Color(r,g,b, a)
        if left then
            draw.FilledRect(x1 + i, y1, x1 + i + 1, y1 + h)
        else
            draw.FilledRect(x1 + w - i, y1, x1 + w - i + 1, y1 + h)
        end
    end
end

function gradientV( x, y, w, h, col1, col2,down )
    rect( x, y, w, h, col1 );

    local r, g, b = col2[1], col2[2], col2[3];

    for i = 1, h do
        local a = i / h * 255;
		if down then
            rect( x, y + i, w, 1, { r, g, b, a } );
		else
		    rect( x, y - i, w, 1, { r, g, b, a } );
		end
    end
end
function rect( x, y, w, h, col )
    draw.Color( col[1], col[2], col[3], col[4] );
    draw.FilledRect( x, y, x + w, y + h );
end

DrawUI();
callbacks.Register("Draw",crosshair);