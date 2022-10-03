
local s1 = 1
local s2 = 1
local flip = 1
local sOffset = 0
local chromVar = 0
local chromSpeed = 0.85
function onCreate()
    makeLuaSprite('offsettween','',0,0)
    setProperty('offsettween.alpha',0.22)
    makeLuaSprite('offsettween2','',0,0)
    makeLuaSprite('epicflash','',0,0)
    makeGraphic('epicflash',3000,3000,'FFFFFF')
    setObjectCamera('epicflash','other')
    addLuaSprite('epicflash',true)
    setProperty('epicflash.alpha', 0)
    makeLuaSprite('darkgame','',-1500,-1000)
    makeGraphic('darkgame',5000,3000,'000000')
    setObjectCamera('darkgame','Game')
    addLuaSprite('darkgame',true)
    setProperty('darkgame.alpha', 0)
    for i = 0,7 do
        makeLuaSprite('scalecontrol' .. i,'',0.7,0.7)
        setProperty('scalecontrol' .. i .. '.alpha',0)
        addLuaSprite('scalecontrol' .. i,false)
    end
    
    makeLuaText('warn1', "Miss = -10% HP", 900, 600, 20)
    setTextSize('warn1', 20)
    setTextColor('warn1', 'FFFFFF')
    setObjectCamera('warn1','other')
    addLuaText('warn1',true)
    makeLuaText('warn2', "Hit = +2% HP", 900, 600, 40)
    setTextSize('warn2', 20)
    setTextColor('warn2', 'FFFFFF')
    setObjectCamera('warn2','other')
    addLuaText('warn2',true)
end
function onCreatePost()
    setProperty('offsettween.angle',1)
    doTweenAlpha('warn1bye','warn1',0,5,'linear')
    doTweenAlpha('warn2bye','warn2',0,5,'linear')
end
function onSongStart()
    songPos = getSongPosition()
    currentStep = (songPos/1000)*(curBpm/15)-sOffset
        doTweenAlpha('oooooaa2','darkgame',0.5,crochet*0.003,'linear')
