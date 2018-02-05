#!/bin/sh

dockerd-entrypoint.sh &

git-pull-all

# Build current versions.
for dir in /src/*/
do
    dir=${dir%*/}
    echo Building runtime: '${dir##*/}' ...
    cd ${dir##*/}
    make build
    cd ..
done

# TODO: Execute tests.
# 1. Start a runtime
# 2. Execute tests.
# 3. Loop over every runtime.