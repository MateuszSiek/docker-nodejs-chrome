# Image: mateuszsiek/nodejs-chrome
FROM node:10.14.0

RUN \
  apt-get update && \
  `# Install tools necessary for Google Chrome to work` \
  apt-get install -y apt-utils libgtk2.0-0 libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 xvfb && \
  `# Install Chrome browser` \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
  apt-get update && \
  apt-get install -y dbus-x11 google-chrome-stable && \
  `# Add handy tools...` && \
  apt-get update && apt-get install -y gettext-base zip gzip rsync jq && \
  apt-get clean

# 1. "fake" dbus address to prevent errors: https://github.com/SeleniumHQ/docker-selenium/issues/87
# 2. Good colors for most apps
# 3. avoid million NPM install messages
# 4. allow installing when the main user is root
ENV \
  DBUS_SESSION_BUS_ADDRESS=/dev/null \
  TERM=xterm \
  npm_config_loglevel=warn \
  npm_config_unsafe_perm=true
