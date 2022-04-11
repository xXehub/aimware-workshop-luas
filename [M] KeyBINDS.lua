local mouseX, mouseY, x, y, dx, dy, w, h = 0, 0, 25, 660, 0, 0, 300, 60;
local shouldDrag = false;
local font = draw.CreateFont("Courier New", 15, 15);
local topbarSize = 20;
local svgData = http.Get( "http://eaassets-a.akamaihd.net/battlelog/prod/emblem/325/83/320/2955057809976353965.png" );
local imgRGBA, imgWidth, imgHeight = common.DecodePNG( svgData );
local texture = draw.CreateTexture( imgRGBA, imgWidth, imgHeight );
local render = {};

render.outline = function( x, y, w, h, col )
    draw.Color( col[1], col[2], col[3], col[4] );
    draw.OutlinedRect( x, y, x + w, y + h );
end
render.rect = function( x, y, w, h, col )
    draw.Color( col[1], col[2], col[3], col[4] );
    --draw.FilledRect( x, y, x + w, y + h );
end
render.rect2 = function( x, y, w, h )
    draw.FilledRect( x, y, x + w, y + h );
end
render.gradient = function( x, y, w, h, col1, col2, is_vertical )
    render.rect( x, y, w, h, col1 );

    local r, g, b = col2[1], col2[2], col2[3];

    if is_vertical then
        for i = 1, h do
            local a = i / h * 255;
            render.rect( x, y + i, w, 1, { r, g, b, a } );
        end
    else
        for i = 1, w do
            local a = i / w * 255;
            render.rect( x + i, y, 1, h, { r, g, b, a } );
        end
    end
end

local function getKeybinds()
    local Keybinds = {};
    local i = 1;

    hLocalPlayer = entities.GetLocalPlayer();
    wid = hLocalPlayer:GetWeaponID()
---------------------------
if gui.GetValue("lbot.master") and gui.GetValue("lbot.trg.key") ~= 0 and input.IsButtonDown(gui.GetValue("lbot.trg.key")) then
    Keybinds[i] = 'Triggerbot';
        i = i + 1;
    end
if gui.GetValue("lbot.master") and gui.GetValue("lbot.antiaim.type") ~= '"Off"' then
    Keybinds[i] = 'Legit AA';
        i = i + 1;
    end
if gui.GetValue("lbot.master") and gui.GetValue("lbot.extra.knifetrigger") then
    Keybinds[i] = 'Knifebot';
        i = i + 1;
    end
if gui.GetValue("lbot.master") and gui.GetValue("misc.fakelag.enable") then
    Keybinds[i] = 'Fakelag';
        i = i + 1;
    end
