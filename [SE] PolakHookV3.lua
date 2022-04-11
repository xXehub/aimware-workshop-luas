local ref = gui.Tab(gui.Reference("Ragebot"), "polakmenu", "PolakHook");

--Anti-Aims
local guiAntiaimBlock = gui.Groupbox(ref, "Custom AA", 16, 16, 250, 250);
local guiAntiaimSwitchKey = gui.Keybox(guiAntiaimBlock , "aaswitchkey", "Switch Key", 70);
local guiArrowsColor = gui.ColorPicker(guiAntiaimBlock, "arrowscolorpicker", "Arrows Color", 255, 0, 0, 255);
local guiAntiaimDeltaSlider = gui.Slider(guiAntiaimBlock, "aadelta", "Desync Delta", 150, 0, 180);
local guiAntiaimRealMaxDeltaJitter = gui.Slider(guiAntiaimBlock, "aajittermaxdelta", "Desync Max Real Delta (Jitter)", 58, 0, 58);
local guiAntiaimRealMinDeltaJitter = gui.Slider(guiAntiaimBlock, "aajittermindelta", "Desync Min Real Delta (Jitter)", 50, 0, 58);
local guiAntiaimAntialignFlicking = gui.Checkbox(guiAntiaimBlock, "antialignflick", "Anti-Align Flicking", 1);
local guiAntiaimDesyncTypeFlicking = gui.Checkbox(guiAntiaimBlock, "desyncmodeflick", "Desync Type Flicking", 0);
local guiAntiaimMode = gui.Checkbox(guiAntiaimBlock, "aamode", "Rage mode", 0);
local guiAntiaimType = gui.Combobox(guiAntiaimBlock, "aatype", "Desync type", "Static (Non-recomend)", "Jitter", "Sway");

--Aimbot Logic
local guiAimLogicBlock = gui.Groupbox(ref, "Aimbot Logic", 280, 16, 250, 250);
local guiNearestKey = gui.Checkbox(guiAimLogicBlock, "nearestkey", "Nearest HSelection (Semi-Rage)", 0);
local guiBaimKey = gui.Checkbox(guiAimLogicBlock, "forcebaimkey", "Force BAim", 0);
local guiMindmgKey = gui.Checkbox(guiAimLogicBlock, "mindmgbaimkey", "Force Damage", 0);
local guiAdaptivedmgKey = gui.Checkbox(guiAimLogicBlock, "adaptivedmgbaimkey", "Adaptive Damage (Enemy HP)", 0);
local guiAwallKey = gui.Checkbox(guiAimLogicBlock, "awallkey", "Auto Wall", 1);
local guiMinDmgSlider = gui.Slider(guiAimLogicBlock, "mindmgslider", "Min Damage", 0, 0, 130);

--Misc Func
local guiMiscBlock = gui.Groupbox(ref, "Misc", 280, 305, 250, 250);
local guiVoteRevealer = gui.Checkbox(guiMiscBlock, "voterevealerkey", "Vote Revealer", 1);
local guiShowArrows = gui.Checkbox(guiMiscBlock, "arrowskey", "Show Arrows", 1);
local guiShowKeyBinds = gui.Checkbox(guiMiscBlock, "keybindskey", "Show Keybinds", 1);
local guiShowWatermark = gui.Checkbox(guiMiscBlock, "watermarkkey", "Show Watermark", 1);

--Some Vars
local aaInverted = 1;

--User Cfg
local aMinDmg = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };	
local aBForce = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };	
local aBLethal = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
local aBShot = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
local aBSafe = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

local aBAim = { "", "", "", "", "", "", "", "", "", "", "" };
local wTypes = { 'shared', 'zeus', 'pistol', 'hpistol', 'smg', 'rifle', 'shotgun', 'scout', 'asniper', 'sniper', 'lmg' }

--Vote vars
local voteType = -1;
local voteResult = -1;
local tTimer = 0;
local voteTarget = "";
local voteName = { "", "", "", "", "", "", "", ""};
local voteVal = { "", "", "", "", "", "", "", ""};
local vIndex = 1;

--Vote

