class Board
    attr_reader :board_hash

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

    def valid_coordinate?(coordinate)
        valid_row = ["A", "B", "C", "D"]
        valid_line = ["1", "2", "3", "4"]

        row = coordinate[0]
        line = coordinate[1]
        
        coordinate.length == 2 && valid_row.include?(row) && valid_line.include?(line)
    end
end