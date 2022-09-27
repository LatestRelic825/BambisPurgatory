local winnin = false
local losin = false
local okin = false

function onCreate()
    makeAnimatedLuaSprite('indicator','chart_quant',0,0)
	addAnimationByPrefix('indicator','Silver','chart_quant0004',24,true)
	addLuaSprite('indicator',false)
	objectPlayAnimation('indicator','Silver',true)
	setScrollFactor('indicator',0,0)
    setObjectCamera('indicator','camHUD')
    scaleObject('indicator',1.25,1.25)
    setObjectOrder('indicator', getObjectOrder('bartop')+3)
    setProperty('indicator.angle', 180)
end

function onCreatePost()
    setProperty('healthBar.x', -220)
    setProperty('healthBar.y', 360)
end

function onUpdatePost()
    setProperty('healthBar.angle', 90)
    setProperty('iconP2.x', getProperty('healthBar.x') + 220)
    setProperty('iconP2.y', getProperty('healthBar.y') - 330)

    setProperty('iconP1.x', getProperty('healthBar.x') + 220)
    setProperty('iconP1.y', getProperty('healthBar.y') + 200)

    if okin == true then
        setProperty('indicator.x', getProperty('healthBar.x') + 315)
        setProperty('indicator.y',  getProperty('healthBar.y') - ((getProperty('healthBar.width') * (getProperty('healthBar.percent') / getProperty('healthBar.scale.y') - 0.005) * 0.01)) + 290)
    end

    if getProperty('healthBar.percent') >= 80 then
        if winnin == false then
            winnin = true
            okin = false
            doTweenX('indicatorWinTweenX','indicator', getProperty('iconP2.x') + 150,0.115,cubeInOut)
            doTweenY('indicatorWinTweenY','indicator', getProperty('iconP2.y') + 60,0.1,expoInOut)
        end
    else
        winnin = false
    end

    if losin == false and winnin == false then
        okin = true
    end

    if getProperty('healthBar.percent') <= 20 then
        if losin == false then
            losin = true
            okin = false
            doTweenX('indicatorLoseTweenX','indicator', getProperty('iconP1.x') + 150,0.115,cubeInOut)
            doTweenY('indicatorLoseTween','indicator', getProperty('iconP1.y') + 60,0.1,expoInOut)
        end
    else
        losin = false
    end
end