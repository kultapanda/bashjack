setup() {
    load 'test_helper/common-setup'
    _common_setup
}

load ../src/game_functions.sh
load ../src/build_table.sh
@test "verify intro is printed" {
    run game_intro
    assert_output --partial "Welcome to Blackjack!"
    assert_output --partial "You are playing against the dealer."
    assert_output --partial "The goal is to get as close to 21 as possible without going over."
    assert_output --partial "Good luck!"
}

@test "verify initialize_table initializes players and dealer" {
    run initialize_table 1 1 100
    assert_output --partial "Player 0: 100"
    assert_output --partial "Dealer: 0"
}

@test "verify initialize_table initializes deck" {
    run initialize_table 1 1 100
    assert_output --partial "Deck initialized"
}

@test "verify deal_initial_cards deals correct number of cards" {
    # Setup test deck and hands
    local -a test_deck=("A♠" "K♥" "Q♣" "J♦")
    declare -A player_hands
    player_hands[0]=""  # Initialize player slot
    local dealer_hand=""
    
    # Deal cards
    deal_initial_cards test_deck player_hands dealer_hand
    
    # Verify player got 2 cards
    assert_equal "$(echo ${player_hands[0]} | wc -w)" "2"
    
    # Verify dealer got 2 cards
    assert_equal "$(echo $dealer_hand | wc -w)" "2"
    
    # Verify deck has correct number of remaining cards
    assert_equal "${#test_deck[@]}" "0"
}

@test "verify deal_initial_cards works with multiple players" {
    # Setup test deck
    local -a test_deck=("A♠" "K♥" "Q♣" "J♦" "10♠" "9♥")
    declare -A player_hands
    player_hands[0]=""  # Initialize first player slot
    player_hands[1]=""  # Initialize second player slot
    local dealer_hand=""
    
    # Deal cards
    deal_initial_cards test_deck player_hands dealer_hand
    
    # Verify each player got 2 cards
    assert_equal "$(echo ${player_hands[0]} | wc -w)" "2"
    assert_equal "$(echo ${player_hands[1]} | wc -w)" "2"
    
    # Verify dealer got 2 cards
    assert_equal "$(echo $dealer_hand | wc -w)" "2"
    
    # Verify deck has correct number of remaining cards
    assert_equal "${#test_deck[@]}" "0"
}