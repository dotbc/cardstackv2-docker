FROM node:12

RUN git clone https://github.com/dotbc/fuga-v2-cards
WORKDIR /fuga-v2-cards
RUN find . -type f -name "*.json" -print0 | xargs -0 sed -i -e 's/https\:\/\/builder\-hub\.stack\.cards/http\:\/\/localhost\:4200/g'
WORKDIR /
RUN git clone https://github.com/cardstack/cardstack
WORKDIR /cardstack
RUN yarn global add lerna
RUN lerna bootstrap
RUN yarn compile
WORKDIR /cardstack/packages/cardhost
RUN npm install
RUN npm run build
ENV DEV_DIR=/fuga-v2-cards/cards