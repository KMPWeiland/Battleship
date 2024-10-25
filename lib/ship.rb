class Ship
    attr_reader :name,
                :length,
                :health

    def initialize(name, length, health = length, sunk = false)
        @name = name
        @length = length
        @health = health
        @sunk = sunk
        # @hit = ship.hit
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


    # def commit_heinous_act
    #     @heinous_act_count +=1
    # end

    # def cursed?
    #     if @heinous_act_count >=3
    #         true
    #     else
    #         false
    #     end
    # end






end
