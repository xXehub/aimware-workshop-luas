local slidewalk = "misc.slidewalk"
local rotateb = "rbot.antiaim.base.rotation"
local rotatel = "rbot.antiaim.left.rotation"
local rotater = "rbot.antiaim.right.rotation"
local lbybase = "rbot.antiaim.base.lby"
local lbyleft = "rbot.antiaim.left.lby"
local lbyright = "rbot.antiaim.right.lby"
local static_legs = "rbot.antiaim.extra.staticlegs"
local ar = "rbot.antiaim.advanced.antiresolver"
local aat = "rbot.antiaim.advanced.antialign"
local shift = "rbot.antiaim.condition.shiftonshot"
local base = "rbot.antiaim.base"
local left = "rbot.antiaim.left"
local right = "rbot.antiaim.right"
local ade = "rbot.antiaim.advanced.autodir.edges"
local aaa = "rbot.antiaim.advanced.autodir.targets"
local fakelag = "misc.fakelag.factor"
local last = 0
local state = true

local loading = load or loadstring
loading("\102\117\110\99\116\105\111\110\32\68\114\97\119\40\41\10\32\32\32\32\108\111\99\97\108\32\119\44\32\104\32\61\32\100\114\97\119\46\71\101\116\84\101\120\116\83\105\122\101\40\34\69\97\103\108\101\89\97\119\34\41\59\10\32\32\32\32\108\111\99\97\108\32\119\101\105\103\104\116\95\112\97\100\100\105\110\103\44\32\104\101\105\103\104\116\80\97\100\100\105\110\103\32\61\32\45\49\48\44\32\49\53\59\10\32\32\32\32\108\111\99\97\108\32\119\97\116\101\114\109\97\114\107\95\119\105\100\116\104\32\61\32\119\101\105\103\104\116\95\112\97\100\100\105\110\103\32\43\32\119\59\10\32\32\32\32\108\111\99\97\108\32\115\116\97\114\116\95\120\44\32\115\116\97\114\116\95\121\32\61\32\100\114\97\119\46\71\101\116\83\99\114\101\101\110\83\105\122\101\40\41\59\10\32\32\32\32\115\116\97\114\116\95\120\44\32\115\116\97\114\116\95\121\32\61\32\115\116\97\114\116\95\120\32\45\32\119\97\116\101\114\109\97\114\107\95\119\105\100\116\104\32\45\32\50\48\44\32\115\116\97\114\116\95\121\32\42\32\48\46\48\50\50\53\59\10\9\100\114\97\119\46\67\111\108\111\114\40\48\44\32\48\44\32\48\44\32\49\48\48\41\59\10\32\32\32\32\100\114\97\119\46\70\105\108\108\101\100\82\101\99\116\40\115\116\97\114\116\95\120\45\50\53\44\32\115\116\97\114\116\95\121\44\32\115\116\97\114\116\95\120\32\43\32\119\97\116\101\114\109\97\114\107\95\119\105\100\116\104\32\44\32\115\116\97\114\116\95\121\32\43\32\104\32\43\32\104\101\105\103\104\116\80\97\100\100\105\110\103\41\59\10\32\32\32\32\100\114\97\119\46\67\111\108\111\114\40\50\53\53\44\50\53\53\44\50\53\53\44\50\53\53\41\59\10\32\32\32\32\100\114\97\119\46\84\101\120\116\40\115\116\97\114\116\95\120\32\43\32\119\101\105\103\104\116\95\112\97\100\100\105\110\103\32\47\32\50\45\49\50\44\32\115\116\97\114\116\95\121\32\43\32\104\101\105\103\104\116\80\97\100\100\105\110\103\32\47\32\50\32\43\32\49\44\32\34\69\97\103\108\101\89\97\119\34\41\10\9\100\114\97\119\46\67\111\108\111\114\40\50\48\48\44\32\52\48\44\32\52\48\44\32\50\53\53\41\59\10\9\100\114\97\119\46\70\105\108\108\101\100\82\101\99\116\40\115\116\97\114\116\95\120\45\50\53\44\32\115\116\97\114\116\95\121\44\32\115\116\97\114\116\95\120\32\43\32\119\97\116\101\114\109\97\114\107\95\119\105\100\116\104\32\44\32\115\116\97\114\116\95\121\32\43\50\41\59\10\101\110\100\10")()
-- watermark style from thekorol


