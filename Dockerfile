FROM docker:dind

COPY run.sh /bin/run.sh
COPY shell.sh /bin/shell.sh

# Install nessessary tools.
RUN apk update && apk add -f git curl nodejs make && npm update && npm install -g git-pull-all

# Clone runtime repositories.
WORKDIR /src
RUN git clone https://github.com/openbrisk/brisk-runtime-dotnetcore && \
    git clone https://github.com/openbrisk/brisk-runtime-nodejs
