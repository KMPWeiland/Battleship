class Cell
    attr_reader :coordinate, :ship

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @hits = 0
    end

    def empty?
        if @ship == nil
            true
        else
            false
        end
    end

    def place_ship(ship_name)
        @ship = ship_name
    end

    def fired_upon?
        if @hits > 0
            true 
        else
            false
        end
    end

    def fire_upon
        @hits += 1
        ship.health -= 1

    end

end