require './lib/player'
require './lib/board'
require './lib/cell'
require './lib/ship'


RSpec.describe Player do
    before :each do
      @board = Board.new
      @player = Player.new("Player 1", @board)
    end
  
    describe '#initialize' do
        it 'exists and has attributes' do
            expect(@player).to be_a(Player)
            expect(@player.name).to eq("Player 1")
            expect(@player.board).to eq(@board)
            expect(@player.previous_shots).to eq([])
        end
    end
  
    describe '#choose_coordinate' do
        it 'prompts the player to enter a valid coordinate' do
        # Use the request_coordinate method with a valid input
            expect(@player.request_coordinate("A1")).to eq("A1")
            expect(@player.choose_coordinate).to eq("A1")
        end
  
        xit 're-prompts if the coordinate has already been fired upon' do
            # Simulate firing on "A1" and then choose "B2"
            @player.previous_shots << "A1"
            expect(@player.request_coordinate("B2")).to eq("B2")
            expect(@player.choose_coordinate).to eq("B2")
        end
  
        it 're-prompts if the player enters an invalid coordinate' do
            # Pass an invalid coordinate, then a valid one
            expect(@player.request_coordinate("Z9")).to eq("Z9") # invalid
            expect(@player.request_coordinate("A2")).to eq("A2") # valid
        end
    end
  
    describe '#fire_at_coordinate' do
        it 'returns a result message for the shot outcome' do
            opponent_board = Board.new
            expect(opponent_board.fire_upon("A1")).to eq("H")
            expect(@player.fire_at_coordinate("A1", opponent_board)).to eq("Player 1's shot on A1 was a hit.")
        end
    end
  
    describe '#is_a_valid_coordinate?' do
        xit 'returns true if the coordinate is valid and has not been fired upon' do
            expect(@player.is_a_valid_coordinate?("A1")).to be true
        end
  
        xit 'returns false if the coordinate has already been fired upon' do
            @player.previous_shots << "A1"  # Simulate previous fire on "A1"
            expect(@player.is_a_valid_coordinate?("A1")).to be false
        end
    end
  
    describe '#has_already_fired_upon?' do
        xit 'returns true if the coordinate has been fired upon' do
            @player.previous_shots << "A1"  # Add "A1" to previous shots
            expect(@player.has_already_fired_upon?("A1")).to be true
        end
  
        xit 'returns false if the coordinate has not been fired upon' do
            expect(@player.has_already_fired_upon?("B2")).to be false
        end
    end
end