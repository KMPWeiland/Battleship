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

    def valid_coordinate?(coordinate)
        valid_row = ["A", "B", "C", "D"]
        valid_line = ["1", "2", "3", "4"]

        row = coordinate[0]
        line = coordinate[1]
        
        coordinate.length == 2 && valid_row.include?(row) && valid_line.include?(line)
    end

    def valid_placement?(ship_object, coordinate_array)
        if coordinate_array.count == ship_object.length && consecutive_coordinates(coordinate_array)
            true
        else
            false
        end
    end

    def consecutive_coordinates(coordinate_array)
        coordinates_rows = coordinate_array.map do |coordinate|
            coordinate[0]
        end

        coordinates_columns = coordinate_array.map do |coordinate|
            coordinate[1].to_i
        end

        if coordinates_rows.all? do |row| #confirm row letters are the same
                row == coordinates_rows[0]
            end
            #now check if columns are consecutive, use .all? to return a boolean
            return coordinates_columns.each_cons(2).all? do |first, second| 
                second == first + 1
            end
        end

        if coordinates_columns.all? do |column| #confirm column numbers are the same
                column == coordinates_columns[0]
            end
            #now check if rows are consecutive, use .ord to turn letters to numbers, use .all? to return a boolean
            return coordinates_rows.each_cons(2).all? do |first, second|
                second.ord == first.ord + 1
            end
        end
        
        false
    end

    def not_diagonal(coordinate_array)
        #can't got up alphabetically and numericall at the same time
        #try RETRUNING FALSE WHEN consecutive_coordinates(coordinate_array)  return true only when BOTH horizontal and vertical placement conditions are met simultaneously 

    end

    # def consecutive_columns(coordinate_array)
    #     coord_column = coordinate_array.map do |coordinate|
    #         coordinate[0]
    #     end
    # end

    # def consecutive_rows(coordinate_array)
    #     coord_row = coordinate_array.map do |coordinate|
    #         coordinate[1].to_i
    #     end
    # end

    # def consecutive_coordinates?
    #     if coord_column == coord_column.sort && coord_row == coord_row.sort
    #         true
    #     else
    #         false
    #     end
    # end

    # def consecutive_coordinates?
    #     if coord_column == coord_column.sort && coord_row == coord_row.sort
    #     #     true
    #     # else
    #     #     false
    #     # end
        
end
