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

    describe '#cell render' do
        it 'was rendered' do
            cell_1 = Cell.new("B4")

            cell_1.render
            expect(cell_1.render).to eq(".")
        end

        it 'was was fired upon and missed (no ship)' do
            cell_1 = Cell.new("B4")

            cell_1.fire_upon
            cell_1.render
            expect(cell_1.render).to eq("M")
        end

        it 'cell 2 tests' do
            cell_1 = Cell.new("B4")
            cell_2 = Cell.new("C3")
            cruiser = Ship.new("Cruiser", 3)

            cell_2.place_ship(cruiser)
            expect(cell_2.empty?).to eq(false)
            
            # cell_2.render
            expect(cell_2.render).to eq(".")

            # cell_2.render(true)
            expect(cell_2.render(true)).to eq("S")
            
            cell_2.fire_upon

            expect(cell_2.render(true)).to eq("H")
        end 

    end

    describe '#sunk?' do
        it 'tests if ship sunk' do
            cell_1 = Cell.new("B4")
            cell_2 = Cell.new("C3")
            cruiser = Ship.new("Cruiser", 3)

            cell_2.place_ship(cruiser)
            cell_2.render
            cell_2.render(true) 

            cell_2.fire_upon

            expect(cruiser.sunk?).to eq(false)

            cruiser.hit
            cruiser.hit
            expect(cruiser.sunk?).to eq(true)
            expect(cell_2.render(true)).to eq("X")
        end 

    end
            
            # cruiser = Ship.new("Cruiser", 3)
            
            # expect(cell.fired_upon?).to eq(false)
            # cell.fire_upon
            # expect(cell.fired_upon?).to eq(true)
    

end
