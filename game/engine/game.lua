engine.game = {}

function engine.game.Config()
	eGame = {}

	eGame.points = 0 -- Pontos iniciados pelo jogo
end

function engine.game.GameOver()
	bird.lock = 2
	eGame.points = 0
end

function engine.game.GivePoint()
	eGame.points = eGame.points + 1
end