# frozen_string_literal: true

# User interactive output and input
module Displayable
  def sample
    puts <<~HEREDOC
      0|1|2
      -+-+-
      3|4|5
      -+-+-
      6|7|8
    HEREDOC
  end

  def ask_game_mode(modes)
    mode1 = modes[1]
    mode2 = modes[2]
    mode3 = modes[3]
    puts <<~HEREDOC
      Select the game mode:
        (1) #{mode1.first} vs #{mode1.last}
        (2) #{mode2.first} vs #{mode2.last}
        (3) #{mode3.first} vs #{mode3.last}
    HEREDOC
  end

  def show_instructions
    puts 'Tic-Tac-Toe'.center(80)
    puts '--------------'.center(80)
    print 'These are the move positions on the board. '
    puts "They're labeled 0-8 from left to right, top to bottom."
    sample
    puts
  end

  def ask_players_name(player_number)
    print "What is Player #{player_number}'s name? "
  end

  def ask_players_piece(player_name)
    print "What piece will #{player_name} be playing as? Choose any single-character of your liking: "
  end

  def ask_computer_mode
    puts <<~HEREDOC
          Who would you like to play against?
      ----------------------------------------------
      OPTION    PLAYER NAME    PIECE    INTELLIGENCE
      (a)       Ultron         U        Dumb
      (b)       T-800          T        Smart
      (c)       Skynet         S        Genius
    HEREDOC
    puts
  end

  def ask_intelligence_level(computer_name)
    puts <<~HEREDOC
      How smart is #{computer_name}?
        (not much) --> You'll most likely win
        (very) --> You might win
        (genius) --> Try to win... I dare you!
    HEREDOC
  end

  def ask_player_for_move
    print 'Where would you like to place your move? '
  end

  def win_message(player)
    puts "#{player.name} has won!"
  end

  def tie_message
    puts "It's a tie!"
  end
end
