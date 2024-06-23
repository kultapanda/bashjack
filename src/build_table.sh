#!/usr/bin/env bash

build_decks() {
    # Setup n decks for the game, defaulting to 1 standard 52 card deck.
    local decks
    # Check for input
    if [[ -z $1 ]]; then
        local num_decks=1
    else
        local num_decks=$1
    fi

    # Check to see if non-num on input
    if [[ $(echo $1 | grep '[[:alpha:]]' ) ]]; then
        return 1
    fi

    # iterate num_decks times to the output of this function to pass test
    for (( i=1; i<=$num_decks; i++ )); do
        # Note trailing whitespace to make sure multiple sets are properly spaced
        local decks+="$(seq 1 9) "
    done
    echo $decks
}

randomize_array_with_shuf() {
  # named ref the incoming array
  declare -n input_array=$1
  # snag dem keys
  local keys=("${!input_array[@]}")
  # shuffle keys into an array with 'shuf'
  local randomized_keys=($(printf "%s\n" "${keys[@]}" | shuf))

  # create new array
  declare -A shuffled_array
  # associate the values of the keys from the input_array
  for key in "${!randomized_keys[@]}"; do
    shuffled_array["$key"]="${input_array[$key]}"
  done
  # TODO: Not yet finished i think
}
