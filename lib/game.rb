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

  def computer_mode(player_number)
    ask_computer_mode(@game_mode, player_number)
    selection = gets.chomp.downcase.to_sym until COMPUTER_MODES.key? selection
    COMPUTER_MODES[selection]
  end

  def details(player_number, is_ai = nil)
    return computer_mode(player_number) if is_ai

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

  def update_board
    board.update_grid(current_player, players_move)
    board.show
  end

  def thinking
    puts "#{current_player.name} is thinking..."
    sleep(1)
  end

  def play
    loop do
      check_if_players_can_win
      ask_player_for_move if current_player.instance_of? Human
      thinking if current_player.instance_of? Computer
      update_board
      break if game_over?

      switch_turns
    end
  end

  def game_over?
    win? || tie?
  end

  def game_over_message
    win? ? win_message(current_player) : tie_message
  end

  def start_game
    board.show
    play
    game_over_message
  end

  private

  def find_matches(win_condition, piece)
    @win = win_condition.all? do |index|
      board.cell_at(index) == piece
    end
  end

  def win?
    WIN_CONDITIONS.each do |win_condition|
      return true if find_matches(win_condition, player_one.piece)
      return true if find_matches(win_condition, player_two.piece)
    end

    false
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
