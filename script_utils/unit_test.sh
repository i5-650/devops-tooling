!/bin/bash

assert_equals() {
    local expected="$1"
    local actual="$2"
    local message="${3:-Values don't match}"

    if [[ "$expected" == "$actual" ]]; then
        return 0
    else
        echo "  Expected: '$expected'"
        echo "  Actual: '$actual'"
        echo "  Message: $message"
        return 1
    fi
}
assert_contains() {
    local haystack="$1"
    local needle="$2"

    if [[ "$haystack" == *"$needle"* ]]; then
        return 0
    else
        echo "  '$haystack' does not contain '$needle'"
        return 1
    fi
}
