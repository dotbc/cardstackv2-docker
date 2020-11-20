#!/bin/bash
FILE=./initialized
if test -f "$FILE"; then
    yarn start
    echo "\nAlready initialized, no need to bootstrap remote realm."
else
    echo "\nBootstrapping remote realm..."
    rm -rf /.cardstack
    yarn start-hub &
    PID=$!
    sleep 10
    echo ""
    echo "Sending Bunny Records realm data..."
    curl -d '{
    "data": {
        "attributes": {
        "csDescription": "This is the Bunny Records realm.",
        "csId": "https://builder-hub.stack.cards/api/realms/bunny-records",
        "csTitle": "Bunny Records Realm",
        "remoteCacheDir": "bunny-records-realm",
        "remoteUrl": "https://github.com/dotbc/fuga-v2-cards.git"
        },
        "relationships": {
        "csAdoptsFrom": {
            "data": {
            "id": "https://base.cardstack.com/public/cards/git-realm",
            "type": "cards"
            }
        }
        },
        "type": "cards"
    }
    }' -H "Content-Type: application/vnd.api+json" -X POST http://localhost:3000/api/realms/meta/cards
    echo ""
    echo "Waiting on hub realm sync, this might take a minute..."
    sleep 10
    echo ""
    echo "Killing the hub process..."
    pkill -f node
    sleep 30
    echo ""
    echo "Restarting whole hub for reindexing..."
    yarn start
    touch initialized
fi