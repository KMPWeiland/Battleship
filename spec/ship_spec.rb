require './lib/ship.rb'

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
       
end