local function VoteEnd(um)
	if um:GetID() == 46 then
		voteType = um:GetInt(3);
		voteTarget = um:GetString(5);
		if (string.len(voteTarget) > 20) then
			voteTarget = string.sub(voteTarget, 0, 15) .. "..."
		end
		
	elseif um:GetID() == 47 then
		tTimer = math.floor(globals.RealTime());
		voteResult = 1
	elseif um:GetID() == 48 then
		tTimer = math.floor(globals.RealTime());
		voteResult = 2
	end
end

local function VoteStart(e)
    if (e:GetName() == "vote_cast") then
		local index = e:GetInt("entityid");
		local vote = e:GetInt("vote_option");
        local name = client.GetPlayerNameByIndex(index)
        if (string.len(name) > 20) then
            name = string.sub(name, 0, 15) .. "..."
        end
		
		voteName[vIndex] = name;
		
		if vote == 0 then
			voteVal[vIndex] = "YES";
		elseif vote == 1 then
			voteVal[vIndex] = "NO";
		else
			voteVal[vIndex] = "N/A";
		end
		vIndex = vIndex + 1;
		
		if vIndex + 1 > 9 then
			vIndex = 1;
		end
    end
end

local function DrawVoteLogs()
	
	if string.len(voteVal[1]) < 1 or string.len(voteName[1]) < 1 or voteType == -1 then
		return;
	end
	
	if entities.GetLocalPlayer() == nil then
		voteResult = -1;
		voteType = -1;
		vIndex = 1;
		for i=1, #voteVal do
			voteVal[i] = "";
			voteName[i] = "";
		end
	end
	
	if not guiVoteRevealer:GetValue() then
		return;
	end
	
	local VotescreenCenterX, VotescreenCenterY = draw.GetScreenSize();
	VotescreenCenterY = VotescreenCenterY * 0.62;
	
	local voteFooterText = "";
	
	if voteType == 0 then
		voteFooterText = "Vote - Kick player: "..voteTarget;
	elseif voteType == 6 then
		voteFooterText = "Vote - Surrender";
	elseif voteType == 13 then
		voteFooterText = "Vote - Timeout";
	else
		voteFooterText = "Vote - Some shit :)";
	end
	
	draw.Color(255, 255, 255, 255);
	draw.TextShadow(35, VotescreenCenterY, voteFooterText);
	draw.FilledRect(35, VotescreenCenterY + 14, draw.GetTextSize(voteFooterText) + 35, VotescreenCenterY + 16);
	
	for i=1, #voteVal do
	
		if string.len(voteVal[i]) < 1 and string.len(voteName[i]) < 1 then
			break;
		end
		
		VotescreenCenterY = VotescreenCenterY + 25;
		draw.Color(255, 255, 255, 255);
		draw.TextShadow(35, VotescreenCenterY, "["..voteVal[i].."] "..voteName[i]);
		
		if voteVal[i] == "YES" then
			draw.Color(78, 217, 28, 255);
		elseif voteVal[i] == "NO" then
			draw.Color(217, 28, 28, 255);
		else
			draw.Color(191, 191, 191, 255);
		end
		
		draw.FilledRect(35, VotescreenCenterY + 14, draw.GetTextSize("["..voteVal[i].."] "..voteName[i]) + 35, VotescreenCenterY + 16);
	end 
	
	if voteResult == 1 or voteResult == 2 then
		if voteResult == 1 then
			draw.Color(78, 217, 28, 255);
			draw.TextShadow(35, VotescreenCenterY + 25, "Vote Result - Succesfull");
		elseif voteResult == 2 then
			draw.Color(217, 28, 28, 255);
			draw.TextShadow(35, VotescreenCenterY + 25, "Vote Result - Failed");
		end
		
		if math.floor(globals.RealTime()) > tTimer + 1.8 then
			voteResult = -1;
			voteType = -1;
			vIndex = 1;
			for i=1, #voteVal do
				voteVal[i] = "";
				voteName[i] = "";
			end
		end
	end
	
end

--

