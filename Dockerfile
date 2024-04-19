FROM debian:buster-slim as build-stage
WORKDIR /app
COPY . .
RUN apt-get update && apt-get install -y curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g flutter
RUN flutter pub get
RUN flutter build web --release

FROM nginx:alpine
COPY --from=build-stage /app/build/web /usr/share/nginx/html
