
# stage 1, Build an Angular Docker Image
FROM node:latest as build
WORKDIR /app
#COPY package.json package-lock.json ./
COPY package*.json /app/
RUN npm install
#COPY . /app
COPY . .
#RUN npm run build
ARG configuration=production
RUN npm run build -- --outputPath=./dist/out --configuration $configuration


# stage 2, Используем скомпилированое приложение, готовое к производству с Nginx
FROM nginx:1.8-alpine
##COPY dist/AngularPsychic /usr/share/nginx/html
#COPY nginx.conf /etc/nginx/nginx.conf


#COPY --from=build /app/dist/AngularPsychic /usr/share/nginx/html
COPY --from=build /app/dist/out/ /usr/share/nginx/html
#RUN rm /etc/nginx/conf.d/default.conf
#COPY data/nginx/nginx.conf /etc/nginx/conf.d

EXPOSE 80
#EXPOSE 443
#CMD ["nginx", "-g", "daemon off;"]

# установка сомозаверяющегося ssl сертификата
#RUN apk update
#RUN apk upgrade
#RUN apk add bash
#RUN apk add openssl
#RUN /bin/bash -c "openssl req -x509 -out etc/ssl/localhost.crt -keyout etc/ssl/localhost.key \
#      -newkey rsa:2048 -nodes -sha256 \
#      -subj '/CN=localhost' -extensions EXT -config <( \
#       printf '[dn]\nCN=localhost\n[req]\ndistinguished_name  \
#    = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth')"



#FROM nginx:1.8-alpine
#COPY dist/AngularPsychic /usr/share/nginx/html