end
function onStepHit()
    floorStep = math.floor(currentStep)
    if floorStep > 0 and floorStep < 124 then
        if floorStep % 16 == 0 then
            setProperty('offsettween.x',15)
            doTweenX('epicintro1','offsettween',0,stepCrochet*0.001,'sineOut')
        end
        if floorStep % 16 == 2 or floorStep % 16 == 10 then
            setProperty('offsettween.x',10)
            doTweenX('epicintro1','offsettween',0,stepCrochet*0.002,'sineOut')
        end
        if floorStep % 16 == 4 or floorStep % 16 == 12 then
            setProperty('offsettween.y',15)
            doTweenY('epicintro2','offsettween',0,stepCrochet*0.002,'expoOut')
        end
        if floorStep % 16 == 6 or floorStep % 16 == 8 or floorStep % 16 == 14 then
            setProperty('offsettween.angle',0.9)
            doTweenAngle('epicintro3','offsettween',0.95,stepCrochet*0.002,'sineOut')
        end
        if floorStep % 16 == 7 or floorStep % 16 == 9 or floorStep % 16 == 15 then
            setProperty('offsettween.angle',1.05)
            doTweenAngle('epicintro3','offsettween',1,stepCrochet*0.002,'sineOut')
        end
    end
    if floorStep == 128 then
        doFlash(1,1,'FFFFFF')
        setProperty('offsettween.x',0)
        setProperty('offsettween.y',2)
        chromVar = 0.02
    end
    if floorStep == 112 then
        setProperty('offsettween.x',0)
    end
    if (floorStep >= 128 and floorStep < 256) or (floorStep >= 768 and floorStep < 1024) then
        if floorStep % 16 == 0 or floorStep % 16 == 6 or floorStep % 16 == 12 then
            setProperty('offsettween.angle',100)
            doTweenAngle('UAUAUA1','offsettween',0,stepCrochet*0.004,'sineInOut')
            flip = -flip
            for i = 0,7 do
                setPropertyFromGroup('strumLineNotes',i,'angle',0)
                noteTweenAngle('wee' .. i,i,360,stepCrochet*0.004,'expoOut')
            end
            chromVar = 0.02
            chromSpeed = 0.85
            setProperty('camHUD.angle',flip*5)
            setProperty('camHUD.zoom',1.05)
            doTweenAngle('bounce1','camHUD',0,crochet*0.002,'expoOut')
            doTweenZoom('bounce2','camHUD',1,crochet*0.002,'expoOut')
        end
        if floorStep % 16 == 4 or floorStep % 16 == 10 then
            for i = 0,7 do
                setPropertyFromGroup('strumLineNotes',i,'angle',0)
            end
        end
        if floorStep % 32 == 0 or floorStep % 64 == 19 or floorStep % 32 == 16 or floorStep % 64 == 26 or floorStep % 64 == 27 or floorStep % 64 == 48 or floorStep % 64 == 58 or floorStep % 64 == 62 then
            setProperty('offsettween.x',30)
            doTweenX('drumloop1','offsettween',0,stepCrochet*0.002,'sineOut')
        end
        if floorStep % 32 == 10 or floorStep % 64 == 22 or floorStep % 64 == 54 or floorStep % 64 == 52 then
            setProperty('offsettween.x',-30)
            doTweenX('drumloop1','offsettween',0,stepCrochet*0.002,'sineOut')
        end
        if floorStep % 32 == 4 or floorStep % 32 == 20 or floorStep % 64 == 28 or floorStep % 64 == 60 then
            setProperty('offsettween.y',60)
            doTweenY('drumloop2','offsettween',0,stepCrochet*0.002,'expoOut')
        end
        if floorStep % 32 == 12 then
            setProperty('offsettween.y',-60)
            doTweenY('drumloop2','offsettween',0,stepCrochet*0.002,'expoOut')
        end
    end
    if floorStep >= 256 and floorStep < 384 then
        if floorStep % 4 == 0 then
            flip = -flip
            setProperty('offsettween.y',flip*30)
            doTweenY('UAUAUA1','offsettween',0,stepCrochet*0.003,'sineIn')
            for i = 0,7 do
                noteTweenAngle('wee' .. i,i,flip*10,stepCrochet*0.003,'sineOut')
                setProperty('scalecontrol' .. i .. '.x',0.8+flip*0.3)
                setProperty('scalecontrol' .. i .. '.y',0.8+flip*-0.3)
                doTweenX('tweenx' .. i,'scalecontrol' .. i,0.7,stepCrochet*0.004,'backOut')
                doTweenY('tweeny' .. i,'scalecontrol' .. i,0.7,stepCrochet*0.004,'backOut')
            end
            chromVar = 0.004
            chromSpeed = 0.9
        end
    end
    if floorStep == 384 then
        doTweenAlpha('roblox1','camHUD',0,crochet*0.002,'linear')
        doTweenAngle('roblox2','camHUD',20,crochet*0.002,'sineIn')
        doTweenY('roblox3','camHUD',200,crochet*0.002,'sineIn')
        doTweenAlpha('oooooaa2','darkgame',0,crochet*0.004,'linear')
    end
    if floorStep == 496 then
        setProperty('camHUD.angle',0)
        setProperty('camHUD.y',0)
        doTweenAlpha('roblox1','camHUD',1,crochet*0.002,'linear')
        doTweenAlpha('oooooaa2','darkgame',0.5,crochet*0.004,'linear')
        for i = 4,7 do
            setPropertyFromGroup('strumLineNotes',i,'y',800)
        end
        for i = 0,7 do
            setPropertyFromGroup('strumLineNotes',i,'angle',0)
        end
    end
    if floorStep == 504 then
        for i = 4,7 do
            noteTweenY('back' .. i,i,50,crochet*0.002,'backOut')
        end
    end
    if floorStep >= 512 and floorStep < 640 then
        if floorStep % 4 == 0 then
            flip = -flip
            setProperty('offsettween.y',flip*30)
            doTweenY('UAUAUA1','offsettween',0,stepCrochet*0.003,'sineOut')
            for i = 0,7 do
                setPropertyFromGroup('strumLineNotes',i,'angle',flip*10)
                noteTweenAngle('wee' .. i,i,flip*2,stepCrochet*0.003,'sineOut')
                setProperty('scalecontrol' .. i .. '.x',1.1)
                setProperty('scalecontrol' .. i .. '.y',0.5)
                doTweenX('augh1' .. i,'scalecontrol' .. i,0.7,stepCrochet*0.008,'elasticOut')
                doTweenY('augh2' .. i,'scalecontrol' .. i,0.7,stepCrochet*0.008,'elasticOut')
            end
            chromVar = 0.02
            chromSpeed = 0.5
        end
    end
    if floorStep == 640 then
        setProperty('offsettween.x',0)
        doTweenX('epicsolo1','offsettween',30,stepCrochet*0.004,'linear')
        doTweenAlpha('epicsolo1','offsettween',0.13,stepCrochet*0.004,'expoOut')
    end
    if floorStep == 768 then
        doTweenAlpha('epicsolo1','offsettween',0.22,stepCrochet*0.004,'expoOut')
    end
    if floorStep == 1024 then
        sOffset = 247
        setProperty('offsettween.alpha',0.34)
        for i = 0,3 do
            noteTweenX('IMBAC1' .. i,i,260+(i-1.5)*110,crochet*0.004,'sineOut')
            noteTweenY('IMBAC2' .. i,i,50,crochet*0.004,'sineOut')
        end
        for i = 4,7 do
            noteTweenX('ok1' .. i,i,920+(i-5.5)*110,crochet*0.004,'sineInOut')
        end
        for i = 0,7 do
            noteTweenAngle('ok2' .. i,i,180,crochet*0.015,'sineIn')
        end
        doFlash(1,4,'000000')
    end
    if floorStep == 1084 then
        for i = 0,7 do
            noteTweenAngle('ok2' .. i,i,0,crochet*0.001,'sineIn')
        end
    end
    if floorStep >= 1088 and floorStep < 1136 then
        if floorStep % 16 == 0 or floorStep % 16 == 6 or floorStep % 16 == 12 then
            setProperty('camGame.zoom',getProperty('camGame.zoom')*1.1)
            setProperty('offsettween.x',20)
            doTweenZoom('B1','camGame',getProperty('camGame.zoom')/1.1,stepCrochet*0.004,'sineOut')
            doTweenX('B2','offsettween',0,stepCrochet*0.004,'sineOut')
            chromVar = 0.02
            chromSpeed = 0.6
        end
    end
    if floorStep == 1136 or floorStep == 124 or floorStep == 764 then
        setProperty('camHUD.alpha',0)
    end
    if floorStep == 1152 or floorStep == 128 or floorStep == 768 then
        doFlash(1,1,'FFFFFF')
        setProperty('camHUD.alpha',1)
    end
    if floorStep == 2032 then
        for i = 0,3 do
            noteTweenAngle('ok2' .. i,i,-360,crochet*0.004,'expoIn')
            noteTweenX('ok3' .. i,i,-400+(i-1.5)*110,crochet*0.004,'expoIn')
            
        end
        for i = 4,7 do
            noteTweenAngle('ok4' .. i,i,-360,crochet*0.004,'expoIn')
            noteTweenX('ok5' .. i,i,590+(i-5.5)*110,crochet*0.004,'expoIn')
            
        end
    end
    if floorStep == 2048 then
        doFlash(1,1,'FFFFFF')
    end
    if floorStep == 2080 then
        doFlash(1,0.5,'FFFFFF')
        setProperty('camHUD.alpha',0)
        setProperty('camGame.alpha',0)
    end
    if floorStep >= 1152 then
        if floorStep % 4 == 0 then
            flip = -flip
            setProperty('camHUD.angle',flip*3)
            setProperty('camHUD.zoom',1.05)
            doTweenAngle('bounce1','camHUD',0,crochet*0.002,'expoOut')
            doTweenZoom('bounce2','camHUD',1,crochet*0.002,'expoOut')
        end
    end
