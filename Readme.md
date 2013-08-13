## Conway's Game of Life
## Author - Aaron Jacobs
## Email - aaron8153@gmail.com

Installation
Download all files from GitHub.
Run bundle

Testing

Run -

	rspec gol_tests.rb
	
	This will test all classes and methods.  RandomGame is called a few times at the end, so a few simulations will run.
    
Playing a Random Game of Your Own

Run -

	ruby gol.rb

	This will create a game with 25x25 and 30% random seed with 100 steps being shown.

	To customize this: edit line 214

Playing a Specific Game of Your Own
	Uncomment lines 216-244, use the cell grid provided to enter in your own pattern.
	Run -
	ruby gol.rb