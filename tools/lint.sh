#!/bin/bash -ex

docker run --rm -it -v $(pwd):/repo --workdir /repo quay.io/helmpack/chart-testing ct lint --config ct.yaml "$@"
# Tidy up any generated sub-charts directories, which will be owned by root because of the docker container
docker run --rm -it -v $(pwd):/repo --workdir /repo quay.io/helmpack/chart-testing sh -c 'rm -rf charts/**/charts'
