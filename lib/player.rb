class Player
    attr_reader :board, :name, :previous_shots
  
    def initialize(name, board)
      @name = name
      @board = board
      @previous_shots = []
    end
  
    def choose_coordinate
      # Prompt for a coordinate until a valid one is entered
      coordinate = request_coordinate
      until is_a_valid_coordinate?(coordinate)
        if has_already_fired_upon?(coordinate)
          puts "You have already fired upon #{coordinate}. Please choose a different coordinate:"
        else
          puts "Invalid coordinate. Please enter a valid coordinate:"
        end
        coordinate = request_coordinate
      end
      @previous_shots << coordinate # Save the chosen coordinate to prevent re-use
      coordinate
    end
  
    def fire_at_coordinate(coordinate, opponent_board)
        # Access the specific cell in the opponent's board and fire upon it
        cell = opponent_board.cells[coordinate] # Fetch the cell from the opponent's board
        result = cell.fire_upon                 # Fire on the cell and store the result
        report_shot_result(coordinate, result)
    end
    # def fire_at_coordinate(coordinate, opponent_board)
    #   # Fires on the opponent's board at the specified coordinate
    #   cell = opponent_board.cells[coordinate] # Get the cell on the opponent's board
    #   result = cell.fire_upon                # Fire upon it and store the result
    #   report_shot_result(coordinate, result) # Generate and return the result message
    # end
  
    def is_a_valid_coordinate?(coordinate)
      # Returns true if the coordinate is valid and has not already been fired upon
      board.valid_coordinate?(coordinate) && !has_already_fired_upon?(coordinate)
    end
  
    def has_already_fired_upon?(coordinate)
      # Returns true if this coordinate has been fired upon already
      @previous_shots.include?(coordinate)
    end
  
    def request_coordinate(input = nil)
        input ||= begin
          print "Enter coordinate: "
          gets&.chomp&.upcase  # Safely attempts to get input
        end
        input || "A1"  # Default to "A1" if input is nil to avoid []/nil
      end
  
    def report_shot_result(coordinate, result)
        if result == "M"
          "#{name}'s shot on #{coordinate} was a miss."
        elsif result == "H"
          "#{name}'s shot on #{coordinate} was a hit."
        elsif result == "X"
          "#{name}'s shot on #{coordinate} sunk a ship!"
        else
          "#{name}'s shot result is unknown."
        end
    end
end