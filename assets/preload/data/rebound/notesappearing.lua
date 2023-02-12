
function onBeatHit()
    for i = 0,7 do
        if curBeat == 16+i*2 then
            noteTweenAlpha("nIntroAlpha"..i, i, 1, 2, "linear")
        end
    end
end
function onUpdate()
    if curBeat < 15 then
    for i = 0,7 do
    setPropertyFromGroup('strumLineNotes',i,'alpha',0)
    end
    end
end