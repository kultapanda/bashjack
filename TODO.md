# Blackjack Game Implementation TODO List

## Game Setup and Initialization
- [X] `game_intro()` - Display welcome message and game rules
- [X] `initialize_table()` - Set up game table with players, dealer, and chips
- [X] `build_decks()` - Create specified number of card decks
- [X] `randomize_array_with_shuf()` - Shuffle the deck
- [ ] `collect_settings()` - Get number of players, decks, and chips from user

## Card Handling
- [X] `deal_card()` - Deal a single card from the deck
- [X] `deal_initial_cards()` - Deal starting hands to players and dealer
- [X] `calculate_hand_value()` - Calculate the value of a hand

## Game State Checks
- [X] `blackjack_check()` - Check if a hand is blackjack
- [X] `bust_check()` - Check if a hand is bust
- [ ] `check_for_winner()` - Determine winner of the round
- [ ] `compare_hands()` - Compare player and dealer hands

## Player Actions
- [X] `hit()` - Take another card
- [ ] `stand()` - End turn
- [ ] `split()` - Split paired cards into two hands
- [ ] `double_down()` - Double bet and take one more card
- [ ] `insurance()` - Place insurance bet against dealer blackjack
- [ ] `surrender()` - Give up hand for half bet back

## Dealer Actions
- [ ] `dealer_play()` - Execute dealer's turn according to rules
- [ ] `reveal_hole_card()` - Show dealer's face-down card

## Betting and Money Management
- [ ] `place_bet()` - Handle player betting
- [ ] `handle_payout()` - Process winnings/losses
- [ ] `update_chips()` - Update player chip counts
- [ ] `check_player_funds()` - Verify player has enough chips to bet

## Game Flow Control
- [ ] `menu_loop()` - Main game menu
- [ ] `game_loop()` - Main game round loop
- [ ] `player_turn()` - Handle player's turn
- [ ] `player_action_loop()` - Process player actions
- [ ] `dealer_turn()` - Handle dealer's turn
- [ ] `dealer_action_loop()` - Process dealer actions
- [ ] `announce_winner()` - Display round results
- [ ] `play_round()` - Execute a complete round of play

## Display Functions
- [ ] `display_table()` - Show current game state
- [ ] `display_hand()` - Show cards in a hand
- [ ] `display_chips()` - Show player chip counts
- [ ] `display_dealer_hand()` - Show dealer's hand (with hidden card if needed)

## Utility Functions
- [ ] `save_game()` - Save current game state
- [ ] `load_game()` - Load saved game state
- [ ] `validate_bet()` - Verify bet is valid
- [ ] `clear_hands()` - Reset hands for new round 