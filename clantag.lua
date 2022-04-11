local silentname = 0
local origName = ""
local time = 0
local timedouble = globals.CurTime()
local rightname = 1
local clantagis = ""
local input = ""
local inputcc = ""
local lenght = 0
local n = 0
local step = 0

local function getOriginalName()

  origName = client.GetConVar("Name")

end
getOriginalName()

local function setName(name)
  client.SetConVar("name", name);
end

local boldletters = {


  
  "𝗮","𝗯","𝗰","𝗱","𝗲","𝗳","𝗴","𝗵","𝗶","𝗷","𝗸","𝗹","𝗺","𝗻","𝗼","𝗽","𝗾","𝗿","𝘀","𝘁","𝘂","𝘃","𝘄","𝘅","𝘆","𝘇",
  "𝗔","𝗕","𝗖","𝗗","𝗘","𝗙","𝗚","𝗛","𝗜","𝗝","𝗞","𝗟","𝗠","𝗡","𝗢","𝗣","𝗤","𝗥","𝗦","𝗧","𝗨","𝗩","𝗪","𝗫","𝗬","𝗭",
  "𝟬","𝟭","𝟮","𝟯","𝟰","𝟱","𝟲","𝟳","𝟴","𝟵","'"," "
}

local boldletters2 = {


  
  "ａ","ｂ","ｃ","ｄ","ｅ","ｆ","ｇ","ｈ","ｉ","ｊ","ｋ","ｌ","ｍ","ｎ","ｏ","ｐ","ｑ","ｒ","ｓ","ｔ","ｕ","ｖ","ｗ","ｘ","ｙ","ｚ",
  "Ａ","Ｂ","Ｃ","Ｄ","Ｅ","Ｆ","Ｇ","Ｈ","Ｉ","Ｊ","Ｋ","Ｌ","Ｍ","Ｎ","Ｏ","Ｐ","Ｑ","Ｒ","Ｓ","Ｔ","Ｕ","Ｖ","Ｗ","Ｘ","Ｙ","Ｚ",
  "０","１","２","３","４","５","６","７","８","９","'"," "
}

local boldletters3 = {


  
  "𝕒","𝕓","𝕔","𝕕","𝕖","𝕗","𝕘","𝕙","𝕚","𝕛","𝕜","𝕝","𝕞","𝕟","𝕠","𝕡","𝕢","𝕣","𝕤","𝕥","𝕦","𝕧","𝕨","𝕩","𝕪","𝕫",
  "𝔸","𝔹","ℂ","𝔻","𝔼","𝔽","𝔾","ℍ","𝕀","𝕁","𝕂","𝕃","𝕄","ℕ","𝕆","ℙ","ℚ","ℝ","𝕊","𝕋","𝕌","𝕍","𝕎","𝕏","𝕐","ℤ",
  "𝟘","𝟙","𝟚","𝟛","𝟜","𝟝","𝟞","𝟟","𝟠","𝟡","'"," "
}

local boldletters4 = {


  
  "🅰","🅱","🅲","🅳","🅴","🅵","🅶","🅷","🅸","🅹","🅺","🅻","🅼","🅽","🅾","🅿","🆀","🆁","🆂","🆃","🆄","🆅","🆆","🆇","🆈","🆉",
  "🅰","🅱","🅲","🅳","🅴","🅵","🅶","🅷","🅸","🅹","🅺","🅻","🅼","🅽","🅾","🅿","🆀","🆁","🆂","🆃","🆄","🆅","🆆","🆇","🆈","🆉",
  "⓿","❶","❷","❸","❹","❺","❻","❼","❽","❾","'"," "
}

local boldletters5 = {


  
  "𝖆","𝖇","𝖈","𝖉","𝖊","𝖋","𝖌","𝖍","𝖎","𝖏","𝖐","𝖑","𝖒","𝖓","𝖔","𝖕","𝖖","𝖗","𝖘","𝖙","𝖚","𝖛","𝖜","𝖝","𝖞","𝖟",
  "𝕬","𝕭","𝕮","𝕯","𝕰","𝕱","𝕲","𝕳","𝕴","𝕵","𝕶","𝕷","𝕸","𝕹","𝕺","𝕻","𝕼","𝕽","𝕾","𝕿","𝖀","𝖁","𝖂","𝖃","𝖄","𝖅",
  "0","1","2","3","4","5","6","7","8","9","'"," "
}


