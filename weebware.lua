--Settings - 0 to turn the option off and 1 to turn it on
--randomize background--
local bgrandom = 0;
--randomize on menu--
local omrandom = 0;

--changing stuff after this line might break stuff--
--on menu--
--Asuka--
local ompngData1 = http.Get("https://i.ibb.co/VM0Gj36/IMGBIN-asuka-langley-soryu-kaworu-nagisa-evangelion-chronicle-rebuild-of-evangelion-png-v-BD0m-Bb5.png");
local omimgRGBA1, omimgWidth1, omimgHeight1 = common.DecodePNG(ompngData1);
local omtexture1 = draw.CreateTexture(omimgRGBA1, omimgWidth1, omimgHeight1);

--girl1--
local ompngData2 = http.Get("https://i.ibb.co/Q8Nk4xm/5e81cd15b4c94.png");
local omimgRGBA2, omimgWidth2, omimgHeight2 = common.DecodePNG(ompngData2);
local omtexture2 = draw.CreateTexture(omimgRGBA2, omimgWidth2, omimgHeight2);

--background--
--catgirl1--
local bgpngData1 = http.Get("https://i.ibb.co/K6nyrp8/pngguru-com-1.png");
local bgimgRGBA1, bgimgWidth1, bgimgHeight1 = common.DecodePNG(bgpngData1);
local bgtexture1 = draw.CreateTexture(bgimgRGBA1, bgimgWidth1, bgimgHeight1);
--catgirl2--
local bgpngData2 = http.Get("https://i.ibb.co/wWXDk0d/pngguru-com-2.png");
local bgimgRGBA2, bgimgWidth2, bgimgHeight2 = common.DecodePNG(bgpngData2);
local bgtexture2 = draw.CreateTexture(bgimgRGBA2, bgimgWidth2, bgimgHeight2);
--Asuka&Rei--
local bgpngData3 = http.Get("https://i.ibb.co/CvYZZkF/evaimg1.png");
local bgimgRGBA3, bgimgWidth3, bgimgHeight3 = common.DecodePNG(bgpngData3);
local bgtexture3 = draw.CreateTexture(bgimgRGBA3, bgimgWidth3, bgimgHeight3);
--Utako Kasumi--
local bgpngData4 = http.Get("https://i.ibb.co/W5FPqqM/hiclipart-com-1.png");
local bgimgRGBA4, bgimgWidth4, bgimgHeight4 = common.DecodePNG(bgpngData4);
local bgtexture4 = draw.CreateTexture(bgimgRGBA4, bgimgWidth4, bgimgHeight4);
--Mirai Kuriyama--
local bgpngData5 = http.Get("https://i.ibb.co/HgY2mw0/Mirai-Kuriyama.png");
local bgimgRGBA5, bgimgWidth5, bgimgHeight5 = common.DecodePNG(bgpngData5);
local bgtexture5 = draw.CreateTexture(bgimgRGBA5, bgimgWidth5, bgimgHeight5);
--Gun Girl--
local bgpngData6 = http.Get("https://i.ibb.co/zG1sFk9/5e81c653042d7.png");
local bgimgRGBA6, bgimgWidth6, bgimgHeight6 = common.DecodePNG(bgpngData6);
local bgtexture6 = draw.CreateTexture(bgimgRGBA6, bgimgWidth6, bgimgHeight6);
--Asuna--
local bgpngData7 = http.Get("https://i.ibb.co/1TX80n0/5e81d78ee27f4.png");
local bgimgRGBA7, bgimgWidth7, bgimgHeight7 = common.DecodePNG(bgpngData7);
local bgtexture7 = draw.CreateTexture(bgimgRGBA7, bgimgWidth7, bgimgHeight7);
--Nami--
local bgpngData8 = http.Get("https://i.ibb.co/KrSg1Yq/5e8389815d2b9.png");
local bgimgRGBA8, bgimgWidth8, bgimgHeight8 = common.DecodePNG(bgpngData8);
local bgtexture8 = draw.CreateTexture(bgimgRGBA8, bgimgWidth8, bgimgHeight8);
--Rias--
local bgpngData9 = http.Get("https://i.ibb.co/bggnMQG/5e8391005246e.png");
local bgimgRGBA9, bgimgWidth9, bgimgHeight9 = common.DecodePNG(bgpngData9);
local bgtexture9 = draw.CreateTexture(bgimgRGBA9, bgimgWidth9, bgimgHeight9);
--Koneko--
local bgpngData10 = http.Get("https://i.ibb.co/2cVr8wB/5e8391dddd943.png");
local bgimgRGBA10, bgimgWidth10, bgimgHeight10 = common.DecodePNG(bgpngData10);
local bgtexture10 = draw.CreateTexture(bgimgRGBA10, bgimgWidth10, bgimgHeight10);

