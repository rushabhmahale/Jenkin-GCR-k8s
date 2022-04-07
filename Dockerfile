FROM node:latest as node
RUN mkdir -p /app
WORKDIR /app
COPY package*.json /app/
RUN curl -fsSLO https://get.docker/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz
RUN npm install 
COPY . /app/
EXPOSE 4200
CMD ["npm", "run", "start"]
