engine.enviroment = {}

function engine.enviroment.Config()
	game.move = {}
	game.move.footer = 0
	game.move.time = 0
	game.move.act = 0.035

	game.colision = {}
	game.colision[0] = 0
	game.colision.ActiveDefault = 0
	game.colision.Start = true
	game.colision.Time = 0
end

-- Função para movimento da Ambientação do jogo
function engine.enviroment.Move(dt)
	if game.move.time > game.move.act and bird.lock ~= 2 then
		if game.move.footer > 0 then
			game.move.footer = game.move.footer - 1

			eGame.tubes.pos[1] = eGame.tubes.pos[1] - 1
			eGame.tubes.pos[2] = eGame.tubes.pos[2] - 1
			eGame.tubes.pos[3] = eGame.tubes.pos[3] - 1
		else
			game.move.footer = 10
		end

		game.move.time = 0
	else
		game.move.time = game.move.time + dt
	end
end

-- Função de colisão do ambiente
-- Retorna TRUE se o objeto (PX, PY) estiver na area (X, Y <> MX, MY) 
function engine.enviroment.Colision(px, py, x, y, mx, my)
	mx = x + mx
	my = y + my

	if px >= x and px <= mx then
		if py >= y and py <= my then
			return true
		end
	end

	return false
end

-- Função que cria campo de colisao
-- ObjectID referente ao ID da imagem
-- callback ref a função realizada quando atinge o a area
-- -- Lista de callback's (Ainda não oficial)
-- -- -- GameOver
-- -- -- GivePoint
-- Retorno o ID da Area colisão
function engine.enviroment.createColisionArea(objectID, callback)
	game.colision[0] = game.colision[0] + 1

	game.colision[game.colision[0]] = {
										objectID,
										callback,
										game.colision.ActiveDefault, -- Se o Colision esta ativo. Por default não!
										game.img.prop[objectID][4], -- X
										game.img.prop[objectID][5], -- Y
										game.img.prop[objectID][6], -- MX
										game.img.prop[objectID][7] -- MY
									  }
	return game.colision[0]
end

-- Função que faz a verificação se Obejeto determinado não esta incidindo
-- na area de uma das colisoes, assim chamando um certo CallBack ja defi-
-- nido quando a area de colisão foi criada.
function engine.enviroment.ColisionCheck(dt, objectID)
	if game.colision.Start then
		if game.colision.Time > 0.008 then
			if game.colision[0] > 0 then
				for i=1,game.colision[0] do
					local local_colision = {
											engine.enviroment.Colision(game.img.prop[objectID][4], game.img.prop[objectID][5], game.colision[i][4], game.colision[i][5], game.colision[i][6], game.colision[i][7]),
											engine.enviroment.Colision(game.img.prop[objectID][4], game.img.prop[objectID][5]+game.img.prop[objectID][7], game.colision[i][4], game.colision[i][5], game.colision[i][6], game.colision[i][7]),
											engine.enviroment.Colision(game.img.prop[objectID][4]+game.img.prop[objectID][6], game.img.prop[objectID][5], game.colision[i][4], game.colision[i][5], game.colision[i][6], game.colision[i][7]),
											engine.enviroment.Colision(game.img.prop[objectID][4]+game.img.prop[objectID][6], game.img.prop[objectID][5]+game.img.prop[objectID][7], game.colision[i][4], game.colision[i][5], game.colision[i][6], game.colision[i][7])
										   }

					if local_colision[1] or local_colision[2] or local_colision[3] or local_colision[4] then
						if game.colision[i][2] == "GameOver" then
							engine.game.GameOver()
						elseif game.colision[i][2] == "GivePoint" then
							engine.game.GivePoint()
						end
					end
				end
			end
		else
			game.colision.Time = game.colision.Time + dt
		end
	end
end

-- Função de que edita a area de colisão de um definido Objeto
function engine.enviroment.editColision(objectID, x, y)
	local colisionID = nil

	for i=1,game.colision[0] do
		if objectID == game.colision[i][1] then
			colisionID = i
		end
	end

	game.colision[colisionID][4] = x
	game.colision[colisionID][5] = y
end

-- Função para verificação de existencia de uma colisão pelo Objeto determiado
function engine.enviroment.existColision(objectID)
	if game.colision[0] > 0 then
		for i=1,game.colision[0] do
			if objectID == game.colision[i][1] then
				return true
			end
		end
	end

	return false
end
