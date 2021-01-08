# Openshift

## Configuring a secure route

You can configure a standard secure route using the default self-signed certificate for the apps cluster DNS using an ingress configuration similar to:

    ingress:
    frontend:
        annotations:
        route.openshift.io/termination: "edge"
        enabled: true
        hosts:
        - host: flagsmith.apps.<cluster-dns-domain>
            paths: 
            - /
    api:
        annotations:
        route.openshift.io/termination: "edge"
        enabled: true
        hosts:
        - host: flagsmith.apps.<cluster-dns-domain>
            paths: 
            - /api

More advanced configuration is beyond the scope of this documentation.

## Postgres Security Context Constraint

Before deploying the chart as normal for kubernetes, you may need to make changes to security context constraints.

Exactly how you should do this will depend on your standard practice and security policy. A common approach is to add postgres to the privileged constraint - the process for this is documented below.

First determine

1. the Openshift project name you intend to use
2. the name of the helm release you intend to deploy flagsmith into.

If you intend to run the included postgres database, which is suitable for pre-production workloads, you should go to the Openshift console and:

1. Navigate to Administration -> Custom Resource Definitions
2. Select `SecurityContextConstraints`
3. Select the Instances list
4. choose `privileged` (or another appropriate SCC)
5. Select the YAML view

In this you will see a `users` key, for example:

  users:
    - 'system:admin'
    - 'system:serviceaccount:openshift-infra:build-controller'

You need to add the Service Account for the Postgres database instance to this list.

The service account name will be, by default, of the form `PROJECT:RELEASE-flagsmith-postgresql`

So for example if your project name is `flagsmith` and your release is `testing` then the service account name will be `flagsmith:testing-flagsmith-postgresql`.

Your users section in the SecurityContextConstraint would then look like:

  users:
    - 'system:admin'
    - 'system:serviceaccount:openshift-infra:build-controller'
    - 'system:serviceaccount:flagsmith:testing-flagsmith-postgresql'

Then click Save.

You can now deploy the helm chart.

