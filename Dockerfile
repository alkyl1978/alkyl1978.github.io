FROM node:alpine
# set working directory
WORKDIR /app
VOLUME ./build  /app/build
# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH
ENV SKIP_PREFLIGHT_CHECK=true
ENV CI=true
# install app dependencies
COPY package.json ./
COPY package-lock.json ./
# COPY package-lock.json ./
RUN npm install --silent --prod
# add app
COPY . ./
# start app
CMD ["npm", "run", "start"]
