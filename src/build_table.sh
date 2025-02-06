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
    local -n arr=$1
    
    # Create a temporary array with shuffled values
    local -a shuffled=($(printf "%s\n" "${arr[@]}" | shuf))
    
    # Clear and reload the original array
    arr=("${shuffled[@]}")
}

deal_card() {
    local -n arr=$1
    local card="${arr[0]}"
    arr=("${arr[@]:1}")
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