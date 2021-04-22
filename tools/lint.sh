#!/bin/bash -ex

cleanup() {
    # Tidy up any generated sub-charts directories, which will be owned by root because of the docker container
    echo "CLEANING UP"
    docker run --rm -it -v $(pwd):/repo --workdir /repo quay.io/helmpack/chart-testing sh -c 'rm -rf charts/**/charts && rm -rf charts/**/tmpcharts'
}

main() {
    trap cleanup EXIT
    cleanup
    docker run --rm -it -v $(pwd):/repo --workdir /repo quay.io/helmpack/chart-testing ct lint --config ct.yaml "$@"
}

main "$@"
