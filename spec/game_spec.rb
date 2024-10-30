require 'pry'
require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

RSpec.describe Game do
    describe '#gamesetup' do
        it 'exists' do
            game1 = Game.new("Tom")
            expect(game1).to be_a(Game)
        end

        it 'has attributes' do
            game1 = Game.new("Tom")
            expect(game1.player1).to eq("Tom")
            expect(game1.computer_player).to eq("Computer")
        end
    end

    describe 'computer placements' do
        it 'computer places ships' do
            game1 = Game.new("Tom")

            #this method automate random placesments on the board of the computer's two ships
            #randomize possible options AND must confirm the random placements are valid
            game1.computer_place_ships

            


            #test to confirm


            #now we need to test that the computer did place ships by looking at the board

            


            # expect(game1.computer_place_ship).to eq()
        end
    end

    
end