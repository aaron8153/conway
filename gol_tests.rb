require 'rspec'
require_relative 'gol.rb'

describe 'Game of Life' do

	#game obj to be used in tests will init with 10x10 grid
	let!(:game) { Game.new }

	context 'Game' do
		subject { Game.new }
		
		it 'should create a new game obj' do
			subject.is_a?(Game).should be_true
		end

		it 'should be able to access row method' do
			subject.should respond_to(:rows)
		end

		it 'should be able to access col method' do
			subject.should respond_to(:cols)
		end

		it 'should be able to access board method' do
			subject.should respond_to(:board)
		end

		it 'should be able to access cells method' do
			subject.should respond_to(:cells)
		end

		it 'should be able to access num_neighbours method' do
			subject.should respond_to(:num_neighbours)
		end

		it 'should detect a neighbour (-1, -1)' do
			subject.board[0][0].living = true
			subject.board[0][0].should be_living
			subject.num_neighbours(subject.board[1][1]).should == 1
		end
		it 'should detect a neighbour (-1, 0)' do
			subject.board[0][1].living = true
			subject.board[0][1].should be_living
			subject.num_neighbours(subject.board[1][1]).should == 1
		end
		it 'should detect a neighbour (-1, +1)' do
			subject.board[0][2].living = true
			subject.board[0][2].should be_living
			subject.num_neighbours(subject.board[1][1]).should == 1
		end
		it 'should detect a neighbour (0, -1)' do
			subject.board[1][0].living = true
			subject.board[1][0].should be_living
			subject.num_neighbours(subject.board[1][1]).should == 1
		end
		it 'should detect a neighbour (0, +1)' do
			subject.board[1][2].living = true
			subject.board[1][2].should be_living
			subject.num_neighbours(subject.board[1][1]).should == 1
		end
		it 'should detect a neighbour (+1, -1)' do
			subject.board[2][0].living = true
			subject.board[2][0].should be_living
			subject.num_neighbours(subject.board[1][1]).should == 1
		end
		it 'should detect a neighbour (+1, 0)' do
			subject.board[2][1].living = true
			subject.board[2][1].should be_living
			subject.num_neighbours(subject.board[1][1]).should == 1
		end
		it 'should detect a neighbour (+1, +1)' do
			subject.board[2][2].living = true
			subject.board[2][2].should be_living
			subject.num_neighbours(subject.board[1][1]).should == 1
		end
		it 'should detect all neighbours at once' do
			subject.board[0][0].living = true
			subject.board[0][1].living = true
			subject.board[0][2].living = true
			subject.board[1][0].living = true
			subject.board[1][2].living = true
			subject.board[2][0].living = true
			subject.board[2][1].living = true
			subject.board[2][2].living = true

			subject.num_neighbours(subject.board[1][1]).should == 8
		end
		it 'should detect 3' do
			subject.board[0][0].living = true
			subject.board[0][1].living = true
			subject.board[0][2].living = true

			subject.num_neighbours(subject.board[1][1]).should == 3
		end
		it 'should detect 3 the other way' do
			subject.board[0][0].living = true
			subject.board[1][0].living = true
			subject.board[2][0].living = true

			subject.board[1-1][1-1].should be_living
			subject.board[1][1-1].should be_living
			subject.board[1+1][1-1].should be_living

			subject.num_neighbours(subject.board[1][1]).should == 3

		end

		it 'should make a grid - Array(Array())' do
			subject.board.is_a?(Array).should be_true

			subject.board.each do |row|
				row.is_a?(Array).should be_true
				row.each do |col|
					col.is_a?(Cell).should be_true
				end
			end
		end

	end

	context 'Cell' do
		subject { Cell.new }
		
		it 'should create a new cell obj' do
			subject.is_a?(Cell).should be_true
		end

		it 'should be able to access x method' do
			subject.should respond_to(:x)
		end

		it 'should be able to access y method' do
			subject.should respond_to(:y)
		end

		it 'should be able to access living method' do
			subject.should respond_to(:living)
		end

		it 'should be able to access will_live method' do
			subject.should respond_to(:will_live)
		end

		it 'should initialize will_live to false' do
			subject.will_live.should be_false
		end

		it 'should be able to access living? method' do
			subject.should respond_to(:living?)
		end	

		it 'should be able to access dead? method' do
			subject.should respond_to(:dead?)
		end	

		it 'should be able to access kill! method' do
			subject.should respond_to(:kill!)
		end

		it 'should be able to access living? method' do
			subject.should respond_to(:resurect!)
		end

		it 'should be able to access to_str method' do
			subject.should respond_to(:to_str)
		end

		it 'should make a dead cell' do
			subject.living.should be_false
		end	

		it 'should initialize properly' do
			subject.x.should == 0
			subject.y.should == 0
		end	
	end

	context 'Sim' do
		subject { Sim.new }
		
		it 'should create a new cell obj' do
			subject.is_a?(Sim).should be_true
		end

		it 'should be able to access game method' do
			subject.should respond_to(:game)
		end

		it 'should be able to access init_cells method' do
			subject.should respond_to(:init_cells)
		end

		it 'should be able to access print! method' do
			subject.should respond_to(:print!)
		end

		it 'should initialize properly' do
			subject.game.is_a?(Game).should be_true
			subject.init_cells.is_a?(Array).should be_true
		end

		it 'should be initialized with cells that are living' do
			#assuming a 10x10 grid, 0 = dead, 1 = living
			cells = [[0,1,0,0,0,0,0,0,0,0],
					 [0,1,0,1,1,1,0,0,0,0],
					 [0,1,0,0,0,0,0,0,0,0],
					 [0,0,0,0,0,0,0,0,0,0],
					 [0,0,0,0,0,0,0,0,0,0],
					 [0,0,0,0,0,0,0,0,0,0],
					 [0,0,0,0,0,0,0,0,0,0],
					 [0,0,0,0,0,0,0,0,0,0],
					 [0,0,0,0,0,0,0,0,0,0],
					 [0,0,0,0,0,0,0,0,0,0]]
			sim = Sim.new(game, cells)
			game.board[0][1].should be_living
			game.board[1][1].should be_living
			game.board[2][1].should be_living

			game.board[1][3].should be_living
			game.board[1][4].should be_living
			game.board[1][5].should be_living
		end
	end

	context 'Rules' do
		let!(:sim) { Sim.new }
		
		context 'Any live cell with fewer than two live neighbours dies, as if caused by under-population.' do
    		it 'should die with < 2 neighbours' do
    			#this will test cells with 0, and 1 neighbors
    			cells = [[1,0,1,1,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0]]
				sim = Sim.new(game, cells)
				sim.step!
				game.board[0][0].should be_dead
				game.board[0][2].should be_dead
				game.board[0][3].should be_dead
    		end
    	end
    	context 'Any live cell with two or three live neighbours lives on to the next generation.' do
    		it 'should live if it has 2 or 3 neighbours' do
    			#this will test cells with 2 or 3 neighbors
    			cells = [[1,1,1,0,0,0,0,0,0,0],
						 [0,1,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0]]
				sim = Sim.new(game, cells)
				sim.step!
				game.board[0][0].should be_living
				game.board[0][1].should be_living
				game.board[0][2].should be_living
				game.board[1][1].should be_living
    		end
    	end
    	context 'Any live cell with more than three live neighbours dies, as if by overcrowding.' do
    		it 'should die with > 3 neighbours' do
    			#this will test cells with 4 and 5 neighbors
    			cells = [[1,1,0,0,0,0,0,0,0,0],
						 [1,1,1,0,0,0,0,0,0,0],
						 [0,1,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0]]
				sim = Sim.new(game, cells)
				sim.step!
				game.board[1][1].should be_dead
				game.board[1][0].should be_dead
    		end
    	end
    	context 'Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.' do
    		it 'should re-animate with exactly 3 neighbours' do
    			#this will test multiple ways to have 3 neighbors
    			cells = [[1,1,0,1,0,0,0,0,0,0],
						 [1,0,0,0,0,0,1,0,1,0],
						 [0,0,0,1,0,1,0,1,0,0],
						 [1,0,0,0,0,0,0,0,0,0],
						 [1,0,0,0,0,0,0,0,0,0],
						 [1,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0],
						 [0,0,0,0,0,0,0,0,0,0]]
				sim = Sim.new(game, cells)
				sim.step!
				game.board[1][1].should be_living
				game.board[1][4].should be_living
				game.board[1][7].should be_living
				game.board[4][1].should be_living
    		end
    	end
	end

	context 'Pkay' do
		subject { Play.new }
		
		it 'should create a new play obj' do
			subject.is_a?(Play).should be_true
		end
		it 'should be able to access sim method' do
			subject.should respond_to(:sim)
		end
		it 'should be able to access steps method' do
			subject.should respond_to(:steps)
		end
		it 'should be able to access go! method' do
			subject.should respond_to(:go!)
		end
	end
	context 'RandomGame' do
		subject { RandomGame.new }
		
		it 'should create a new RandomGame obj' do
			subject.is_a?(RandomGame).should be_true
		end
		it 'should be able to access cols method' do
			subject.should respond_to(:cols)
		end
		it 'should be able to access cols method' do
			subject.should respond_to(:rows)
		end
		it 'should be able to access seed method' do
			subject.should respond_to(:seed)
		end
		it 'should be able to access steps method' do
			subject.should respond_to(:steps)
		end
		it 'should be able to respond to choose method' do
			subject.should respond_to(:choose)
		end
	end
end















