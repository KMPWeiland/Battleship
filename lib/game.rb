class Game
    attr_reader :player1,
                :computer_player
                # :turn_count

    def initialize(player1, computer_player = "Computer")
        @player1 = player1
        @computer_player = "Computer"
        # @turn_count = 0
    end


    def start
        puts "Welcome to BATTLESHIP /n Enter p to play. Enter q to quit."
        user_input = gets.chomp  # Get user input and store it in user_input
        if user_input == "p"
            computer_place_ships
        elsif user_input == "q"
            end_game
        else
          puts "Invalid input. Type 'p' to start the game."
        end
    end

    

    def computer_place_ships
        board = Board.new
        comp_cruiser = Ship.new("My Cruiser", 3)  
        comp_sub = Ship.new("My Submarine", 2)
    #1. go thru the cells hash and create an array the keys
        # coord_array = []
        # board.cells.each do |coordinate, value|
        #     coord_array << coordinate
        # end      
        generate_coord_array(board)
    #2. call .sample(3) on the array of the keys to select a random placement for the cruiser, and then place the ship
        place_ships_randomly(board, ship, coord_array, size)    
    
    
    loop do
            random_cruiser_coords = coord_array.sample(3)
            if board.valid_placement?(comp_cruiser, random_cruiser_coords)
                board.place(comp_cruiser, random_cruiser_coords)
                break
            end

        end
        #but have to make sure this is NOT diagonal, maybe make a helper method
    #3. call .sample(2) on the array of the keys AND confirm it's a valid placement 
        loop do
            random_sub_coords = coord_array.sample(2)
        
            if board.valid_placement?(comp_sub, random_cruiser_coords)
                board.place(comp_sub, random_cruiser_coords)
                break
            end
        end

        p "I have laid out my ships on the grid. \n" + 
        "You now need to lay out your two ships. \n" +
        "The Cruiser is three units long and the Submarine is two units long. \n" +
        "  1 2 3 4 \n" + 
        "A #{@cells["A1"].render} #{@cells["A2"].render} #{@cells["A3"].render} #{@cells["A4"].render} \n" +
        "B #{@cells["B1"].render} #{@cells["B2"].render} #{@cells["B3"].render} #{@cells["B4"].render} \n" +
        "C #{@cells["C1"].render} #{@cells["C2"].render} #{@cells["C3"].render} #{@cells["C4"].render} \n" +
        "D #{@cells["C1"].render} #{@cells["D2"].render} #{@cells["D3"].render} #{@cells["D4"].render} \n" +
        "Enter the squares for the Cruiser (3 spaces): "

        # user_input = gets.chomp
        # player_place_ships      
    end

end
    #helper method to create an array of the baord's coordinates (array of keys from the board hash)
    def generate_coord_array(board)
        board.cells.keys
    end

    #helper method to select a random placement for the computer's ships
    def place_ships_randomly(board, ship, coord_array, size)
        loop do
            random_coords = coord_array.sample(size)
            if board.valid_placement?(ship, random_coords)
                board.place(ship, random_coords)
                break
            end
        end
    end





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
    