end


function onEvent(name, value1, value2)
    if name == "DoLuaStuff" then
        if floorStep > 128 and floorStep < 256 then
            setProperty('camHUD.x',math.cos(math.random(0,180)*math.pi/90)*70)
            setProperty('camHUD.y',math.sin(math.random(0,180)*math.pi/90)*70)
            doTweenX('computerbreakx','camHUD',0,stepCrochet*0.002,'sineIn')
            doTweenY('computerbreaky','camHUD',0,stepCrochet*0.002,'sineIn')
        end
    end
end


function onUpdatePost()
    songPos = getSongPosition()
    currentStep = (songPos/1000)*(curBpm/15)-sOffset
	hp = getProperty('health')
    offset1 = getProperty('offsettween.x')
    offset2 = getProperty('offsettween.y')
    offset3 = getProperty('offsettween.angle')
    speed = getProperty('offsettween.alpha')
    chromVar = chromVar*chromSpeed
	clearEffects('camHUD')
	clearEffects('camGame')
	addChromaticAbberationEffect('camHUD', chromVar)
	addChromaticAbberationEffect('camGame', chromVar)
    triggerEvent('Change Scroll Speed',speed, 0.001)
    s1 = -s1
    if s1 == 1 then
        s2 = -s2
    end
    if floorStep > 0 and floorStep < 128 then
        for i = 0,3 do
        setPropertyFromGroup('strumLineNotes',i,'x',260+(i-1.5)*(110*offset3))
        end
        for i = 4,7 do
        setPropertyFromGroup('strumLineNotes',i,'x',920+(i-5.5)*(110*offset3))
        end
        for i = 0,1 do
        setPropertyFromGroup('strumLineNotes',0+i*4,'y',50+offset1*2+offset2*-0.5)
        setPropertyFromGroup('strumLineNotes',1+i*4,'y',50+offset1*3.5+offset2*-2)
        setPropertyFromGroup('strumLineNotes',2+i*4,'y',50+offset1*2+offset2*-3.5)
        setPropertyFromGroup('strumLineNotes',3+i*4,'y',50+offset1*0.5+offset2*-2)
        end
    end
    if (floorStep >= 128 and floorStep < 256) or (floorStep >= 768 and floorStep < 1024) then
        for i = 0,3 do
            setPropertyFromGroup('strumLineNotes',i,'x',260+(i-1.5)*110+math.sin((currentStep+i)*math.pi/4)*offset3)
            setPropertyFromGroup('strumLineNotes',i,'y',50+(i%2-0.25)*offset1*5+((i+1)%2-0.25)*offset2*5)
        end
        for i = 4,7 do
            setPropertyFromGroup('strumLineNotes',i,'x',920+(i-5.5)*110+math.sin((currentStep+i)*math.pi/4)*offset3)
            setPropertyFromGroup('strumLineNotes',i,'y',50+(i%2-0.25)*offset1*5+((i+1)%2-0.25)*offset2*5)
        end
        notesLength = getProperty('notes.length')
        for i1 = 0, notesLength, 1 do
            TN = getPropertyFromGroup('notes',i1,'noteData')
            TNX = getPropertyFromGroup('notes',i1,'x')
            TNY = getPropertyFromGroup('notes',i1,'y')
            TNOY = getPropertyFromGroup('strumLineNotes',TN+4,'y')
            setPropertyFromGroup('notes',i1,'x',TNX+math.sin(((-100+TNY*(300/(offset3+0.01))-TNOY)+currentStep*-32)*math.pi*0.001)*offset3*2+math.sin(currentStep*-32*math.pi*0.001)*-offset3*2)
        end
    end
    if floorStep >= 1152 then
        chromVar = 0.005
    end
    if floorStep > 640 and floorStep < 768 then
        for i = 4,7 do
            setPropertyFromGroup('strumLineNotes',i,'x',920+offset2+(i-5.5)*math.cos(currentStep*math.pi/32)*110)
            setPropertyFromGroup('strumLineNotes',i,'y',50+math.sin((i*8+currentStep)*math.pi/16)*20)
        end
    end
    if (floorStep > 256 and floorStep < 384) or (floorStep > 512 and floorStep < 640) then
        for i = 0,1 do
        setPropertyFromGroup('strumLineNotes',0+i*4,'x',(260+i*660)+(4-5.5)*110+offset2)
        setPropertyFromGroup('strumLineNotes',1+i*4,'x',(260+i*660)+(5-5.5)*110)
        setPropertyFromGroup('strumLineNotes',2+i*4,'x',(260+i*660)+(6-5.5)*110)
        setPropertyFromGroup('strumLineNotes',3+i*4,'x',(260+i*660)+(7-5.5)*110-offset2)
        setPropertyFromGroup('strumLineNotes',0+i*4,'y',50)
        setPropertyFromGroup('strumLineNotes',1+i*4,'y',50-offset2)
        setPropertyFromGroup('strumLineNotes',2+i*4,'y',50+offset2)
        setPropertyFromGroup('strumLineNotes',3+i*4,'y',50)
        end
        for i = 0,7 do
            setPropertyFromGroup('strumLineNotes',i,'scale.x',getProperty('scalecontrol' .. i .. '.x'))
            setPropertyFromGroup('strumLineNotes',i,'scale.y',getProperty('scalecontrol' .. i .. '.y'))
        end
        notesLength = getProperty('notes.length')
        for i1 = 0, notesLength, 1 do
            TN = getPropertyFromGroup('notes',i1,'noteData')
            TNX = getPropertyFromGroup('notes',i1,'x')
            TNY = getPropertyFromGroup('notes',i1,'y')
            TNOY = getPropertyFromGroup('strumLineNotes',TN+4,'y')
            setPropertyFromGroup('notes',i1,'x',TNX+math.floor(math.sin((((-100+TNY*2)-TNOY)+currentStep*-32)*math.pi*0.001)*(offset2/10+0.5)+math.sin(currentStep*-32*math.pi*0.001)*-(offset2/10+0.5)+0.5)*60)
            setPropertyFromGroup('notes',i1,'scale.x',getProperty('scalecontrol' .. TN+4 .. '.x'))
            setPropertyFromGroup('notes',i1,'scale.y',getProperty('scalecontrol' .. TN+4 .. '.y'))
        end
    end
end
function goodNoteHit()
	hp = getProperty('health')
	setProperty('health',hp+0.04)
end
function noteMiss()
	setProperty('health',hp-0.2)
	shake = shake+80
end



function resetOffsets()
    setProperty('offsettween.x',0)
    setProperty('offsettween.y',0)
    setProperty('offsettween.angle',0)
end



function doFlash(brightness,length,color) --self explanatory
    setProperty('epicflash.alpha',brightness)
    setProperty('epicflash.color',getColorFromHex(color))
    doTweenAlpha('epicparts','epicflash',0,length,'sineOut')
end