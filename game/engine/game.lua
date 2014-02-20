engine.game = {}

function engine.game.Config()
	eGame = {}

	eGame.points = 0 -- Pontos iniciados pelo jogo

	eGame.tubes = {}
	eGame.tubes.x = {144, 144+70, 144+140}
	eGame.tubes.y = {math.random(0, 100), math.random(0, 100), math.random(0, 100)}
	eGame.tubes.pos = {((love.window.getWidth()/2) - (26/2)) + eGame.tubes.x[1], ((love.window.getWidth()/2) - (26/2)) + eGame.tubes.x[2], ((love.window.getWidth()/2) - (26/2)) + eGame.tubes.x[3]}
end

function engine.game.GameOver()
	bird.lock = 2
	eGame.points = 0
	print("Game Over")
end

function engine.game.GivePoint()
	eGame.points = eGame.points + 1
end

function engine.game.tubesColision()
	for i=1,3 do
		for j=1,2 do
			engine.enviroment.createColisionArea(game.img.tube[i][j], "GameOver") -- Cria colisão dos tubos
		end
	end
end

function engine.game.tubesRepos(dt)
	if eGame.tubes.pos[1] < -12 then
		eGame.tubes.y[1] = math.random(0, 100)

		if eGame.tubes.pos[2] > eGame.tubes.pos[3] then
			eGame.tubes.pos[1] = eGame.tubes.pos[2] + 80
		else
			eGame.tubes.pos[1] = eGame.tubes.pos[3] + 80
		end
	end

	if eGame.tubes.pos[2] < -12 then
		eGame.tubes.y[2] = math.random(0, 100)

		if eGame.tubes.pos[1] > eGame.tubes.pos[3] then
			eGame.tubes.pos[2] = eGame.tubes.pos[1] + 80
		else
			eGame.tubes.pos[2] = eGame.tubes.pos[3] + 80
		end
	end

	if eGame.tubes.pos[3] < -12 then
		eGame.tubes.y[3] = math.random(0, 100)

		if eGame.tubes.pos[1] > eGame.tubes.pos[2] then
			eGame.tubes.pos[3] = eGame.tubes.pos[1] + 80
		else
			eGame.tubes.pos[3] = eGame.tubes.pos[2] + 80
		end
	end
end