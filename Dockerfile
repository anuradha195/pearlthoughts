FROM node:19-alpine3.16

# Create app directory
WORKDIR /usr/src/app

COPY . .

RUN npm init -y && npm install

EXPOSE 3000
CMD [ "node", "examples/hello-world/index.js" ]