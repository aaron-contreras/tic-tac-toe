# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/game.rb'

describe Game do
  subject(:game) { Game.new }
  let(:game_board) { game.board }

  before do
    allow(game).to receive(:player_one).and_return double('player_one', piece: 'A')
    allow(game).to receive(:player_two).and_return double('player_two', piece: 'V')
  end

  let(:winner) { game.player_one.piece }
  let(:loser) { game.player_two.piece }

  describe '#game_over?' do
    context 'when board has three in a row horizontally' do
      context 'in top row' do
        it 'is over' do
          # Arrange
          board_arrangement = [
            winner, winner, winner,
            loser, '', '',
            loser, '', ''
          ]

          game_board.instance_variable_set(:@grid, board_arrangement)

          expect(game).to be_game_over
        end
      end
      context 'in middle row' do
        it 'is over' do
          board_arrangement = [
            loser, loser, '',
            winner, winner, winner,
            '', '', ''
          ]
          game_board.instance_variable_set(:@grid, board_arrangement)
          expect(game).to be_game_over
        end
      end
      context 'in bottom row' do
        it 'is over' do
          board_arrangement = [
            loser, '', loser,
            loser, '', '',
            winner, winner, winner
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
            winner, loser, '',
            winner, loser, '',
            winner, '', ''
          ]
          game_board.instance_variable_set(:@grid, board_arrangement)

          expect(game).to be_game_over
        end
      end

      context 'in middle column' do
        it 'is over' do
          board_arrangement = [
            loser, winner, '',
            '', winner, loser,
            '', winner, ''
          ]
          game_board.instance_variable_set(:@grid, board_arrangement)
          expect(game).to be_game_over
        end
      end

      context 'in right column' do
        it 'is over' do
          board_arrangement = [
            loser, '', winner,
            '', loser, winner,
            loser, '', winner
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
            winner, '', '',
            loser, winner, '',
            loser, '', winner
          ]
          game_board.instance_variable_set(:@grid, board_arrangement)
          expect(game).to be_game_over
        end
      end

      context 'from bottom left to top right' do
        it 'is over' do
          board_arrangement = [
            loser, '', winner,
            loser, winner, '',
            winner, '', ''
          ]
          game_board.instance_variable_set(:@grid, board_arrangement)
          expect(game).to be_game_over
        end
      end
    end

    context 'when the board is full' do
      it 'is over' do
        board_arrangement = [
          winner, loser, winner,
          loser, winner, loser,
          loser, winner, loser
        ]
        game_board.instance_variable_set(:@grid, board_arrangement)
        expect(game).to be_game_over
      end
    end

    context 'when the board is not full and no winners' do
      it 'is not over' do
        board_arrangement = [
          winner, loser, '',
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

  describe '#play' do
    it 'loops until game is over' do
      # Arrange
      board_arrangement = [
        winner, loser, loser,
        winner, loser, winner,
        winner, winner, loser
      ]

      game_board.instance_variable_set(:@grid, board_arrangement)

      allow(game).to receive(:check_if_players_can_win)
      allow(game).to receive(:ask_player_for_move)
      allow(game).to receive(:thinking)
      allow(game).to receive(:update_board)
      allow(game).to receive(:switch_turns)

      # Assert
      expect(game).to receive(:game_over?).once.and_return(true)

      # Act
      game.play
    end
  end
end

# rubocop:enable Metrics/BlockLength
