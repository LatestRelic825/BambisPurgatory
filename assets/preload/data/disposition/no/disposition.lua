Chromacrap = 0;

function boundTo(value, min, max)
    return math.max(min, math.min(max, value))
end
function math.lerp(from,to,i)return from+(to-from)*i end

function setChrome(chromeOffset)
    setShaderFloat("temporaryShader", "rOffset", chromeOffset);
    setShaderFloat("temporaryShader", "gOffset", 0.0);
    setShaderFloat("temporaryShader", "bOffset", chromeOffset * -1);
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
    Chromacrap = Chromacrap + 0.015 -- edit this
end

function onCreatePost()
    initLuaShader("vcr")
    
    makeLuaSprite("temporaryShader")
    makeGraphic("temporaryShader", screenWidth, screenHeight)
    
    setSpriteShader("temporaryShader", "vcr")
    
    addHaxeLibrary("ShaderFilter", "openfl.filters")
    runHaxeCode([[
        trace(ShaderFilter);
        game.camGame.setFilters([new ShaderFilter(game.getLuaObject("temporaryShader").shader)]);
        game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("temporaryShader").shader)]);
    ]])
end

function onUpdate(elapsed)
    Chromacrap = math.lerp(Chromacrap, 0, boundTo(elapsed * 20, 0, 1))
    setChrome(Chromacrap)
end


--this part made by hydration

local s1 = 1
local s2 = 1
local s3 = 1
local s4 = 1
local flip1 = 1
local flip2 = 1
Disoriented = 0
HP = 0
function onCreate()
    setProperty('camGame.zoom',1.5)
    makeLuaSprite('offsettween','',0,0)
    setProperty('offsettween.alpha',0.2)
    setProperty('offsettween.x',900)
    makeLuaSprite('offsettween2','',0,0)
    makeLuaSprite('epicflash','',0,0)
    makeGraphic('epicflash',3000,3000,'FFFFFF')
    setObjectCamera('epicflash','other')
    addLuaSprite('epicflash',true)
    setProperty('epicflash.alpha', 0)
    strumx1 = 240
    strumx2 = 900
    strumy = 60
    mult = 1
    if downscroll then
        strumy = 550
        mult = -1
    end
    for i = 0,7 do
        makeLuaSprite('scalecontrol' .. i,'',0.7,0.7)
        setProperty('scalecontrol' .. i .. '.alpha',0)
        makeLuaSprite('notes' .. i,'',0,0)
        setProperty('notes' .. i .. '.y',-300)
    end
    makeLuaText('dbug', "curStep: 0", 800, 535, 20)
    setTextSize('dbug', 40)
    setTextColor('dbug', 'FFFFFF')
    setObjectCamera('dbug','other')
    addLuaText('dbug',true)
end
function onSongStart()
    songPos = getSongPosition()
    currentStep = (songPos/1000)*(230/15)
    if currentStep < 128 then
    setProperty('offsettween.y',-330)
    doTweenY('hinotes1','offsettween',0,crochet*0.004,'elasticOut')
        for i = 0,3 do
        setProperty('notes' .. i .. '.x',-660)
        end
        for i = 4,7 do
        setProperty('notes' .. i .. '.x',-330+(i-5.5)*50)
        doTweenX('hinotes2' .. i,'notes' .. i,-330,crochet*0.002,'expoInOut')
        setProperty('scalecontrol' .. i .. '.x',1)
        doTweenX('hiscale1' .. i,'scalecontrol' .. i,0.7,crochet*0.002,'backInOut')
        setProperty('scalecontrol' .. i .. '.y',1)
        doTweenY('hiscale2' .. i,'scalecontrol' .. i,0.7,crochet*0.002,'backInOut')
        end
    end
    if currentStep > 128 then
        for i = 0,7 do
        setProperty('notes' .. i .. '.y',0)
        end
        setProperty('offsettween.alpha',0.7)
    end
