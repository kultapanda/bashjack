# Ante
# Player turn
# Hit or stand or split or double down or insurance then check bust or blackjack
# Dealer turn
# Hit or stand then check bust or blackjack

hitA() {
    local -n target_hand=$1  # nameref for the hand to modify
    local -a deck=("${!2}")  # copy of deck array
    
    # Deal a card
    #local card="${deck[0]}"
    #target_hand+=("$card")
    card=$(deal_card deck)
    target_hand+=("$card")
    
    # Remove card from deck (modify original deck via indirect reference)
    eval "$2=(\"\${deck[@]:1}\")"
    
    echo "$card"
}

hitB() {
    local hand_var=$1   # Name of hand variable
    local deck_var=$2   # Name of deck variable
    local card
    
    # Get the first card using indirect reference
    eval "card=\${$deck_var[0]}"
    
    # Add to hand
    eval "$hand_var+=(\"\$card\")"
    
    # Remove from deck
    eval "$deck_var=(\"\${$deck_var[@]:1}\")"
    
    echo "$card"
}

#hit() {
#    # Parameter 1: player_hand as an array
#    # Parameter 2: deck as an array
#    local player_hand=$1
#    local deck=$2
#    local card
#
#    card=$(deal_card deck)
#    player_hand+=("$card")
#}

#stand() {
#    # Signal that player's turn is over
#    return 0
#}
#
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