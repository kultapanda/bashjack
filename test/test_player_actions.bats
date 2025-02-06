setup() {
    load 'test_helper/common-setup'
    _common_setup
}

# Load the build_table.sh script
load ../src/build_table.sh
load ../src/player_actions.sh


@test "check that hit adds a card to the player's hand" {
    local -a test_hand=()
    local -a test_deck=("A♠" "K♥" "Q♣")

    hit test_hand test_deck
    assert_equal "${#test_hand[@]}" 1
}

@test "hit function deals one card correctly" {
    local -a test_hand=()
    local -a test_deck=("A♠" "K♥" "Q♣")
    local original_deck_size=${#test_deck[@]}
    
    # Execute hit
    hit test_hand test_deck
    
    # Verify card was dealt
    assert_equal "${#test_hand[@]}" "1"
    # Verify deck decreased by 1
    assert_equal "${#test_deck[@]}" "$((original_deck_size - 1))"
    # Verify dealt card is not in remaining deck
    local found=0
    for card in "${test_deck[@]}"; do
        if [[ "$card" == "${test_hand[0]}" ]]; then
            found=1
            break
        fi
    done
    assert_equal "$found" "0"
}

@test "hit function maintains deck order" {
    local -a test_hand=()
    local -a test_deck=("A♠" "K♥" "Q♣")
    local expected_next="K♥"
    
    # Deal first card
    hit test_hand test_deck
    
    # Deal second card
    hit test_hand test_deck
    
    # Verify second card was what we expected
    assert_equal "${test_hand[1]}" "$expected_next"



}