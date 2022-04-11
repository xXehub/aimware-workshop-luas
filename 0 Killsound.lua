local miscRef = gui.Reference("MISC")
local soundTab = gui.Tab(miscRef,"misc.sound_tab","Sounds")
local soundGroup = gui.Groupbox(soundTab,"Sounds",5,5,625 / 2 - 2)
local PlayerFootstepsSlider = gui.Slider(soundGroup,"misc.sound.footsteps","Footsteps sound",100,0,100)
local GlobalFootstepsSlider = gui.Slider(soundGroup,"misc.sound.gfootsteps","Global footsteps sound",100,0,100)
local WeaponsSlider = gui.Slider(soundGroup,"misc.sound.weapons","Weapons sound",100,0,100)
local DialogSlider = gui.Slider(soundGroup,"misc.sound.dialog","Dialog sound",100,0,100)
local AmbientSlider = gui.Slider(soundGroup,"misc.sound.ambient","Ambient sound",100,0,100)

local soundGroup2 = gui.Groupbox(soundTab,"Other sounds",625 / 2 + 11,5,625 / 2 - 2)
local gVolumeSlider = gui.Slider(soundGroup2,"misc.sound.gVolume","Master volume",client.GetConVar("volume") * 100,0,100)
local mainMenuVolumeSlider = gui.Slider(soundGroup2,"misc.sound.main_menu","Main menu volume",client.GetConVar("snd_menumusic_volume") * 100,0,100)
local MVPVolumeSlider = gui.Slider(soundGroup2,"misc.sound.mvp","MVP volume",client.GetConVar("snd_mvp_volume") * 100,0,100)
local RoundEndVolumeSlider = gui.Slider(soundGroup2,"misc.sound.roundend","Round end volume",client.GetConVar("snd_roundend_volume") * 100,0,100)
local RoundStartVolumeSlider = gui.Slider(soundGroup2,"misc.sound.roundstart","Round start volume",client.GetConVar("snd_roundstart_volume") * 100,0,100)

local voiceGroup = gui.Groupbox(soundTab,"Voice chat",5,300,625 / 2 - 2)
local voiceChatEnable = gui.Checkbox(voiceGroup,"misc.voice.enable","Enable voice chat",true)
local voiceLoopbackEnable = gui.Checkbox(voiceGroup,"misc.voice.loopback","Voice Loopback",false)
local VoiceScaleSlider = gui.Slider(voiceGroup,"misc.voice.scale","Voice scale",client.GetConVar("voice_scale") * 100,0,100)

callbacks.Register("Draw",function()
    client.Command("snd_setmixer PlayerFootsteps vol " .. PlayerFootstepsSlider:GetValue() / 100, true)
    client.Command("snd_setmixer GlobalFootsteps vol " .. GlobalFootstepsSlider:GetValue() / 100, true)
    client.Command("snd_setmixer Weapons vol " .. WeaponsSlider:GetValue() / 100, true)
    client.Command("snd_setmixer Dialog vol " .. DialogSlider:GetValue() / 100, true)
    client.Command("snd_setmixer Ambient vol " .. AmbientSlider:GetValue() / 100, true)
    
    client.Command("volume " .. gVolumeSlider:GetValue() / 100, true)
    client.Command("snd_menumusic_volume " .. mainMenuVolumeSlider:GetValue() / 100, true)
    client.Command("snd_mvp_volume " .. MVPVolumeSlider:GetValue() / 100, true)
    client.Command("snd_roundend_volume " .. RoundEndVolumeSlider:GetValue() / 100, true)
    client.Command("snd_roundstart_volume " .. RoundStartVolumeSlider:GetValue() / 100, true)
    
    if(voiceChatEnable:GetValue() == true) then
        client.Command("voice_enable 1", true)
    else
        client.Command("voice_enable 0", true)
    end
    if(voiceLoopbackEnable:GetValue() == true) then
        client.Command("voice_loopback 1", true)
    else
        client.Command("voice_loopback 0", true)
    end
    client.Command("voice_scale " .. VoiceScaleSlider:GetValue() / 100, true)
end)