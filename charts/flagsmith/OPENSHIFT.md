# Openshift

In order to install Flagsmith to OpenShift you need to provide the domain of the OpenShift cluster and the destination namespace in the helm call. Futhermore, you need to include the values files `openshift` in order to create the routes for the Flagsmith deployments. The command looks likes this:

``` bash
helm install flagsmith ./flagsmith-kubernetes -f flagsmith-kubernetes/openshift-values.yaml --set frontend.env[0].name=API_URL,frontend.env[0].value=http://flagsmith-api-<Release Namespace>.<OpenShift domain>/api/v1/,frontend.env[1].name=ASSET_URL,frontend.env[1].value=/ --set openshiftdomain=<OpenShift domain>
```

An example for the Flagsmith installation for a minishift cluster looks like this:

``` bash
helm install flagsmith ./flagsmith-kubernetes -f flagsmith-kubernetes/openshift-values.yaml --set frontend.env[0].name=API_URL,frontend.env[0].value=http://flagsmith-api-flagsmith.my.openshift.domain.com/api/v1/,frontend.env[1].name=ASSET_URL,frontend.env[1].value=/ --set openshiftdomain=my.openshift.domain.com --dry-run
```
