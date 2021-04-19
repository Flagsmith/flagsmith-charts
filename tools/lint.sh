#!/bin/bash -ex

docker run --rm -it -v $(pwd):/repo --workdir /repo quay.io/helmpack/chart-testing ct lint --config ct.yaml "$@"
