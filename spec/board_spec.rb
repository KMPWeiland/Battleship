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

        # it 'is a hash' do
        #     board = Board.new
        #     expect(board.board_hash).to be_a Hash
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
   
    describe '#validating placements' do
        before(:each) do
            @board = Board.new
            @cruiser = Ship.new("Cruiser", 3)
            @submarine = Ship.new("Submarine", 2)
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

            expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be(false)
        end
    end

end
