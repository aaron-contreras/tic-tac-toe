# frozen_string_literal: true

require_relative './player.rb'
# Player controlled by A.I.
class Computer < Player
  LEVELS = %w[not_much very genius].freeze

  def initialize(player_info)
    super (player_info.first 2)
    @intelligence = player_info.last
  end

  def self.match_modes(intelligence)
    LEVELS.select do |level|
      level[0] == intelligence
    end[0]
  end

  def self.intelligence_level
    loop do
      selected_mode = gets.chomp[0]
      intelligence = match_modes(selected_mode)
      break intelligence unless intelligence.empty?
    end
  end

  def move(board, other_player)
    move = send(@intelligence.to_sym, board, other_player)
    add_move_to_list move
    clear_winning_move other_player
    move
  end

  def clear_winning_move(other_player)
    other_player.winning_move = nil
  end

  def not_much(board, _other_player)
    board.empty_cells.sample
  end

  def very(board, other_player)
    other_player.winning_move || not_much(board, other_player)
  end
end
