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
                expect(@board.valid_placement?(@submarine, ["C2", "C3"])).to be(true)
            end
    end

end
