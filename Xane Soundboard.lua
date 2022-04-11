client.AllowListener('player_death')

local PseudoRandom = {
    Chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-={}|[]`~';

    GetRandomString = function(self, time, length)
        local RandomString = ''
        math.randomseed(time)

        local CharTable = {}
        for Char in self.Chars:gmatch"." do
            table.insert(CharTable, Char)
        end

        for i = 1, length do
            RandomString = RandomString .. CharTable[math.random(1, #CharTable)];
        end

        return RandomString
    end;
}

local Soundboard = {

    RunCommand = client.Command;
    GetConVar = client.GetConVar;
    SetConVar = client.SetConVar;
    GetRealTime = globals.RealTime;

    soundfiles = {
        [1] = {'D:\Jpg\CSGO\steamapps\common\Counter-Strike Global Offensive\csgo\sound\xanesoundboard/awbest.mp3', 2};
        [2] = {'D:\Jpg\CSGO\steamapps\common\Counter-Strike Global Offensive\csgo\sound\xanesoundboard/awbro.mp3', 1};
        [3] = {'D:\Jpg\CSGO\steamapps\common\Counter-Strike Global Offensive\csgo\sound\xanesoundboard/donkey.mp3', 2};
        [4] = {'D:\Jpg\CSGO\steamapps\common\Counter-Strike Global Offensive\csgo\sound\xanesoundboard/ezwinlol.mp3', 2};
        [5] = {'D:\Jpg\CSGO\steamapps\common\Counter-Strike Global Offensive\csgo\sound\xanesoundboard/monkey.mp3', 4};
        [6] = {'D:\Jpg\CSGO\steamapps\common\Counter-Strike Global Offensive\csgo\sound\xanesoundboard/nicehackbro.mp3', 1};
        [7] = {'D:\Jpg\CSGO\steamapps\common\Counter-Strike Global Offensive\csgo\sound\xanesoundboard/nicemissbro.mp3', 1};
        [8] = {'D:\Jpg\CSGO\steamapps\common\Counter-Strike Global Offensive\csgo\sound\xanesoundboard/shootingfake.mp3', 4};
        [9] = {'D:\Jpg\CSGO\steamapps\common\Counter-Strike Global Offensive\csgo\sound\xanesoundboard/whathappenedbro.mp3', 1};
        [10] = {'D:\Jpg\CSGO\steamapps\common\Counter-Strike Global Offensive\csgo\sound\xanesoundboard/whyyoudiebro.mp3', 1};
        [11] = {'D:\Jpg\CSGO\steamapps\common\Counter-Strike Global Offensive\csgo\sound\xanesoundboard/whyyoudiebro2x.mp3', 1};
        [12] = {'D:\Jpg\CSGO\steamapps\common\Counter-Strike Global Offensive\csgo\sound\xanesoundboard/youaremad.mp3', 1};
    };

    timers = {};
    shouldPlay = false;

    HandleTimers = function(self)

        if (self.shouldPlay) then
            self:PlaySound(self.soundfiles[math.random(1, 12)], true)
            self.shouldPlay = false
        end

        for k, v in pairs(self.timers) do
            if (v ~= nil) then
                if v() then
                    self.timers[k] = nil
                end
            end
        end
    end;

    AddTimer = function(self, time, callback)
        local time = self.GetRealTime() + time + 0.25;
        local GetTime = self.GetRealTime

        self.timers[PseudoRandom:GetRandomString(time, 16)] = function()
            if (time < GetTime()) then
                callback()
                return true;
            else
                return false;
            end
        end
    end;

    PlaySound = function(self, Soundfile, InVoiceChat)
    
        if (InVoiceChat and not (self.GetConVar('voice_loopback') == 1)) then
            self.SetConVar('voice_loopback', 1, true)
            self.SetConVar('voice_inputfromfile', 1, true)
            self.RunCommand('+voicerecord', true)
        end

        self.RunCommand('play ' .. Soundfile[1], true);

        self:AddTimer(Soundfile[2], function() 
            self.SetConVar('voice_loopback', 0, true)
            self.SetConVar('voice_inputfromfile', 0, true)
            self.RunCommand('-voicerecord', true)
        end)
    end;
}

callbacks.Register('Draw', function() 
    Soundboard:HandleTimers()
end)

callbacks.Register('FireGameEvent', function(Event)
    if (Event:GetName() == 'player_death') then
        local pLoacalIndex = client.GetLocalPlayerIndex()
        local AttackerIndex = client.GetPlayerIndexByUserID(Event:GetInt('attacker'))
        local VictimIndex = client.GetPlayerIndexByUserID(Event:GetInt('userid'))
        
        if (pLoacalIndex == AttackerIndex and pLoacalIndex ~= VictimIndex) then
            Soundboard.shouldPlay = true
        end
    end
end)

local Button = gui.Button(gui.Reference('Misc', 'General', 'Extra'), 'Play Random Xane Sound', function() Soundboard:PlaySound(Soundboard.soundfiles[math.random(1, 12)], true) end)
Button:SetWidth(248+16)