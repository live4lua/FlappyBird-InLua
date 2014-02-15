engine.enviroment = {}

function engine.enviroment.Config()
	game.move = {}
	game.move.footer = 0
	game.move.time = 0
	game.move.act = 0.035

	game.colision = {}
	game.colision.ActiveDefault = 0
end

-- Função para movimento da Ambientação
function engine.enviroment.Move(dt)
	if game.move.time > game.move.act then
		if game.move.footer > 0 then
			game.move.footer = game.move.footer - 1
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
-- -- -- WinPoint
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
										game.img.prop[objectID][7], -- MY
									  }
	return game.colision[0]
end