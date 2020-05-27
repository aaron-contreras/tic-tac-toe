# frozen_string_literal: true

require_relative 'player'
require_relative 'board'
require 'pry'
# Contains the tic-tac-toe logic
class Game
  attr_reader :player_one, :player_two, :board
  attr_writer :player_one_turn

  SAMPLE = Board.new :sample
  @selection = 1

  def initialize(player_one_info, player_two_info)
    @board = Board.new :playing
    @player_one = Player.new player_one_info
    @player_two = Player.new player_two_info
    @player_one_turn = true
    @win = false
  end

  def self.show_instructions
    puts 'Tic-Tac-Toe'.center(80)
    puts '--------------'.center(80)
    print 'These are the move positions on the board. '
    puts "They're labeled 0-8 from left to right, top to bottom."
    SAMPLE.show
    puts
  end

  def self.setup_game
    show_instructions
    Game.new ask_user_info, ask_user_info
  end

  def self.ask_user_info
    print "What is Player #{@selection}'s name? "
    name = gets.chomp
    print "What piece will #{name} be playing as? Choose any single-character of your liking: "
    piece = gets.chomp[0].upcase
    @selection += 1
    [name, piece]
  end

  def play
    until win? || tie?
      board.update_grid(current_player, ask_for_move)
      board.show
      switch_turns unless win? || tie?
    end
  end

  def show_game_over_message
    if win?
      puts "#{current_player.name} has won!"
    else
      puts "It's a tie!"
    end
  end

  def start_game
    board.show
    play
    show_game_over_message
  end

  private

  def find_matches(win_condition, piece)
    @win = win_condition.all? do |index|
      board.cell_at(index) == piece
    end
  end

  def win?
    win_conditions = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 4, 8],
      [6, 4, 2], [0, 3, 6], [1, 4, 7], [2, 5, 8]
    ]

    win_conditions.each do |win_condition|
      find_matches(win_condition, player_one.piece)
      break if @win

      find_matches(win_condition, player_two.piece)
    end

    @win
  end

  def tie?
    return if win?

    @tie = true if board.filled?
  end

  def ask_for_move
    move = nil

    until board.valid_move? move
      print 'Where would you like to place your move? '
      possible_move = gets.chomp

      move = possible_move.to_i if possible_move.between?('0', '8')
    end

    move
  end

  def switch_turns
    self.player_one_turn = if player_one_turn?
                             false
                           else
                             true
                           end
  end

  def player_one_turn?
    @player_one_turn
  end

  def current_player
    if player_one_turn?
      player_one
    else
      player_two
    end
  end
end

game = Game.setup_game
game.start_game
