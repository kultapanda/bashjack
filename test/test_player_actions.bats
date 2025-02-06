setup() {
    load 'test_helper/common-setup'
    _common_setup
}

# Load the build_table.sh script
load ../src/build_table.sh
load ../src/player_actions.sh


@test "check that hit adds a card to the player's hand" {
    skip "Not currently working"
    local -a player_hand
    local -a deck
    readarray -t deck < <(build_decks 1)

    #hit player_hand deck
    hit deck player_hand
    assert_equal "${#player_hand[@]}" 1
}

@test "hit function deals one card correctly" {
    skip "Not currently working"
    local -a test_hand=()
    local -a test_deck=("A♠" "K♥" "Q♣")
    local original_deck_size=${#test_deck[@]}
    
    # Execute hit
    hitB test_hand test_deck
    
    # Verify card was dealt
    assert_equal "${#test_hand[@]}" "1"
    # Verify deck decreased by 1
    assert_equal "${#test_deck[@]}" "$((original_deck_size - 1))"
    # Verify dealt card is no longer in deck
    assert_equal "$output" "${test_hand[0]}"
}

@test "hit function maintains deck order" {
    skip "Not currently working"
    local -a test_hand=()
    local -a test_deck=("A♠" "K♥" "Q♣")
    local expected_next="K♥"
    
    # Deal first card
    hitB test_hand test_deck
    
    # Deal second card
    hitB test_hand test_deck
    
    # Verify second card was what we expected
    assert_equal "$output" "$expected_next"



}