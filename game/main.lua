function load()
	game = {}

	game_config()

	game.source = love.graphics.newImage("game/files/game.png") -- Inicia imagem com toda a source do jogo

	game.res = {game.source:getWidth(), game.source:getHeight()} -- Dimenciona em um Array o tamanho da Source

	game.img.background = {engine.image.Create(0, 0, 145, 256, game.res[1], game.res[2]),   -- Cria uma imagem na Engine do Jogo para o BackGround
						   engine.image.Create(146, 0, 145, 256, game.res[1], game.res[2])} -- em um Array por existirem dois planos para o Background

	game.img.footer = engine.image.Create(291, 0, 168, 56, game.res[1], game.res[2])    -- Cria uma imagem na Engine do Jogo
	game.img.flaptitle = engine.image.Create(350, 90, 92, 26, game.res[1], game.res[2]) -- //
	game.img.bird = engine.image.Create(31, 491, 17, 12, game.res[1], game.res[2])      -- //
	game.img.start_bt = engine.image.Create(354, 118, 52, 30, game.res[1], game.res[2]) -- //
	game.img.rank_bt = engine.image.Create(414, 118, 52, 30, game.res[1], game.res[2])  -- //
	game.img.rate_bt = engine.image.Create(465, 1, 31, 19, game.res[1], game.res[2])    -- //

	engine.enviroment.createColisionArea(game.img.footer, "GameOver") -- Cria colisão de certo Objeto
end

function game_config()
	engine.image.Config()
	engine.bird.Config()
	engine.enviroment.Config()
end
	
function love.draw()
	-- Background (Sempre aparece)
	engine.image.Draw(game.img.background[1], game.source, game.img.prop[game.img.background[1]][1], 0, 0, game.img.prop[game.img.background[1]][2])

	-- Chão (Sempre aparece)
	engine.image.Draw(game.img.footer, game.source, game.img.prop[game.img.footer][1], game.move.footer-13, love.window.getHeight()-56, game.img.prop[game.img.footer][2])
	engine.image.Draw(game.img.footer, game.source, game.img.prop[game.img.footer][1], game.move.footer, love.window.getHeight()-56, game.img.prop[game.img.footer][2])

	-- Componetes do menu que somente vão aparecer quando for indicado pelo modo MENU
	if bird.lock == 1 then
		-- Titulo FlappyBird
		engine.image.Draw(game.img.flaptitle, game.source, game.img.prop[game.img.flaptitle][1], (love.window.getWidth()/2)-(89/2), (love.window.getHeight()/2)-75, game.img.prop[game.img.flaptitle][2])
		-- Menu de inicio do jogo
		engine.image.Draw(game.img.start_bt, game.source, game.img.prop[game.img.start_bt][1], ((love.window.getWidth()/2)-26) - 32, (love.window.getHeight()/2)+40, game.img.prop[game.img.start_bt][2])
		-- Menu de Rank do jogo
		engine.image.Draw(game.img.rank_bt, game.source, game.img.prop[game.img.rank_bt][1], ((love.window.getWidth()/2)-26) + 32, (love.window.getHeight()/2)+40, game.img.prop[game.img.rank_bt][2])
		-- Menu de 'Rate' do jogo
		engine.image.Draw(game.img.rate_bt, game.source, game.img.prop[game.img.rate_bt][1], ((love.window.getWidth()/2)-15), (love.window.getHeight()/2), game.img.prop[game.img.rate_bt][2])
	end

	-- O 'bird' (SEMPRE NO FINAL DO DRAW)
	engine.image.Draw(game.img.bird, game.source, game.img.prop[game.img.bird][1], (love.window.getWidth()/2)-7, ((love.window.getHeight()/2)-40) + bird.vMove, game.img.prop[game.img.bird][2])
end

function love.load()
end

function love.update(dt)
	engine.bird.Frame(dt)		-- Cria movimentação da imagem da ave
	engine.bird.Move(dt) 		-- Cria movimentação vertical da ave
	engine.enviroment.Move(dt)  -- Cria movimento do ambiente

	engine.enviroment.ColisionCheck(dt, game.img.bird) -- Colisão do Bird
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