function clearLoveCallbacks()
	love.draw = nil
	love.joystickpressed = nil
	love.joystickreleased = nil
	love.keypressed = nil
	love.keyreleased = nil
	--love.load = nil
	love.mousepressed = nil
	love.mousereleased = nil
	love.update = nil
end

state = {}
function loadState(name)
	state = {}
	clearLoveCallbacks()
	require(name .. "/main")
	load()
end

function load()
end

function love.load()
	loadState("game")
end
	
function love.draw()
end

function love.update(dt)
end

function love.focus(bool)
end

function love.keypressed(key, unicode)
end

function love.keyreleased(key)
end

function love.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
end

function love.quit()
end

function insideBox(px, py, x, y, mx, my)
	if px >= x and px <= mx then
		if py >= y and py <= my then
			return true
		end
	end

	return false 
end