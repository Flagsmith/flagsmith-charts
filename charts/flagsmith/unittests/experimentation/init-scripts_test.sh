#!/bin/sh
# Checks the pure functions in files/experimentation/init.sh.
set -eu
INIT_SH_LIB=1 . "$(dirname "$0")/../../files/experimentation/init.sh"

check() { [ "$2" = "$3" ] || { echo "FAIL $1: got [$2], want [$3]"; exit 1; }; }

check "jaas quote" "$(jaas_quote 'p"a\b')" '"p\\"a\\\\b"'

echo "init-scripts: all checks passed"
