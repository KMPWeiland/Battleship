require './lib/ship.rb'
require 'pry'

RSpec.describe Ship do 
    describe '#initialize' do
        it 'exists' do
            cruiser = Ship.new("Cruiser", 3)
            expect(cruiser).to be_a(Ship)
        end

        it 'has attributes' do
            cruiser = Ship.new("Cruiser", 3)
            expect(cruiser.name).to eq("Cruiser")
            expect(cruiser.length).to eq(3)
            expect(cruiser.health).to eq(3) 
        end       
    end

    describe '#sunk' do 
        it 'has sunk?/is not suck by default' do
            cruiser = Ship.new("Cruiser", 3)
            
            expect(cruiser.sunk?).to eq(false)
        end
    end

    describe '#hit' do 
        it 'has been hit' do
            cruiser = Ship.new("Cruiser", 3)

            expect(cruiser.sunk?).to eq(false)

            cruiser.hit
            expect(cruiser.health).to eq(2)
            expect(cruiser.sunk?).to eq(false)

            cruiser.hit
            expect(cruiser.health).to eq(1)
            expect(cruiser.sunk?).to eq(false)

            cruiser.hit
            expect(cruiser.health).to eq(0)
            expect(cruiser.sunk?).to eq(true)
        end
    end     
end

