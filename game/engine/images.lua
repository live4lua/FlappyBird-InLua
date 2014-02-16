engine.image = {}

function engine.image.Config()
	game.img = {}
	game.img.prop = {} -- Propiedade das imagens
	game.img.prop_c = 0 -- Contador
end

-- Função utilizada para armazenar e criar as informações das imagens
-- onde apartir daqui devem ser compreendidas como OBJETOS. Assim to-
-- da e qualquer imagem exemplificada nesse codigo começa a ser expl-
-- icada como OBJETO.

function engine.image.Create(sx, sy, mx, my, resWidth, resHight)
	game.img.prop_c = game.img.prop_c + 1

	game.img.prop[game.img.prop_c] = {
										love.graphics.newQuad(sx, sy, mx, my, resWidth, resHight),
										math.rad(0), -- Rotação
										0, -- Time da IMG 
										0, -- X
										0, -- Y
										mx, -- Max X
										my -- Max Y
									  }

	return game.img.prop_c
end

-- Função para Armazenar novos valores de rotação e posição com que
-- imprime a imagem utilizando o love2d. Assim ele tambem tem como 
-- a parte de atualizar as informações de colisão do objeto caso o
-- mesmo objeto exista nas definiçoes de colisão

function engine.image.Draw(id, image, quad, x, y, r)
	game.img.prop[id][2] = r
	game.img.prop[id][4] = x
	game.img.prop[id][5] = y

	if engine.enviroment.existColision(id) then
		engine.enviroment.editColision(id, x, y)
	end


	love.graphics.draw(game.source, game.img.prop[id][1], x, y, game.img.prop[id][2])
end

-- Função para editar a parte da quadrangulação da imagem pela source
-- de imagem geral do game
function engine.image.Edit(id, sx, sy, mx, my, resWidth, resHight)
	game.img.prop[id][1] = love.graphics.newQuad(sx, sy, mx, my, resWidth, resHight)
end

-- Função para editar a rotação da imagem
function engine.image.RadEdit(id, rad)
	game.img.prop[id][2] = math.rad(rad)
end