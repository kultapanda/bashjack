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
    local num_decks=${1:-1}
    local num_players=${2:-1}
    local chips_per_player=${3:-100}

    # Initialize deck
    readarray -t deck < <(build_decks $num_decks)
    randomize_array_with_shuf deck

    # Initialize players
    declare -A players
    for ((i=0; i<num_players; i++)); do
        players[$i]=$chips_per_player
    done

    # Initialize dealer
    declare -A dealer
    dealer[chips]=0
    
    
    
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