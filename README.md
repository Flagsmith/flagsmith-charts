# Flagsmith Helm chart

## Requirements

helm version > 3.0.2

## To run locally

You can test and run the application locally on OSX using `minikube` like this:

```bash
# Install Docker for Desktop and then:

brew install minikube
minikube start --memory 8192 --cpus 4
helm install flagsmith --debug ./flagsmith
minikube dashboard
```

## Test install Chart

Install Chart without building a package:

```bash
helm install flagsmith --debug ./flagsmith
```

Run template and check kubernetes resouces are made:

```bash
helm template flagsmith flagsmith --debug -f flagsmith/values.yaml
```

## build chart package

To build chart package run:

```bash
helm package ./flagsmith
```

## Configuration

The following table lists the configurable parameters of the chart and their default values.

Parameter                          | Description                                                                                                | Default
:--------------------------------- | :--------------------------------------------------------------------------------------------------------- | :---------------------------------------------------
`api.image` | docker image for flagsmith (contains `repository` and `tag`) ||
`frontend.enabled` | if `true`, creates frontend deployment and pods | `false`
`api.env` | if not `null` will add values to container environment variables
`postgresql.enabled` | if `true`, creates postgresql database | `true`
