#!/usr/bin/env bash

# Initialize arrays for suits and ranks
suits=("Hearts" "Diamonds" "Clubs" "Spades")
ranks=("2" "3" "4" "5" "6" "7" "8" "9" "10" "Jack" "Queen" "King" "Ace")

# Declare an empty array for the deck
deck=()

# Populate the deck array with all combinations of suits and ranks
for suit in "${suits[@]}"; do
  for rank in "${ranks[@]}"; do
    deck+=("$rank of $suit")
  done
done

# Print the entire deck
for card in "${deck[@]}"; do
  echo "$card"
done

echo "----"
echo ${!deck[@]}
