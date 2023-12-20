# Flagsmith Helm Charts

[https://flagsmith.github.io/flagsmith-charts/](https://flagsmith.github.io/flagsmith-charts/)

## Usage

Add this repository using:

```
$ helm repo add flagsmith https://flagsmith.github.io/flagsmith-charts/
```

Or by adding the following into `helmfile.yaml`:

```yaml
repositories:
  # ...
  - name: flagsmith
    url: https://flagsmith.github.io/flagsmith-charts/
```

## Further Information

For a detailed walkthrough of how to set up and configure Flagsmith on Kubernetes, please check out
[our docs](https://docs.flagsmith.com/deployment/hosting/kubernetes).

## Source

The source for these charts is hosted at [https://github.com/Flagsmith/flagsmith-charts/](https://github.com/Flagsmith/flagsmith-charts/)
