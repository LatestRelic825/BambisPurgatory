function onCreatePost()
    initLuaShader("dropShadow")

    setSpriteShader("boyfriend", "dropShadow")
    setShaderFloat('boyfriend', '_alpha', 0.5)
    setShaderFloat('boyfriend', '_disx', 15)
    setShaderFloat('boyfriend', '_disy', 5)
    setShaderBool('boyfriend', 'inner', true)
    setShaderBool('boyfriend', 'inverted', true)

    setSpriteShader("gf", "dropShadow")
    setShaderFloat('gf', '_alpha', 0.5)
    setShaderFloat('gf', '_disx', 20)
    setShaderFloat('gf', '_disy', 0)
    setShaderBool('gf', 'inner', true)
    setShaderBool('gf', 'inverted', true)
end