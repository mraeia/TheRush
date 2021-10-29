FROM node:14.15.0-alpine

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn

CMD ["yarn","start"]