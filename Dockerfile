FROM node:12

RUN git clone https://github.com/cardstack/cardstack
WORKDIR /cardstack
RUN yarn global add lerna
RUN lerna bootstrap
RUN yarn compile
WORKDIR /cardstack/packages/cardhost
RUN npm install