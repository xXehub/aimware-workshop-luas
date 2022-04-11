
local realTime = globals.CurTime()
local i = 0
local oldName = client.GetConVar("name")
go = false

local ref = gui.Reference("Misc", "Enhancement", "Appearance")
local slider = gui.Slider(ref, "slider", "Interval", 0.1, 0, 1, 0.1)
local first = gui.Editbox(ref, "1_spam", "First spam")
local second = gui.Editbox(ref, "2_spam", "Second spam")
local third = gui.Editbox(ref, "3_spam", "Third spam")
local fourth = gui.Editbox(ref, "4_spam", "Fourth spam")
local btn = gui.Button(ref, "Apply", function()
    go = true
end)

first:SetValue("♕ＳＨ３ＨＵＢ♕")
second:SetValue("♕ＳＨ３ＨＵＢ♕")
third:SetValue("♕ＳＨ３ＨＵＢ♕")
fourth:SetValue("♕ＳＨ３ＨＵＢ♕")

callbacks.Register("Draw", function()
    if go then
        if i < 4 then
            if globals.CurTime() - realTime >= slider:GetValue() then
                i = i + 1
                client.SetConVar("name", gui.GetValue("misc."..i.."_spam"), 1)
                realTime = globals.CurTime()
            end
        end
    end
end)
