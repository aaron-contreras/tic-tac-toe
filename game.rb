# frozen_string_literal: true

require_relative './player.rb'
require_relative './board.rb'
require_relative './displayable.rb'
require 'pry'
# Contains the tic-tac-toe logic
class Game
  include Displayable
  attr_reader :player_one, :player_two, :board
  attr_writer :player_one_turn

  def initialize
    show_instructions
    @board = Board.new
    @game_mode = game_mode
    @player_one = Player.new ask_user_info(1)
    @player_two = Player.new ask_user_info(2)
    @player_one_turn = rand(2)
    @win = false
  end

  def ask_user_info(player_number)
    ask_players_name(player_number)
    name = gets.chomp

    ask_players_piece(name)
    piece = gets.chomp[0].upcase

    [name, piece]
  end

  def play
    until win? || tie?
      board.update_grid(current_player, player_move)
      board.show
      switch_turns unless win? || tie?
    end
  end

  def game_over
    if win?
      win_message current_player
    else
      tie_message
    end
  end

  def start_game
    board.show
    play
    game_over
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

  def player_move
    move = nil

    until board.valid_move? move
      ask_player_for_move
      possible_move = gets.chomp

      move = possible_move.to_i if possible_move.between?('0', '8')
    end

    move
  end

  def switch_turns
    self.player_one_turn = player_one_turn? ? false : true
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

game = Game.new
game.start_game
