# Flagsmith Charts

Official Helm charts for Flagsmith,
[https://flagsmith.github.io/flagsmith-charts/](https://flagsmith.github.io/flagsmith-charts/)

- [Flagsmith](./charts/flagsmith/)

## Usage

Add this repository using:

```bash
helm repo add flagsmith https://flagsmith.github.io/flagsmith-charts/
```

Or by adding the following into `helmfile.yaml`:

```yaml
repositories:
 # ...
 - name: flagsmith
   url: https://flagsmith.github.io/flagsmith-charts/
```
