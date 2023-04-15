FROM node:16-alpine
# Installing libvips-dev for sharp Compatibility
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev git
RUN npm install -g npm@9.6.4
RUN npm install -g pnpm
RUN npm install -g @sveltejs/kit
RUN mkdir /srv/app && chown node:node /srv/app
USER node
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}
WORKDIR /srv/app
COPY ./package.json ./pnpm-lock.yaml ./
ENV PATH /srv/node_modules/.bin:$PATH
RUN pnpm install
COPY ./ .
#RUN pnpm run build
EXPOSE 5000
EXPOSE 4000
CMD ["pnpm", "start"]