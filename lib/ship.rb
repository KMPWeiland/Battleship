class Ship
    attr_reader :name,
                :length
    
    attr_accessor :health

    def initialize(name, length, health = length, sunk = false)
        @name = name
        @length = length
        @health = health
        @sunk = sunk
    end

    def sunk? 
        if @health == 0
            true
        else
            false
        end
    end

    def hit
        @health -= 1
    end
end
