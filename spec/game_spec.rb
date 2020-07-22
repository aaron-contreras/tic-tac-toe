# frozen_string_literal: true

require_relative '../lib/game.rb'

describe Game do


  describe '#game_over?' do
    subject(:game) { Game.new }

    before do
      allow_any_instance_of(Game).to receive(:show_instructions)
      allow_any_instance_of(Game).to receive(:game_mode).and_return 1
      allow_any_instance_of(Game).to receive(:create_player).with(1).and_return double('player1', piece: 'H')
      allow_any_instance_of(Game).to receive(:create_player).with(2).and_return double('player2', piece: 'P')
    end

    context 'game mode is human vs human' do
      context 'when board has three in a row horizontally' do
        it 'is over' do
          # Arrange
          winners_piece = game.player_one.piece
          board_arrangement = [
            winners_piece, winners_piece, winners_piece,
            '', '', '',
            '', '', ''
          ]
          game.board.instance_variable_set(:@grid, board_arrangement)

          expect(game).to be_game_over
        end
      end

      context 'when board has three in a row vertically' do
        it 'is over' do
          winners_piece = game.player_one.piece
          board_arrangement = [
            winners_piece, '', '',
            winners_piece, '', '',
            winners_piece, '', ''
          ]
          game.board.instance_variable_set(:@grid, board_arrangement)

          expect(game).to be_game_over
        end
      end

      context 'when board has three in a row diagonally' do
        it 'is over' do
          winners_piece = game.player_one.piece
          board_arrangement = [
            winners_piece, '', '',
            '', winners_piece, '',
            '', '', winners_piece
          ]
          game.board.instance_variable_set(:@grid, board_arrangement)
          expect(game).to be_game_over
        end
      end

      context "when the board is full" do
        it 'is over' do 
          board_arrangement = [
            'H', 'K', 'H',
            'K', 'H', 'K',
            'K', 'H', 'K'
          ]
          game.board.instance_variable_set(:@grid, board_arrangement)
          expect(game).to be_game_over
        end
      end

      context 'when the board is not full and no winners' do
        it 'is not over' do
          board_arrangement = [
            'H', '', '',
            '', '', '',
            '', '', ''
          ]
          game.board.instance_variable_set(:@grid, board_arrangement)
          expect(game).not_to be_game_over
        end
      end
    end
  end
end