local function DrawWatermark()
	if not guiShowWatermark:GetValue() then
		return;
	end
	
	local localPlayer = entities.GetLocalPlayer();
	local playerResources = nil;
	local indexlocalPlayer = nil;
    local localName = 'localhost';	
	local localPing = '0';
	
	if(localPlayer ~= nil) then
		playerResources = entities.GetPlayerResources();
		indexlocalPlayer = client.GetLocalPlayerIndex()
		localName = client.GetPlayerNameByIndex(indexlocalPlayer);
	
		localPing = playerResources:GetPropInt("m_iPing", localPlayer:GetIndex());
	end
	
	local waterText = "plhook [beta] | "..localName.." | "..localPing.." ping";
	--
	local textWidth, textHeight = draw.GetTextSize(waterText);
	local screenX, screenY = draw.GetScreenSize();
	screenY = screenY * 0.0110;
	local startX = screenX - textWidth - 35;
	local endX = screenX - 35;
	
	local r, g, b, a = gui.GetValue("theme.ui.bg1");	
	draw.Color(r, g, b, a);
	draw.FilledRect(startX, screenY, endX, screenY + 25);
	draw.Triangle(startX - 20, screenY + 25, startX, screenY, startX, screenY + 25);
	draw.Triangle(endX, screenY, endX + 20, screenY, endX, screenY + 25);
	
	r, g, b, a = gui.GetValue("theme.nav.text");
	draw.Color(r, g, b, a);
	draw.Text(startX, screenY + 6, waterText);
	
	r, g, b, a = gui.GetValue("theme.header.line");
	draw.Color(r, g, b, a);
	draw.Line(startX - 20, screenY + 25, startX, screenY);
	draw.Line(startX - 20, screenY + 25, startX, screenY + 25);
	--
	draw.Line(endX, screenY, endX + 20, screenY);
	draw.Line(endX, screenY + 24, endX + 20, screenY);
end

local function DrawKeybinds()
	local YAdd = 50;
	local screenCenterX, screenCenterY = draw.GetScreenSize();
	screenCenterX = screenCenterX * 0.5;
	screenCenterY = screenCenterY * 0.5;
	
	if guiShowArrows:GetValue() then
		local r, g, b, a = gui.GetValue("theme.ui.bg1");
		draw.Color(46, 46, 46, 200);
		draw.Triangle(screenCenterX + 50, screenCenterY - 7, screenCenterX + 65, screenCenterY - 7 + 8, screenCenterX + 50, screenCenterY - 7 + 15);
		draw.Triangle(screenCenterX - 50, screenCenterY - 7, screenCenterX - 65, screenCenterY - 7 + 8, screenCenterX - 50, screenCenterY - 7 + 15);
	
		r, g, b, a = guiArrowsColor:GetValue();
		draw.Color(r, g, b, a);	
	
		if aaInverted == 1 then
			draw.Line(screenCenterX + 50, screenCenterY - 7, screenCenterX + 65, screenCenterY - 7 + 8);
			draw.Line(screenCenterX + 50, screenCenterY - 7 + 15, screenCenterX + 65, screenCenterY - 7 + 8);
		else
			draw.Line(screenCenterX - 50, screenCenterY - 7, screenCenterX - 65, screenCenterY - 7 + 8);
			draw.Line(screenCenterX - 50, screenCenterY - 7 + 15, screenCenterX - 65, screenCenterY - 7 + 8);
		end	
	end
	
	if not guiShowKeyBinds:GetValue() then
		return;
	end
	
	draw.Color(255, 0, 0, 255);
	
	if guiNearestKey:GetValue() then
		local sInfo = "Nearest hitbox active!";
		draw.TextShadow(screenCenterX - draw.GetTextSize(sInfo) / 2, screenCenterY + YAdd, sInfo);
		YAdd = YAdd + 15;
	end
	
	if guiAntiaimMode:GetValue() then
		local sInfo = "Rage desync active!";
		draw.TextShadow(screenCenterX - draw.GetTextSize(sInfo) / 2, screenCenterY + YAdd, sInfo);
		YAdd = YAdd + 15;
	end
		
	draw.Color(68, 255, 0, 255);
	
	if guiMindmgKey:GetValue() then
		local sInfo = "Min Damage: "..guiMinDmgSlider:GetValue();
		
		if guiAdaptivedmgKey:GetValue() then
			sInfo = "Adaptive Damage";
		end
		
		draw.TextShadow(screenCenterX - draw.GetTextSize(sInfo) / 2, screenCenterY + YAdd, sInfo);
		YAdd = YAdd + 15;
	end
	
	if guiBaimKey:GetValue() and not guiNearestKey:GetValue() then
		local sInfo = "Force Baim";
		draw.TextShadow(screenCenterX - draw.GetTextSize(sInfo) / 2, screenCenterY + YAdd, sInfo);
		YAdd = YAdd + 15;
	end
	
	if gui.GetValue("rbot.antiaim.condition.shiftonshot") then
		local sInfo = "Hide Shots";
		draw.TextShadow(screenCenterX - draw.GetTextSize(sInfo) / 2, screenCenterY + YAdd, sInfo);
		YAdd = YAdd + 15;
	end	
	
	if guiAwallKey:GetValue() then
		local sInfo = "Auto Wall";
		draw.TextShadow(screenCenterX - draw.GetTextSize(sInfo) / 2, screenCenterY + YAdd, sInfo);
		YAdd = YAdd + 15;
	end
