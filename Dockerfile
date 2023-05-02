FROM node:18-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app
RUN npm i

COPY ./server.js /usr/src/app/server.js

EXPOSE 3000
CMD ["npm", "start"]
