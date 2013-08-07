require 'rspec'
require_relative 'gol.rb'

describe 'Game of Life' do
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

		it 'should make a dead cell' do
			subject.living.should be_false
		end	

		

	end
end