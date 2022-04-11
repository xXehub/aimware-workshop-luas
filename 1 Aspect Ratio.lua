local a={}local b=gui.Reference("VISUALS","World")
local c=gui.Groupbox(b,"Aspect Ratio",327,288,297)

local d=gui.Checkbox(c,"aspect_ratio_check","Aspect Ratio Changer",false)local e=gui.Slider(c,"aspect_ratio_reference","Force Aspect Ratio",100,1,199)

local function f(g,h)while g~=0 do g,h=math.fmod(h,g),g end;return h end;local function i(j)local k,l=draw.GetScreenSize()

local m=k*j/l;if j==1 or not d:GetValue()then m=0 end;client.SetConVar("r_aspectratio",tonumber(m),true)end;local function n()

local k,l=draw.GetScreenSize()for o=1,200 do local p=o*0.01;p=2-p;local q=f(k*p,l)if k*p/q<100 or p==1 then a[o]=k*p/q..":"..l/q end end;

local r=e:GetValue()*0.01;r=2-r;i(r)end;callbacks.Register('Draw',"Aspect Ratio",n)
