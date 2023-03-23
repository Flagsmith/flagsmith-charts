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

## Development

We use [pre-commit](https://pre-commit.com/index.html#install) for linting. You can install and run with:

```bash
pip install pre-commit
pre-commit run --all-files
```
