# frozen_string_literal: true

require_relative './player.rb'
require_relative './human.rb'
require_relative './computer.rb'
require_relative './board.rb'
require_relative './displayable.rb'
require 'pry'
# Contains the tic-tac-toe logic
class Game
  include Displayable
  attr_reader :player_one, :player_two, :board
  attr_writer :player_one_turn

  GAME_MODES = {
    1 => %w[Human Human],
    2 => %w[Human Computer],
    3 => %w[Computer Computer]
  }.freeze

  def initialize
    show_instructions
    @board = Board.new
    @game_mode = game_mode
    @player_one = create_player(1)
    @player_two = create_player(2)
    @player_one_turn = rand(2)
    @win = false
    p player_one, player_two
  end

  def game_mode
    ask_game_mode GAME_MODES
    mode = gets.chomp.to_i until GAME_MODES.key? mode
    mode
  end

  def details(player_number, is_ai = nil)
    ask_players_name player_number
    name = gets.chomp

    ask_players_piece name
    piece = gets.chomp[0].upcase

    if is_ai
      ask_intelligence_level name
      [name, piece, Computer.intelligence_level]
    else
      [name, piece]
    end
  end

  def create_player(player_number)
    if GAME_MODES[@game_mode][player_number - 1] == 'Human'
      Human.new details(player_number)
    else
      Computer.new details(player_number, Player.ai?)
    end
  end

  def play
    until win? || tie?
      board.update_grid(current_player, current_player.move(board))
      board.show
      binding.pry
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
      break if @win
    end

    @win
  end

  def tie?
    return if win?

    @tie = true if board.filled?
  end

  # def player_move
  #   move = nil

  #   until board.valid_move? move
  #     ask_player_for_move
  #     possible_move = gets.chomp

  #     move = possible_move.to_i if possible_move.between?('0', '8')
  #   end

  #   move
  # end

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
