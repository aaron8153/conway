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

end

class Cell
	attr_accessor :x, :y, :living
	
	def initialize(x, y)	
		@x = x
		@y = x
		@living = false
	end
end