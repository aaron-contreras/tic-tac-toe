# frozen_string_literal: true

# Players required to play a game
class Player
  attr_reader :piece, :name, :moves
  attr_accessor :winning_move

  MOVES = {
    center: 4,
    edge: [1, 3, 5, 7],
    corner: [0, 2, 6, 8],
    adjacent_corners: [[0, 2], [2, 8], [8, 6], [6, 0]]
  }.freeze

  FORKS = {
    corner: [[0, 8], [2, 6]]
  }.freeze

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

  def can_fork?(other_player)
    lined_up_corners = FORKS[:corner].any? do |corner_fork|
      (corner_fork - @moves).empty?
    end

    only_center_move = other_player.moves[0] == MOVES[:center]

    lined_up_corners && only_center_move
  end

  def clear_winning_move(other_player)
    other_player.winning_move = nil
  end

  def can_win?(board, win_conditions)
    @winning_move = nil
    win_conditions.each do |condition|
      matches = @moves.select do |move|
        condition.include? move
      end

      if matches.length == 2
        missing_move = (condition - matches).first.to_i
        break (@winning_move = missing_move) if board.cell_at(missing_move).empty?
      end
    end

    @winning_move.nil? ? false : true
  end
end
