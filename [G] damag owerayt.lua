--MinDamage Key by Ryanchiew with indicator (hold/bind)
--Discord: Ryanchiew#7167
local guiSet = gui.SetValue
local guiGet = gui.GetValue
local togglekey = input.IsButtonDown
local ref = gui.Reference("RAGEBOT");
local tab = gui.Tab(ref,"Extra","MinDamage")
local dmgsettings = gui.Groupbox(tab,"MinDamage by Ryanchiew#7167",16,16,280,300)
local togglekey = gui.Keybox(dmgsettings, "ChangeDmgKey", "Mindamage Key", 0)
local setDmg = gui.Combobox(dmgsettings, "mindmgmode", "Min Damage Mode", "Off", "Toggle", "Hold")
local awpdmg = gui.Groupbox(tab,"Awp Damage Settings",16,190,280,300)
local awpDamage = gui.Slider(awpdmg, "awpDamage", "Awp Min Damage", 1, 0, 100)
local awpori = gui.Slider(awpdmg, "awpori", "Awp Original Min Damage", 1, 0, 100)
local scoutdmg = gui.Groupbox(tab,"Scout Damage Settings",310,16,280,300)
local scoutDamage = gui.Slider(scoutdmg, "scoutDamage", "Scout Min Damage", 1, 0, 100)
local scoutori = gui.Slider(scoutdmg, "scoutori", "Scout Original Min Damage", 1, 0, 100)
local autodmg = gui.Groupbox(tab,"Auto Damage Settings",310,190,280,300)
local autoDamage = gui.Slider(autodmg, "autoDamage", "Auto Min Damage", 1, 0, 100)
local autoori = gui.Slider(autodmg, "autoori", "Auto Original Min Damage", 1, 0, 100)
local position = gui.Groupbox(tab,"Indicators position",16,350,280,300)
local xpos = gui.Slider(position, "xpos", "X Position", 1, 0, 1980)
local ypos = gui.Slider(position, "ypos", "Y Position", 1, 0, 1080)
local Toggle =-1
local pressed = false

function changeMinDamage()
if (setDmg:GetValue()==1) then
        if input.IsButtonPressed(togglekey:GetValue()) then
            pressed=true;
Toggle = Toggle *-1

        elseif (pressed and input.IsButtonReleased(togglekey:GetValue())) then
            pressed=false;

            if Toggle == 1 then
            guiSet("rbot.accuracy.weapon.sniper.mindmg", awpDamage:GetValue())
            guiSet("rbot.accuracy.weapon.scout.mindmg", scoutDamage:GetValue())
            guiSet("rbot.accuracy.weapon.asniper.mindmg", autoDamage:GetValue())
            else
        guiSet("rbot.accuracy.weapon.asniper.mindmg", autoori:GetValue())
        guiSet("rbot.accuracy.weapon.sniper.mindmg", awpori:GetValue())
        guiSet("rbot.accuracy.weapon.scout.mindmg", scoutori:GetValue())

            end
        end
    elseif (setDmg:GetValue()==2) then
        if input.IsButtonDown(togglekey:GetValue()) then
            guiSet("rbot.accuracy.weapon.sniper.mindmg", awpDamage:GetValue())
            guiSet("rbot.accuracy.weapon.scout.mindmg", scoutDamage:GetValue())
            guiSet("rbot.accuracy.weapon.asniper.mindmg", autoDamage:GetValue())
        else
        guiSet("rbot.accuracy.weapon.asniper.mindmg", autoori:GetValue())
        guiSet("rbot.accuracy.weapon.sniper.mindmg", awpori:GetValue())
        guiSet("rbot.accuracy.weapon.scout.mindmg", scoutori:GetValue())
        end
    elseif (setDmg:GetValue()==0) then
        Toggle = -1
        guiSet("rbot.accuracy.weapon.asniper.mindmg", autoori:GetValue())
        guiSet("rbot.accuracy.weapon.sniper.mindmg", awpori:GetValue())
        guiSet("rbot.accuracy.weapon.scout.mindmg", scoutori:GetValue())
    end
end

function Drawtext()
    w = xpos:GetValue()
    h = ypos:GetValue()
