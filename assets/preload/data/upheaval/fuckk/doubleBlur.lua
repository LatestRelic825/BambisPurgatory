local bVal = 50
function onUpdatePost(el)
	for i = 0, 1 do
		if getProperty('healthBar.percent') <= 50 then
			if not luaSpriteExists('blur'..i) then
				makeAnimatedLuaSprite('blur'..i, getProperty('dad.imageFile'), getProperty('dad.x'), getProperty('dad.y'))
			end
			setProperty('blur'..i..'.visible', getProperty('dad.visible'))
			setProperty('blur'..i..'.offset.x', getProperty('dad.offset.x'))
			setProperty('blur'..i..'.offset.y', getProperty('dad.offset.y'))
			setProperty('blur'..i..'.flipX', getProperty('dad.flipX'))
			
			--setProperty('blur'..i..'.animation.frameName', string.gsub(getProperty('dad.animation.frameName'), "(%d%d%d%d)" , function(a) 
			setProperty('blur0.animation.frameName', string.gsub(getProperty('dad.animation.frameName'), "(%d%d%d%d)" , function(a) 
				local num = tostring(tonumber(a) - math.random(-2, 2))
				return ("0"):rep(4 - #num) .. num
			end)) -- thx soup
			setProperty('blur1.animation.frameName', string.gsub(getProperty('dad.animation.frameName'), "(%d%d%d%d)" , function(a) 
				local num = tostring(tonumber(a) + math.random(-2, 2))
				return ("0"):rep(4 - #num) .. num
			end)) -- thx soup
			
			setProperty('blur'..i..'.alpha', 0.4 - getProperty('healthBar.percent') / 100)
			setProperty('blur0.x', getProperty('dad.x') + getProperty('healthBar.percent') - getProperty('dad.frameWidth') / bVal - 1)
			setProperty('blur0.y', getProperty('dad.y') - getProperty('healthBar.percent') + getProperty('dad.frameHeight') / bVal)
			setProperty('blur1.x', getProperty('dad.x') - getProperty('healthBar.percent') + getProperty('dad.frameWidth') / bVal - 1)
			setProperty('blur1.y', getProperty('dad.y') + getProperty('healthBar.percent') - getProperty('dad.frameHeight') / bVal)
			
			addLuaSprite('blur'..i, true)
		else
			if luaSpriteExists('blur'..i) then
				removeLuaSprite('blur'..i, true)
			end
		end
	end
	--setProperty('health', 0.4)
end

function onEvent(n, v1)
	local bars = string.lower('Dad') or 1
	for i = 0, 1 do
		if n == 'Change Character' and v1 == bars and luaSpriteExists('blur0') then
			loadFrames('blur'..i, getProperty('dad.imageFile'))
		end
	end
end