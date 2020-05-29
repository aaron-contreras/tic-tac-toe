# frozen_string_literal: true

# Players required to play a game
require 'pry'
class Player
  attr_reader :piece, :name
  attr_accessor :winning_move

  def initialize(player_info)
    @name = player_info[0]
    @piece = player_info[1]
    @turn = false
    @moves = []
    @winning_move = nil
  end

  def turn?
    @turn
  end

  def move(board, other_player); end

  def self.ai?
    true
  end

  def add_move_to_list(move)
    @moves.push(move)
  end

  def can_win?(board, win_conditions)
    win_conditions.each_with_index do |condition, index|
      matches = @moves.select do |move|
        condition.include? move
      end

      if matches.length == 2
        missing_move = (condition - matches).first.to_i
        p "#{self} can win at #{missing_move} and the cell contains #{board.cell_at(missing_move)}"
        break (@winning_move = missing_move) if board.cell_at(missing_move).empty?
      end
    end

    @winning_move.nil? ? false : true
  end
end
