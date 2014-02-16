engine.bird = {}

function engine.bird.Config()
	bird = {}

	-- Informçaões do 'bird'
	bird.frame_c = 1 -- Indicador contagem do Frame
	bird.time = 0    -- Tempo de contagem dos Frames pelo update(dt)
	bird.frame = {{3, 491, 17, 12},
				  {31, 491, 17, 12},
				  {59, 491, 17, 12}} -- Informação de posição da imagem pelos 3 frames

	-- Array de informações para movimento do 'bird' no MENU
	bird.vMove_or = 0 -- Orientação do movimento 1 cima 0 baixo
	bird.vMove_time = 0 -- Tempo decorido entre os updates(dt)
	bird.vMove = 0 -- Quantidade de movimento Realizado (Usado tambem nas informações de Gravidade quando jogavel)

	-- Lock do movimento automatico ou do jogo
	-- Modos:
	-- -- 0 (Em Jogo)
	-- -- 1 (Movimento automatico [menu e espera])
	-- -- 2 (GameOver)
	bird.lock = 0

	-- Array de informações para gravidade do Movimento
	bird.gMove = {}
	bird.gMove.InMove = 0 -- Define se esta em movimento de subida ou nao
	bird.gMove.mTime = 0.0030 -- Tempo do Update
	bird.gMove.Time = 0 -- Tempo de contagem
	bird.gMove.gTime = 0 -- Tempo da Gravidade
	bird.gMove.Vend = 0 -- Velocidade Final
	bird.gMove.Vinit = 0 -- Velocidade Inicial
	bird.gMove.Rad = 0 -- Radianos

	bird.gMove.RadCalc = ((360-320)/(5/0.2)) -- Calculo do Raio de giro do Bird conciderando 5 movimento padrao
end

-- Cria movimentação da imagem do BIRD
function engine.bird.Frame(dt)
	if bird.time > 0.15 and bird.lock ~= 2 then -- Adicinando para não movimentar o frame quando der GameOver
		if bird.frame_c < 3 then
			bird.frame_c = bird.frame_c + 1
			engine.image.Edit(game.img.bird, bird.frame[bird.frame_c][1], bird.frame[bird.frame_c][2], bird.frame[bird.frame_c][3], bird.frame[bird.frame_c][4], game.res[1], game.res[2])
		else
			bird.frame_c = 1
			engine.image.Edit(game.img.bird, bird.frame[bird.frame_c][1], bird.frame[bird.frame_c][2], bird.frame[bird.frame_c][3], bird.frame[bird.frame_c][4], game.res[1], game.res[2])
		end

		bird.time = 0
	else
		bird.time = bird.time + dt
	end
end

-- Função de movimento do Bird
-- Dependente do tipo da variavel bird.lock
-- em seus 3 modos:
-- -- 0 (Em Jogo)
-- -- 1 (Movimento automatico [menu e espera])
-- -- 2 (GameOver)

function engine.bird.Move(dt) 
-- Não sera explicado oque acontece nesse trecho de codigo por ser mais complexo
-- Então caso haja necessidade entre em contato com pelo email dos Devs ou pelo live4lua
-- Nota do DEV: Deixo bem claro que tudo que foi feito fora de padão('logico') nesse trecho teve com a
-- 				funcionalidade de melhoria do jogo, em aspectos de velocidade e outros.
	if bird.lock == 1 then
		if bird.vMove_time > 0.015 then
			if bird.vMove_or == 0 then
				if bird.vMove >= -2.2 and bird.vMove <= 2 then
					bird.vMove = bird.vMove + 0.2

					if bird.vMove >= 2 then
						bird.vMove_or = 1
					end
				end
			elseif bird.vMove_or == 1 then
				if bird.vMove >= -2 and bird.vMove <= 2.2 then
					bird.vMove = bird.vMove - 0.2

					if bird.vMove <= -2 then
						bird.vMove_or = 0
					end
				end
			end

			bird.vMove_time = 0
		else
			bird.vMove_time = bird.vMove_time + dt
		end
	elseif bird.lock == 0 then
		if bird.gMove.InMove == 1 then
			if bird.gMove.Time > bird.gMove.mTime then
				bird.gMove.gTime = bird.gMove.gTime + bird.gMove.Time
				bird.gMove.Vend = (bird.gMove.Vinit - ((GAME_GRAVITY/2)*bird.gMove.gTime))/2
				bird.vMove = bird.vMove - bird.gMove.Vend

				if bird.gMove.Rad <= 91 or bird.gMove.Rad >= 330 then
					if bird.gMove.Rad <= 0 then bird.gMove.Rad = 360 end
					bird.gMove.Rad = bird.gMove.Rad - 0.8
					engine.image.RadEdit(game.img.bird, bird.gMove.Rad)
				end
				
				if bird.gMove.Vend <= 0 then	
					bird.gMove.InMove = 0
					bird.gMove.gTime = 0
					engine.image.RadEdit(game.img.bird, bird.gMove.Rad)
				end
			else
				bird.gMove.Time = bird.gMove.Time + dt
			end
		elseif bird.gMove.InMove == 0 then
			if bird.gMove.Time > bird.gMove.mTime then
				bird.gMove.gTime = bird.gMove.gTime + bird.gMove.Time
				bird.vMove = bird.vMove + ((GAME_GRAVITY/14)*bird.gMove.gTime)

				if bird.gMove.Rad <= 90 or bird.gMove.Rad >= 320 then
					if bird.gMove.Rad >= 360 then bird.gMove.Rad = 0  end
					bird.gMove.Rad = bird.gMove.Rad + 0.3
					engine.image.RadEdit(game.img.bird, bird.gMove.Rad)
				end

				bird.gMove.Time = 0
			else
				bird.gMove.Time = bird.gMove.Time + dt
			end
		end	
	end
end

-- Callback utilizado para gerar movimento no 'bird'

function engine.bird.MoveAdd(addMove)

	bird.gMove.gTime = 0 -- Tempo da Gravidade
	bird.gMove.Vend = 0 -- Dist Final
	bird.gMove.Vinit = addMove -- Velocidade Inicial

	bird.gMove.InMove = 1 -- Define que ha movimento sendo realizado
end