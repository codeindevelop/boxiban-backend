FROM node:18-alpine as base

WORKDIR /src
COPY package*.json /
EXPOSE 80

FROM base as production
ENV NODE_ENV=production
RUN npm ci
COPY . /
COPY .env.example /.env

CMD ["node", "bin/www"]

FROM base as dev
ENV NODE_ENV=development
RUN npm install -g nodemon && npm install
COPY . /
CMD ["nodemon", "bin/www"]