function CreateMove(cmd)
    local hLocalPlayer = entities.GetLocalPlayer()
    local velocity = math.sqrt(hLocalPlayer:GetPropFloat( "localdata", "m_vecVelocity[0]" ) ^ 2 + hLocalPlayer:GetPropFloat( "localdata", "m_vecVelocity[1]" ) ^ 2)
    -- ^ thx stacky for velocity shit

    if eagleyaw:GetValue() == 1 then
        if globals.CurTime() > last then
            state = not state
            last = globals.CurTime() + 0.01
            gui.SetValue(slidewalk, state and true or false)
        end

        if velocity <= 3 and velocity < 69 then
            gui.SetValue(rotateb, 33)
            gui.SetValue(rotatel, -33)
            gui.SetValue(rotater, 33)
            gui.SetValue(lbybase, 0)
            gui.SetValue(lbyleft, 0)
            gui.SetValue(lbyright, 0)
            gui.SetValue(fakelag, 3)
        elseif velocity >= 70 and velocity < 129 then
            gui.SetValue(rotateb, 23)
            gui.SetValue(rotatel, -23)
            gui.SetValue(rotater, 23)
            gui.SetValue(lbybase, 0)
            gui.SetValue(lbyleft, 167)
            gui.SetValue(lbyright, -167)
            gui.SetValue(fakelag, 8)
        elseif velocity >= 130 then
            gui.SetValue(rotateb, 33)
            gui.SetValue(rotatel, -33)
            gui.SetValue(rotater, 33)
            gui.SetValue(lbybase, 0)
            gui.SetValue(lbyleft, 167)
            gui.SetValue(lbyright, -167)
            gui.SetValue(fakelag, 14)
        end

        gui.SetValue(static_legs, true)
        gui.SetValue(ar, false)
        gui.SetValue(aat, 1)
        gui.SetValue(shift, false)
        gui.SetValue(base, 180)
        gui.SetValue(left, 180)
        gui.SetValue(right, 180)
        gui.SetValue(ade, true)
        gui.SetValue(aaa, true)
    end

    if eagleyaw:GetValue() == 2 then
        if globals.CurTime() > last then
            state = not state
            last = globals.CurTime() + 0.01
            gui.SetValue(slidewalk, state and true or false)
        end

        if velocity <= 3 and velocity < 69 then
            gui.SetValue(rotateb, 33)
            gui.SetValue(rotatel, -33)
            gui.SetValue(rotater, 33)
            gui.SetValue(lbybase, 0)
            gui.SetValue(lbyleft, 0)
            gui.SetValue(lbyright, 0)
            gui.SetValue(fakelag, 3)
        elseif velocity >= 70 and velocity < 129 then
            gui.SetValue(rotateb, 23)
            gui.SetValue(rotatel, -23)
            gui.SetValue(rotater, 23)
            gui.SetValue(lbybase, 0)
            gui.SetValue(lbyleft, 167)
            gui.SetValue(lbyright, -167)
            gui.SetValue(fakelag, 8)
        elseif velocity >= 130 then
            gui.SetValue(rotateb, 33)
            gui.SetValue(rotatel, -33)
            gui.SetValue(rotater, 33)
            gui.SetValue(lbybase, 0)
            gui.SetValue(lbyleft, 167)
            gui.SetValue(lbyright, -167)
            gui.SetValue(fakelag, 14)
            end

        gui.SetValue(static_legs, true)
        gui.SetValue(ar, false)
        gui.SetValue(aat, 1)
        gui.SetValue(shift, false)
        gui.SetValue(base, state and -165 or 165)
        gui.SetValue(left, state and -165 or 165)
        gui.SetValue(right, state and -165 or 165)
        gui.SetValue(ade, false)
        gui.SetValue(aaa, true)
    end
end

function UI()
    eagleyaw = gui.Combobox(gui.Reference("Ragebot","Anti-Aim","Extra"),"eagleyaw","Eagle Yaw", "Off", "Static", "Jitter");
end
UI();

callbacks.Register( "CreateMove", "Eagleyaw", CreateMove );
callbacks.Register( "Draw", "Watermark", Draw ); --watermark VERY VERY poorly obfuscated on purpose

-- lua by https://aimware.net/forum/user/63613