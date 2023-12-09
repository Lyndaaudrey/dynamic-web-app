FROM node:16-alpine3.11

# create app directory in container
RUN mkdir -p /home/app

# copy local app to container app directory
COPY ./website /home/app

# set default app direcotry in container
WORKDIR /home/app

# install app dependencies
RUN npm install

#Expose
EXPOSE 80

# run the server
CMD ["node", "server.js"]

