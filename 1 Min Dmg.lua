
--MinDamage Key by Ryanchiew with indicator (hold/bind)
--Discord: Ryanchiew#7167
local guiSet = gui.SetValue
local guiGet = gui.GetValue
local togglekey = input.IsButtonDown

--UI References
local ref = gui.Reference("RAGEBOT");
local tab = gui.Tab(ref,"Extra","MinDamage")

-- Makes new UI Boxes & Sliders

local dmgsettings = gui.Groupbox(tab,"Hotkey & Mode", 16, 16, 280, 300)
local togglekey = gui.Keybox(dmgsettings, "ChangeDmgKey", "Mindamage Key", 0)
local setDmg = gui.Combobox(dmgsettings, "mindmgmode", "Min Damage Mode", "Off", "Toggle", "Hold")

local creditbox = gui.Groupbox(tab, "Min damage by Ryanchiew#7167 & Changes made by Froggie", 16, 525, 575, 300)

local awpdmg = gui.Groupbox(tab,"Awp Damage Settings", 16, 190, 280, 300)
local awpori = gui.Slider(awpdmg, "awpori", "Awp Original Min Damage", 1, 0, 130)
local awpDamage = gui.Slider(awpdmg, "awpDamage", "Awp Min Damage Override", 1, 0, 130)

local scoutdmg = gui.Groupbox(tab,"Scout Damage Settings", 310, 16, 280, 300)
local scoutori = gui.Slider(scoutdmg, "scoutori", "Scout Original Min Damage", 1, 0, 130)
local scoutDamage = gui.Slider(scoutdmg, "scoutDamage", "Scout Min Damage Override", 1, 0, 130)

local autodmg = gui.Groupbox(tab,"Auto Damage Settings", 310, 190, 280, 300)
local autoori = gui.Slider(autodmg, "autoori", "Auto Original Min Damage", 1, 0, 130)
local autoDamage = gui.Slider(autodmg, "autoDamage", "Auto Min Damage Override", 1, 0, 130)

local r8dmg = gui.Groupbox(tab,"R8 Damage Settings", 310, 350, 280, 300)
local r8ori = gui.Slider(r8dmg, "r8ori", "R8 Original Min Damage", 1, 0, 130)
local r8Damage = gui.Slider(r8dmg, "r8Damage", "R8 Min Damage Override", 1, 0, 130)

local position = gui.Groupbox(tab,"Indicators position", 16, 350, 280, 300)
local xpos = gui.Slider(position, "xpos", "X Position", 18, 0, 3840)
local ypos = gui.Slider(position, "ypos", "Y Position", 597, 0, 2160)


local Toggle =-1
local pressed = false

--Gets stuff
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

 			guiSet("rbot.accuracy.weapon.hpistol.mindmg", r8Damage:GetValue())

            else

guiSet("rbot.accuracy.weapon.asniper.mindmg", autoori:GetValue())

    guiSet("rbot.accuracy.weapon.sniper.mindmg", awpori:GetValue())

        guiSet("rbot.accuracy.weapon.scout.mindmg", scoutori:GetValue())

        	guiSet("rbot.accuracy.weapon.hpistol.mindmg", r8ori:GetValue())
            end
        end

 elseif (setDmg:GetValue()==2) then
 if input.IsButtonDown(togglekey:GetValue()) then

 guiSet("rbot.accuracy.weapon.sniper.mindmg", awpDamage:GetValue())

    guiSet("rbot.accuracy.weapon.scout.mindmg", scoutDamage:GetValue())

 		guiSet("rbot.accuracy.weapon.asniper.mindmg", autoDamage:GetValue())

 			guiSet("rbot.accuracy.weapon.hpistol.mindmg", r8Damage:GetValue())

 	else

 guiSet("rbot.accuracy.weapon.asniper.mindmg", autoori:GetValue())

    guiSet("rbot.accuracy.weapon.sniper.mindmg", awpori:GetValue())

        guiSet("rbot.accuracy.weapon.scout.mindmg", scoutori:GetValue())

        	guiSet("rbot.accuracy.weapon.hpistol.mindmg", r8ori:GetValue())

 end

 elseif (setDmg:GetValue()==0) then
 Toggle = -1

 guiSet("rbot.accuracy.weapon.asniper.mindmg", autoori:GetValue())

        guiSet("rbot.accuracy.weapon.sniper.mindmg", awpori:GetValue())

        	guiSet("rbot.accuracy.weapon.scout.mindmg", scoutori:GetValue())

        		guiSet("rbot.accuracy.weapon.hpistol.mindmg", r8ori:GetValue())
 end
end

-- Draws nice things on screen
function Drawtext()

    w = xpos:GetValue()
 h = ypos:GetValue()

if (setDmg:GetValue()==1) then
 if Toggle == 1 then

--Indicator
 draw.Color(0, 255, 0, 255);
 	draw.Text(w, h-80, "Min Damage Mode On (toggle)");

-- AWP
 draw.Color(255, 255, 0, 255);

 	draw.Text(w+90, h-60, awpDamage:GetValue());

 		draw.Color(255, 255, 0, 255);

 			draw.Text(w+30, h-60, "awp:");
