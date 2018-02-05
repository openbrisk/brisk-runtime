.PHONY: build

build:
	docker build -t openbrisk/brisk-runtime-integration-tests .

run:
	docker run --privileged -it \
	--entrypoint "/bin/run.sh" \
	-v `pwd`/docker:/var/lib/docker \
	openbrisk/brisk-runtime-integration-tests

shell:
	docker run --privileged -it \
	--entrypoint "/bin/shell.sh" \
	-v `pwd`/docker:/var/lib/docker \
	openbrisk/brisk-runtime-integration-tests