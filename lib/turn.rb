class Turn
    attr_reader :player, :computer, :player_board, :computer_board
  
    def initialize(player, computer, player_board, computer_board)
      @player = player
      @computer = computer
      @player_board = player_board
      @computer_board = computer_board
    end
  
    def display_boards
      # Render both boards with appropriate visibility settings
      player_view = "Player's Board:\n" + player_board.render(true)      # Render player’s board, showing ships
      computer_view = "Computer's Board:\n" + computer_board.render      # Render computer’s board, hiding ships
      "#{player_view}\n\n#{computer_view}"                               # Return the combined view as a string
    end
  
    def player_shot
      # Player chooses a coordinate and fires on the computer's board
      coordinate = player.choose_coordinate                              # Player selects a target coordinate
      result = computer_board.cells[coordinate].fire_upon               # Fire on the specific cell in the computer's board
      player.report_shot_result(coordinate, result)                      # Report the result of the shot
    end
  
    def computer_shot
      # Computer chooses a coordinate and fires on the player's board
      coordinate = computer_random_coordinate                            # Computer selects a target coordinate
      result = player_board.cells[coordinate].fire_upon                 # Fire on the specific cell in the player’s board
      computer.report_shot_result(coordinate, result)                    # Report the result of the shot
    end
  
    def computer_random_coordinate
      # Selects a random coordinate that hasn’t been fired upon
      player_board.cells.keys.sample { |coord| !player_board.cells[coord].fired_upon? }
      available_coordinates.sample
    end
  
    def play_turn
      # Execute a complete turn sequence
      display_boards                                                     # Display both boards
      player_shot                                                        # Player fires a shot
      computer_shot                                                      # Computer fires a shot
    end
  end