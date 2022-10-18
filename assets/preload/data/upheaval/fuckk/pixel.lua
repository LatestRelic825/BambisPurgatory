local shadname = "pixel"

function onCreatePost()
        initLuaShader(shadname)
    
    makeLuaSprite("grapshad")
    makeGraphic("grapshad", screenWidth, screenHeight)
        setSpriteShader("grapshad", shadname)

        addHaxeLibrary("ShaderFilter", "openfl.filters")

        runHaxeCode([[
        trace(ShaderFilter);
      game.camGame.setFilters([new ShaderFilter(game.getLuaObject("grapshad").shader)]);
      game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("grapshad").shader)]);
    ]])
    
end
local vals = 0.10

function onUpdate(elapsed)
    setShaderFloat("grapshad", "Pixelly", vals);
end