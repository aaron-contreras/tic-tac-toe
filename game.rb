require_relative 'player'
require_relative 'board'

class Game
  SAMPLE = Board.new :sample
  @@selection = 1
  @@player_one_turn = true

  def initialize player_one_info, player_two_info
    @board = Board.new :playing
    @player_one = Player.new player_one_info
    @player_two = Player.new player_two_info
    @win = false
  end

  def self.show_instructions
    puts "Tic-Tac-Toe".center(80)
    puts "--------------".center(80)
    print "These are the move positions on the board. "
    puts "They're labeled 0-8 from left to right, top to bottom."
    SAMPLE.show
    puts
  end

  def self.start_game
    show_instructions
    Game.new get_player_info, get_player_info
  end

  def self.get_player_info
    print "What is Player #{@@selection}'s name? "
    name = gets.chomp

    print "What piece will #{name} be playing as? Choose any character of your liking: "
    piece = gets.chomp.upcase

    @@selection += 1
    [name, piece]
  end

  def play
   board.show 
    until win? || tie?
      board.update_grid(current_player, get_move)
      board.show
      switch_turns unless win? || tie?
    end

    if win?
      puts "#{current_player.name} has won!"
    else
      puts "It's a tie!"
    end
  end

  private
  attr_reader :player_one, :player_two, :board

  def win?
    win_conditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 4, 8],
      [6, 4, 2],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8]
    ]

    win_conditions.each do |win_condition|
      @win = true if (win_condition.all? {|index| board.cell_at(index) == player_one.piece})
      @win = true if (win_condition.all? {|index| board.cell_at(index) == player_two.piece})
    end

    @win
  end

  def tie?
    unless win?
      @tie = true if board.filled?
    end
  end

  def get_move
    move = nil

    until board.valid_move? move
      print "Where would you like to place your move? "
      move = gets.chomp

      if move.between?('0', '8') && move.length == 1
        move = move.to_i
      else
        move = nil
      end
    end
    move
  end

  def switch_turns
    if player_one_turn?
      self.player_one_turn = false
    else
      self.player_one_turn = true
    end
  end

  def player_one_turn?
    @@player_one_turn
  end

  def player_one_turn=(value)
    @@player_one_turn = value
  end

  def current_player
    if player_one_turn?
      player_one
    else
      player_two
    end
  end

end

game = Game.start_game
game.play