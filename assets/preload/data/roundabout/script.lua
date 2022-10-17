--my name is mr roundabout

function onCreate()
	makeLuaSprite("cool", "", 0, 0)

	initLuaShader("greyscale")
    makeLuaSprite("greyscaleShader")
    makeGraphic("greyscaleShader", screenWidth, screenHeight)
    setSpriteShader("greyscaleShader", "greyscale")

    setSpriteShader("bg", "greyscale")
    
    addHaxeLibrary("ShaderFilter", "openfl.filters")
end

function onCreatePost()
	setProperty('redGlow.color', getColorFromHex('000000'))
end

function onStepHit()
	if curStep == 2309 then
		setProperty('cool.x', 6)
		setProperty('redGlow.visible', true)
	end
end

function onUpdatePost(elapsed)
    --lol
    runHaxeCode([[
        // trace(ShaderFilter);
        game.camGame.setFilters([new ShaderFilter(game.screenshader.shader), new ShaderFilter(game.getLuaObject("greyscaleShader").shader)]);
    ]])
    setShaderFloat("greyscaleShader", "iStrength", getProperty('cool.x')/10)
    setShaderFloat("bg", "iStrength", getProperty('cool.x')/10)
end