if (setDmg:GetValue()==1) then
    if Toggle == 1 then
        draw.Color(0, 255, 0, 255);
        draw.Text(w, h-60, "Min Damage Mode On (toggle)");
        draw.Color(255, 255, 0, 255);
        draw.Text(w+90, h-40, awpDamage:GetValue());
        draw.Color(255, 255, 0, 255);
        draw.Text(w+30, h-40, "awp:");
        draw.Color(255, 255, 0, 255);
        draw.Text(w+90, h-20, scoutDamage:GetValue());
        draw.Color(255, 255, 0, 255);
        draw.Text(w+30, h-20, "scout:");
        draw.Color(255, 255, 0, 255);
        draw.Text(w+90, h, autoDamage:GetValue());
        draw.Color(255, 255, 0, 255);
        draw.Text(w+30, h, "auto:");
    elseif Toggle == -1 then
    draw.Color(255, 255, 255, 255);
    draw.Text(w, h-60, "Min Damage Mode Off");
    draw.Color(255, 255, 255, 255);
    draw.Text(w+90, h-20, scoutori:GetValue());
    draw.Color(255, 255, 255, 255);
    draw.Text(w+90, h-40, awpori:GetValue());
    draw.Color(255, 255, 255, 255);
    draw.Text(w+90, h, autoori:GetValue());
    draw.Color(255, 255, 255, 255);
    draw.Text(w+30, h-20, "scout:");
    draw.Color(255, 255, 255, 255);
    draw.Text(w+30, h-40, "awp:");
    draw.Color(255, 255, 255, 255);
    draw.Text(w+30, h, "auto:");
    end
elseif (setDmg:GetValue()==2) then
    if input.IsButtonDown(togglekey:GetValue()) then
          draw.Color(0, 255, 0, 255);
        draw.Text(w, h-60, "Min Damage Mode On (toggle)");
        draw.Color(255, 255, 0, 255);
        draw.Text(w+90, h-40, awpDamage:GetValue());
        draw.Color(255, 255, 0, 255);
        draw.Text(w+30, h-40, "awp:");
        draw.Color(255, 255, 0, 255);
        draw.Text(w+90, h-20, scoutDamage:GetValue());
        draw.Color(255, 255, 0, 255);
        draw.Text(w+30, h-20, "scout:");
        draw.Color(255, 255, 0, 255);
        draw.Text(w+90, h, autoDamage:GetValue());
        draw.Color(255, 255, 0, 255);
        draw.Text(w+30, h, "auto:");
    else
    draw.Color(255, 255, 255, 255);
    draw.Text(w, h-60, "Min Damage Mode Off");
    draw.Color(255, 255, 255, 255);
    draw.Text(w+90, h-20, scoutori:GetValue());
    draw.Color(255, 255, 255, 255);
    draw.Text(w+90, h-40, awpori:GetValue());
    draw.Color(255, 255, 255, 255);
    draw.Text(w+90, h, autoori:GetValue());
    draw.Color(255, 255, 255, 255);
    draw.Text(w+30, h-20, "scout:");
    draw.Color(255, 255, 255, 255);
    draw.Text(w+30, h-40, "awp:");
    draw.Color(255, 255, 255, 255);
    draw.Text(w+30, h, "auto:");
        
    
    end
else
    draw.Color(255, 255, 255, 255);
    draw.Text(w, h-60, "Min Damage Mode Off");
    draw.Color(255, 255, 255, 255);
    draw.Text(w+90, h-20, scoutori:GetValue());
    draw.Color(255, 255, 255, 255);
    draw.Text(w+90, h-40, awpori:GetValue());
    draw.Color(255, 255, 255, 255);
    draw.Text(w+90, h, autoori:GetValue());
    draw.Color(255, 255, 255, 255);
    draw.Text(w+30, h-20, "scout:");
    draw.Color(255, 255, 255, 255);
    draw.Text(w+30, h-40, "awp:");
    draw.Color(255, 255, 255, 255);
    draw.Text(w+30, h, "auto:");
end
end
callbacks.Register("Draw", "Drawtext", Drawtext);
callbacks.Register("Draw", "changeMinDamage", changeMinDamage);