end
function onStepHit()
    floorStep = math.floor(currentStep)
    if floorStep == 128 then
        doTweenZoom('oooo1','camGame',0.7,crochet*0.016,'linear')
        setProperty('offsettween.y',-330)
        doTweenY('oooo2','offsettween',0,crochet*0.004,'sineInOut')
    end
    if floorStep == 240 then
        doTweenAlpha('oooo3','offsettween',0.7,crochet*0.002,'sineInOut')
    end
    if floorStep >= 128 and floorStep < 256 then
        setProperty('offsettween.x',40)
        setProperty('offsettween.angle',getProperty('offsettween.angle')+0.125)
        doTweenX('boioi','offsettween',20,stepCrochet*0.001,'sineOut')
        for i = 0,7 do
        setProperty('scalecontrol' .. i .. '.x',0.75)
        doTweenX('hiscale1' .. i,'scalecontrol' .. i,0.7,stepCrochet*0.0005,'linear')
        setProperty('scalecontrol' .. i .. '.y',0.75)
        doTweenY('hiscale2' .. i,'scalecontrol' .. i,0.7,stepCrochet*0.0005,'linear')
        end
    end
    if floorStep == 256 then
        setProperty('offsettween.angle',0)
    end
    if floorStep >= 256 and floorStep < 512 then
        if floorStep % 8 == 0 then
        doTweenX('brhu1','offsettween',110,stepCrochet*0.001,'linear')
        for i = 0,7 do
        setProperty('scalecontrol' .. i .. '.x',0.85)
        doTweenX('hiscale1' .. i,'scalecontrol' .. i,0.7,stepCrochet*0.002,'sineOut')
        setProperty('scalecontrol' .. i .. '.y',0.85)
        doTweenY('hiscale2' .. i,'scalecontrol' .. i,0.7,stepCrochet*0.002,'sineOut')
        end
        end
        if floorStep % 8 == 2 then
        doTweenX('brhu1','offsettween',0,crochet*0.001,'sineIn')
        end
        if floorStep % 8 == 4 then
            setProperty('offsettween.y',80)
            doTweenY('brhu2','offsettween',0,crochet*0.001,'sineOut')
            for i = 0,7 do
            setProperty('scalecontrol' .. i .. '.x',0.85)
            doTweenX('hiscale1' .. i,'scalecontrol' .. i,0.7,stepCrochet*0.002,'sineOut')
            setProperty('scalecontrol' .. i .. '.y',0.85)
            doTweenY('hiscale2' .. i,'scalecontrol' .. i,0.7,stepCrochet*0.002,'sineOut')
            end
        end
        if floorStep % 32 == 30 then
            flip1 = -flip1
            setProperty('offsettween.angle',90*flip1)
            doTweenAngle('brhu3','offsettween',0,crochet*0.004,'expoOut')
        end
    end
    if floorStep == 2304 then
        setProperty('offsettween.x',0)
        doTweenX('middlescroll1','offsettween',-330,crochet*0.001,'expoOut')
    end
    if floorStep >= 2560 and floorStep < 2816 then
        if floorStep % 64 < 16 and floorStep % 2 == 0 then
            setProperty('offsettween.x',getProperty('offsettween.x')+0.6)
            setProperty('offsettween.y',30)
            doTweenX('aaugh1','offsettween',getProperty('offsettween.x')+0.2,stepCrochet*0.002,'sineOut')
            doTweenY('aaugh2','offsettween',20,stepCrochet*0.002,'sineOut')
        end
        for i = 0,2 do
        if floorStep % 64 == 16+i*6 then
            setProperty('offsettween.y',70)
            doTweenY('aaugh','offsettween',0,crochet*0.001,'sineOut')
        end
        if floorStep % 64 == 32 then
            flip1 = -flip1
            setProperty('offsettween.y',0)
            doTweenY('aaugh','offsettween',100,stepCrochet*0.015,'sineIn')
        end
        if floorStep % 64 == 47 then
            doTweenY('aaugh','offsettween',0,stepCrochet*0.001,'linear')
        end
        end
        if floorStep % 64 == 48 then
            setProperty('offsettween.y',0)
            doTweenY('aaugh','offsettween',110,crochet*0.004,'expoIn')
        end
        for i = 0,3 do
            if floorStep % 64 > 48+i*4 then
                setProperty('camGame.zoom',0.8+i*0.1)
                setProperty('camGame.angle',0)
                doTweenZoom('spam4-' .. i,'camGame',0.85+i*0.1,crochet*0.001,'linear')
                doTweenAngle('spam5-' .. i,'camGame',(i%2-0.5)*10,crochet*0.001,'linear')
            end
        end
    end
    if floorStep == 2816 then
        doTweenAngle('byeee','offsettween',800,crochet*0.016,'expoIn')
        doFlash(1,2,'FFFFFF')
        
    end
