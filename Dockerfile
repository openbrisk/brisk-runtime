FROM docker:dind

# Install nessessary tools.
RUN apk update && apk add curl

# Pull runtime images.
#RUN docker pull openbrisk/brisk-runtime-dotnetcore && \
#	docker pull openbrisk/brisk-runtime-nodejs

COPY run.sh ./
ENTRYPOINT [ "./run.sh" ]