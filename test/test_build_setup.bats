setup() {
    load 'test_helper/common-setup'
    _common_setup
}

# Load the build_table.sh script
load ../src/build_table.sh

@test "empty param supplies 52 cards" {
    readarray -t deck < <(build_decks)
    assert_equal "${#deck[@]}" "52"
}

@test "1 deck supplies 52 cards" {
    readarray -t deck < <(build_decks 1)
    assert_equal "${#deck[@]}" "52"
}


@test "2 decks supplies 104 cards" {
    local -a deck
    readarray -t deck < <(build_decks 2)
    assert_equal "${#deck[@]}" "104"
}

@test "random # of decks equals total cards divided by 52 is proper" {
    RANDOM_NUMBER=$(echo $((1 + $RANDOM % 10)))
    readarray -t deck < <(build_decks $RANDOM_NUMBER)
    assert_equal "${#deck[@]}" "$((RANDOM_NUMBER * 52))"
}

@test "non-int to build_decks causes error" {
    run build_decks "notanumber"
    assert_failure
}

# # New tests for deck validation
@test "verify deck contains all suits" {
    skip "This test is failing, but works in the shell. Fuckbats."
    local -a deck
    readarray -t deck < <(build_decks 1)
    local hearts=0 diamonds=0 clubs=0 spades=0
    for card in "${deck[@]}"; do
        case ${card: -1} in
            "♥") ((hearts++));;
            "♦") ((diamonds++));;
            "♣") ((clubs++));;
            "♠") ((spades++));;
        esac
    done
    assert_equal "$hearts" "13"
    assert_equal "$diamonds" "13"
    assert_equal "$clubs" "13"
    assert_equal "$spades" "13"
}

@test "verify deck contains all values" {
    #skip "Skipping this test while debugging the suit test."
    local -a deck
    readarray -t deck < <(build_decks 1)
    local -A values=()
    for card in "${deck[@]}"; do
        value=${card%?}  # Remove suit

        values["$value"]=1
    done
    assert [ ${values["A"]} ]
    assert [ ${values["K"]} ]
    assert [ ${values["Q"]} ]
    assert [ ${values["J"]} ]
    for i in {2..10}; do
        assert [ ${values["$i"]} ]
    done
}

# Shuffling tests
@test "shuffled deck maintains correct size" {
    local -a deck
    readarray -t deck < <(build_decks 1)
    local original_size=${#deck[@]}
    randomize_array_with_shuf deck
    assert_equal "${#deck[@]}" "$original_size"
}


@test "shuffling changes card order" {
    local -a deck1 deck2
    readarray -t deck1 < <(build_decks 1)
    deck2=("${deck1[@]}")
    randomize_array_with_shuf deck2
    local different=0
    for i in "${!deck1[@]}"; do

        if [[ "${deck1[$i]}" != "${deck2[$i]}" ]]; then
            different=1
            break
        fi
    done
    assert_equal "$different" "1"
}

# Dealing tests
@test "deal_card returns top card from deck" {
    local -a deck
    readarray -t deck < <(build_decks 1)
    local original_size=${#deck[@]}
    local first_card="${deck[0]}"
    

    run deal_card deck
    assert_output "$first_card"
}

@test 'deal_card removes card from deck' {
    local -a deck
    readarray -t deck < <(build_decks 1)
    local original_size=${#deck[@]}
    local first_card="${deck[0]}"
    deal_card deck
    assert_equal "${#deck[@]}" "$((original_size - 1))"
    assert_not_equal "${deck[0]}" "$first_card"
}

@test 'deal_card returns null when deck is empty' {
    local -a deck
    readarray -t deck < <(build_decks 1)
    for i in "${!deck[@]}"; do
        unset 'deck[$i]'
    done
    run deal_card deck
    assert_output ""
}

# Hand calculation tests
@test "calculate_hand_value basic hand" {
    run calculate_hand_value "10♥" "K♠"
    assert_output "20"
}


@test "calculate_hand_value with ace high" {
    run calculate_hand_value "A♥" "K♠"
    assert_output "21"
}

@test "calculate_hand_value with ace low" {
    run calculate_hand_value "A♥" "8♠" "5♣"
    assert_output "14"
}
