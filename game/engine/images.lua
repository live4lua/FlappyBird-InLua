engine.image = {}

function engine.image.Config()
	game.img = {}
	game.img.prop = {} -- Propiedade das imagens
	game.img.prop_c = 0 -- Contador
end

function engine.image.Create(sx, sy, mx, my, resWidth, resHight)
	game.img.prop_c = game.img.prop_c + 1

	game.img.prop[game.img.prop_c] = {
										love.graphics.newQuad(sx, sy, mx, my, resWidth, resHight),
										math.rad(0), -- Rotação
										0, -- Time da IMG 
										0, -- X
										0, -- Y
										mx, -- Max X
										my, -- Max Y
									  }

	return game.img.prop_c
end

function engine.image.Draw(id, image, quad, x, y, r)
	game.img.prop[id][2] = r
	game.img.prop[id][4] = x
	game.img.prop[id][5] = y

	love.graphics.draw(game.source, game.img.prop[id][1], x, y, game.img.prop[id][2])
end

function engine.image.Edit(id, sx, sy, mx, my, resWidth, resHight)
	game.img.prop[id][1] = love.graphics.newQuad(sx, sy, mx, my, resWidth, resHight)
end

function engine.image.RadEdit(id, rad)
	game.img.prop[id][2] = math.rad(rad)
end