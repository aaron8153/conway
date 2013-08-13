class Game
	attr_accessor :rows, :cols, :board, :cells
	
	def initialize(rows=10, cols=10)
		@rows = rows
		@cols = cols
		@cells = []

		@board = Array.new(rows) do |row|
					Array.new(cols) do |col|
						Cell.new(col, row)
					end
				end
	end

	def num_neighbours(cell)
		neighbours = 0
		# NW
		if cell.y > 0 && cell.x > 0
			if self.board[cell.y - 1][cell.x - 1].living?
				neighbours += 1
			end
		end
		# N
		if cell.y > 0
			if self.board[cell.y - 1][cell.x].living?
				neighbours += 1
			end
		end
		# NE
		if cell.y > 0 && cell.x < ( cols - 1 )
			if self.board[cell.y - 1][cell.x + 1].living?
				neighbours += 1
			end
		end
		# W
		if cell.x > 0
			if self.board[cell.y][cell.x - 1].living?
				neighbours += 1
			end
		end
		# E
		if cell.x < ( cols - 1 )
			if self.board[cell.y][cell.x + 1].living?
				neighbours += 1
			end
		end
		# SW
		if cell.y < ( rows - 1 ) && cell.x > 0
			if self.board[cell.y + 1][cell.x - 1].living?
				neighbours += 1
			end
		end
		# S
		if cell.y < ( rows - 1 )
			if self.board[cell.y + 1][cell.x].living?
				neighbours += 1
			end
		end
		# SE
		if cell.y < ( rows - 1 ) && cell.x < ( cols - 1 )
			if self.board[cell.y + 1][cell.x + 1].living?
				neighbours += 1
			end
		end
		neighbours
	end

end

class Cell
	attr_accessor :x, :y, :living, :will_live
	
	def initialize(x=0, y=0)	
		@x = x
		@y = y
		@living = false
		@will_live = false
	end

	def living?
		living
	end

	def dead?
		!living
	end

	def kill!
		@living = false
	end

	def resurect!
		@living = true
	end

	def to_str
		if living
			'o'
		else
			'-'
		end
	end
end

class Sim
	attr_accessor :game, :init_cells

	def initialize(game=Game.new, init_cells=[])
		@game = game
		@init_cells = init_cells

		init_cells.each_with_index do |r, row|
			r.each_with_index do |c, col|
				if init_cells[col][row] == 1 
					game.board[col][row].living = true
				end
			end
		end
	end

	def step!
		game.board.each do |row|
			row.each do |cell|
				#Rule 1
				if cell.living? and game.num_neighbours(cell) < 2
					cell.will_live = false
				end
				#Rule 2
				if cell.living? and ([2, 3].include? game.num_neighbours(cell))
					cell.will_live = true
				end
				#Rule 3
				if cell.living? and game.num_neighbours(cell) > 3
					cell.will_live = false
				end
				#Rule 4
				if cell.dead? and game.num_neighbours(cell) == 3
					cell.will_live = true
				end
			end
		end
		game.board.each do |row|
			row.each do |cell|
				if cell.will_live == true
					cell.resurect!
					cell.will_live = false
				else
					cell.kill!
				end
			end
		end
	end

	def print!
		out = ""
		game.board.each do |row|
			row.each do |cell|
				out += cell.to_str
			end
			puts out
			out = ""
		end
	end
end

class Play
	attr_accessor :sim, :steps

	def initialize(sim=Sim.new, steps=100)
		@sim = sim
		@steps = steps
	end

	def go!
		(1..steps).each do
			system('clear')
			sim.print!
			sim.step!
			sleep(0.2)
		end
	end
end

class RandomGame
	attr_accessor :cols, :rows, :seed, :steps
	def initialize(cols=25, rows=25, seed=30, steps=100)
		@rows = rows
		@cols = cols
		@seed = seed
		@steps = steps
		
		game = Game.new(rows, cols)
		cells = Array.new(rows) do |row|
					Array.new(cols) do |col|
						if choose
							1
						else
							0
						end
					end
				end
		sim = Sim.new(game, cells)
		play = Play.new(sim, steps)
		play.go!
	end

	def choose
  		rand() <= seed/100.0
	end
end

#Cols, Rows, Seed (out of 100), steps to show
randomgame = RandomGame.new(50,50,30,400)

#game = Game.new(25,25)
#cells = [[0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#		 [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#		 [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#		 [0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0],
#		 [0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0],
#		 [0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0],
#		 [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#		 [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#		 [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#		 [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#		 [0,1,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#		 [0,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#		 [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0],
#		 [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0],
#		 [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0],
#		 [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#		 [0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#		 [0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#		 [0,0,0,1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0],
#		 [0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0],
#		 [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0],
#		 [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0],
#		 [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0],
#		 [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
#		 [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]]
#sim = Sim.new(game, cells)
#play = Play.new(sim, 300)
#play.go!








