
FROM node

ENV MONGO_DB_USERNAME=ag2233 \
    MONGO_DB_PWD=ashutosh

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

CMD ["node", "server.js"]