end

--Anti Aims

local function StaticSync(bSide)
	if bSide == 1 then
		gui.SetValue("rbot.antiaim.base.rotation", 58);
		gui.SetValue("rbot.antiaim.base.lby", guiAntiaimDeltaSlider:GetValue() * -1);
	else
		gui.SetValue("rbot.antiaim.base.rotation", -58);
		gui.SetValue("rbot.antiaim.base.lby", guiAntiaimDeltaSlider:GetValue());
	end
end

local function JitterSync(bSide)
	if bSide == 1 then
		gui.SetValue("rbot.antiaim.base.rotation", math.random(guiAntiaimRealMinDeltaJitter:GetValue(), guiAntiaimRealMaxDeltaJitter:GetValue()));
		gui.SetValue("rbot.antiaim.base.lby", math.random(guiAntiaimDeltaSlider:GetValue() * -1));
	else
		gui.SetValue("rbot.antiaim.base.rotation", math.random(guiAntiaimRealMinDeltaJitter:GetValue() * -1, guiAntiaimRealMaxDeltaJitter:GetValue() * -1));
		gui.SetValue("rbot.antiaim.base.lby", math.random(guiAntiaimDeltaSlider:GetValue()));
	end
end

local iSwayIndex = 18;
local function SwaySync(bSide)
	if bSide == 1 then
		gui.SetValue("rbot.antiaim.base.rotation", 58);
		gui.SetValue("rbot.antiaim.base.lby", iSwayIndex * -1);
	else
		gui.SetValue("rbot.antiaim.base.rotation", -58);
		gui.SetValue("rbot.antiaim.base.lby", iSwayIndex);
	end
	
	if iSwayIndex + 5 > guiAntiaimDeltaSlider:GetValue() + 1 then
	   iSwayIndex = 0;
	end
	
	iSwayIndex = iSwayIndex + 5;	
end

local function CustomDesync()
	local aaRMode = 0;
	local aaSide = 0;
	
	gui.SetValue("rbot.antiaim.left", 0);
    gui.SetValue("rbot.antiaim.right", 0);
	gui.SetValue("rbot.antiaim.advanced.autodir.targets", 0);
	gui.SetValue("rbot.antiaim.advanced.autodir.edges", 0);
	
	if guiAntiaimMode:GetValue() then
		gui.SetValue("rbot.antiaim.base", "180.0 Desync");
		gui.SetValue("rbot.antiaim.advanced.pitch", 1);
		aaRMode = 1;
	else
		gui.SetValue("rbot.antiaim.base", "0.0 Desync");
		gui.SetValue("rbot.antiaim.advanced.pitch", 0);
	end
	
	if guiAntiaimAntialignFlicking:GetValue() == true then
		if math.random(34) == 1 then
			gui.SetValue("rbot.antiaim.advanced.antialign", 1);
		else
			gui.SetValue("rbot.antiaim.advanced.antialign", 0);
		end
	end
	
	if guiAntiaimDesyncTypeFlicking:GetValue() == true then
		if math.random(5) == 1 then
			guiAntiaimType:SetValue(2);
		else
			guiAntiaimType:SetValue(1);
		end
	end
	
	if guiAntiaimSwitchKey:GetValue() then
		if input.IsButtonPressed(guiAntiaimSwitchKey:GetValue()) then
			if aaInverted == 1 then
				aaInverted = 0;
			else
				aaInverted = 1;
			end
		end
	end
	
	if aaRMode == 1 then
		aaSide = 1 - aaInverted;
	else
		aaSide = aaInverted;
	end
	
	if guiAntiaimType:GetValue() == 0 then
		StaticSync(aaSide);
	elseif guiAntiaimType:GetValue() == 1 then
		JitterSync(aaSide);
	else
		SwaySync(aaSide);
	end
