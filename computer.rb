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

  def not_much(board, _other_player)
    board.empty_cells.sample
  end

  def very(board, other_player)
    other_player.winning_move || not_much(board, other_player)
  end

  def fork_game(board)
    corners_to_fork = board.empty_cells & MOVES[:corner]
    corners_to_fork.sample
  end

  def block_fork(board)
    empty_edges = board.empty_cells & MOVES[:edge]
    empty_edges.sample
  end

  def only_move_is_corner
    @moves.length == 1 && MOVES[:corner].include?(@moves.first)
  end

  def opposite_corner
    return unless only_move_is_corner

    fork_move = FORKS[:corner].select do |combo|
      combo.include? @moves.first
    end.flatten

    (fork_move - @moves)[0].to_i
  end

  def win_or_block_win(other_player)
    return winning_move if winning_move
    return other_player.winning_move if other_player.winning_move
  end

  def fork_or_block_fork(board, other_player)
    return fork_game(board) if can_fork?(other_player)
    return block_fork(board) if other_player.can_fork?(self)
  end

  def play_remaining_moves_in_priority(board)
    return MOVES[:center] if board.center_empty?
    return opposite_corner if board.opposite_empty? opposite_corner
    return board.empty_corner(MOVES[:corner]) if board.empty_corner(MOVES[:corner])
    return board.empty_side(MOVES[:edge]) if board.empty_side(MOVES[:edge])
  end

  def genius(board, other_player)
    win_or_block_win(other_player) ||
      fork_or_block_fork(board, other_player) ||
      play_remaining_moves_in_priority(board)
  end
end
