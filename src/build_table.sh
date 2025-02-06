#!/usr/bin/env bash

build_decks() {
    # Setup n decks for the game, defaulting to 1 standard 52 card deck.
    local -a cards=()
    local suits=("♠" "♥" "♣" "♦")
    local values=("A" "2" "3" "4" "5" "6" "7" "8" "9" "10" "J" "Q" "K")
    
    # Check for input and validate
    local num_decks=${1:-1}  # Default to 1 if not specified
    
    # Check to see if non-num on input
    if [[ ! "$num_decks" =~ ^[0-9]+$ ]]; then
        return 1
    fi

    # Build complete deck(s)
    for (( d=1; d<=$num_decks; d++ )); do
        for suit in "${suits[@]}"; do
            for value in "${values[@]}"; do
                # Use printf to properly handle special characters and spaces
                printf "%s\n" "$value$suit"
            done
        done
    done
}

randomize_array_with_shuf() {
    # Take array by reference
    local -n shuffled_array=$1
    
    # Create a temporary array with shuffled values
    local -a shuffled=($(printf "%s\n" "${shuffled_array[@]}" | shuf))
    
    # Clear and reload the original array
    shuffled_array=("${shuffled[@]}")
}

deal_card() {
    local -n deal_card_array=$1
    local card="${deal_card_array[0]}"
    deal_card_array=("${deal_card_array[@]:1}")
    echo "$card"
}

calculate_hand_value() {
    local -a cards=("$@")
    local total=0
    local aces=0
    
    # Process each card
    for card in "${cards[@]}"; do
        value=${card%?}  # Remove suit
        case $value in

            "A") ((aces++)); ((total+=11));;
            "K"|"Q"|"J") ((total+=10));;
            *) ((total+=$value));;
        esac
    done
    
    # Adjust for aces if needed
    while (( total > 21 && aces > 0 )); do
        ((total-=10))
        ((aces--))
    done
    
    echo "$total"
}


# Gameplay functions
# Game start/initialization
# Number of players
# Number of decks
# Chips per player
# Deal initial cards

# Ante
# Player turn
# Hit or stand or split or double down or insurance then check bust or blackjack
# Dealer turn
# Hit or stand then check bust or blackjack
# Compare scores
# Payout
# Game end


# TODO: add hit() function
# TODO: add stand() function
# TODO: add bust() function
# TODO: add dealer_draw() function
# TODO: add compare_scores() function
# TODO: add play_game() function
# TODO: add player_turn() function
# TODO: add dealer_turn() function
# TODO: add check_bust() function
# TODO: add check_blackjack() function
# TODO: add check_dealer_turn() function
# TODO: add check_player_turn() function
# TODO: add check_game_over() function