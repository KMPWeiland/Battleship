require 'rspec'
require 'pry'
require './lib/turn'
require './lib/player'
require './lib/board'
require './lib/cell'
require './lib/ship'

RSpec.describe Turn do
    before :each do
        # Set up the game boards and players
        @player_board = Board.new
        @computer_board = Board.new
        @player = Player.new("Player 1", @player_board)
        @computer = Player.new("Computer", @computer_board)
        @turn = Turn.new(@player, @computer, @player_board, @computer_board)

        # Places ships on boards for consistent results in shots
        @player_ship = Ship.new("Cruiser", 3)
        @computer_ship = Ship.new("Submarine", 2)
        @player_board.place(@player_ship, ["A1", "A2", "A3"])
        @computer_board.place(@computer_ship, ["B2", "B3"])
    end

    describe '#initialize' do
        it 'exists and has attributes' do
            expect(@turn).to be_a(Turn)
            expect(@turn.player).to eq(@player)
            expect(@turn.computer).to eq(@computer)
            expect(@turn.player_board).to eq(@player_board)
            expect(@turn.computer_board).to eq(@computer_board)
        end
    end

    describe '#display_boards' do
        it 'returns the player and computer boards as strings' do
        # Render the boards as they would be displayed to the player
            expected_output = "Player's Board:\n" + @player_board.render(true) + "\n\nComputer's Board:\n" + @computer_board.render
            expect(@turn.display_boards).to eq(expected_output)
        end
    end

    describe '#player_shot' do
        it 'returns the result of the player’s shot as a string' do
            # Mock the coordinate chosen by player to avoid prompt loop
            allow(@player).to receive(:choose_coordinate).and_return("B2")
            
            # Ensure the cell at B2 on the computer's board has a ship for a hit
            @computer_board.cells["B2"].place_ship(Ship.new("Submarine", 2))
            
            # Expect player_shot to return the correct hit message
            expect(@turn.player_shot).to eq("Player 1's shot on B2 was a hit.")
        end
    end

    describe '#computer_shot' do
        it 'returns the result of the computers shot as a string' do
            # Mock the chosen coordinate to avoid random behavior
            allow(@turn).to receive(:computer_random_coordinate).and_return("A1")
            
            # Place a ship on "A1" in the player board to register as a hit
            @player_board.cells["A1"].place_ship(Ship.new("Cruiser", 3))
            
            # Expect the shot to report a hit
            expect(@turn.computer_shot).to eq("Computer's shot on A1 was a hit.")
        end
    end

    describe '#play_turn' do
        it 'is a full turn, including displaying boards and both shots' do
            # Mock player and computer shot selections to control randomness
            allow(@player).to receive(:choose_coordinate).and_return("B2")
            allow(@turn).to receive(:computer_random_coordinate).and_return("A1")

            # Place ships on B2 and A1 to ensure both shots register as hits
            @computer_board.cells["B2"].place_ship(Ship.new("Submarine", 2)) # Hit for player
            @player_board.cells["A1"].place_ship(Ship.new("Cruiser", 3))     # Hit for computer

            # Expected board display after shots are taken
            expected_display = "Player's Board:\n" + @player_board.render(true) + "\n\nComputer's Board:\n" + @computer_board.render

            # Check that both the display and shot outcomes match expectations
            expect(@turn.display_boards).to eq(expected_display)
            expect(@turn.player_shot).to eq("Player 1's shot on B2 was a hit.")
            expect(@turn.computer_shot).to eq("Computer's shot on A1 was a hit.")
        end
    end
end