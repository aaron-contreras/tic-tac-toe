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
  - [x] Extreme
    - [x] Plays perfect strategy
      - [x] Opening moves
        - If Computer starts
          - [x] Play corner or center move
          - If played corner
            - [x] Play opposite corner next
            - [x] Follow strategy afterwards 
        - If Human starts
          - If Human played Center
            - [x] Play corner
            - [x] Follow strategy
          - If Human Played Corner
            - [x] Play Center
          - Follow strategy in order
            - [x] Win
              - Player has two in a row
              - Place the move in the remaining cell.
            - [x] Block
              - 'Very' mode
              - If the opponent has two in a row, place the move in the missing cell
            - [x] Blocking an opponent's fork
              - [x] If the opponent has two opposite corners marked and computer has a center move only
                - [x] Play an empty edge
            - [x] Center
              - [x] Mark the center if available
            - [x] Opposite corner
               - [x] If the opponent is in the corner, computer plays the opposite corner.
            - [x] Empty corner
              - [x] The player plays in a corner square
            - [x] Empty side
              - [x] The player plays in any edge square
  - [ ] Computer cheating mode lol