---------------------------
if gui.GetValue("rbot.master") and (wid == 1 or wid == 64) and gui.GetValue("rbot.accuracy.weapon.hpistol.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
elseif gui.GetValue("rbot.master") and (wid == 2 or wid == 3 or wid == 4 or wid == 30 or wid == 32 or wid == 36 or wid == 61 or wid == 63) and gui.GetValue("rbot.accuracy.weapon.pistol.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
    elseif gui.GetValue("rbot.master") and (wid == 7 or wid == 8 or wid == 10 or wid == 13 or wid == 16 or wid == 39 or wid == 60) and gui.GetValue("rbot.accuracy.weapon.rifle.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
elseif gui.GetValue("rbot.master") and (wid == 11 or wid == 38) and gui.GetValue("rbot.accuracy.weapon.asniper.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
elseif gui.GetValue("rbot.master") and (wid == 17 or wid == 19 or wid == 23 or wid == 24 or wid == 26 or wid == 33 or wid == 34) and gui.GetValue("rbot.accuracy.weapon.smg.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
elseif gui.GetValue("rbot.master") and (wid == 14 or wid == 28) and gui.GetValue("rbot.accuracy.weapon.lmg.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
elseif gui.GetValue("rbot.master") and (wid == 25 or wid == 27 or wid == 29 or wid == 35) and gui.GetValue("rbot.accuracy.weapon.shotgun.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
    end
    if gui.GetValue("rbot.master") and gui.GetValue("rbot.accuracy.movement.slowkey") ~= 0 and input.IsButtonDown(gui.GetValue("rbot.accuracy.movement.slowkey")) then
    Keybinds[i] = 'Slowwalk';
        i = i + 1;
    end
if gui.GetValue("rbot.master") and gui.GetValue("rbot.antiaim.base.rotation") > 1 then
    Keybinds[i] = 'Anti-Aim Inverted';
        i = i + 1;
    end
if gui.GetValue("rbot.master") and gui.GetValue("rbot.antiaim.extra.fakecrouchkey") ~= 0 and input.IsButtonDown(gui.GetValue("rbot.antiaim.extra.fakecrouchkey")) then
    Keybinds[i] = 'Fake Duck';
        i = i + 1;
    end
if gui.GetValue("rbot.master") and gui.GetValue("rbot.antiaim.condition.shiftonshot") then
    Keybinds[i] = 'Hide Shots';
        i = i + 1;
    end
if gui.GetValue("esp.master") and gui.GetValue("esp.local.thirdperson") then
    Keybinds[i] = 'Thirdperson';
        i = i + 1;
    end
---------------------------
if gui.GetValue("misc.fakelatency.key") == 0 then
if gui.GetValue("misc.master") and gui.GetValue("misc.fakelatency.enable") then
    Keybinds[i] = 'Fakelatency';
        i = i + 1;
    end
elseif gui.GetValue("misc.fakelatency.key") ~= 0 then
if gui.GetValue("misc.master") and gui.GetValue("misc.fakelatency.enable") and input.IsButtonDown(gui.GetValue("misc.fakelatency.key")) then
    Keybinds[i] = 'Fakelatency';
        i = i + 1;
    end
end

    return Keybinds;
end

local function drawkeybinds(Keybinds)
    local temp = false;
    for index in pairs(Keybinds) do
        
        if (temp) then
            render.gradient( x+9, (y + topbarSize + 5) + (index * 15), 198, 1, { 13, 14, 15, 255 }, {40, 30, 30, 255 }, false );
        end
        temp=true;
        draw.SetFont(font);
        draw.Color(255, 255, 255, 255);
        draw.Text(x + 15, (y + topbarSize + 9) + (index * 15), Keybinds[index])
draw.Text(x + 145, (y + topbarSize + 9) + (index * 15), "[active]")
      
    end
end

local function drawRectFill(r, g, b, a, x, y, w, h, texture)
    if (texture ~= nil) then
        draw.SetTexture(texture);
    else
        draw.SetTexture(texture);
    end
    draw.Color(r, g, b, a);
    draw.FilledRect(x, y, x + w, y + h);
end

local function drawGradientRectFill(col1, col2, x, y, w, h)
    drawRectFill(col1[1], col1[2], col1[3], col1[4], x, y, w, h);
    local r, g, b = col2[1], col2[2], col2[3];
    for i = 1, h do
        local a = i / h * col2[4];
        drawRectFill(r, g, b, a, x + 2, y + i, w - 2, 1);
    end
end

local function dragFeature()
    if input.IsButtonDown(1) then
        mouseX, mouseY = input.GetMousePos();
        if shouldDrag then
            x = mouseX - dx;
            y = mouseY - dy;
        end
        if mouseX >= x and mouseX <= x + w and mouseY >= y and mouseY <= y + 40 then
            shouldDrag = true;
            dx = mouseX - x;
            dy = mouseY - y;
        end
    else
        shouldDrag = false;
    end
end

local function drawOutline(r, g, b, a, x, y, w, h, howMany)
    for i = 1, howMany do
        draw.Color(r, g, b, a);
        draw.OutlinedRect(x - i, y - i, x + w + i, y + h + i);
    end
end

local function drawWindow(Keybinds)
    local tW, _ = draw.GetTextSize(keytext);
    local h2 = 5 + (Keybinds * 15);
    local h = h + (Keybinds * 15);
    
    drawRectFill(13, 14, 15, 250, x + 7, y + 20, 202, 20);

    draw.Color(255, 255, 255);
    draw.SetFont(font);
    local keytext = 'Keybinds';
    
    draw.Text(x + ((55 - tW) / 2), y + 25, keytext)
    
    drawRectFill(25, 28, 31, 250, x + 7, y + 40, 200, h2);
    drawOutline(40, 30, 30, 255, x + 9, y + 40, 198, h2, 2);
    
    draw.Color(255, 255, 255);
    draw.SetTexture( texture );
    draw.FilledRect( x+10, y+22, x+25, y+37 );
    draw.SetTexture( texture );
    
end

callbacks.Register("Draw", function()
    if keybindlist:GetValue() == false then return end
    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then return end

    draw.SetTexture( texture );
    local Keybinds = getKeybinds();
    drawWindow(#Keybinds);

    drawkeybinds(Keybinds);
    dragFeature();
end)
------------------------------------------------------------
--DrawUI
------------------------------------------------------------
function DrawUI()
keybindlist = gui.Checkbox(gui.Reference("Misc","General","Extra"),"keybindlist","Show Keybinds",0);
keybindlist:SetDescription("Shows a list of active keybinds.");
end
DrawUI();