end

--Aimbot Logic 

local function RestoreDamage()
	for i=1, #wTypes do
		gui.SetValue("rbot.accuracy.weapon."..wTypes[i]..".mindmg", aMinDmg[i]);
	end
end

local function SetDamage(iMinDmg)
	for i=1, #wTypes do
		gui.SetValue("rbot.accuracy.weapon."..wTypes[i]..".mindmg", iMinDmg);
	end
end

local function SetBaim()
	for i=1, #wTypes do
		gui.SetValue("rbot.hitscan.points."..wTypes[i]..".scale", "0 3 0 2 3 0 0 0");
	end
end

local function SetHitbox(sHitbox)
	for i=1, #wTypes do
		gui.SetValue("rbot.hitscan.points."..wTypes[i]..".scale", sHitbox);
	end
end

local function RestoreBaim()
	for i=1, #wTypes do
		gui.SetValue("rbot.hitscan.points."..wTypes[i]..".scale", aBAim[i]);
	end
end

local function SetAwall(iToggle)
	for i=1, #wTypes do
		gui.SetValue("rbot.hitscan.mode."..wTypes[i]..".autowall", iToggle);
	end
end

local function CleanBConditions()
	for i=1, #wTypes do
		gui.SetValue("rbot.hitscan.mode."..wTypes[i]..".bodyaim.force", 0);
		gui.SetValue("rbot.hitscan.mode."..wTypes[i]..".bodyaim.lethal", 0);
		gui.SetValue("rbot.hitscan.mode."..wTypes[i]..".bodyaim.onshot", 0);
		gui.SetValue("rbot.hitscan.mode."..wTypes[i]..".bodyaim.safepoint", 0);
	end
end

local function RestoreBConditions()
	for i=1, #wTypes do
		gui.SetValue("rbot.hitscan.mode."..wTypes[i]..".bodyaim.force", aBForce[i]);
		gui.SetValue("rbot.hitscan.mode."..wTypes[i]..".bodyaim.lethal", aBLethal[i]);
		gui.SetValue("rbot.hitscan.mode."..wTypes[i]..".bodyaim.onshot", aBShot[i]);
		gui.SetValue("rbot.hitscan.mode."..wTypes[i]..".bodyaim.safepoint", aBSafe[i]);
	end
end

local function pythag(x1, y1, x2, y2)
	return math.sqrt(math.pow(x2 - x1, 2) + math.pow(y2 - y1, 2));
end

local function GetClosestEnemy()
	local screenCenterX, screenCenterY = draw.GetScreenSize();
	screenCenterX = screenCenterX * 0.5;
	screenCenterY = screenCenterY * 0.5;
	
	local players = entities.FindByClass( "CCSPlayer" );
	local localPlayer = entities.GetLocalPlayer();
	local sEnemy = nil;
	
	local lX, lY = 0, 0;
	
    for i = 1, #players do
        local player = players[i];

        if player:IsAlive() and localPlayer:GetTeamNumber() ~= player:GetTeamNumber() then
            local x, y = client.WorldToScreen( player:GetAbsOrigin() );

            if x ~= nil and y ~= nil then
				if pythag(lX, lY, screenCenterX, screenCenterY) > pythag(x, y, screenCenterX, screenCenterY) then
					lX = x;
					lY = y;
					sEnemy = player;
				end
            end
        end
    end
	
	return sEnemy;
end

local function GetAdaptiveDamage()
	return GetClosestEnemy():GetHealth() + 1;
end

