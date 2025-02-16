ARG APP_NAME

FROM node:20.11.0-alpine AS build
WORKDIR /app
# COPY package.json  package-lock.json ./
COPY . ./
RUN yarn install --force
RUN npx nest build ${APP_NAME}

FROM node:20.11.0-alpine
WORKDIR /app
COPY --from=build /app/dist/apps/${APP_NAME} /app
COPY --from=build /app/node_modules /app/node_modules
CMD ["node", "/app/main.js"]
