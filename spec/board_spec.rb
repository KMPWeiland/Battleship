require 'pry'
require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'


RSpec.describe Board do
    describe '#board' do
        it 'exists' do
            board = Board.new
            expect(board).to be_a Board
        end
    end

    describe '#cells_method' do
        it 'is a hash' do
            board = Board.new
            expect(board.cells).to be_a Hash
        end

        it 'has 16 key value pairs' do
            board = Board.new
            expect(board.cells.count).to eq(16)
        end
    end
   
    describe '#valid_coordinate?' do
        it 'will retrun true if coordinate is valid' do
            board = Board.new

            expect(board.valid_coordinate?("A1")).to eq true
            expect(board.valid_coordinate?("D4")).to eq true
        end

        it 'will return false if coordinate is not valid' do
            board = Board.new
            expect(board.valid_coordinate?("A5")).to eq false
            expect(board.valid_coordinate?("E1")).to eq false
            expect(board.valid_coordinate?("A22")).to eq false
        end
    end

    describe '#validating placements' do
        before(:each) do
            @board = Board.new
            @cruiser = Ship.new("Cruiser", 3)
            @submarine = Ship.new("Submarine", 2)
            @row_boat = Ship.new("Row Boat", 2)
        end

            it 'has an arry argument that is the same length as the ship' do
                # board = Board.new
                # cruiser = Ship.new("Cruiser", 3)
                # submarine = Ship.new("Submarine", 2)
                expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to be(false)
                expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to be(false)
            end

            it 'coordinates are consecutive' do
                # board = Board.new
                # cruiser = Ship.new("Cruiser", 3)
                # submarine = Ship.new("Submarine", 2)
                expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to be(false)
                expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to be(false)
                expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to be(false)
                expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to be(false)
            end

            it 'coordinates are not diagonal' do
                expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to be(false)
                expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to be(false)
                expect(@board.valid_placement?(@row_boat, ["A3", "A4"])).to be(true)
            end

            it 'checks for valid placements' do
                expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to be(true)
                expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be(true)
            end
    end

    describe '#placing ships' do 
        it 'can place ship in the boards cells' do
            board = Board.new
            cruiser = Ship.new("Cruiser", 3) 
            
            # board.place(cruiser, ["A1", "A2", "A3"])
            expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be(true)
        end

        it 'creates cell variables' do
            board = Board.new
            cruiser = Ship.new("Cruiser", 3) 
            
            board.place(cruiser, ["A1", "A2", "A3"])

            cell_1 = board.cells["A1"] 
            cell_2 = board.cells["A2"]
            cell_3 = board.cells["A3"]

            expect(cell_3.ship == cell_2.ship).to be(true)
        end

        it 'ships do not overlap' do
            board = Board.new
            cruiser = Ship.new("Cruiser", 3) 
            
            board.place(cruiser, ["A1", "A2", "A3"])

            cell_1 = board.cells["A1"] 
            cell_2 = board.cells["A2"]
            cell_3 = board.cells["A3"]
            
            submarine = Ship.new("Submarine", 2)
            board.place(submarine, ["A1", "B1"])
           

            expect(board.valid_placement?(submarine,["A1", "B1"])).to be(false)


            # expect(board.not_diagonal(["A1", "B1"])).to be(true)
            # expect(cell_1.ship == cell_1.ship).to be(true)
            # expect(cell_3.ship == cell_2.ship).to be(true)
            # expect(cell_3.ship == cell_4.ship).to be(false)
        end
    end

    describe '#can_render' do
        it 'can render board for game' do
            board = Board.new
            cruiser = Ship.new("Cruiser", 3) 
            board.place(cruiser, ["A1", "A2", "A3"]) 

            expected_layout = " 1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
            expect(board.render).to eq(expected_layout)
        end

        it 'can render board for game' do
            board = Board.new
            cruiser = Ship.new("Cruiser", 3) 
            board.place(cruiser, ["A1", "A2", "A3"]) 
# binding.pry
            expected_layout = " 1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
            expect(board.render(true)).to eq(expected_layout)
        end
    end

        # it 'displays specific cells as occupied' do
        #     board.mark_cell("A1", "empty?")
        #     board.mark_cell("B2", "empty?")
        #     board.mark_cell("C3", "empty?")
        #     expected_layout = "   1   2   3   4\nA  X   .   .   . \nB  .   X   .   . \nC  .   .   X   . \nD  .   .   .   . \n"
        #     expect(board.display).to eq(expected_layout)
end