--Scout
 draw.Color(255, 255, 0, 255);

 	draw.Text(w+90, h-40, scoutDamage:GetValue());

 		draw.Color(255, 255, 0, 255);

 			draw.Text(w+30, h-40, "scout:");

--AUTO

 draw.Color(255, 255, 0, 255);

 	draw.Text(w+90, h, autoDamage:GetValue());

		draw.Color(255, 255, 0, 255);

 			draw.Text(w+30, h, "auto:");

--R8

 draw.Color(255, 255, 0, 255);

 	draw.Text(w+90, h-20, r8Damage:GetValue());

 		draw.Color(255, 255, 0, 255);

 			draw.Text(w+30, h-20, "r8:");

 elseif Toggle == -1 then

-- INDICATOR
 draw.Color(255, 255, 255, 255);

 	draw.Text(w, h-80, "Min Damage Mode Off");

--Scout
 draw.Color(255, 255, 255, 255);

 	draw.Text(w+90, h-40, scoutori:GetValue());

  		draw.Color(255, 255, 255, 255);

 			draw.Text(w+30, h-40, "scout:");

--Awp
 draw.Color(255, 255, 255, 255);

 	draw.Text(w+90, h-60, awpori:GetValue());

  		draw.Color(255, 255, 255, 255);

 			draw.Text(w+30, h-60, "awp:");

--Auto
 draw.Color(255, 255, 255, 255);
 	
 	draw.Text(w+90, h, autoori:GetValue());
  		
  		draw.Color(255, 255, 255, 255);
 		
 			draw.Text(w+30, h, "auto:");

--Revolver
draw.Color(255, 255, 255, 255);
 	
 	draw.Text(w+90, h-20, r8ori:GetValue());
 		
 		draw.Color(255, 255, 255, 255);
 			
 			draw.Text(w+30, h-20, "r8:");

 end

elseif (setDmg:GetValue()==2) then
 if input.IsButtonDown(togglekey:GetValue()) then

--Awp
 draw.Color(0, 255, 0, 255);
 	
 	draw.Text(w+90, h-60, awpDamage:GetValue());
 		
 		draw.Color(255, 255, 0, 255);
 			
 			draw.Text(w+30, h-60, "awp:");

--Scout
 draw.Color(255, 255, 0, 255);
 
 	draw.Text(w+90, h-40, scoutDamage:GetValue());
 
 		draw.Color(255, 255, 0, 255);
 
 			draw.Text(w+30, h-40, "scout:");

--Auto
 draw.Color(255, 255, 0, 255);
 
 	draw.Text(w+90, h, autoDamage:GetValue());
 
 		draw.Color(255, 255, 0, 255);
 
 			draw.Text(w+30, h, "auto:");

--Revolver
 draw.Color(255, 255, 0, 255);
 
 		draw.Text(w+90, h-20, r8Damage:GetValue());
 
 			draw.Color(255, 255, 0, 255);
 
 				draw.Text(w+30, h-20, "r8:");

 else

--Scout
 draw.Color(255, 255, 255, 255);
 
 	draw.Text(w+90, h-40, scoutori:GetValue());
 
 		draw.Color(255, 255, 255, 255);
 
 			draw.Text(w+30, h-40, "scout:");

--Awp
 draw.Color(255, 255, 255, 255);
 
 	draw.Text(w+90, h-60, awpori:GetValue());
 
 		draw.Color(255, 255, 255, 255);
 
 			draw.Text(w+30, h-60, "awp:");

 --Auto
 draw.Color(255, 255, 255, 255);
 
 	draw.Text(w+90, h, autoori:GetValue());

		draw.Color(255, 255, 255, 255);

 			draw.Text(w+30, h, "auto:");

--Revolver
 draw.Color(255, 255, 255, 255);
 
 	draw.Text(w+90, h-20, r8ori:GetValue());
 
 		draw.Color(255, 255, 255, 255);
 
			draw.Text(w+30, h-20, "r8:");
 
end

else

--Indicator
 draw.Color(255, 255, 255, 255);

 	draw.Text(w, h-80, "Min Damage Mode Off");

--Scout
 draw.Color(255, 255, 255, 255);
 
 	draw.Text(w+90, h-40, scoutori:GetValue());

		draw.Color(255, 255, 255, 255);

 			draw.Text(w+30, h-40, "scout:");

--Awp
 draw.Color(255, 255, 255, 255);

 	draw.Text(w+90, h-60, awpori:GetValue());

		draw.Color(255, 255, 255, 255);

 			draw.Text(w+30, h-60, "awp:");

--Auto
 draw.Color(255, 255, 255, 255);

 	draw.Text(w+90, h, autoori:GetValue());

 		draw.Color(255, 255, 255, 255);

 			draw.Text(w+30, h, "auto:");

--Revolver
 draw.Color(255, 255, 255, 255);

	 draw.Text(w+90, h-20, r8ori:GetValue());

 		draw.Color(255, 255, 255, 255);

 			draw.Text(w+30, h-20, "r8:");

	end

end

--callbacks (Even stoopid knows this one)
callbacks.Register("Draw", "Drawtext", Drawtext);
callbacks.Register("Draw", "changeMinDamage", changeMinDamage);