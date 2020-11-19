FROM node:12

RUN git clone https://github.com/cardstack/cardstack
WORKDIR /cardstack
RUN yarn global add lerna
RUN lerna bootstrap
RUN yarn compile
WORKDIR /cardstack/packages/cardhost
COPY init.sh /cardstack/packages/cardhost/init.sh
RUN chmod +x /cardstack/packages/cardhost/init.sh
RUN npm install