
local s1 = 1
local s2 = 1
local s3 = 1
local s4 = 1
local flip = 1
function onCreate()
    makeLuaSprite('extravars','',0,0)
    setProperty('extravars.alpha',1.00)
    makeLuaSprite('extravars2','',0,0)
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
        makeLuaSprite('notes' .. i,'',0,0)
    end
    setTextSize('dbug', 40)
    setTextColor('dbug', 'FFFFFF')
    setObjectCamera('dbug','other')
    addLuaText('dbug',true)
end
function onSongStart()
end
function onStepHit()
    floorStep = math.floor(currentStep)
    for i = 0,2 do
        if floorStep == i*6 then
            setProperty('camHUD.angle',(i%2-0.5)*8)
            doTweenAngle('bruh3','camHUD',0,crochet*0.001,'sineOut')
        end
    end
    for i = 0,3 do
        if floorStep == 12+i*4 then
            doTweenX('bruh1-' .. i,'notes' .. i,-660,crochet*0.001,'expoIn')
            doTweenX('bruh2-' .. i,'notes' .. i+4,-310,crochet*0.001,'expoIn')
        end
        if floorStep == 16+i*4 then
            setProperty('camHUD.angle',((i+1)%2-0.5)*4)
            doTweenAngle('bruh3','camHUD',0,crochet*0.001,'linear')
        end
    end
    if floorStep == 16 then
        doTweenZoom('bruh4','camGame',0.8,crochet*0.004,'sineIn')
    end
    if floorStep == 32 or floorStep == 1856 then
        doFlash(1,2,'FFFFFF')
        for i = 0,3 do
            setProperty('notes' .. i .. '.x',-660)
        end
        setProperty('extravars.x',30)
        setProperty('extravars.y',30)
    end
    if floorStep == 1344 or floorStep == 2368 then
        doFlash(1,1,'000000')
    end
    if (floorStep > 32 and floorStep < 352) or (floorStep > 399 and floorStep < 512) then
        if floorStep % 32 == 8 then
            flip = -flip
            doTweenX('byo1','extravars',30*flip,crochet*0.002,'sineIn')
        end
        if floorStep % 32 == 16 then
            setProperty('camHUD.zoom',1.06)
            doTweenZoom('bruh3','camHUD',1,crochet*0.001,'sineOut')
            setProperty('extravars.x',120*flip)
            setProperty('extravars.y',120)
            doTweenX('byo1','extravars',30*flip,crochet*0.002,'expoOut')
            doTweenY('byo2','extravars',30,crochet*0.002,'expoOut')
            doTweenAngle('byo3','extravars',getProperty('extravars.angle')+0.8,crochet*0.002,'expoOut')
        end
    end
    if floorStep > 352 and floorStep < 400 then
        if floorStep % 32 == 8 then
            flip = -flip
            doTweenX('byo1','extravars',20*flip,crochet*0.002,'sineIn')
        end
        for i = 0,7 do
            if floorStep % 64 == (48+i*4)%64 then
                setProperty('extravars.angle',getProperty('extravars.angle')-0.25)
            end
        end
    end
    if floorStep == 512 then
        for i = 4,7 do
            noteTweenAngle('angle' .. i,i,360,crochet*0.004,'expoOut')
        end
        doTweenX('byo1','extravars',0,crochet*0.004,'backIn')
        doTweenY('byo2','extravars',0,crochet*0.004,'expoOut')
    end
    if (floorStep > 543 and floorStep < 800) or (floorStep > 831 and floorStep < 1344) or (floorStep > 1856 and floorStep < 2368) then
        for i = 0,1 do
            if floorStep % 32 == 0+i*6 then
                setProperty('extravars.x',-110)
                for i = 4,7 do
                    noteTweenAngle('angle' .. i,i,180,stepCrochet*0.001,'linear')
                end
            end
            if floorStep % 32 == 1+i*6 then
                doTweenX('byo1','extravars',0,stepCrochet*0.003,'sineIn')
                for i = 4,7 do
                    noteTweenAngle('angle' .. i,i,0,stepCrochet*0.003,'expoIn')
                end
            end
            if floorStep % 32 == 4+i*6 then
                setProperty('extravars.y',(i%2-0.5)*30)
                doTweenY('byo2','extravars',0,stepCrochet*0.002,'expoOut')
            end
        end
        for i = 0,3 do
            if floorStep % 32 == 12+i then
                setProperty('extravars.y',(i%2-0.5)*15)
                doTweenY('byo2','extravars',0,stepCrochet*0.001,'sineOut')
            end
        end
        for i = 0,1 do
            if floorStep % 32 == 16+i*2 or floorStep % 32 == 28 then
                setProperty('extravars.angle',20-i*10)
                doTweenAngle('byo3','extravars',0,stepCrochet*0.002,'sineOut')
            end
        end
        if floorStep % 32 == 20 or floorStep % 32 == 26 then
            setProperty('extravars.angle',-30)
            doTweenAngle('byo3','extravars',0,stepCrochet*0.002,'sineOut')
        end
        for i = 0,3 do
            if floorStep % 32 == 22+i then
                setProperty('extravars.y',(i%2-0.5)*10)
                doTweenY('byo2','extravars',0,stepCrochet*0.001,'sineOut')
            end
        end
        for i = 0,1 do
            if floorStep % 32 == 30+i then
                setProperty('extravars.y',(i%2-0.5)*25)
                doTweenY('byo2','extravars',0,stepCrochet*0.001,'sineOut')
            end
        end
    end
    if floorStep > 1472 and floorStep < 1535 then
            for i = 0,11 do
                if floorStep % 32 == i then
                setProperty('extravars.y',(i%2-0.5)*55)
                end
            end
            if floorStep % 32 == 12 then
                setProperty('extravars.y',(-0.5)*75)
                setProperty('extravars.angle',40)
                doTweenY('byo2','extravars',0,stepCrochet*0.004,'linear')
                doTweenAngle('byo3','extravars',0,stepCrochet*0.004,'sineOut')
            end
            for i = 0,7 do
                if floorStep % 32 == 16+i*2 then
                    setProperty('extravars.x',(i%2-0.5)*30)
                    doTweenX('byo1','extravars',0,stepCrochet*0.002,'sineIn')
                end
            end
    end
    if floorStep > 1535 and floorStep < 1598 then
            if floorStep % 32 == 0 then
                setProperty('extravars2.x',50)
                doTweenX('byo4','extravars2',0,stepCrochet*0.016,'linear')
            end
            for i = 0,7 do
                if floorStep % 32 == 16+i*2 then
                    setProperty('extravars2.x',20)
                    doTweenX('byo4','extravars2',0,stepCrochet*0.002,'sineOut')
                end
            end
    end
    if floorStep == 1600 then
        setProperty('extravars2.x',30)
    end
    if floorStep == 1728 then
        doTweenX('byo4','extravars2',0,stepCrochet*0.004,'linear')
    end
    if floorStep == 2368 then
        setProperty('extravars.alpha',0.70)
        for i = 0,3 do
            setProperty('notes' .. i .. '.x',-660)
        end
    end
    for i = 0,3 do
        if floorStep == 2864+i*4 then
            doTweenY('bruh2-' .. i,'notes' .. 7-i,700,crochet*0.001,'expoIn')
        end
    end
