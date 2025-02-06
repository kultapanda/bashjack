#!/bin/bash

test -d test/bats || git submodule add -f https://github.com/bats-core/bats-core.git test/bats
test -d test/test_helper/bats-support || git submodule add -f https://github.com/bats-core/bats-support.git test/test_helper/bats-support
test -d test/test_helper/bats-assert || git submodule add -f https://github.com/bats-core/bats-assert.git test/test_helper/bats-assert

## Install bats-core
#cd test/bats
#./install.sh /usr/local
#
## Install bats-support
#cd ../test_helper/bats-support
#
