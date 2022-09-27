function onEvent(name, value1, value2)
    if name == 'Freeze Chart' and not lowQuality then
        currentpos = getPropertyFromClass('Conductor', 'songPosition')
        stopThis = value1
        runTimer('resetRun', value2)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'resetRun' then
        stopThis = ''
    end
end

function onUpdatePost()
    if stopThis == 'true' then
        setPropertyFromClass('Conductor', 'songPosition', currentpos)
    end
end