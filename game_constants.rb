# frozen_string_literal: true

module GameConstants
  GAME_MODES = {
    1 => %w[Human Human],
    2 => %w[Human Computer],
    3 => %w[Computer Computer]
  }.freeze

  WIN_CONDITIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 4, 8],
    [6, 4, 2], [0, 3, 6], [1, 4, 7], [2, 5, 8]
  ].freeze
end
