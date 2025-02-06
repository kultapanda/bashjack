# Ante
# Player turn
# Hit or stand or split or double down or insurance then check bust or blackjack
# Dealer turn
# Hit or stand then check bust or blackjack

hit() {
    # Parameter 1: player_hand as an array
    # Parameter 2: deck as an array
    local -n hit_player_hand=$1
    local -n hit_deck=$2

    hit_player_hand+=("$(deal_card hit_deck)")
    # We need to explicitly update hit_deck to match the modified deck due to the way bash handles arrays in subshells, which is unfortunate, but it's a limitation of bash.
    hit_deck=("${hit_deck[@]:1}")
}

#stand() {
#    # Signal that player's turn is over
#    return 0
#}

#dealer_play() {
#    # Parameter 1: dealer_hand as an array
#    # Parameter 2: deck as an array
#    local -n dealer_hand=$1
#    local -n deck=$2
#    local dealer_value
#    
#    while true; do
#        dealer_value=$(calculate_hand_value "${dealer_hand[@]}")
#        if (( dealer_value >= 17 )); then
#            break
#        fi
#        hit dealer_hand deck
#    done
#}