local w, h = draw.GetScreenSize()

local menuref = gui.Reference("MENU")
local weebmenu = gui.Tab(gui.Reference("Settings"), "WeebWare Settings", "WeebWare Settings")
local menubox = gui.Groupbox(weebmenu, "WeebWare by atk3001", 16, 16, 608, 500)
local OMIMAGE = gui.Combobox(menubox, "OMIMAGE.SET", "Select the on menu image", "OFF", "Asuka", "Rem")
local BGIMAGE = gui.Combobox(menubox, "BGIMAGE.SET", "Select the background image", "OFF", "Neko1", "Neko2", "Asuka&Rei", "Utako Kasumi", "Mirai Kuriyama", "Gun Girl", "Asuna", "Nami", "Rias", "Koneko")
local SLIDERPOS = gui.Slider(menubox, "BGIMAGE.POSITION.SET", "Background image position", w, 0, w + 200 )
local SLIDERSIZE = gui.Slider(menubox, "BGIMAGE.POSITION.SET", "Background image size", 100, 1 , 300)
local BGALWAYSSHOW = gui.Checkbox(menubox,"BGIMAGE.SHOW.ALWAYS", "Always show the background image", false );


if omrandom == 1 then
	local OMran = math.random(1,2);
	OMIMAGE:SetValue(OMran)
end

if bgrandom == 1 then
	local BGran = math.random(1,10);
	BGIMAGE:SetValue(BGran)
end

