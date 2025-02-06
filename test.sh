#!/usr/bin/env bash

declare -a foreverarray

function inside() {
	local -n arr=$1
    # Modify first element of array
    arr[0]="modified_${arr[0]}"
}
# Add some initial values to foreverarray
foreverarray=("first" "second" "third")

# Print initial values
echo "Before inside() call:"
printf "%s\n" "${foreverarray[@]}"

# Call inside with foreverarray
inside foreverarray

# Print values after call
echo -e "\nAfter inside() call:" 
printf "%s\n" "${foreverarray[@]}"

function example_function() {
    # Initialize default values
    local params=(
        ["name"]="default_name"
        ["age"]=0
        ["city"]="unknown"
    )
    
    # Parse named parameters
    local key
    for arg in "$@"; do
        if [[ $arg == *"="* ]]; then
            key="${arg%%=*}"
            params[$key]="${arg#*=}"
        fi
    done
    
	echo "---"

    # Use the parameters
    echo "Name: ${params[name]}"
    echo "Age: ${params[age]}"
    echo "City: ${params[city]}"
}

# Usage:
example_function name="John" age=30 city="New York"


echo "---"

declare -a player_hand=("J♥")
declare -a deck=("A♠" "K♥" "Q♣")
declare -A params
params=(
    ["player_hand"]=player_hand
    ["deck"]=deck
)

test_hit_function() {
	if [[ -v params["player_hand"] ]]; then
		echo "player_hand is set"
		local -n hit_func_player_hand=${params["player_hand"]}
		echo "values are: ${hit_func_player_hand[@]}"
	else
		echo "player_hand is not set"
	fi
	if [[ -v params["deck"] ]]; then
		echo "deck is set"
		local -n hit_func_deck=${params["deck"]}
		echo "values are: ${hit_func_deck[@]}"
	else
		echo "deck is not set"
	fi
	
}

test_hit_function params