local function GetClosestHitbox()
	local screenCenterX, screenCenterY = draw.GetScreenSize();
	screenCenterX = screenCenterX * 0.5;
	screenCenterY = screenCenterY * 0.5;
	
	local sEnemy = GetClosestEnemy();
	local sHitbox = "3 0 0 0 0 0 0 0";
	
	local selectedX, selectedY = client.WorldToScreen(sEnemy:GetBonePosition(8));
	local breastX, breastY = client.WorldToScreen(sEnemy:GetBonePosition(6));
	local stomachX, stomachY = client.WorldToScreen(sEnemy:GetBonePosition(5));
	local pelvisX, pelvisY = client.WorldToScreen(sEnemy:GetBonePosition(3));
	local leg1X, leg1Y = client.WorldToScreen(sEnemy:GetBonePosition(72));
	local leg2X, leg2Y = client.WorldToScreen(sEnemy:GetBonePosition(1));
	
	if pythag(selectedX, selectedY, screenCenterX, screenCenterY) > pythag(breastX, breastY, screenCenterX, screenCenterY) then
		sHitbox = "0 3 0 0 0 0 0 0";
		selectedX = breastX;
		selectedY = breastY;
	end
	
	if pythag(selectedX, selectedY, screenCenterX, screenCenterY) > pythag(stomachX, stomachY, screenCenterX, screenCenterY) then
		sHitbox = "0 0 0 3 0 0 0 0";
		selectedX = stomachX;
		selectedY = stomachY;
	end
	
	if pythag(selectedX, selectedY, screenCenterX, screenCenterY) > pythag(pelvisX, pelvisY, screenCenterX, screenCenterY) then
		sHitbox = "0 0 0 0 3 0 0 0";
		selectedX = pelvisX;
		selectedY = pelvisY;
	end
	
	if pythag(selectedX, selectedY, screenCenterX, screenCenterY) > pythag(leg1X, leg1Y, screenCenterX, screenCenterY) then
		sHitbox = "0 0 0 0 0 3 0 0";
		selectedX = leg1X;
		selectedY = leg1Y;
	end
	
	if pythag(selectedX, selectedY, screenCenterX, screenCenterY) > pythag(leg2X, leg2Y, screenCenterX, screenCenterY) then
		sHitbox = "0 0 0 0 0 0 3 3";
		selectedX = leg2X;
		selectedY = leg2Y;
	end
	
	return sHitbox;
end

local function AimbotLogic()

	if guiMindmgKey:GetValue() then
		local minDamage = guiMinDmgSlider:GetValue();
			
		if guiAdaptivedmgKey:GetValue() then
			minDamage = GetAdaptiveDamage();
		end
			
		SetDamage(minDamage);
	else
		RestoreDamage();
	end
	
	if guiNearestKey:GetValue() then
		SetHitbox(GetClosestHitbox());
		CleanBConditions();
	else
		RestoreBConditions();
		if guiBaimKey:GetValue() then
			SetBaim();
		else
			RestoreBaim();
		end
	end
	
	if guiAwallKey:GetValue() then
		SetAwall(1);
	else
		SetAwall(0);
	end
end

--

local function BackupCfg()
	for i=1, #wTypes do
		aMinDmg[i] = gui.GetValue("rbot.accuracy.weapon."..wTypes[i]..".mindmg");
		aBAim[i] = gui.GetValue("rbot.hitscan.points."..wTypes[i]..".scale");
		aBForce[i] = gui.GetValue("rbot.hitscan.mode."..wTypes[i]..".bodyaim.force");
		aBLethal[i] = gui.GetValue("rbot.hitscan.mode."..wTypes[i]..".bodyaim.lethal");
		aBShot[i] = gui.GetValue("rbot.hitscan.mode."..wTypes[i]..".bodyaim.onshot");
		aBSafe[i] = gui.GetValue("rbot.hitscan.mode."..wTypes[i]..".bodyaim.safepoint");
	end
end

BackupCfg();
--
client.AllowListener("vote_cast");
callbacks.Register('FireGameEvent', VoteStart);
callbacks.Register("DispatchUserMessage", VoteEnd);
callbacks.Register("Draw", DrawVoteLogs);
--
callbacks.Register("Draw", CustomDesync);
callbacks.Register("Draw", AimbotLogic);
callbacks.Register("Draw", DrawWatermark); --Draw watermark
callbacks.Register("Draw", DrawKeybinds); --Draw keybinds