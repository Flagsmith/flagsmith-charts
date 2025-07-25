# Changelog

## [1.0.0](https://github.com/Flagsmith/flagsmith-charts/compare/flagsmith-0.75.0...flagsmith-1.0.0) (2025-07-25)


### ⚠ BREAKING CHANGES

* remove ability to specify ingress paths ([#138](https://github.com/Flagsmith/flagsmith-charts/issues/138)) (#139)

### Features

* `exec` liveness probes ([bd65ebb](https://github.com/Flagsmith/flagsmith-charts/commit/bd65ebbdc269e77e7ff4786f67863ae58f7c2106))
* `serviceAccountName` for migrate job, expose `migrate-and-serve` entrypoint ([#243](https://github.com/Flagsmith/flagsmith-charts/issues/243)) ([c7c6558](https://github.com/Flagsmith/flagsmith-charts/commit/c7c6558a14aa77588b18dfe9cb41323cdd642698))
* Ability to provide extra volumes to containers ([#184](https://github.com/Flagsmith/flagsmith-charts/issues/184)) ([1fe75ec](https://github.com/Flagsmith/flagsmith-charts/commit/1fe75ecb066a3dd792a8851189d5836d28836e93))
* Ability to specify `serviceAccountName` ([#240](https://github.com/Flagsmith/flagsmith-charts/issues/240)) ([85565b8](https://github.com/Flagsmith/flagsmith-charts/commit/85565b8525d4129e90a54655c47328da526169eb))
* Add default user/organisation/project bootstrapping ([#232](https://github.com/Flagsmith/flagsmith-charts/issues/232)) ([241fe8c](https://github.com/Flagsmith/flagsmith-charts/commit/241fe8c5d733bfecfe117872fa6e9e4259844bb9))
* add env variables from secrets ([#89](https://github.com/Flagsmith/flagsmith-charts/issues/89)) ([1a9ff59](https://github.com/Flagsmith/flagsmith-charts/commit/1a9ff5995ff808d547755ef20137c1e309218024))
* add extraObjects ([#262](https://github.com/Flagsmith/flagsmith-charts/issues/262)) ([f28fcbb](https://github.com/Flagsmith/flagsmith-charts/commit/f28fcbbb6fb4bf058c98334cd6d7b3841917b628))
* Add global image options ([86e2007](https://github.com/Flagsmith/flagsmith-charts/commit/86e20079e10afbb937d30e51a3cfaafaf44b5754))
* Add SSE service ([14f7217](https://github.com/Flagsmith/flagsmith-charts/commit/14f7217341f4e739e48921d45f761dc6a9348f36))
* Add templating functionality to extraContainers ([#310](https://github.com/Flagsmith/flagsmith-charts/issues/310)) ([626d6a2](https://github.com/Flagsmith/flagsmith-charts/commit/626d6a22f51aeb4abef8e857142b70f09f1b21cf))
* Add volumeMounts ([408db7b](https://github.com/Flagsmith/flagsmith-charts/commit/408db7b6cedac0f9f1de48cf85009af9e636f610))
* Allow including extra `spec` keys for deployments ([#292](https://github.com/Flagsmith/flagsmith-charts/issues/292)) ([f29c242](https://github.com/Flagsmith/flagsmith-charts/commit/f29c242398e40ec816e73917a9867eb324846f65))
* Automatically generate API and SSE secrets using Jobs. Accept existing SSE secrets ([5565013](https://github.com/Flagsmith/flagsmith-charts/commit/5565013a145f7039877657cd9be6bd447eb7ebea))
* Automatically generate Django secret key ([e0c9242](https://github.com/Flagsmith/flagsmith-charts/commit/e0c9242b55212699c27c43c4df1f829b8670ba25))
* Expose Prometheus metrics. Add `serviceMonitor` option for use with Prometheus Operator ([ad31efe](https://github.com/Flagsmith/flagsmith-charts/commit/ad31efe9b1c8d75aa1bf6e9d5768b92636f27f0d))
* **hpa:** add hpa for api deployment ([#324](https://github.com/Flagsmith/flagsmith-charts/issues/324)) ([24b1a0f](https://github.com/Flagsmith/flagsmith-charts/commit/24b1a0fc3bdccde4560aea6998dc471da6e3b573))
* **jobs:** Add job to migrate analytics data from influx to postgres  ([#230](https://github.com/Flagsmith/flagsmith-charts/issues/230)) ([5deacc0](https://github.com/Flagsmith/flagsmith-charts/commit/5deacc06688665d10ffee94fcf59d4e39af3135e))
* Migrate job, waiter deprecation, togglable init container ([#188](https://github.com/Flagsmith/flagsmith-charts/issues/188)) ([37486f8](https://github.com/Flagsmith/flagsmith-charts/commit/37486f8b7a9055506c2a02bc66ef5c312a6e546f))
* Support new Task processor readiness/liveness probes ([6cca12a](https://github.com/Flagsmith/flagsmith-charts/commit/6cca12a3931a6d6a23ac06a340e1cd5ead382970))
* Support new Task processor readiness/liveness probes ([17dfa77](https://github.com/Flagsmith/flagsmith-charts/commit/17dfa77256cf2eff0fd9478f2d2f4883a0bd583c))
* Use separate liveness and readiness checks ([9e33747](https://github.com/Flagsmith/flagsmith-charts/commit/9e33747a6094e224bd790d3e248160c6bae7e5ef))


### Bug Fixes

* **.github/release:** Add bitnami repo ([#216](https://github.com/Flagsmith/flagsmith-charts/issues/216)) ([64f9630](https://github.com/Flagsmith/flagsmith-charts/commit/64f9630a271a7600e7d6a23b08194b533c410760))
* Add all resources to release namespace ([295bc1d](https://github.com/Flagsmith/flagsmith-charts/commit/295bc1d08458ebeb0defe5f7348b75c216bcf1d9))
* Add missing SSE ingress ([8cae5e7](https://github.com/Flagsmith/flagsmith-charts/commit/8cae5e7ed372ce27d8fde9e91ac080c1ccb6473c))
* Add task processor container port ([c306992](https://github.com/Flagsmith/flagsmith-charts/commit/c306992ab785ccf4db20cb5d81fb3e8321aff055))
* allow using influxDB credentials from existing secret ([73c148f](https://github.com/Flagsmith/flagsmith-charts/commit/73c148fd3dca29a3586095990540a8c4bbfcbd80))
* allow using influxDB credentials from existing secret ([f42017e](https://github.com/Flagsmith/flagsmith-charts/commit/f42017eab12fddd491b67f1a630004e6c00e187e))
* **ci:** Remove publish validation after releasing chart ([2e3e095](https://github.com/Flagsmith/flagsmith-charts/commit/2e3e095ceeaebd9cc0392007cf9725e60d4adae3))
* correct ingress backend templating ([c65ea77](https://github.com/Flagsmith/flagsmith-charts/commit/c65ea7723c6fabf0216335720a19e0166fe78aaa))
* Do not deploy SSE k8s service if SSE is disabled ([d056204](https://github.com/Flagsmith/flagsmith-charts/commit/d0562041929d86998315bf877c22e5c89df75af9))
* Enable ENABLE_ADMIN_ACCESS_USER_PASS by default ([c97f5ba](https://github.com/Flagsmith/flagsmith-charts/commit/c97f5ba997032389f3af60d7df010b98ae036fce))
* Fix generating SSE secret ([9000a28](https://github.com/Flagsmith/flagsmith-charts/commit/9000a28af2b9ef5ae181dba88dea68c7076b6873))
* Incorrect `serviceAccountName` values ([#241](https://github.com/Flagsmith/flagsmith-charts/issues/241)) ([c757de2](https://github.com/Flagsmith/flagsmith-charts/commit/c757de271429702ed02a78ae8472a01ba21748db))
* incorrect env var POSTGRESQL_USERNAME ([#70](https://github.com/Flagsmith/flagsmith-charts/issues/70)) ([e041498](https://github.com/Flagsmith/flagsmith-charts/commit/e041498b0d7b4f8be2a6383d90513e8ce52f911f))
* incorrect property name ([#71](https://github.com/Flagsmith/flagsmith-charts/issues/71)) ([a242af1](https://github.com/Flagsmith/flagsmith-charts/commit/a242af161de945ba1448feb44bf98f826a1e6e8a))
* Lowercase names for migrate jobs ([#203](https://github.com/Flagsmith/flagsmith-charts/issues/203)) ([3437185](https://github.com/Flagsmith/flagsmith-charts/commit/34371854c1e91c22499b301062fed82e161b15c1))
* **notes:** update docs link ([#218](https://github.com/Flagsmith/flagsmith-charts/issues/218)) ([4112ef3](https://github.com/Flagsmith/flagsmith-charts/commit/4112ef3445d543c7d6aacacf7184a373959b8060))
* **postgresql:port-parsing:** use %v to parse port ([#60](https://github.com/Flagsmith/flagsmith-charts/issues/60)) ([ed06a6f](https://github.com/Flagsmith/flagsmith-charts/commit/ed06a6ff6bff872eefc7686a69af6d5871b26479))
* remove ability to specify ingress paths ([#138](https://github.com/Flagsmith/flagsmith-charts/issues/138)) ([#139](https://github.com/Flagsmith/flagsmith-charts/issues/139)) ([a34f99e](https://github.com/Flagsmith/flagsmith-charts/commit/a34f99e94340ab57e8bc3551a23cc92b8b15fb2e))
* revert pathing changes to API Ingress ([25cd405](https://github.com/Flagsmith/flagsmith-charts/commit/25cd405df249d0499126f0d6b80d2716492070f1))
* secret warning being shown ([#269](https://github.com/Flagsmith/flagsmith-charts/issues/269)) ([88fe146](https://github.com/Flagsmith/flagsmith-charts/commit/88fe146fa1336db528f9ea1519207c8973cc7392))
* Set  `ALLOW_ADMIN_INITIATION_VIA_CLI` when `bootstrap.enabled` is `true` ([#239](https://github.com/Flagsmith/flagsmith-charts/issues/239)) ([1d86894](https://github.com/Flagsmith/flagsmith-charts/commit/1d86894c119961a6b0a950cd64badebf1fb8b135))
* Task processor probe timeouts are too optimistic ([#318](https://github.com/Flagsmith/flagsmith-charts/issues/318)) ([78b5c34](https://github.com/Flagsmith/flagsmith-charts/commit/78b5c3429f4f2364e6e063932532caf48762269b))
* **task-processor:** add run by processor ([#169](https://github.com/Flagsmith/flagsmith-charts/issues/169)) ([47333ea](https://github.com/Flagsmith/flagsmith-charts/commit/47333ea6be3960bea77db89573ee55a7de8d26e8))
* **task-processor:** the extraEnv where added in the wrong place ([#220](https://github.com/Flagsmith/flagsmith-charts/issues/220)) ([19b8cb6](https://github.com/Flagsmith/flagsmith-charts/commit/19b8cb6acfe8d7c25d08708f6513521829881f4d))
* Wrong indentaion for allow admin initialization ([e6886c6](https://github.com/Flagsmith/flagsmith-charts/commit/e6886c63174c53a9fb052ceb45e6f7eb86d328f9))
* Wrong indentaion for allow admin initialization ([6cebf60](https://github.com/Flagsmith/flagsmith-charts/commit/6cebf6092e4efea8433abca7d85c888d342d101e))
* Wrong indentation for the bootstrap job environment ([#258](https://github.com/Flagsmith/flagsmith-charts/issues/258)) ([1a8fc91](https://github.com/Flagsmith/flagsmith-charts/commit/1a8fc91cd0ffe0dd24a829869f9827a664382a8f))


### CI

* add codeowners ([#194](https://github.com/Flagsmith/flagsmith-charts/issues/194)) ([e0ce722](https://github.com/Flagsmith/flagsmith-charts/commit/e0ce7225ad31039e9458a60a76dd070a0a27c6ec))
* auto assign prs ([#171](https://github.com/Flagsmith/flagsmith-charts/issues/171)) ([79f8174](https://github.com/Flagsmith/flagsmith-charts/commit/79f81745a442eabc6e697a1db66c09103029ab30))
* docker images thru scarf ([#246](https://github.com/Flagsmith/flagsmith-charts/issues/246)) ([896a3d0](https://github.com/Flagsmith/flagsmith-charts/commit/896a3d06cd3d7a6955d48537e0db93a35f4d4b3f))
* fix auto assign permissions ([#174](https://github.com/Flagsmith/flagsmith-charts/issues/174)) ([06cf5b1](https://github.com/Flagsmith/flagsmith-charts/commit/06cf5b15fa7d5a3ff4437d0ac11aa177b9dce2ee))


### Docs

* link to docs from readme ([#154](https://github.com/Flagsmith/flagsmith-charts/issues/154)) ([0cf9120](https://github.com/Flagsmith/flagsmith-charts/commit/0cf91203da115c256efbce43db4a79cbac0e0fac))


### Dependency Updates

* bump Flagsmith from 2.184.0 to 2.188.1 ([#389](https://github.com/Flagsmith/flagsmith-charts/issues/389)) ([52be9d4](https://github.com/Flagsmith/flagsmith-charts/commit/52be9d4685832956bd0dfbdf9560ed3b0b46a1bc))


### Other

* 0.73.0 ([02e513c](https://github.com/Flagsmith/flagsmith-charts/commit/02e513c027705944f4762cd21dc28a3239a4e1ce))
* 0.74.0 ([58e3662](https://github.com/Flagsmith/flagsmith-charts/commit/58e366268e84464872427ec26ae7af54d760ab1c))
* **main:** release 0.75.0 ([#384](https://github.com/Flagsmith/flagsmith-charts/issues/384)) ([c2c2b3d](https://github.com/Flagsmith/flagsmith-charts/commit/c2c2b3d7fc03b88ee9d10df8b39c8d3466b1d90f))
* Use run-docker script for task processor ([#173](https://github.com/Flagsmith/flagsmith-charts/issues/173)) ([8bd648e](https://github.com/Flagsmith/flagsmith-charts/commit/8bd648e9b72d82dd10f9b3ac915b7eaeb08f2bf8))

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
