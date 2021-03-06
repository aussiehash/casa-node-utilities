#!/usr/bin/env bash
# This script should be used to resync the chain from Casa's server. It will only work if there is no registered user.

if docker logs bitcoind 2>&1 | grep -q reindex-chainstate; then
    echo Bitcoind Chainstate error found. Fixing ...
    curl --header "Content-Type: application/json" \
        --request POST \
        --data '{"full":true}' \
        "http://127.0.0.1:3000/v1/device/resync-chain"
    docker logs manager --tail 100 -f
else
    echo Bitcoind Chainstate error not found. Please contact Casa Support at help@team.casa
fi
