.PHONY: build

build:
	docker build -t openbrisk/brisk-runtime-integration-tests .

run:
	docker run --privileged -it openbrisk/brisk-runtime-integration-tests
