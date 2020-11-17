FROM node:12

RUN git clone https://github.com/dotbc/fuga-v2-cards
RUN git clone https://github.com/cardstack/cardstack
WORKDIR /cardstack
RUN yarn global add lerna
RUN lerna bootstrap
RUN yarn compile
WORKDIR /cardstack/packages/cardhost
RUN npm install
RUN npm run build
ENV DEV_DIR=/fuga-v2-cards/cards
RUN yarn start