end
function onUpdatePost()
    songPos = getSongPosition()
    currentStep = (songPos/1000)*(230/15)
    offset1 = getProperty('offsettween.x')
    offset2 = getProperty('offsettween.y')
    offset3 = getProperty('offsettween.angle')
    offset4 = getProperty('offsettween2.x')
    offset5 = getProperty('offsettween2.y')
    speed = getProperty('offsettween.alpha')
    Disoriented = Disoriented*0.93
    HP = HP*0.994
    if HP > 250 then
        setProperty('health',-1)
    end
    setProperty('camHUD.zoom',1)
    setProperty('camHUD.alpha',1)
    setProperty('timeBar.alpha',0)
    setProperty('timeTxt.alpha',0)
    setProperty('scoreTxt.alpha',0)
    triggerEvent('Change Scroll Speed',speed, 0.001)
    setTextString('dbug', 'curStep: ' .. math.floor(currentStep))
    --setTextString('dbug', 'Test Var: ' .. math.floor(Disoriented))
    s1 = -s1
    if s1 == 1 then
        s2 = -s2
    end
    if s2 == 1 then
        s3 = -s3
    end
    if s3 == 1 then
        s4 = -s4
    end
    for i = 0,3 do
        setPropertyFromGroup('strumLineNotes',i,'x',strumx1+(i-1.5)*110+getProperty('notes' .. i .. '.x')+math.random(-100,100)*0.01*Disoriented)
        setPropertyFromGroup('strumLineNotes',i,'y',strumy+getProperty('notes' .. i .. '.y')*mult)
    end
    for i = 4,7 do
        setPropertyFromGroup('strumLineNotes',i,'x',strumx2+(i-5.5)*110+getProperty('notes' .. i .. '.x')+math.random(-100,100)*0.01*Disoriented)
        setPropertyFromGroup('strumLineNotes',i,'y',strumy+getProperty('notes' .. i .. '.y')*mult)
    end
    if floorStep < 128 then
        for i = 4,7 do
            setProperty('notes' .. i .. '.y',offset2+math.sin((i/2+currentStep/16+offset3)*math.pi)*10)
        end
    end
    if currentStep > 2304 and currentStep < 2308 then
        strumx1 = 240+offset1*2
        strumx2 = 900+offset1
    end
    if floorStep >= 128 and floorStep < 256 then
        for i = 0,3 do
            setProperty('notes' .. i .. '.x',math.cos((i/2+currentStep/32+offset3)*math.pi)*offset1+offset2*2)
            setProperty('notes' .. i .. '.y',math.sin((i/2+currentStep/16+offset3/2)*math.pi)*(floorStep*-1+128)/128)
        end
        for i = 4,7 do
            setProperty('notes' .. i .. '.x',math.cos((i/2+currentStep/32+offset3)*math.pi)*(floorStep-128)/128*offset1+offset2)
            setProperty('notes' .. i .. '.y',math.sin((i/2+currentStep/32+offset3/2)*math.pi)*10)
        end
    end
    if floorStep >= 256 and floorStep < 512 then
        for i = 0,3 do
            setProperty('notes' .. i .. '.x',offset1*((i+(math.floor(floorStep/8)))%2-0.5)*2+offset3*2)
            setProperty('notes' .. i .. '.y',offset2*((i%2)-0.5))
            setPropertyFromGroup('strumLineNotes',i,'angle',offset3)
        end
        for i = 4,7 do
            setProperty('notes' .. i .. '.x',offset1*((i+(math.floor(floorStep/8)))%2-0.5)*2+offset3*2)
            setProperty('notes' .. i .. '.y',offset2*((i%2)-0.5)*2)
            setPropertyFromGroup('strumLineNotes',i,'angle',offset3)
        end
    end
    if floorStep >= 2560 and floorStep < 2816 then
        if floorStep % 64 < 16 then
            for i = 4,7 do
                setProperty('notes' .. i .. '.x',(i-5.5)*(offset2-20)*2)
                setProperty('notes' .. i .. '.y',math.sin((i/5+offset1)*math.pi)*offset2)
            end
        end
        if floorStep % 64 > 16 and floorStep % 64 < 32 then
            for i = 4,7 do
                setProperty('notes' .. i .. '.x',(i-5.5)*offset2)
                setProperty('notes' .. i .. '.y',math.sin((i/2+currentStep/2)*math.pi)*offset2)
            end
        end
        if floorStep % 64 > 32 and floorStep % 64 < 48 then
            for i = 4,7 do
                setProperty('notes' .. i .. '.x',0)
                setProperty('notes' .. i .. '.y',(((1+i)%2)-0.5)*offset2*flip1)
            end
        end
        if floorStep % 64 > 48 then
            for i = 4,7 do
                setProperty('notes' .. i .. '.x',(i-5.5)*-(110+offset2)+((i%4)-1.5)*(110+offset2)*s4)
                setProperty('notes' .. i .. '.y',math.sin((i/2+(currentStep%64)/8)*math.pi)*((currentStep%64)-48)*3)
            end
        end
    end
    if floorStep >= 2816 then
        for i = 4,7 do
            setProperty('notes' .. i .. '.x',0)
            setProperty('notes' .. i .. '.y',0+offset3)
        end
    end
    for i = 0,7 do
        setPropertyFromGroup('strumLineNotes',i,'scale.x',getProperty('scalecontrol' .. i .. '.x'))
        setPropertyFromGroup('strumLineNotes',i,'scale.y',getProperty('scalecontrol' .. i .. '.y'))
    end
    notesLength = getProperty('notes.length')
    for i1 = 0, notesLength, 1 do
        TN = getPropertyFromGroup('notes',i1,'noteData')
        TT = getPropertyFromGroup('notes',i1,'noteType')
        setPropertyFromGroup('notes',i1,'scale.x',getProperty('scalecontrol' .. TN .. '.x'))
        setPropertyFromGroup('notes',i1,'scale.y',getProperty('scalecontrol' .. TN .. '.y'))
        if getPropertyFromGroup('notes',i1,'mustPress') then
            setPropertyFromGroup('notes',i1,'scale.x',getProperty('scalecontrol' .. TN+4 .. '.x'))
            setPropertyFromGroup('notes',i1,'scale.y',getProperty('scalecontrol' .. TN+4 .. '.y'))
        end
        if TT == 'Hell Note' then
            setPropertyFromGroup('notes',i1,'x',getPropertyFromGroup('notes',i1,'x')+math.random(-7,7))
            setPropertyFromGroup('notes',i1,'y',getPropertyFromGroup('notes',i1,'y')+math.random(-3,3))
            if TN == 0 then
                setPropertyFromGroup('notes',i1,'angle',90)
            end
            if TN == 1 then
                setPropertyFromGroup('notes',i1,'angle',0)
            end
            if TN == 2 then
                setPropertyFromGroup('notes',i1,'angle',-180)
            end
            if TN == 3 then
                setPropertyFromGroup('notes',i1,'angle',-90)
            end 
        end
    end
end
function doFlash(brightness,length,color) --self explanatory
    setProperty('epicflash.alpha',brightness)
    setProperty('epicflash.color',getColorFromHex(color))
    doTweenAlpha('epicparts','epicflash',0,length,'sineOut')
end
function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'Hell Note' then
		HellNoteEffect()
    end
end 
function HellNoteEffect()
    Disoriented = Disoriented*4
    Disoriented = Disoriented+200
    HP = HP+100
end