--i said i wouldnt use lua but i forgot how to make this shit in haxe lmao
local angleshit = 2;
local anglevar = 2;
local anglefunny = true
function onUpdate()
    songPos = getSongPosition()
      local currentBeat = (songPos/1000)*(bpm/200)

    currentBeat = (songPos / 1000) * (bpm / 140)

        setProperty('camHUD.angle',0 - 5 * math.cos((currentBeat*0.25)*math.pi) )
        setProperty('camGame.angle',0 - 3 * math.cos((currentBeat*0.25)*math.pi) )
    end