end
function onUpdatePost()
    songPos = getSongPosition()
    currentStep = (songPos/1000)*(curBpm/15)
    var1 = getProperty('extravars.x')
    var2 = getProperty('extravars.y')
    var3 = getProperty('extravars.angle')
    var4 = getProperty('extravars2.x')
    var5 = getProperty('extravars2.y')
    speed = getProperty('extravars.alpha')
    triggerEvent('Change Scroll Speed',speed, 0.001)
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
        setPropertyFromGroup('strumLineNotes',i,'x',strumx1+(i-1.5)*110+getProperty('notes' .. i .. '.x'))
        setPropertyFromGroup('strumLineNotes',i,'y',strumy+getProperty('notes' .. i .. '.y')*mult)
    end
    for i = 4,7 do
        setPropertyFromGroup('strumLineNotes',i,'x',strumx2+(i-5.5)*110+getProperty('notes' .. i .. '.x'))
        setPropertyFromGroup('strumLineNotes',i,'y',strumy+getProperty('notes' .. i .. '.y')*mult)
    end
    if (currentStep > 32 and currentStep < 544) then
        for i = 4,7 do
        setProperty('notes' .. i .. '.x',-310+math.sin((i/4+currentStep/16+var3)*math.pi)*var1)
        setProperty('notes' .. i .. '.y',0+math.sin((i/4+currentStep/16+var3)*math.pi)*var2)
        end
    end
    if (floorStep > 543 and floorStep < 800) or (floorStep > 831 and floorStep < 1344) or (floorStep > 1856 and floorStep < 2368) then
        for i = 4,7 do
        setProperty('notes' .. i .. '.x',-310+(i%2-0.5)*var1*2+(i-5.5)*var3)
        setProperty('notes' .. i .. '.y',(i%2-0.5)*var2*2)
        end
    end
    if floorStep > 1344 and floorStep < 1855 then
        for i = 0,7 do
        setProperty('notes' .. i .. '.x',0+(i%2-0.5)*var1*2+(i-5.5)*var3)
        setProperty('notes' .. i .. '.y',(i%2-0.5)*var2*2+math.sin((i/2+currentStep/4)*math.pi)*var4*s4)
        end
    end
end
function doFlash(brightness,length,color) --self explanatory
    setProperty('epicflash.alpha',brightness)
    setProperty('epicflash.color',getColorFromHex(color))
    doTweenAlpha('epicparts','epicflash',0,length,'sineOut')
end