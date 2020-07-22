# frozen_string_literal: true

require_relative '../lib/game.rb'

describe Game do
  describe '#game_over?' do
    subject(:game) { Game.new }

    before do
      allow_any_instance_of(described_class).to receive(:show_instructions)
      allow_any_instance_of(described_class).to receive(:game_mode).and_return 1
      allow_any_instance_of(described_class).to receive(:create_player).with(1).and_return double('player1', piece: 'H')
      allow_any_instance_of(described_class).to receive(:create_player).with(2).and_return double('player2', piece: 'P')
    end

    let(:game_board) { game.board }
    let(:winner_piece) { game.player_one.piece }
    let(:loser_piece) { game.player_two.piece }

    context 'when board has three in a row horizontally' do
      context 'in top row' do
        it 'is over' do
          # Arrange
          board_arrangement = [
            winner_piece, winner_piece, winner_piece,
            loser_piece, '', '',
            loser_piece, '', ''
          ]
          game_board.instance_variable_set(:@grid, board_arrangement)

          expect(game).to be_game_over
        end
      end
      context 'in middle row' do
        it 'is over' do
          board_arrangement = [
            loser_piece, loser_piece, '',
            winner_piece, winner_piece, winner_piece,
            '', '', ''
          ]
          game_board.instance_variable_set(:@grid, board_arrangement)
          expect(game).to be_game_over
        end
      end
      context 'in bottom row' do
        it 'is over' do
          board_arrangement = [
            loser_piece, '', loser_piece,
            loser_piece, '', '',
            winner_piece, winner_piece, winner_piece
          ]
          game_board.instance_variable_set(:@grid, board_arrangement)
          expect(game).to be_game_over
        end
      end
    end

    context 'when board has three in a row vertically' do
      context 'in left column' do
        it 'is over' do
          board_arrangement = [
            winner_piece, loser_piece, '',
            winner_piece, loser_piece, '',
            winner_piece, '', ''
          ]
          game_board.instance_variable_set(:@grid, board_arrangement)

          expect(game).to be_game_over
        end
      end

      context 'in middle column' do
        it 'is over' do
          board_arrangement = [
            loser_piece, winner_piece, '',
            '', winner_piece, loser_piece,
            '', winner_piece, ''
          ]
          game_board.instance_variable_set(:@grid, board_arrangement)
          expect(game).to be_game_over
        end
      end

      context 'in right column' do
        it 'is over' do
          board_arrangement = [
            loser_piece, '', winner_piece,
            '', loser_piece, winner_piece,
            loser_piece, '', winner_piece
          ]
          game_board.instance_variable_set(:@grid, board_arrangement)
          expect(game).to be_game_over
        end
      end
    end

    context 'when board has three in a row diagonally' do
      context 'from top left to bottom right' do
        it 'is over' do
          board_arrangement = [
            winner_piece, '', '',
            loser_piece, winner_piece, '',
            loser_piece, '', winner_piece
          ]
          game_board.instance_variable_set(:@grid, board_arrangement)
          expect(game).to be_game_over
        end
      end

      context 'from bottom left to top right' do
        it 'is over' do
          board_arrangement = [
            loser_piece, '', winner_piece,
            loser_piece, winner_piece, '',
            winner_piece, '', ''
          ]
          game_board.instance_variable_set(:@grid, board_arrangement)
          expect(game).to be_game_over
        end
      end
    end

    context 'when the board is full' do
      it 'is over' do
        board_arrangement = [
          winner_piece, loser_piece, winner_piece,
          loser_piece, winner_piece, loser_piece,
          loser_piece, winner_piece, loser_piece 
        ]
        game_board.instance_variable_set(:@grid, board_arrangement)
        expect(game).to be_game_over
      end
    end

    context 'when the board is not full and no winners' do
      it 'is not over' do
        board_arrangement = [
          winner_piece, loser_piece, '',
          '', '', '',
          '', '', ''
        ]
        game_board.instance_variable_set(:@grid, board_arrangement)
        expect(game).not_to be_game_over
      end
    end

    context 'when the board is empty' do
      it 'is not over' do
        board_arrangment = [
          '', '', '',
          '', '', '',
          '', '', ''
        ]
        game_board.instance_variable_set(:@grid, board_arrangment)
        expect(game).not_to be_game_over
      end
    end
  end
end
