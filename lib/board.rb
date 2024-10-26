class Board
    # attr_reader :board_hash

    def initialize
        # @board_hash = {
        #     "A1" => :value_1,
        #     "A2" => :value_2
        # }
    end

    def cells
        {
            "A1" => Cell.new("A1"),
            "A2" => Cell.new("A2"),
            "A3" => Cell.new("A3"),
            "A4" => Cell.new("A4"),
            "B1" => Cell.new("B1"),
            "B2" => Cell.new("B2"),
            "B3" => Cell.new("B3"),
            "B4" => Cell.new("B4"),
            "C1" => Cell.new("C1"),
            "C2" => Cell.new("C2"),
            "C3" => Cell.new("C3"),
            "C4" => Cell.new("C4"),
            "D1" => Cell.new("D1"),
            "D2" => Cell.new("D2"),
            "D3" => Cell.new("D3"),
            "D4" => Cell.new("D4")
    }
    end

    def valid_placement?(ship_object, coordinate_array)
        if coordinate_array.count == ship_object.length && consecutive_coordinates == true
            true
        else
            false
        end
    end

    def consecutive_coordinates(coordinate_array)
        coord_column = coordinate_array.map do |coordinate|
            coordinate[1]
        coord_row = coordinate_array.map do |coordinate|
            coordinate[2].to_i
        if coord_column.
    end




end
