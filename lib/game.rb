class Game
    attr_reader :player1, :computer_player
  
    def initialize(player1, computer_player = "Computer")
      @player1 = player1
      @computer_player = computer_player
      @comp_board = Board.new
      @comp_cruiser = Ship.new("My Cruiser", 3)
      @comp_sub = Ship.new("My Submarine", 2)
      @player_board = Board.new
      @player_cruiser = Ship.new("Your Cruiser", 3)
      @player_sub = Ship.new("Your Submarine", 2)
    end
  
    # Start the game with an initial prompt
    def start
      puts "Hello Sailor! Welcome to BATTLESHIP. \nEnter 'p' to play or 'q' to quit."
      user_input = gets.chomp.downcase
  
      if user_input == "p"
        computer_place_ships
        player_place_ships
        play_turns
      elsif user_input == "q"
        leave_game
      else
        puts "Invalid input. Type 'p' to start or 'q' to quit."
        start
      end
    end
  
    # Place computer's ships randomly
    def computer_place_ships
      place_ships_randomly(@comp_cruiser, 3)
      place_ships_randomly(@comp_sub, 2)
      puts "I have laid out my ships. Now, it's your turn."
    end
  
    # Place a ship at random valid locations
    def place_ships_randomly(ship, size)
      loop do
        random_coords = @comp_board.cells.keys.sample(size)
        if @comp_board.valid_placement?(ship, random_coords)
          @comp_board.place(ship, random_coords)
          break
        end
      end
    end
  
    # Player places ships with validation
    def player_place_ships
      display_boards
  
      puts "Enter coordinates for your Cruiser (3 spaces):"
      get_valid_ship_placement(@player_cruiser, 3)
  
      puts "Enter coordinates for your Submarine (2 spaces):"
      get_valid_ship_placement(@player_sub, 2)
  
      display_boards
    end
  
    # Helper to get valid coordinates from the player for their ship
    def get_valid_ship_placement(ship, size)
      loop do
        user_input = gets.chomp.upcase.split
        if @player_board.valid_placement?(ship, user_input)
          @player_board.place(ship, user_input)
          break
        else
          puts "Invalid coordinates. Please try again:"
        end
      end
    end
  
    # Main game loop
    def play_turns
      loop do
        display_boards
        player_shot
        break if winner_declared
  
        computer_shot
        break if winner_declared
      end
    end
  
    # Display the boards for both the player and computer
    def display_boards
      puts "=============COMPUTER BOARD============="
      puts @comp_board.render(false)  # Hides computer ships
      puts "==============PLAYER BOARD=============="
      puts @player_board.render(true) # Shows player ships
    end
  
    # Get and validate player's shot
    def player_shot
        loop do
            puts "Enter the coordinate for your shot:"
            coordinate = gets.chomp.upcase
        
            if valid_player_shot?(coordinate)
                result = @comp_board.cells[coordinate].fire_upon
                display_shot_result("Your", coordinate, result)
                break
            else
                puts "Invalid or previously targeted coordinate. Please try again."
            end
        end
    end
  
    # Helper to validate player's shot
    def valid_player_shot?(coordinate)
      @comp_board.valid_coordinate?(coordinate) && !@comp_board.cells[coordinate].fired_upon?
    end
  
    # Computer's shot on player's board
    def computer_shot
      available_coords = @player_board.cells.keys.reject { |coord| @player_board.cells[coord].fired_upon? }
      coordinate = available_coords.sample
  
      result = @player_board.cells[coordinate].fire_upon
      display_shot_result("Computer's", coordinate, result)
    end
  # if cell.render = hit
    # Display shot result
    def display_shot_result(name, coordinate, result)
        if result.is_a?(Ship)
          puts "Your shot on #{:coordinate} was a hit!"
        elsif result.is_a?(Ship) && result.sunk?
          puts "Your shot on #{:coordinate} hit and sunk a ship!"
        elsif result.nil?
          puts "Your shot on #{:coordinate} was a miss."
        else
          puts "Unexpected result for shot!"
        end
    end
  
    # Check if a winner is declared and end the game
    def winner_declared
        if @comp_cruiser.sunk? && @comp_sub.sunk?
            puts "You win! At ease, Sailor."
        elsif @player_cruiser.sunk? && @player_sub.sunk?
            puts "I win!"
            true
        else
            false
        end
    end
  
    # End the game
    def leave_game
      puts "Goodbye!"
    end
  end
  
