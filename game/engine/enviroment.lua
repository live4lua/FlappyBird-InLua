engine.enviroment = {}

function engine.enviroment.Config()
	move = {}
	move.footer = 0
	move.time = 0
	move.act = 0.035
end

function engine.enviroment.Move(dt)
	if move.time > move.act then
		if move.footer > 0 then
			move.footer = move.footer - 1
		else
			move.footer = 10
		end

		move.time = 0
	else
		move.time = move.time + dt
	end
end