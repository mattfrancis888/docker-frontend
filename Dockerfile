FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# --from=builder "I want to copy something from the builder phase"
# /usr/share/nginx/html is where nginx will serve our build; check the docs at dockerhub