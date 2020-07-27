# frozen_string_literal: true

require_relative '../lib/board.rb'

describe Board do
  subject(:board) { described_class.new }

  describe '#build_grid' do
    it 'creates a 9-celled board' do
      # Arrange
      grid = board.instance_variable_get(:@grid)

      # Act/Assert
      expect(grid.size).to eq 9
    end
  end

  describe '#update_grid' do
    let(:player) { double('Player', piece: 'A') }

    it 'adds a move to the board' do
      # Arrange
      cell = 0
      grid = board.instance_variable_get(:@grid)
      
      # Act/Assert
      expect { board.update_grid(player, cell) }.to change { grid[cell] }
    end
  end

  describe '#valid_move?' do
    context 'when given an out-of-bounds move' do
      context 'when it goes over the range' do
        it 'is invalid' do
          # Arrange
          move = 13

          # Act/Assert
          expect(board.valid_move?(move)).to be false
        end
      end

      context 'when it goes below the range' do
        it 'is invalid' do
          # Arrange
          move = -3
          
          # Act/Assert
          expect(board.valid_move?(move)).to be false
        end
      end
    end

    context 'when given a move that is already played' do
      it 'is invalid' do
        # Arrange
        board_arrangement = [
          'A', '', '',
          '', '', '',
          '', '', ''
        ]

        board.instance_variable_set(:@grid, board_arrangement)

        move = 0

        # Act/Assert
        expect(board.valid_move?(move)).to be false
      end
    end

    context 'when given a valid move' do
      it 'is valid' do
        # Arrange
        move = 3

        expect(board.valid_move?(move)).to be true
      end
    end
  end
end