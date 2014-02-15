function load()
	game = {}

	game_config()

	game.source = love.graphics.newImage("game/files/game.png")

	game.res = {game.source:getWidth(), game.source:getHeight()}

	game.img.background = {engine.image.Create(0, 0, 145, 256, game.res[1], game.res[2]),
						   engine.image.Create(146, 0, 145, 256, game.res[1], game.res[2])}

	game.img.footer = engine.image.Create(291, 0, 168, 56, game.res[1], game.res[2])
	game.img.flaptitle = engine.image.Create(350, 90, 92, 26, game.res[1], game.res[2])
	game.img.bird = engine.image.Create(31, 491, 17, 12, game.res[1], game.res[2])
	game.img.start_bt = engine.image.Create(354, 118, 52, 30, game.res[1], game.res[2])
	game.img.rank_bt = engine.image.Create(414, 118, 52, 30, game.res[1], game.res[2])
	game.img.rate_bt = engine.image.Create(465, 1, 31, 19, game.res[1], game.res[2])
end

function game_config()
	engine.image.Config()
	engine.bird.Config()
	engine.enviroment.Config()
end
	
function love.draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(game.source, game.img.prop[game.img.background[1]][1], 0, 0, game.img.prop[game.img.background[1]][2])

	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(game.source, game.img.prop[game.img.footer][1], move.footer-13, love.window.getHeight()-56, game.img.prop[game.img.footer][2])
	love.graphics.draw(game.source, game.img.prop[game.img.footer][1], move.footer, love.window.getHeight()-56, game.img.prop[game.img.footer][2])

	love.graphics.draw(game.source, game.img.prop[game.img.flaptitle][1], (love.window.getWidth()/2)-(89/2), (love.window.getHeight()/2)-75, game.img.prop[game.img.flaptitle][2])

	love.graphics.draw(game.source, game.img.prop[game.img.bird][1], (love.window.getWidth()/2)-7, ((love.window.getHeight()/2)-40) + bird.vMove, game.img.prop[game.img.bird][2])

	love.graphics.draw(game.source, game.img.prop[game.img.start_bt][1], ((love.window.getWidth()/2)-26) - 32, (love.window.getHeight()/2)+40, game.img.prop[game.img.start_bt][2])
	love.graphics.draw(game.source, game.img.prop[game.img.rank_bt][1], ((love.window.getWidth()/2)-26) + 32, (love.window.getHeight()/2)+40, game.img.prop[game.img.rank_bt][2])

	love.graphics.draw(game.source, game.img.prop[game.img.rate_bt][1], ((love.window.getWidth()/2)-15), (love.window.getHeight()/2), game.img.prop[game.img.rate_bt][2])
end

function love.load()
end

function love.update(dt)
	engine.bird.Frame(dt)		-- Cria movimentação da imagem da ave
	engine.bird.Move(dt) 		-- Cria movimentação vertical da ave
	engine.enviroment.Move(dt)  -- Cria movimento do ambiente
end

function love.focus(bool)
end

function love.keypressed(key, unicode)
	if key == " " then
		engine.bird.MoveAdd(1.3)
	end
end

function love.keyreleased(key)
end

function love.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
end

function love.quit()
	print("byee! Have a nice day :D")
end

require("game/engine/main") -- Engine do jogo