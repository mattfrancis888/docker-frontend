FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
#EXPOSE 3000
EXPOSE $PORT
#CMD [ "npm", "start"]
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html
CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'

# --from=builder "I want to copy something from the builder phase"
# /usr/share/nginx/html is where nginx will serve our build; check the docs at dockerhub
#CMD sed -i is for deploying to heroku (you could comment it out and change $port to 80 in default.conf when running at your machine):
# https://dev.to/levelupkoodarit/deploying-containerized-nginx-to-heroku-how-hard-can-it-be-3g14
#https://www.codementor.io/@idreesibraheem/how-to-deploy-a-minimal-docker-app-to-heroku-136rp9223y