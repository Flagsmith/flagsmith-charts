# Changelog

## [0.77.0](https://github.com/Flagsmith/flagsmith-charts/compare/flagsmith-0.76.0...flagsmith-0.77.0) (2025-07-25)


### Features

* `exec` liveness probes ([bd65ebb](https://github.com/Flagsmith/flagsmith-charts/commit/bd65ebbdc269e77e7ff4786f67863ae58f7c2106))
* Add global image options ([86e2007](https://github.com/Flagsmith/flagsmith-charts/commit/86e20079e10afbb937d30e51a3cfaafaf44b5754))
* Automatically generate API and SSE secrets using Jobs. Accept existing SSE secrets ([5565013](https://github.com/Flagsmith/flagsmith-charts/commit/5565013a145f7039877657cd9be6bd447eb7ebea))
* Expose Prometheus metrics. Add `serviceMonitor` option for use with Prometheus Operator ([ad31efe](https://github.com/Flagsmith/flagsmith-charts/commit/ad31efe9b1c8d75aa1bf6e9d5768b92636f27f0d))
* **initcontainers:** add api volume mounts to init containers to support SSL auth methods that require certs to be mounted ([#392](https://github.com/Flagsmith/flagsmith-charts/issues/392)) ([738425e](https://github.com/Flagsmith/flagsmith-charts/commit/738425ebffaf048d1d6c99c413ed6ab01a3a2b9f))


### Bug Fixes

* Add all resources to release namespace ([295bc1d](https://github.com/Flagsmith/flagsmith-charts/commit/295bc1d08458ebeb0defe5f7348b75c216bcf1d9))
* Add task processor container port ([c306992](https://github.com/Flagsmith/flagsmith-charts/commit/c306992ab785ccf4db20cb5d81fb3e8321aff055))
* **ci:** Remove publish validation after releasing chart ([2e3e095](https://github.com/Flagsmith/flagsmith-charts/commit/2e3e095ceeaebd9cc0392007cf9725e60d4adae3))
* Fix generating SSE secret ([9000a28](https://github.com/Flagsmith/flagsmith-charts/commit/9000a28af2b9ef5ae181dba88dea68c7076b6873))


### Dependency Updates

* bump Flagsmith from 2.184.0 to 2.188.1 ([#389](https://github.com/Flagsmith/flagsmith-charts/issues/389)) ([52be9d4](https://github.com/Flagsmith/flagsmith-charts/commit/52be9d4685832956bd0dfbdf9560ed3b0b46a1bc))


### Other

* 0.73.0 ([02e513c](https://github.com/Flagsmith/flagsmith-charts/commit/02e513c027705944f4762cd21dc28a3239a4e1ce))
* 0.74.0 ([58e3662](https://github.com/Flagsmith/flagsmith-charts/commit/58e366268e84464872427ec26ae7af54d760ab1c))
* **main:** release 0.75.0 ([#384](https://github.com/Flagsmith/flagsmith-charts/issues/384)) ([c2c2b3d](https://github.com/Flagsmith/flagsmith-charts/commit/c2c2b3d7fc03b88ee9d10df8b39c8d3466b1d90f))
* **main:** release flagsmith 0.76.0 ([#401](https://github.com/Flagsmith/flagsmith-charts/issues/401)) ([14b5d67](https://github.com/Flagsmith/flagsmith-charts/commit/14b5d67ef01f4050fe84be79324ae122021425f8))

## [0.76.0](https://github.com/Flagsmith/flagsmith-charts/compare/flagsmith-0.75.0...flagsmith-0.76.0) (2025-07-25)


### Features

* **initcontainers:** add api volume mounts to init containers to support SSL auth methods that require certs to be mounted ([#392](https://github.com/Flagsmith/flagsmith-charts/issues/392)) ([738425e](https://github.com/Flagsmith/flagsmith-charts/commit/738425ebffaf048d1d6c99c413ed6ab01a3a2b9f))

## [0.75.0](https://github.com/Flagsmith/flagsmith-charts/compare/v0.74.0...v0.75.0) (2025-07-24)


### Features

* `exec` liveness probes ([bd65ebb](https://github.com/Flagsmith/flagsmith-charts/commit/bd65ebbdc269e77e7ff4786f67863ae58f7c2106))
* Add global image options ([86e2007](https://github.com/Flagsmith/flagsmith-charts/commit/86e20079e10afbb937d30e51a3cfaafaf44b5754))
* Automatically generate API and SSE secrets using Jobs. Accept existing SSE secrets ([5565013](https://github.com/Flagsmith/flagsmith-charts/commit/5565013a145f7039877657cd9be6bd447eb7ebea))
* Expose Prometheus metrics. Add `serviceMonitor` option for use with Prometheus Operator ([ad31efe](https://github.com/Flagsmith/flagsmith-charts/commit/ad31efe9b1c8d75aa1bf6e9d5768b92636f27f0d))


### Bug Fixes

* Add all resources to release namespace ([295bc1d](https://github.com/Flagsmith/flagsmith-charts/commit/295bc1d08458ebeb0defe5f7348b75c216bcf1d9))
* Add task processor container port ([c306992](https://github.com/Flagsmith/flagsmith-charts/commit/c306992ab785ccf4db20cb5d81fb3e8321aff055))
* **ci:** Remove publish validation after releasing chart ([2e3e095](https://github.com/Flagsmith/flagsmith-charts/commit/2e3e095ceeaebd9cc0392007cf9725e60d4adae3))
* Fix generating SSE secret ([9000a28](https://github.com/Flagsmith/flagsmith-charts/commit/9000a28af2b9ef5ae181dba88dea68c7076b6873))


### Dependency Updates

* bump Flagsmith from 2.184.0 to 2.188.1 ([#389](https://github.com/Flagsmith/flagsmith-charts/issues/389)) ([52be9d4](https://github.com/Flagsmith/flagsmith-charts/commit/52be9d4685832956bd0dfbdf9560ed3b0b46a1bc))


### Other

* 0.73.0 ([02e513c](https://github.com/Flagsmith/flagsmith-charts/commit/02e513c027705944f4762cd21dc28a3239a4e1ce))
* 0.74.0 ([58e3662](https://github.com/Flagsmith/flagsmith-charts/commit/58e366268e84464872427ec26ae7af54d760ab1c))
