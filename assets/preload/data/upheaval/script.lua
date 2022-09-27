function onCreate()
    -- background shit
    makeLuaSprite('stageback', 'stageback', -600, -300);
    setScrollFactor('stageback', 0.9, 0.9);
    
    makeLuaSprite('stagefront', 'stagefront', -650, 600);
    setScrollFactor('stagefront', 0.9, 0.9);
    scaleObject('stagefront', 1.1, 1.1);

    makeLuaSprite('stagecurtains', 'stagecurtains', -500, -300);
    setScrollFactor('stagecurtains', 1.3, 1.3);
    scaleObject('stagecurtains', 0.9, 0.9);

    addLuaSprite('stageback', false);
    addLuaSprite('stagefront', false);
    addLuaSprite('stagecurtains', false);

    setProperty('skipCountdown', true)
end

function onCreatePost()
    makeLuaSprite("cool", "", 10, 5)

    initLuaShader("static")
    makeLuaSprite("staticShader")
    makeGraphic("staticShader", screenWidth, screenHeight)
    setSpriteShader("staticShader", "static")

    initLuaShader("greyscale")
    makeLuaSprite("greyscaleShader")
    makeGraphic("greyscaleShader", screenWidth, screenHeight)
    setSpriteShader("greyscaleShader", "greyscale")
    
    addHaxeLibrary("ShaderFilter", "openfl.filters")

    makeLuaSprite("barLeft")
    makeGraphic("barLeft", screenWidth/2, screenHeight, '000000')
    setObjectCamera('barLeft', 'camother')
    addLuaSprite('barLeft', true)

    makeLuaSprite("barRight", '', screenWidth/2, 0)
    makeGraphic("barRight", screenWidth/2, screenHeight, '000000')
    setObjectCamera('barRight', 'camother')
    addLuaSprite('barRight', true)

    setProperty('camHUD.visible', false)
    setProperty('dad.x', -2000)
    setProperty('dad.visible', false)
    setProperty('gfSpeed', 2)
    setProperty('camGame.zoom', 1.25)
end

local ignoreFocus = true
local darkenChar = false
local offsetX, offsetY = -140, -175
function onStepHit()
    if curStep == 192 then
        doTweenX("barLeft.tw", "barLeft", getProperty('barLeft.x') - 480, 4, 'cubeout')
        doTweenX("barRight.tw", "barRight", getProperty('barRight.x') + 480, 4, 'cubeout')
        doTweenZoom("camTween", "camGame", 0.9, 10, 'cubeout')
    end
    if curStep == 448 then
        doTweenX("grayscaleTween", "cool", 5, 5.05, 'quadin')
        doTweenY("staticTween", "cool", 10, 5.05, 'quadin')
        doTweenX("barLeftTween", "barLeft", screenWidth/-2, 3.5, 'cubein')
        doTweenX("barRightTween", "barRight", screenWidth, 3.5, 'cubein')
        doTweenZoom("camTweenZm", "camGame", 1.5, 5.05, 'quadin')
        doTweenAngle("camTweenAn", "camGame", 7, 5.05, 'quadin')

        doTweenY("gfTweenY", "gf", getProperty('gf.y') - 400, 3.5, 'cubein')
        doTweenAngle("gfTweenAn", "gf", 10, 3.5, 'cubein')
        doTweenAlpha("gfTweenAlpha", "gf", 0, 3.5)
    end
    if curStep == 512 then
        darkenChar = true
        ignoreFocus = false
        cancelTween('camTweenZm')
        cancelTween('camTweenAn')

        setProperty('camGame.angle', 0)
        setProperty('camHUD.visible', true)
        setProperty('dad.x', defaultOpponentX)
        setProperty('dad.visible', true)

        cancelTween('grayscaleTween')
        cancelTween('staticTween')
        setProperty('cool.x', 0)
        setProperty('cool.y', 2)

        removeLuaSprite('stageback')
        removeLuaSprite('stagefront')
        removeLuaSprite('stagecurtains')
    end
end

function onUpdatePost(elapsed)
    if darkenChar == false then
        setProperty('boyfriend.color', getColorFromHex('ffffff'))
        setProperty('gf.color', getColorFromHex('ffffff'))
    end
    if ignoreFocus then
        setProperty('camFollow.x', getMidpointX('boyfriend') + offsetX)
        setProperty('camFollow.y', getMidpointY('boyfriend') + offsetY)
        triggerEvent('Camera Follow Pos', '', '')
    end
    --what the actual fuck bro
    runHaxeCode([[
        // trace(ShaderFilter);
        game.camGame.setFilters([new ShaderFilter(game.screenshader.shader), new ShaderFilter(game.getLuaObject("greyscaleShader").shader), new ShaderFilter(game.getLuaObject("staticShader").shader)]);
        game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("greyscaleShader").shader)]);
    ]])
    setShaderFloat("greyscaleShader", "iStrength", getProperty('cool.x')/10)
    setShaderFloat("staticShader", "strength", getProperty('cool.y')/20)
    setShaderFloat("staticShader", "iTime", os.clock())
end