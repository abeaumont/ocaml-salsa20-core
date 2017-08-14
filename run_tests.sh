if [ -f ./salsa20_core_tests.native ]; then
    ./salsa20_core_tests.native -v
else
    ./salsa20_core_tests.byte -v
fi

if [ -f ./utils_tests.native ]; then
    ./utils__tests.native -v
else
    ./utils_tests.byte -v
fi
