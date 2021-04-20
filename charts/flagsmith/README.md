# Flagsmith Helm chart

## Installation

```bash
helm repo add flagsmith https://flagsmith.github.io/flagsmith-charts/
helm install flagsmith flagsmith/flagsmith
```

This will install using default options. (Pods may error and restart
while waiting for other pods to become ready.).

### Ingress configuration

The above will start pods in the cluster, but to gain web access to
Flagsmith, do one of the following:

#### In a cluster that has an ingress controller

Set the following values for flagsmith, with changes as needed to
accommodate your ingress controller, and any associated DNS
changes. Also, set the `API_URL` env-var such that the URL is
reachable from a browser accessing the frontend.

Eg:

```yaml
ingress:
  frontend:
    enabled: true
    hosts:
      - host: flagsmith.[MYDOMAIN]
        paths:
          - /
  api:
    enabled: true
    hosts:
      - host: flagsmith.[MYDOMAIN]
        paths:
          - /api/

frontend:
  env:
    - name: API_URL
      value: 'https://flagsmith.[MYDOMAIN]/api/v1/'
```

Then, once any out-of-cluster DNS or CDN changes have been applied,
access `https://flagsmith.[MYDOMAIN]` in a browser.

#### Minikube ingress

(See https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/ for more details.)

If using minikube, enable ingress with `minikube addons enable ingress`.

Then set the following values for flagsmith:
```yaml
ingress:
  frontend:
    enabled: true
    hosts:
      - host: flagsmith.local
        paths:
          - /
  api:
    enabled: true
    hosts:
      - host: flagsmith.local
        paths:
          - /api/
```
and apply. This will create two ingress resources.

Run `minikube ip`. Set this ip and `flagsmith.local` in your `/etc/hosts`, eg:

```
192.168.99.99	flagsmith.local
```

Then access `http://flagsmith.local` in a browser.

#### Port forwarding

Set the following values for flagsmith:
```yaml
frontend:
  env:
    - name: API_URL
      value: 'http://localhost:8000/api/v1/'
```

In one terminal, run:
```bash
kubectl -n [flagsmith-namespace] port-forward svc/[flagsmith-release-name]-api 8000:8000
```
and in another, run:
```bash
kubectl -n [flagsmith-namespace] port-forward svc/[flagsmith-release-name]-frontend 8080:8080
```

Then access `http://localhost:8080` in a browser.

## Configuration

The following table lists the configurable parameters of the chart and
their default values.

| Parameter            | Description                                                      | Default |
| ---------            | ------------                                                     | ------- |
| `api.image`          | docker image for flagsmith (contains `repository` and `tag`)     |         |
| `frontend.enabled`   | if `true`, creates frontend deployment and pods                  | `false` |
| `api.env`            | if not `null` will add values to container environment variables |         |
| `postgresql.enabled` | if `true`, creates in-cluster PostgreSQL database                | `true`  |

---

## Development and contributing

### Requirements

helm version > 3.0.2

### To run locally

You can test and run the application locally on OSX using `minikube` like this:

```bash
# Install Docker for Desktop and then:

brew install minikube
minikube start --memory 8192 --cpus 4
helm install flagsmith --debug ./flagsmith
minikube dashboard
```

### Test install Chart

Install Chart without building a package:

```bash
helm install flagsmith --debug ./flagsmith
```

Run template and check kubernetes resouces are made:

```bash
helm template flagsmith flagsmith --debug -f flagsmith/values.yaml
```

### build chart package

To build chart package run:

```bash
helm package ./flagsmith
```
