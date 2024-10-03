# Flagsmith Edge Proxy Helm chart
![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.15.0](https://img.shields.io/badge/AppVersion-2.15.0-informational?style=flat-square)

Helm chart for deploying the [Flagsmith Edge Proxy](https://docs.flagsmith.com/advanced-use/edge-proxy) to Kubernetes.

## Usage
### Setup the Flagsmith chart repository
```
helm repo add flagsmith https://flagsmith.github.io/flagsmith-charts/
helm repo update
```

### Install the chart
```
helm install edge-proxy flagsmith/edge-proxy
```

## Values

### Edge Proxy configuration values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| edgeProxy.configMap.content | string | `""` | Content to assign to the new ConfigMap.  This is passed into `tpl` allowing for templating from values. |
| edgeProxy.configMap.create | bool | `true` | Create a new ConfigMap for the config file. |
| edgeProxy.configMap.key | string | `nil` | Key in ConfigMap to get config from. |
| edgeProxy.configMap.name | string | `nil` | Name of existing ConfigMap to use. Used when create is false. |
| edgeProxy.envFrom | list | `[]` | Maps all the keys on a ConfigMap or Secret as environment variables. https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#envfromsource-v1-core |
| edgeProxy.extraEnv | list | `[]` | Extra environment variables to pass to the Edge Proxy container. |
----------------------------------------------

#### edgeProxy.configMap
`edgeProxy.configMap` Holds the Flagsmith Edge Proxy configuration to use.

If `edgeProxy.configMap.create` is `true`, a configMap will be created using the contents defined in `edgeProxy.configMap.content`.

If `edgeProxy.configMap.content` is not provided, a default/example configuration is used - you can view it in `config/config.json`.

You can also set `edgeProxy.configMap.create` to `false` and provide the name of an already existing ConfigMap using `edgeProxy.configMap.name`


### Other values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"flagsmith/edge-proxy"` |  |
| image.tag | string | `nil` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.port | int | `8000` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |

----------------------------------------------


