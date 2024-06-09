setup() {
    load 'test_helper/common-setup'
    _common_setup
}

# Load the build_table.sh script
load ../src/build_table.sh

@test "empty param supplies 52 cards" {
    # Setup expected output
    EXPECTED_OUTPUT="1 2 3 4 5 6 7 8 9"
    # Call the build_decks function
    run build_decks
    assert_output "$EXPECTED_OUTPUT"
}

@test "1 deck supplies 52 cards" {
    # Setup expected output
    EXPECTED_OUTPUT="1 2 3 4 5 6 7 8 9"
    # Call the build_decks function
    run build_decks
    assert_output "$EXPECTED_OUTPUT"
}

@test "2 decks supplies 104 cards" {
    EXPECTED_OUTPUT="1 2 3 4 5 6 7 8 9 1 2 3 4 5 6 7 8 9"
    run build_decks 2
    assert_output "$EXPECTED_OUTPUT"
}

@test "random # of decks equals total cards divided by random # is proper" {
    RANDOM_NUMBER=$(echo $((1 + $RANDOM % 10)))
    DECK_LENGTH_WITH_SPACES=18
    run build_decks $RANDOM_NUMBER
    OUTPUT_LENGTH=$(echo $output | wc -c)
    CALCULATED_OUTPUT=$(echo "$OUTPUT_LENGTH / $DECK_LENGTH_WITH_SPACES" | bc)
    assert_equal $CALCULATED_OUTPUT $RANDOM_NUMBER
}

@test "non-int to build_decks causes error" {
    run build_decks "notanumber"
    assert_failure
}
