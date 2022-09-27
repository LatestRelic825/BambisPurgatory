function onCountdownStarted()
	if dadName == 'bambi-god' or dadName == 'bombu' or dadName == 'bombai' or dadName == 'expunged' or dadName == 'bambi-3d'
	or dadName == 'baiburg' or dadName == 'dave-3d' or dadName == 'bamburg' or dadName == 'bambi-unfair' or dadName == 'crusti' or dadName == 'crusturn' or dadName == 'dave3d' then --replace the name for your character name dededededDEEZ nuts
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