callbacks.Register("Draw", function()
	if menuref:IsActive() or BGALWAYSSHOW:GetValue() then
	menux,menuy = menuref:GetValue()
	sw = SLIDERPOS:GetValue()
	size = SLIDERSIZE:GetValue() / 100
		--background stuff--
		if BGIMAGE:GetValue() == 1 then
			local bgimgWidths1 = bgimgWidth1 / 2 * size
			local bgimgHeights1 = bgimgHeight1 / 2 * size
			local x = sw - bgimgWidths1
			local y = h - bgimgHeights1
			
			draw.Color(255, 255, 255, 255)
			draw.SetTexture(bgtexture1)
			draw.FilledRect(x, y, x+bgimgWidths1, y+bgimgHeights1)
			
		elseif BGIMAGE:GetValue() == 2 then
			local bgimgWidths2 = bgimgWidth2 / 2 * size
			local bgimgHeights2 = bgimgHeight2 / 2 * size
			local x = sw - bgimgWidths2
			local y = h - bgimgHeights2
		
			draw.Color(255, 255, 255, 255)
			draw.SetTexture(bgtexture2)
			draw.FilledRect(x, y, x+bgimgWidths2, y+bgimgHeights2)
			
		elseif BGIMAGE:GetValue() == 3 then
			local bgimgWidths3 = bgimgWidth3 / 1.5 * size
			local bgimgHeights3 = bgimgHeight3 / 1.5 * size
			local x = sw - bgimgWidths3
			local y = h - bgimgHeights3
		
			draw.Color(255, 255, 255, 255)
			draw.SetTexture(bgtexture3)
			draw.FilledRect(x, y, x+bgimgWidths3, y+bgimgHeights3)
		elseif BGIMAGE:GetValue() == 4 then
			local bgimgWidths4 = bgimgWidth4 * size
			local bgimgHeights4 = bgimgHeight4 * size
			local x = sw - bgimgWidths4
			local y = h - bgimgHeights4
		
			draw.Color(255, 255, 255, 255)
			draw.SetTexture(bgtexture4)
			draw.FilledRect(x, y, x+bgimgWidths4, y+bgimgHeights4)
		elseif BGIMAGE:GetValue() == 5 then
			local bgimgWidths5 = bgimgWidth5 * size
			local bgimgHeights5 = bgimgHeight5 * size
			local x = sw - bgimgWidths5
			local y = h - bgimgHeights5
		
			draw.Color(255, 255, 255, 255)
			draw.SetTexture(bgtexture5)
			draw.FilledRect(x, y, x+bgimgWidths5, y+bgimgHeights5)
		elseif BGIMAGE:GetValue() == 6 then
			local bgimgWidths6 = bgimgWidth6 / 2 * size
			local bgimgHeights6 = bgimgHeight6 / 2 * size
			local x = sw - bgimgWidths6
			local y = h - bgimgHeights6
		
			draw.Color(255, 255, 255, 255)
			draw.SetTexture(bgtexture6)
			draw.FilledRect(x, y, x+bgimgWidths6, y+bgimgHeights6)
		elseif BGIMAGE:GetValue() == 7 then
			local bgimgWidths7 = bgimgWidth7 / 2 * size
			local bgimgHeights7 = bgimgHeight7 / 2 * size
			local x = sw - bgimgWidths7
			local y = h - bgimgHeights7
		
			draw.Color(255, 255, 255, 255)
			draw.SetTexture(bgtexture7)
			draw.FilledRect(x, y, x+bgimgWidths7, y+bgimgHeights7)
		elseif BGIMAGE:GetValue() == 8 then
			local bgimgWidths8 = bgimgWidth8 / 1.5 * size
			local bgimgHeights8 = bgimgHeight8 / 1.5 * size
			local x = sw - bgimgWidths8
			local y = h - bgimgHeights8
		
			draw.Color(255, 255, 255, 255)
			draw.SetTexture(bgtexture8)
			draw.FilledRect(x, y, x+bgimgWidths8, y+bgimgHeights8)
		elseif BGIMAGE:GetValue() == 9 then
			local bgimgWidths9 = bgimgWidth9 / 1.3 * size
			local bgimgHeights9 = bgimgHeight9 / 1.3 * size
			local x = sw - bgimgWidths9
			local y = h - bgimgHeights9
		
			draw.Color(255, 255, 255, 255)
			draw.SetTexture(bgtexture9)
			draw.FilledRect(x, y, x+bgimgWidths9, y+bgimgHeights9)
		elseif BGIMAGE:GetValue() == 10 then
			local bgimgWidths10 = bgimgWidth10 / 1.3 * size
			local bgimgHeights10 = bgimgHeight10 / 1.3 * size
			local x = sw - bgimgWidths10
			local y = h - bgimgHeights10
		
			draw.Color(255, 255, 255, 255)
			draw.SetTexture(bgtexture10)
			draw.FilledRect(x, y, x+bgimgWidths10, y+bgimgHeights10)
		end 
	end	
	
	if menuref:IsActive() then
		--on menu stuff--
		if OMIMAGE:GetValue() == 1 then
			local omimgWidths1 = omimgWidth1 / 2
			local omimgHeights1 = omimgHeight1 / 2
			local x = menux + 718
			local y = menuy - 270
	
			draw.Color(255, 255, 255, 255)
			draw.SetTexture(omtexture1)
			draw.FilledRect(x, y, x+omimgWidths1, y+omimgHeights1)
			
		elseif OMIMAGE:GetValue() == 2 then
			local omimgWidths2 = omimgWidth2 / 2.5
			local omimgHeights2 = omimgHeight2 / 2.5
			local x = menux - omimgWidths2 + 800
			local y = menuy - omimgHeights2
	
			draw.Color(255, 255, 255, 255)
			draw.SetTexture(omtexture2)
			draw.FilledRect(x, y, x+omimgWidths2, y+omimgHeights2)
		end
	end
end)