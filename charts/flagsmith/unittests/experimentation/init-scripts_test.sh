#!/bin/sh
# Checks the pure functions in files/experimentation/init.sh.
set -eu
INIT_SH_LIB=1 . "$(dirname "$0")/../../files/experimentation/init.sh"

check() { [ "$2" = "$3" ] || { echo "FAIL $1: got [$2], want [$3]"; exit 1; }; }

parse_clickhouse_url 'clickhouses://u:p@h:9440/flagsmith_exp'
check "TLS scheme server" "$CH_SERVER" 'clickhouse://u:p@h:9440'
check "TLS scheme database" "$CH_DATABASE" 'flagsmith_exp'
check "TLS scheme flag" "$CH_SECURE" '--secure'

parse_clickhouse_url 'clickhouse://u:p@h:9000/db?secure=True&verify=False'
check "secure query database" "$CH_DATABASE" 'db'
check "secure query flag" "$CH_SECURE" '--secure'

parse_clickhouse_url 'clickhouse://u:p@h:9000/db'
check "plain flag" "$CH_SECURE" ''

if (parse_clickhouse_url 'clickhouse://u:p@h:9000') 2>/dev/null; then echo "FAIL: URL without database accepted"; exit 1; fi
if (parse_clickhouse_url 'https://h:8443/db') 2>/dev/null; then echo "FAIL: HTTP URL accepted"; exit 1; fi

check "sql quote" "$(sql_quote "it's a\\b")" "'it\\'s a\\\\b'"
check "jaas quote" "$(jaas_quote 'p"a\b')" '"p\\"a\\\\b"'

echo "init-scripts: all checks passed"
