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

end
