engine.image = {}

function engine.image.Config()
	game.img = {}
	game.img.prop = {} -- Propiedade das imagens
	game.img.prop_c = 0 -- Contador

	game.img.fade = {} -- {ObjectID, Fade, Mode} 
	game.img.fade[0] = 1 -- Contador dos fades
	game.img.fade.cTime = 0 -- Contagem do tempo de update
	game.img.fade.time = 0.015 -- Tempo de update
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
										0,           -- Time da IMG 
										0,           -- X
										0,           -- Y
										mx,          -- Max X
										my,          -- Max Y
										100          -- Fade
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

	love.graphics.setColor(255, 255, 255, 2.55*game.img.prop[id][8])
	love.graphics.draw(game.source, game.img.prop[id][1], x, y, game.img.prop[id][2])
end

-- Função para editar a parte da quadrangulação da imagem pela source
-- de imagem geral do game
function engine.image.Edit(id, sx, sy, mx, my, resWidth, resHight)
	game.img.prop[id][1] = love.graphics.newQuad(sx, sy, mx, my, resWidth, resHight)
end

-- Função para editar a rotação do objeto
function engine.image.RadEdit(id, rad)
	game.img.prop[id][2] = math.rad(rad)
end

-- Função de fade para objeto
function engine.image.fade(dt)
	if game.img.fade.cTime >= game.img.fade.time then
		for i=1,game.img.fade[0] do
			if game.img.fade[i] ~= nil then
				if game.img.fade[i][3] == "In" then
					if game.img.prop[game.img.fade[i][1]][8] < game.img.fade[i][2] then
						print("Object FadeIN", game.img.prop[game.img.fade[i][1]][8], "<", game.img.fade[i][2], game.img.prop[game.img.fade[i][1]][8] < game.img.fade[i][2]) -- DEBUG
						game.img.prop[game.img.fade[i][1]][8] = game.img.prop[game.img.fade[i][1]][8] + 1
					else
						game.img.fade[i] = nil
					end
				elseif game.img.fade[i][3] == "Out" then
					if game.img.prop[game.img.fade[i][1]][8] > game.img.fade[i][2] then
						print("Object FadeOut:", game.img.prop[game.img.fade[i][1]][8], ">", game.img.fade[i][2], game.img.prop[game.img.fade[i][1]][8] > game.img.fade[i][2]) -- DEBUG
						game.img.prop[game.img.fade[i][1]][8] = game.img.prop[game.img.fade[i][1]][8] - 1
					else
						game.img.fade[i] = nil
					end
				end
			end
		end

		game.img.fade.cTime = 0
	else
		game.img.fade.cTime = game.img.fade.cTime + dt
	end
end

function engine.image.fadeIn(objectID, fade)
	local fade_c

	for i=1,game.img.fade[0] do
		if game.img.fade[i] == nil then
			fade_c = i
		elseif game.img.fade[0] == i then
			game.img.fade[0] = game.img.fade[0] + 1
			fade_c = game.img.fade[0]
		end

		game.img.fade[fade_c] = {objectID, fade, "In"}
	end
end

function engine.image.fadeOut(objectID, fade)
	local fade_c

	for i=1,game.img.fade[0] do
		if game.img.fade[i] == nil then
			fade_c = i
		elseif game.img.fade[0] == i then
			game.img.fade[0] = game.img.fade[0] + 1
			fade_c = game.img.fade[0]
		end

		game.img.fade[fade_c] = {objectID, fade, "Out"}
	end
end

