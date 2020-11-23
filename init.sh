#!/bin/bash
echo ""
echo "Bootstrapping remote realm..."
rm -rf /.cardstack
yarn start-hub &
sleep 10
echo ""
echo "Sending Bunny Records realm data..."
curl -d '@/cardstack/packages/cardhost/bunny.json' -H "Content-Type: application/vnd.api+json" -X POST http://localhost:3000/api/realms/meta/cards
sleep 10
echo ""
echo "Waiting on hub realm sync, this might take a minute..."
pkill -f node
sleep 40
echo ""
echo "Restarting whole hub for reindexing..."
yarn start-hub &
yarn start