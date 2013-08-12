class Game
	attr_accessor :rows, :cols, :board
	
	def initialize(rows=10, cols=10)
		@rows = rows
		@cols = cols

		@board = Array.new(rows) do |row|
					Array.new(cols)  do |col|
						Cell.new(row, col)
					end
				end
	end

	def num_neighbours(cell)
		neighbours = 0
		# y, x
		#-1,-1 NW - not at left or top
		if cell.x > 0 && cell.y > 0
			if self.board[cell.x - 1][cell.y - 1].living?
				neighbours += 1
			end
		end
		#-1,0 N - not at top
		if cell.x > 0
			if self.board[cell.x - 1][cell.y].living?
				neighbours += 1
			end
		end
		#-1,+1 NE - not at top or right
		if cell.x > 0 && cell.y < ( cols - 1 )
			if self.board[cell.x - 1][cell.y + 1].living?
				neighbours += 1
			end
		end
		#0,-1 W - not at left
		if cell.y > 0
			if self.board[cell.x][cell.y - 1].living?
				neighbours += 1
			end
		end
		#0,+1 E - not at right
		if cell.y < ( cols - 1 )
			if self.board[cell.x][cell.y + 1].living?
				neighbours += 1
			end
		end
		#+1,-1 SW - not at left or bottom
		if cell.x > 0 && cell.x < ( rows - 1 )
			if self.board[cell.x + 1][cell.y - 1].living?
				neighbours += 1
			end
		end
		#+1,0 S - not at bottom
		if cell.x < ( rows - 1 )
			if self.board[cell.x + 1][cell.y].living?
				neighbours += 1
			end
		end
		#+1,+1 SE - not at bottom or right
		if cell.x < ( rows - 1 ) && cell.y < ( cols - 1 )
			if self.board[cell.x + 1][cell.y + 1].living?
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
		@y = x
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
end

class Sim
	attr_accessor :game, :init_cells

	def initialize(game=Game.new, init_cells=[])
		@game = game
		@init_cells = init_cells

		init_cells.each_with_index do |r, row|
			r.each_with_index do |c, col|
				if init_cells[row][col] == 1 
					game.board[row][col].living = true
				end
			end
		end
	end

	def step!
		game.board.each do |row|
			row.each do |cell|
				#Rule 1
				if cell.living? && game.num_neighbours(cell) < 2
					cell.will_live = false
				end
				#Rule 2
				if cell.living? && ([2, 3].include? game.num_neighbours(cell))
					cell.will_live = true
				end
				#Rule 3
				if cell.living? && game.num_neighbours(cell) > 3
					cell.will_live = false
				end
				#Rule 4
				if cell.dead? && game.num_neighbours(cell) == 3
					cell.will_live = true
				end
			end
		end
		game.board.each do |row|
			row.each do |cell|
				cell.living = cell.will_live
			end
		end
	end
end









