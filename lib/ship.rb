class Ship
    attr_reader :name,
                :length,
                :health

    def initialize(name, length, health = length)
        @name = name
        @length = length
        @health = health
    end
end
