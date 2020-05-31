# frozen_string_literal: true

require_relative './player.rb'
require_relative './human.rb'
require_relative './computer.rb'
require_relative './board.rb'
require_relative './displayable.rb'
require_relative './game_constants.rb'
# Contains the tic-tac-toe logic
class Game
  include Displayable
  include GameConstants
  attr_reader :player_one, :player_two, :board
  attr_writer :player_one_turn

  def initialize
    show_instructions
    @board = Board.new
    @game_mode = game_mode
    @player_one = create_player(1)
    @player_two = create_player(2)
    @player_one_turn = rand(2)
    @win = false
  end

  def game_mode
    ask_game_mode GAME_MODES
    mode = gets.chomp.to_i until GAME_MODES.key? mode
    mode
  end

  def computer_mode
    ask_computer_mode
    selection = gets.chomp.downcase.to_sym until COMPUTER_MODES.key? selection
    COMPUTER_MODES[selection]
  end

  def details(player_number, is_ai = nil)
    return computer_mode if is_ai

    ask_players_name player_number
    name = gets.chomp

    ask_players_piece name
    piece = gets.chomp[0].upcase
    [name, piece]
  end

  def create_player(player_number)
    if GAME_MODES[@game_mode][player_number - 1] == 'Human'
      Human.new details(player_number)
    else
      Computer.new details(player_number, Player.ai?)
    end
  end

  def players_move
    current_player.move(board, other_player)
  end

  def check_if_players_can_win
    current_player.can_win?(board, WIN_CONDITIONS)
    other_player.can_win?(board, WIN_CONDITIONS)
  end

  def play
    until win? || tie?
      check_if_players_can_win
      board.update_grid(current_player, players_move)
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
    WIN_CONDITIONS.each do |win_condition|
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

  def switch_turns
    self.player_one_turn = player_one_turn? ? false : true
  end

  def player_one_turn?
    @player_one_turn
  end

  def current_player
    player_one_turn? ? player_one : player_two
  end

  def other_player
    player_one_turn? ? player_two : player_one
  end
end

game = Game.new
game.start_game
