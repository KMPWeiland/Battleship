require 'rspec'
require './lib/ship.rb'
require './lib/cell.rb'
require 'pry'

RSpec.describe Cell do
    describe '#initialize' do
        it 'exists' do
            cell = Cell.new("B4")
            expect(cell).to be_a(Cell)
        end
        
        it 'has attributes' do
            cell = Cell.new("B4")
            expect(cell.coordinate).to eq("B4")
        end

        it 'has a ship' do
            cell = Cell.new("B4")
            expect(cell.ship).to eq(nil)
        end
    end

    describe '#empty?' do
        it 'cell is empty?' do
            cell = Cell.new("B4")
            expect(cell.empty?).to eq(true)
        end

        it 'placed ship' do
            cell = Cell.new("B4")
            cruiser = Ship.new("Cruiser", 3)

            cell.place_ship(cruiser)
            expect(cell.ship).to eq(cruiser)
            expect(cell.empty?).to eq(false)
        end
    end

    describe '#Health changes' do
        it 'was fired upon' do
            cell = Cell.new("B4")
            cruiser = Ship.new("Cruiser", 3)
            
            expect(cell.fired_upon?).to eq(false)
            cell.fire_upon
            expect(cell.fired_upon?).to eq(true)
        end

        it 'impacts health after hit' do
            cell = Cell.new("B4")
            cruiser = Ship.new("Cruiser", 3)
            cell.place_ship(cruiser)
            

            expect(cruiser.health).to eq(3)

            cell.fire_upon
            
            expect(cell.takes_hit).to eq(true)
            expect(cruiser.health).to eq(2)
        end
    end
        
end
