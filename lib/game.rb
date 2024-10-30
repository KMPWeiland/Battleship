class Game
    attr_reader :player1,
                :computer_player
                # :turn_count

    def initialize(player1, computer_player = "Computer")
        @player1 = player1
        @computer_player = "Computer"
        # @turn_count = 0
        @comp_board = Board.new
        @comp_cruiser = Ship.new("My Cruiser", 3)  
        @comp_sub = Ship.new("My Submarine", 2)
        @player_board = Board.new
        @player_cruiser = Ship.new("Your Cruiser", 3)
        @player_sub = Ship.new("Your Submarine", 2)
    end


    def start
        puts "Hello Sailor! Welcome to BATTLESHIP. \n Enter p to play. Enter q to quit."
        user_input = gets.chomp.downcase  # Get user input and store it in user_input
        if user_input == "p"
            computer_place_ships
        elsif user_input == "q"
            leave_game
        else
          puts "Invalid input. Type 'p' to start the game."
          start
        end
    end

    def computer_place_ships
        # board = Board.new
        # comp_cruiser = Ship.new("My Cruiser", 3)  
        # comp_sub = Ship.new("My Submarine", 2)
    
       #1 create an array the keys 
       coord_array = generate_coord_array

       #2 find random AND valid placements for the computers' cruiser
       place_ships_randomly(@comp_cruiser, coord_array, 3)
        
       #3 find random AND valid placements for the computers' submarine
       place_ships_randomly(@comp_sub, coord_array, 2)
       
       #4 display computer board and prompt player to input their coordinates
       display_computer_board  

       #5 player's turn to place ships
       player_places_cruiser 

    end   

    #helper method to create an array of the baord's coordinates (array of keys from the board hash)
    def generate_coord_array
        @comp_board.cells.keys
    end

    #helper method to select a random placement for the computer's ships
    def place_ships_randomly(ship, coord_array, size)
        loop do
            random_coords = coord_array.sample(size)
            if @comp_board.valid_placement?(ship, random_coords)
                @comp_board.place(ship, random_coords)
                break
            end
        end
    end

    #helper method to display the computer's board and prompt the player to input their spaces
    def display_computer_board
        puts "I have laid out my ships on the grid. \n" + 
        "You now need to lay out your two ships. \n" +
        "The Cruiser is three units long and the Submarine is two units long. \n" +
        "  1 2 3 4 \n" + 
        "A #{@comp_board.cells["A1"].render} #{@comp_board.cells["A2"].render} #{@comp_board.cells["A3"].render} #{@comp_board.cells["A4"].render} \n" +
        "B #{@comp_board.cells["B1"].render} #{@comp_board.cells["B2"].render} #{@comp_board.cells["B3"].render} #{@comp_board.cells["B4"].render} \n" +
        "C #{@comp_board.cells["C1"].render} #{@comp_board.cells["C2"].render} #{@comp_board.cells["C3"].render} #{@comp_board.cells["C4"].render} \n" +
        "D #{@comp_board.cells["C1"].render} #{@comp_board.cells["D2"].render} #{@comp_board.cells["D3"].render} #{@comp_board.cells["D4"].render} \n" + 
        "Enter the squares for the Cruiser (3 spaces): "           
    end

    def player_places_cruiser
        user_input = gets.chomp
        player_cruiser_coords = user_input.split(" ")
        if @player_board.valid_placement?(@player_cruiser, player_cruiser_coords)
            @player_board.place(@player_cruiser, player_cruiser_coords)
            puts "Enter the squares for the Submarine (2 spaces):"
            player_places_sub
        else
            puts "Those are invalid coordinates. Please try again."
            player_places_cruiser
        end
    end

    def player_places_sub
        user_input = gets.chomp
        player_cruiser_coords = user_input.split(" ")
        if @player_board.valid_placement?(@player_sub, player_cruiser_coords)
            @player_board.place(@player_sub, player_cruiser_coords)
            display_boards
        else
            puts "Those are invalid coordinates. Please try again."
            player_places_sub
        end
    end

        # # Render both boards with appropriate visibility settings
        # player_view = "Player's Board:\n" + @player_board.render(true)      # Render player’s board, showing ships
        # computer_view = "Computer's Board:\n" + @comp_board.render      # Render computer’s board, hiding ships
        # "#{player_view}\n\n#{computer_view}"                               # Return the combined view as a string
       
    def display_boards
        # Print both boards with appropriate labels and visibility settings
        puts "==============COMPUTER BOARD=============="
        puts @comp_board.render
        puts "==============PLAYER BOARD=============="
        puts @player_board.render(true)
        player_shot
    end

    def player_shot
        loop do
            puts "Enter the coordinate for your shot:"
            coordinate = gets.chomp.upcase

            if valid_player_shot?(coordinate)
                cell = @comp_board.cells[coordinate]
                cell.fire_upon
                display_shot_result("Your", coordinate, cell.render)
                computer_shot
                # display_boards
                break
            else
                puts "Invalid or previously targeted coordinate. Please try again."
            end
        end
    end

    def display_shot_result(player, coordinate, render_result)
        if render_result == "M"
            puts "#{player} shot on #{coordinate} was a miss."
        elsif render_result == "H"
            puts "#{player} shot on #{coordinate} hit a ship!"
        elsif render_result == "X"
            puts "#{player} shot on #{coordinate} sunk the ship!"
        else
            "????"
        end
    end

    def valid_player_shot?(coordinate)
        @comp_board.valid_coordinate?(coordinate) && !@comp_board.cells[coordinate].fired_upon?
    end
    
        
    def computer_shot
        loop do 
        # Computer chooses a coordinate and fires on the player's board
            available_coordinates = @player_board.cells.keys.select { |coord| !@player_board.cells[coord].fired_upon? }
            random_coord = available_coordinates.sample
            if valid_comp_shot?(random_coord)
                cell = @comp_board.cells[random_coord]
                cell.fire_upon
                display_shot_result("My", random_coord, cell.render)
                # player_shot
                display_boards
                break
            end            
        end
    end

    def valid_comp_shot?(coordinate)
        @player_board.cells.key?(coordinate) && !@player_board.cells[coordinate].fired_upon?
    end
     
    # end
    #     coordinate = computer_random_coordinate                            # Computer selects a target coordinate
    #     result = player_board.cells[coordinate].fire_upon                 # Fire on the specific cell in the player’s board
    #     computer.report_shot_result(coordinate, result)                    # Report the result of the shot
    #   end

 
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

    def leave_game
        puts "Goodbye!"
    end

    def winner_declared
        if  @comp_cruiser.sunk? && @comp_sub.sunk?
            puts "You win! At ease, Sailor."
        elsif
            @player_cruiser.sunk? && @player_sub.sunk?
            puts "I win!"
        end
    end

