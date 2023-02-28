FROM node:16

WORKDIR /usr/code

COPY package*.json .

RUN npm install

COPY . .

# VOLUME [ "/app/node_modules" ]

EXPOSE 3000

CMD ["npm", "run", "start:dev"]

# Autre tuto il y a 
# CMD ["npm", "run", "dev"]