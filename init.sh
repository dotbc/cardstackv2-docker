FILE=./initialized
if test -f "$FILE"; then
    yarn start
    echo "Already initialized, no need to bootstrap remote realm."
else
    echo "Bootstrapping remote realm..."
    yarn start-hub
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
    }' -H "Content-Type: application/vnd.api+json" -X POST http://cardstack:3000/api/realms/meta/cards
    yarn start-hub
    yarn start-ember
    touch initialized
fi