end




    # def computer_place_ships
    #     board = Board.new
    #     comp_cruiser = Ship.new("My Cruiser", 3)  
    #     comp_sub = Ship.new("My Submarine", 2)
    # #1. go thru the cells hash and create an array the keys
    #     # coord_array = []
    #     # board.cells.each do |coordinate, value|
    #     #     coord_array << coordinate
    #     # end      
    #     generate_coord_array(board)
    # #2. call .sample(3) on the array of the keys to select a random placement for the cruiser, and then place the ship
    #     place_ships_randomly(board, ship, coord_array, size)    
    
    
    # loop do
    #         random_cruiser_coords = coord_array.sample(3)
    #         if board.valid_placement?(comp_cruiser, random_cruiser_coords)
    #             board.place(comp_cruiser, random_cruiser_coords)
    #             break
    #         end

    #     end
    #     #but have to make sure this is NOT diagonal, maybe make a helper method
    # #3. call .sample(2) on the array of the keys AND confirm it's a valid placement 
    #     loop do
    #         random_sub_coords = coord_array.sample(2)
        
    #         if board.valid_placement?(comp_sub, random_cruiser_coords)
    #             board.place(comp_sub, random_cruiser_coords)
    #             break
    #         end
    #     end

    #     p "I have laid out my ships on the grid. \n" + 
    #     "You now need to lay out your two ships. \n" +
    #     "The Cruiser is three units long and the Submarine is two units long. \n" +
    #     "  1 2 3 4 \n" + 
    #     "A #{@cells["A1"].render} #{@cells["A2"].render} #{@cells["A3"].render} #{@cells["A4"].render} \n" +
    #     "B #{@cells["B1"].render} #{@cells["B2"].render} #{@cells["B3"].render} #{@cells["B4"].render} \n" +
    #     "C #{@cells["C1"].render} #{@cells["C2"].render} #{@cells["C3"].render} #{@cells["C4"].render} \n" +
    #     "D #{@cells["C1"].render} #{@cells["D2"].render} #{@cells["D3"].render} #{@cells["D4"].render} \n" +
    #     "Enter the squares for the Cruiser (3 spaces): "

    #     # user_input = gets.chomp
    #     # player_place_ships      
    # end


    # user_input = gets.chomp
    #  #any time you call one of these variable you have to call it on an object (always call the methods on an object)
    #  #pattern of transfering the local variable to the instance variable 
    #  #DO I INITIALIZE PLAYERS HERE? WILL THAT INTERFERE WITH INSTANCE VARIABLES FROM PREVIOUS CLASSES?

    


#     def start_game
#         until player1.has_lost? || player2.has_lost?
#             @turn_count +=1
#             turn = Turn.new(player1, player2)
#             turn_type = turn.type
#             winner = turn.winner

#             if turn_type == :basic
#                 puts "Turn #{@turn_count}: #{winner.name} won two cards."
#             elsif turn_type == :war
#                 puts "Turn #{@turn_count}: WAR - #{winner.name} won six cards."
#             elsif
#                 puts "Turn #{@turn_count}: *mutually assured destruction* 6 cards removed from play."
#             end

#             turn.pile_cards
#             turn.award_spoils(winner) unless turn_type = :mutually_assured_destruction
        
#             if @turn_count == 1000000
#                 puts "---- DRAW ----"
#                 break
#             end

#         end
       

#         if player1.has_lost?
#             puts "*~*~*~* #{player2.name} has won the game! *~*~*~*"
#         elsif player2.has_lost?
#             puts "*~*~*~* #{player1.name} has won the game! *~*~*~*"
#         end
#     end
# end
    

 # if @comp_board.cells[user_input]
        #     @comp_board.cells[user_input].fire_upon
        #     # puts "Shot fired on #{user_input}!"
        #     computer_shot
        # else
        #     puts "Invalid coordinate. Please try again."
        # end
        # if user_input.render == "M"
        #     "Your shot on #{sampled_coord} was a miss."
        # elsif user_input.render == "H"
        #     "Your shot on #{sampled_coord} hit my ship!"
        # elsif user_input.render == "X"
        #     "Your shot on #{sampled_coord} sunk my ship!"
        # end