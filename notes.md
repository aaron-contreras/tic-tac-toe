# Computer vs Human version implementation notes

I have found a "perfect match" strategy on wikipedia so let's implement that as the computer's logic to play against a Human "A.I." (in quotes yeah...)

First let's set up the task list of things to be done for this version

- [x] Read up on rubocop
- [x] Implement rubocop into my project
- [x] Set game modes
  - [x] Human vs Human
  - [x] Human vs Computer
  - [x] Computer vs Computer
- [x] Break down the logic of the computer's moves
- [x] Call the corresponding method of difficulty depending on intelligence level
  - [x] Easy
    - [x] Computer plays random moves.
      - [x] Get the empty cells in the board.
      - [x] Pick a random cell from the empty ones
  - [x] Medium
    - [x] Play as easy mode unless the other player is missing one move to win
    - **One move to win**
      - [x] Compare winning_moves with the opposites player move_list
      - [x] if a player's moves matches a two moves in a winning condition and the remaining move is empty
        - [x] set the player's winning move at that cell
      - [x] If other player has a winning move
        - [x] Place the move in the remaining square (`one?` method)
  - [ ] Extreme
  - [ ] Computer cheating mode lol