local ccmenu = gui.Tab(gui.Reference("Settings"), "Clantag Changer", "Clantag Changer")
local menubox = gui.Groupbox(ccmenu, "Fake animated clantag changer by atk3001", 16, 16, 608, 500)
local c =  gui.Editbox(menubox, "Clantag","")
local gap = gui.Checkbox(menubox,"lua_clantag_gap", "No Gap", false );
local mode = gui.Combobox( menubox, "lua_clantag_mode", "Choose Mode", "Static", "Left", "Right", "Length" )
local lettermode = gui.Combobox( menubox, "lua_clantag_lettermode", "Choose The Font", "𝗕𝗼𝗹𝗱", "Ａｅｓｔｈｅｔｉｃ １","𝔸𝕖𝕤𝕥𝕙𝕖𝕥𝕚𝕔 𝟚", "Emoji", "𝕱𝖗𝖆𝖐𝖙𝖚𝖗","No Font" )
local speed = gui.Slider(menubox, "lua_clantag_time", "Animation Speed", 10, 3, 100 )
local button = gui.Button(menubox, "Set Clantag", function()
  input = c:GetValue()
  n = string.len(input)
  if gap:GetValue() then
    print(1)
    inputcc = input .. input
    lenght = string.len(input) * 2
  else 
    print(2)
    inputcc = input .. " " .. input
    lenght = string.len(input) * 2 + 1
  end
  step = 0
  n1 = 1

  if gap:GetValue() then
    n2 = n
  else 
    n2 = n + 1
  end

  if gap:GetValue() then
    n3 = lenght - n + 1
  else 
    n3 = lenght - n
  end
  n4 = lenght

  n5 = 1
  n6 = n

end)
local animate = gui.Checkbox(menubox,"lua_clantag_stat", "Start Clantag", false );

local function convertname()
if lettermode:GetValue() ~= 5 then
  local letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789' "
  for i=1, #clantagis do
    local char = clantagis:sub(i,i)
    if char == "." then 
    output = output .. "."
    elseif char == "!" then
    output = output .. "!"
    elseif char == "?" then
    output = output .. "?"
    elseif char == "/" then
    output = output .. "/"
    elseif char == "\\" then
    output = output .. "\\"
    elseif char == "~" then
    output = output .. "卐"
    elseif char == "$" then
    output = output .. "$"
    elseif char == "&" then
    output = output .. "&"
    elseif char == "=" then
    output = output .. "="
    elseif char == "#" then
    output = output .. "#"
    elseif char == "-" then
    output = output .. "-"
    else
      if lettermode:GetValue() == 0 then
        output = output .. boldletters[letters:find(char)]
      elseif lettermode:GetValue() == 1 then
        output = output .. boldletters2[letters:find(char)]
      elseif lettermode:GetValue() == 2 then
        output = output .. boldletters3[letters:find(char)]
      elseif lettermode:GetValue() == 3 then
        output = output .. boldletters4[letters:find(char)]
      elseif lettermode:GetValue() == 4 then
        output = output .. boldletters5[letters:find(char)]
      end
    end
  end
else
output = clantagis
end
end

local function changename()
if animate:GetValue() and (entities.GetLocalPlayer() ~= nil and engine.GetServerIP() ~= nil and engine.GetMapName() ~= nil)then
  curutime = globals.CurTime()
  if curutime >= timedouble + (speed:GetValue() / 10) then
    timedouble = globals.CurTime()
    time = time + 1
    output = ""

    if mode:GetValue() == 0 then
      clantagis = input
      convertname()
      setName(output .. "  " .. origName)
    elseif mode:GetValue() == 1 then
        clantagis = string.sub(inputcc, n1, n2)

        convertname()

        setName(output .. " " .. origName)
        n1 = n1 + 1
        n2 = n2 + 1

        if n2 > lenght then
          n1 = 1
          if gap:GetValue() then
            n2 = n
          else 
            n2 = n + 1
          end
        end
    elseif mode:GetValue() == 2 then
        clantagis = string.sub(inputcc, n3, n4)

        convertname()

        setName(output .. " " .. origName)
        n3 = n3 - 1
        n4 = n4 - 1

        if n3 <= 0 then
          if gap:GetValue() then
            n3 = lenght - n + 1
          else 
            n3 = lenght - n
          end
          n4 = lenght
        end
    elseif mode:GetValue() == 3 then
      if step == 0 then
        clantagis = string.sub(input, 1, n6)
        convertname()
        setName(output .. " " .. origName)
        n6 = n6 - 1

        if n6 == 0 then
          step = 1
          n6 = 1
        end
      elseif step == 1 then
        setName(origName)
        step = 2
      elseif step == 2 then
        clantagis = string.sub(input, 1, n6)
        convertname()
        setName(output .. " " .. origName)

        n6 = n6 + 1

        if n6 == n then
          step = 0
          n6 = n
        end
      end

    end

  end
  rightname = 0
elseif rightname == 0 then
  setName(origName)
  rightname = 1
end
end

callbacks.Register("Draw", changename)

local function makenamesilent()
    local lp = entities.GetLocalPlayer()
    if silentname == 0 and lp ~= nil then
      setName("\n\xAD\xAD\xAD\xAD")
      curtime = globals.CurTime()
      silentname = 1
    end
    if silentname == 1 and globals.CurTime() >= curtime + 0.1 then
      setName(origName)
      silentname = 2
    end

    if lp == nil then
      silentname = 0
    end
end

callbacks.Register("Draw",makenamesilent)