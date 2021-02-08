FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#FROM nginx
EXPOSE 3000
EXPOSE $PORT
CMD [ "npm", "start"]
#COPY --from=builder /app/build /usr/share/nginx/html
# --from=builder "I want to copy something from the builder phase"
# /usr/share/nginx/html is where nginx will serve our build; check the docs at dockerhub

#https://www.codementor.io/@idreesibraheem/how-to-deploy-a-minimal-docker-app-to-heroku-136rp9223y