class Board
    attr_reader :cells

    def initialize
        @cells =
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
        if coordinate_array.count == ship_object.length && 
            consecutive_coordinates(coordinate_array) && 
            not_diagonal(coordinate_array) && 
            coordinate_array.any? {|coordinate| @cells[coordinate].empty?}
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

        if coordinates_rows.all? { |row| row == coordinates_rows[0] } #confirm row letters are the same
            #now check if columns are consecutive, use .all? to return a boolean
            return coordinates_columns.each_cons(2).all? do |first, second| 
                second == first + 1
            end
        end

        if coordinates_columns.all? { |column| column == coordinates_columns[0] } #confirm column numbers are the same
            #now check if rows are consecutive, use .ord to turn letters to numbers, use .all? to return a boolean
            return coordinates_rows.each_cons(2).all? do |first, second|
                second.ord == first.ord + 1
            end
        end
        
        false
    end

    def not_diagonal(coordinate_array)  
        # NB: can't got up alphabetically and numerically at the same time 
        #return true only when BOTH horizontal and vertical placement conditions are met simultaneously 
        coordinates_rows = coordinate_array.map do |coordinate|
            coordinate[0]
        end

        coordinates_columns = coordinate_array.map do |coordinate|
            coordinate[1].to_i
        end

        if coordinates_rows.all? { |row| row != coordinates_rows[0] } 
            return false
        end

        if coordinates_columns.all? { |column| column != coordinates_columns[0] } 
            #confirm column numbers are the same
            #now check if rows are consecutive, use .ord to turn letters to numbers, use .all? to return a boolean
            return false
        end

        true
    end

    def place(ship_object, coordinate_array)
        if valid_placement?(ship_object, coordinate_array)
            coordinate_array.each do |coordinate| 
                @cells[coordinate].place_ship(ship_object)               
            end
        end
    end

    def render(reveal = false)
        if reveal == true 
            p "  1 2 3 4 \n" + 
            "A #{reveal_ship("A1")} #{reveal_ship("A2")} #{reveal_ship("A3")} #{reveal_ship("A4")} \n" +
            "B #{reveal_ship("B1")} #{reveal_ship("B2")} #{reveal_ship("B3")} #{reveal_ship("B4")} \n" +
            "C #{reveal_ship("C1")} #{reveal_ship("C2")} #{reveal_ship("C3")} #{reveal_ship("C4")} \n" +
            "D #{reveal_ship("C1")} #{reveal_ship("D2")} #{reveal_ship("D3")} #{reveal_ship("D4")} \n"
        else
            p "  1 2 3 4 \n" + 
            "A #{@cells["A1"].render} #{@cells["A2"].render} #{@cells["A3"].render} #{@cells["A4"].render} \n" +
            "B #{@cells["B1"].render} #{@cells["B2"].render} #{@cells["B3"].render} #{@cells["B4"].render} \n" +
            "C #{@cells["C1"].render} #{@cells["C2"].render} #{@cells["C3"].render} #{@cells["C4"].render} \n" +
            "D #{@cells["C1"].render} #{@cells["D2"].render} #{@cells["D3"].render} #{@cells["D4"].render} \n"
        end
    end

    def reveal_ship(cell_key)
        if @cells[cell_key].fired_upon? == false && @cells[cell_key].empty? == false 
            @cells[cell_key].render(true)
        else 
            @cells[cell_key].render
        end
    end






    # def not_overlapping(coordinate_array)
    #     if coordinate_array.all? { |coordinate| cells[coordinate].empty?}
    #         false
    #     else 
    #         true
    #     end
    # end


    # def not_overlapping(coordinate_array, target_coordinate)
    #     if coordinate_array.all? { |coordinate| cell.coordinate != target_coordinate}
    #         false
    #     else
    #         true
    #     end
    # end

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


    # def valid_placement?(ship_object, coordinate_array)
    #     length_match = coordinate_array.count == ship_object.length
    #     consecutive = consecutive_coordinates(coordinate_array)
    #     non_diagonal = not_diagonal(coordinate_array)
    #     non_overlapping = not_overlapping(coordinate_array)
    
    #     puts "Length match: #{length_match}" # Should print true
    #     puts "Consecutive: #{consecutive}"   # Should print true
    #     puts "Non-diagonal: #{non_diagonal}" # Should print true
    #     puts "Non-overlapping: #{non_overlapping}" # Should print true
    
    #     length_match && consecutive && non_diagonal && non_overlapping
    # end
    
end