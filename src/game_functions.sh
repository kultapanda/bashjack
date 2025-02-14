# Initialization:
# Gameplay functions
# Game start/initialization
# Number of players
# Number of decks
# Chips per player
# Deal initial cards

game_intro() {
    echo "Welcome to Blackjack!"
    echo "You are playing against the dealer."
    echo "The goal is to get as close to 21 as possible without going over."
    echo "Good luck!"
    # TODO: Add prompts for number of players, number of decks, and chips per player
}

initialize_table() {
    # Parameters:
    # 1: num_decks
    # 2: num_players
    # 3: chips_per_player
    local initialize_table_num_decks=${1:-1}
    local initialize_table_num_players=${2:-1}
    local initialize_table_chips_per_player=${3:-100}

    # Initialize deck
    readarray -t initialize_table_deck < <(build_decks $initialize_table_num_decks)
    randomize_array_with_shuf initialize_table_deck
    echo "Deck initialized"

    # Initialize players
    declare -A initialize_table_players
    for ((i=0; i<initialize_table_num_players; i++)); do
        initialize_table_players[$i]=$initialize_table_chips_per_player
        echo "Player $i: ${initialize_table_players[$i]}"
    done

    # Initialize dealer
    declare -A initialize_table_dealer
    initialize_table_dealer[chips]=0
    echo "Dealer: ${initialize_table_dealer[chips]}"
    
    
    
}

blackjack_check() {
    # Parameter 1: player_hand as an array
    local -n player_hand=$1
    local player_value
    player_value=$(calculate_hand_value "${player_hand[@]}")
    if (( player_value == 21 )); then
        return 0
    fi
}

bust_check() {
    # Parameter 1: player_hand as an array
    local -n player_hand=$1
    local player_value
    player_value=$(calculate_hand_value "${player_hand[@]}")
    if (( player_value > 21 )); then
        return 0
    fi
    return 1
}



# Game State and actions:
# Compare scores
# Payout
# Game end

deal_initial_cards() {
    # Parameters:
    # 1: init_deck
    # 2: player_hands
    # 3: dealer_hand
    local -n deck=$1
    local -n players=$2
    local -n dealer=$3
    
    # Deal 2 cards to each player
    for player in "${!players[@]}"; do
        players[$player]="${deck[0]} ${deck[1]}"
        deck=("${deck[@]:2}")
    done
    
    # Deal 2 cards to dealer
    dealer="${deck[0]} ${deck[1]}"
    deck=("${deck[@]:2}")
}

#play_round() {
#    local -n round_deck=$1
#    local -n player_hands=$2
#    local -n dealer_hand=$3
#    
#    # Deal initial cards
#    # Player turns
#    # Dealer turn
#    # Compare hands
#    # Handle payouts
#}
#
#compare_hands() {
#    local player_value=$1
#    local dealer_value=$2
#    
#    # Return: 1=player wins, 0=push, -1=dealer wins
#}
#
#place_bet() {
#    local -n player_chips=$1
#    local min_bet=${2:-10}
#    local max_bet=${3:-100}
#    
#    # Handle bet input and validation
#}
#
#handle_payout() {
#    local result=$1
#    local bet=$2
#    local -n chips=$3
#    
#    # Calculate and apply winnings/losses
#}