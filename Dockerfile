# specify the node base image with your desired version node:<version>
FROM node:12.18.4-alpine3.9
# replace this with your application's default port
EXPOSE 8888

# Create app directory
RUN mkdir -p /home/Service
WORKDIR /home/Service

# Bundle app source
COPY . /home/Service
# RUN npm config set registry https://registry.npm.taobao.org
RUN ELECTRON_MIRROR=http://npm.taobao.org/mirrors/electron/ npm install 

CMD [ "npm","start" ]