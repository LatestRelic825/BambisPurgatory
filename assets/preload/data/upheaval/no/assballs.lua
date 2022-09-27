function onUpdate()
	if curStep == 1 then
		if inGameOver == false then
			for i=0,4,1 do
				setPropertyFromGroup('opponentStrums', i, 'texture', 'NOTE_assets')
			end
			for i = 0, getProperty('unspawnNotes.length')-1 do
				if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets'); --Change texture
				end
			end
	    end
	end
	if curStep == 512 then
		if inGameOver == false then
			for i=0,4,1 do
				setPropertyFromGroup('opponentStrums', i, 'texture', 'polynote')
			end
			for i = 0, getProperty('unspawnNotes.length')-1 do
				if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', i, 'texture', 'polynote'); --Change texture
				end
			end
	    end
	end
end