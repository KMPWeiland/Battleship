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
            binding.pry
            expect(board.valid_coordinate?("A5")).to eq false
            expect(board.valid_coordinate?("E1")).to eq false
            expect(board.valid_coordinate?("A22")).to eq false
        end
    end
end