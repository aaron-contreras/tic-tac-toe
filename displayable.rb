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

  def game_mode
    puts <<~HEREDOC
      Select the game mode:
        (1) Human vs Human
        (2) Human vs Computer
        (3) Computer vs Computer
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
