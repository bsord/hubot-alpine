FROM alpine

MAINTAINER Brandon Sorgdrager <Brandon.Sorgdrager@gmail.com>

# Install dependencies
RUN apk update && apk upgrade \
  && apk add redis \
  && apk add nodejs \
  && npm install -g npm \
  && npm install -g coffee-script \
  && npm install -g yo generator-hubot \
  && npm install hubot-sonny \
  && npm install hubot-uptime \
  && npm install hubot-cron \
  && npm install hubot-cryptoalert \
  && rm -rf /var/cache/apk/*

# Create hubot user
RUN adduser -h /hubot -s /bin/bash -S hubot
USER  hubot
WORKDIR /hubot

# Install hubot
RUN yo hubot --owner="Brandon Sorgdrager" --name="Sonny" --description="A ghost in the machine" --defaults
COPY package.json package.json
RUN npm install
# ADD hubot/hubot-scripts.json /hubot/ (apparently deprecated)
ADD hubot/external-scripts.json /hubot/

EXPOSE 80

# And go
CMD ["/bin/sh", "-c", "bin/hubot --adapter slack"]
