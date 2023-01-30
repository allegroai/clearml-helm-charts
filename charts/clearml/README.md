# ClearML Ecosystem for Kubernetes

![Version: 5.5.1](https://img.shields.io/badge/Version-5.5.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.9.2](https://img.shields.io/badge/AppVersion-1.9.2-informational?style=flat-square)

MLOps platform

**Homepage:** <https://clear.ml>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| valeriano-manassero |  | <https://github.com/valeriano-manassero> |

## Introduction

The **clearml-server** is the backend service infrastructure for [ClearML](https://github.com/allegroai/clearml).
It allows multiple users to collaborate and manage their experiments.

**clearml-server** contains the following components:

* The ClearML Web-App, a single-page UI for experiment management and browsing
* RESTful API for:
    * Documenting and logging experiment information, statistics and results
    * Querying experiments history, logs and results
* Locally-hosted file server for storing images and models making them easily accessible using the Web-App

## Local environment

For development/evaluation it's possible to use [kind](https://kind.sigs.k8s.io).
After installation, following commands will create a complete ClearML insatllation:

```
cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraPortMappings:
  # API server's default nodePort is 30008. If you customize it in helm values by
  # `apiserver.service.nodePort`, `containerPort` should match it
  - containerPort: 30008
    hostPort: 30008
    listenAddress: "127.0.0.1"
    protocol: TCP
  # Web server's default nodePort is 30080. If you customize it in helm values by
  # `webserver.service.nodePort`, `containerPort` should match it
  - containerPort: 30080
    hostPort: 30080
    listenAddress: "127.0.0.1"
    protocol: TCP
  # File server's default nodePort is 30081. If you customize it in helm values by
  # `fileserver.service.nodePort`, `containerPort` should match it
  - containerPort: 30081
    hostPort: 30081
    listenAddress: "127.0.0.1"
    protocol: TCP
  extraMounts:
  - hostPath: /tmp/clearml-kind/
    containerPath: /var/local-path-provisioner
EOF

helm install clearml allegroai/clearml
```

After deployment, the services will be exposed on localhost on the following ports:

* API server on `30008`
* Web server on `30080`
* File server on `30081`

Data persisted in every Kubernetes volume by ClearML will be accessible in /tmp/clearml-kind folder on the host.

## Production cluster environment

In a production environment it's suggested to install an ingress controller and verify that is working correctly.
During ClearML deployment enable `ingress` section of chart values.
This will create 3 ingress rules:

* `app.<your domain name>`
* `files.<your domain name>`
* `api.<your domain name>`

(*for example, `app.clearml.mydomainname.com`, `files.clearml.mydomainname.com` and `api.clearml.mydomainname.com`*)

Just pointing the domain records to the IP where ingress controller is responding will complete the deployment process.

A production ready cluster should also have some different configuration like the one proposed in `values-production.yaml` that can be applied with:

```
helm install clearml allegroai/clearml -f values-production.yaml
```

## Upgrades/ Values upgrades

Updating to latest version of this chart can be done in two steps:

```
helm repo update
helm upgrade clearml allegroai/clearml
```

Changing values on existing installation can be done with:

```
helm upgrade clearml allegroai/clearml --version <CURRENT CHART VERSION> -f custom_values.yaml
```

Please note: updating values only should always be done setting explicit chart version to avoid a possible chart update.
Keeping separate updates procedures between version and values can be a good practice to seprate potential concerns.

## ENTERPRISE Version

There are some specific Enterprise version features that can be enabled only with specific Enterprise licensed images.
Enabling this features on OSS version can cause the entire installation to break.

## Additional Configuration for ClearML Server

You can also configure the **clearml-server** for:

* fixed users (users with credentials)
* non-responsive experiment watchdog settings

For detailed instructions, see the [Optional Configuration](https://github.com/allegroai/clearml-server#optional-configuration) section in the **clearml-server** repository README file.

## Source Code

* <https://github.com/allegroai/clearml-helm-charts>
* <https://github.com/allegroai/clearml>

## Requirements

Kubernetes: `>= 1.21.0-0 < 1.27.0-0`

| Repository | Name | Version |
|------------|------|---------|
| file://../../dependency_charts/elasticsearch | elasticsearch | 7.16.2 |
| file://../../dependency_charts/mongodb | mongodb | 10.3.4 |
| file://../../dependency_charts/redis | redis | 10.9.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| apiserver | object | `{"additionalConfigs":{},"affinity":{},"enabled":true,"existingAdditionalConfigsConfigMap":"","existingAdditionalConfigsSecret":"","extraEnvs":[],"image":{"pullPolicy":"IfNotPresent","repository":"allegroai/clearml","tag":"1.9.2-317"},"indexReplicas":0,"indexShards":1,"ingress":{"annotations":{},"enabled":false,"hostName":"api.clearml.127-0-0-1.nip.io","ingressClassName":"","path":"/","tlsSecretName":""},"nodeSelector":{},"podAnnotations":{},"prepopulateEnabled":true,"processes":{"count":8,"maxRequests":1000,"maxRequestsJitter":300,"timeout":24000},"replicaCount":1,"resources":{"limits":{"cpu":"2000m","memory":"1Gi"},"requests":{"cpu":"100m","memory":"256Mi"}},"securityContext":{},"service":{"nodePort":30008,"port":8008,"type":"NodePort"},"tolerations":[]}` | Api Server configurations |
| apiserver.additionalConfigs | object | `{}` | files declared in this parameter will be mounted and read by apiserver (examples in values.yaml) if not overridden by existingAdditionalConfigsSecret |
| apiserver.affinity | object | `{}` | Api Server affinity setup |
| apiserver.enabled | bool | `true` | Enable/Disable component deployment |
| apiserver.existingAdditionalConfigsConfigMap | string | `""` | reference for files declared in existing ConfigMap will be mounted and read by apiserver (examples in values.yaml) |
| apiserver.existingAdditionalConfigsSecret | string | `""` | reference for files declared in existing Secret will be mounted and read by apiserver (examples in values.yaml) if not overridden by existingAdditionalConfigsConfigMap |
| apiserver.extraEnvs | list | `[]` | Api Server extra envrinoment variables |
| apiserver.image | object | `{"pullPolicy":"IfNotPresent","repository":"allegroai/clearml","tag":"1.9.2-317"}` | Api Server image configuration |
| apiserver.indexReplicas | int | `0` | Number of additional replicas in Elasticsearch indexes |
| apiserver.indexShards | int | `1` | Number of shards in Elasticsearch indexes |
| apiserver.ingress | object | `{"annotations":{},"enabled":false,"hostName":"api.clearml.127-0-0-1.nip.io","ingressClassName":"","path":"/","tlsSecretName":""}` | Ingress configuration for Api Server component |
| apiserver.ingress.annotations | object | `{}` | Ingress annotations |
| apiserver.ingress.enabled | bool | `false` | Enable/Disable ingress |
| apiserver.ingress.hostName | string | `"api.clearml.127-0-0-1.nip.io"` | Ingress hostname domain |
| apiserver.ingress.ingressClassName | string | `""` | ClassName (must be defined if no default ingressClassName is available) |
| apiserver.ingress.path | string | `"/"` | Ingress root path url |
| apiserver.ingress.tlsSecretName | string | `""` | Reference to secret containing TLS certificate. If set, it enables HTTPS on ingress rule. |
| apiserver.nodeSelector | object | `{}` | Api Server nodeselector |
| apiserver.podAnnotations | object | `{}` | specific annotation for Api Server pods |
| apiserver.prepopulateEnabled | bool | `true` | Enable/Disable example data load |
| apiserver.processes | object | `{"count":8,"maxRequests":1000,"maxRequestsJitter":300,"timeout":24000}` | Api Server internal processes configuration |
| apiserver.processes.count | int | `8` | Api Server internal listing processes |
| apiserver.processes.maxRequests | int | `1000` | Api Server maximum number of concurrent requests |
| apiserver.processes.maxRequestsJitter | int | `300` | Api Server max jitter on api request |
| apiserver.processes.timeout | int | `24000` | Api timeout (ms) |
| apiserver.replicaCount | int | `1` | Api Server number of pods |
| apiserver.resources | object | `{"limits":{"cpu":"2000m","memory":"1Gi"},"requests":{"cpu":"100m","memory":"256Mi"}}` | Api Server resources per pod; these are minimal requirements, it's suggested to increase these values in production environments |
| apiserver.securityContext | object | `{}` | Api Server pod security context |
| apiserver.service | object | `{"nodePort":30008,"port":8008,"type":"NodePort"}` | Api Server internal service configuration |
| apiserver.service.nodePort | int | `30008` | If service.type set to NodePort, this will be set to service's nodePort field. If service.type is set to others, this field will be ignored |
| apiserver.tolerations | list | `[]` | Api Server tolerations setup |
| clearml | object | `{"apiserverKey":"GGS9F4M6XB2DXJ5AFT9F","apiserverSecret":"2oGujVFhPfaozhpuz2GzQfA5OyxmMsR3WVJpsCR5hrgHFs20PO","clientConfigurationApiUrl":"","clientConfigurationFilesUrl":"","cookieDomain":"","cookieName":"clearml-token-k8s","defaultCompany":"d1bd92a3b039400cbafc60a7a5b1e52b","fileserverKey":"XXCRJ123CEE2KSQ068WO","fileserverSecret":"YIy8EVAC7QCT4FtgitxAQGyW7xRHDZ4jpYlTE7HKiscpORl1hG","readinessprobeKey":"GK4PRTVT3706T25K6BA1","readinessprobeSecret":"ymLh1ok5k5xNUQfS944Xdx9xjf0wueokqKM2dMZfHuH9ayItG2","secureAuthTokenSecret":"ymLh1ok5k5xNUQfS944Xdx9xjf0wueokqKM2dMZfHuH9ayItG2","testUserKey":"ENP39EQM4SLACGD5FXB7","testUserSecret":"lPcm0imbcBZ8mwgO7tpadutiS3gnJD05x9j7afwXPS35IKbpiQ"}` | ClearMl generic configurations |
| clearml.apiserverKey | string | `"GGS9F4M6XB2DXJ5AFT9F"` | Api Server basic auth key |
| clearml.apiserverSecret | string | `"2oGujVFhPfaozhpuz2GzQfA5OyxmMsR3WVJpsCR5hrgHFs20PO"` | Api Server basic auth secret |
| clearml.clientConfigurationApiUrl | string | `""` | Override the API Urls displayed when showing an example of the SDK's clearml.conf configuration |
| clearml.clientConfigurationFilesUrl | string | `""` | Override the Files Urls displayed when showing an example of the SDK's clearml.conf configuration |
| clearml.cookieDomain | string | `""` | Cookie domain to be left empty if not exposed with an ingress |
| clearml.cookieName | string | `"clearml-token-k8s"` | Name fo the UI cookie |
| clearml.defaultCompany | string | `"d1bd92a3b039400cbafc60a7a5b1e52b"` | Company name |
| clearml.fileserverKey | string | `"XXCRJ123CEE2KSQ068WO"` | File Server basic auth key |
| clearml.fileserverSecret | string | `"YIy8EVAC7QCT4FtgitxAQGyW7xRHDZ4jpYlTE7HKiscpORl1hG"` | File Server basic auth secret |
| clearml.readinessprobeKey | string | `"GK4PRTVT3706T25K6BA1"` | Readiness probe basic auth key |
| clearml.readinessprobeSecret | string | `"ymLh1ok5k5xNUQfS944Xdx9xjf0wueokqKM2dMZfHuH9ayItG2"` | Readiness probe basic auth secret |
| clearml.secureAuthTokenSecret | string | `"ymLh1ok5k5xNUQfS944Xdx9xjf0wueokqKM2dMZfHuH9ayItG2"` | Secure Auth secret |
| clearml.testUserKey | string | `"ENP39EQM4SLACGD5FXB7"` | Test Server basic auth key |
| clearml.testUserSecret | string | `"lPcm0imbcBZ8mwgO7tpadutiS3gnJD05x9j7afwXPS35IKbpiQ"` | Test File Server basic auth secret |
| elasticsearch | object | `{"clusterHealthCheckParams":"wait_for_status=yellow&timeout=1s","clusterName":"clearml-elastic","enabled":true,"esConfig":{"elasticsearch.yml":"xpack.security.enabled: false\n"},"esJavaOpts":"-Xmx2g -Xms2g","extraEnvs":[{"name":"bootstrap.memory_lock","value":"false"},{"name":"cluster.routing.allocation.node_initial_primaries_recoveries","value":"500"},{"name":"cluster.routing.allocation.disk.watermark.low","value":"500mb"},{"name":"cluster.routing.allocation.disk.watermark.high","value":"500mb"},{"name":"cluster.routing.allocation.disk.watermark.flood_stage","value":"500mb"},{"name":"http.compression_level","value":"7"},{"name":"reindex.remote.whitelist","value":"*.*"},{"name":"xpack.monitoring.enabled","value":"false"},{"name":"xpack.security.enabled","value":"false"}],"httpPort":9200,"minimumMasterNodes":1,"persistence":{"enabled":true},"replicas":1,"resources":{"limits":{"cpu":"2000m","memory":"4Gi"},"requests":{"cpu":"100m","memory":"2Gi"}},"roles":{"data":"true","ingest":"true","master":"true","remote_cluster_client":"true"},"volumeClaimTemplate":{"accessModes":["ReadWriteOnce"],"resources":{"requests":{"storage":"50Gi"}},"storageClassName":null}}` | Configuration from https://github.com/elastic/helm-charts/blob/7.16/elasticsearch/values.yaml |
| enterpriseFeatures | object | `{"airGappedDocumentation":{"enabled":false,"image":{"repository":"","tag":"4"}},"apiserverImageTagOverride":"3.15.3-909","clearmlApplications":{"affinity":{},"agentKey":"GK4PRTVT3706T25K6BA1","agentSecret":"ymLh1ok5k5xNUQfS944Xdx9xjf0wueokqKM2dMZfHuH9ayItG2","basePodImage":{"repository":"","tag":"app-1.1.1-47"},"enabled":true,"extraEnvs":[],"gitAgentPass":"git_password","gitAgentUser":"git_user","image":{"pullPolicy":"IfNotPresent","repository":"","tag":"1.24-57"},"nodeSelector":{},"podAnnotations":{},"replicaCount":1,"resources":{"limits":{"cpu":"2000m","memory":"1Gi"},"requests":{"cpu":"100m","memory":"256Mi"}},"tolerations":[]},"defaultCompanyGuid":"d1bd92a3b039400cbafc60a7a5b1e52b","enabled":false,"extraIndexUrl":"","fileserverImageTagOverride":"3.15.3-909","overrideReferenceApiUrl":"","overrideReferenceFileUrl":"","webserverImageTagOverride":"3.15.3-801"}` | Enterprise features (work only with an Enterprise license) |
| enterpriseFeatures.airGappedDocumentation | object | `{"enabled":false,"image":{"repository":"","tag":"4"}}` | Air gapped documentation  configurations |
| enterpriseFeatures.airGappedDocumentation.enabled | bool | `false` | Enable/Disable air gapped documentation deployment |
| enterpriseFeatures.airGappedDocumentation.image | object | `{"repository":"","tag":"4"}` | Air gapped documentation image configuration |
| enterpriseFeatures.apiserverImageTagOverride | string | `"3.15.3-909"` | Image tag override for apiserver enterprise version |
| enterpriseFeatures.clearmlApplications | object | `{"affinity":{},"agentKey":"GK4PRTVT3706T25K6BA1","agentSecret":"ymLh1ok5k5xNUQfS944Xdx9xjf0wueokqKM2dMZfHuH9ayItG2","basePodImage":{"repository":"","tag":"app-1.1.1-47"},"enabled":true,"extraEnvs":[],"gitAgentPass":"git_password","gitAgentUser":"git_user","image":{"pullPolicy":"IfNotPresent","repository":"","tag":"1.24-57"},"nodeSelector":{},"podAnnotations":{},"replicaCount":1,"resources":{"limits":{"cpu":"2000m","memory":"1Gi"},"requests":{"cpu":"100m","memory":"256Mi"}},"tolerations":[]}` | APPS configurations |
| enterpriseFeatures.clearmlApplications.affinity | object | `{}` | APPS affinity setup |
| enterpriseFeatures.clearmlApplications.agentKey | string | `"GK4PRTVT3706T25K6BA1"` | Apps Server basic auth key |
| enterpriseFeatures.clearmlApplications.agentSecret | string | `"ymLh1ok5k5xNUQfS944Xdx9xjf0wueokqKM2dMZfHuH9ayItG2"` | Apps Server basic auth secret |
| enterpriseFeatures.clearmlApplications.basePodImage | object | `{"repository":"","tag":"app-1.1.1-47"}` | APPS base spawning pods image |
| enterpriseFeatures.clearmlApplications.enabled | bool | `true` | Enable/Disable component deployment |
| enterpriseFeatures.clearmlApplications.extraEnvs | list | `[]` | APPS extra envrinoment variables |
| enterpriseFeatures.clearmlApplications.gitAgentPass | string | `"git_password"` | Apps Server Git password |
| enterpriseFeatures.clearmlApplications.gitAgentUser | string | `"git_user"` | Apps Server Git user |
| enterpriseFeatures.clearmlApplications.image | object | `{"pullPolicy":"IfNotPresent","repository":"","tag":"1.24-57"}` | APPS image configuration |
| enterpriseFeatures.clearmlApplications.nodeSelector | object | `{}` | APPS nodeselector |
| enterpriseFeatures.clearmlApplications.podAnnotations | object | `{}` | specific annotation for APPS pods |
| enterpriseFeatures.clearmlApplications.replicaCount | int | `1` | APPS number of pods |
| enterpriseFeatures.clearmlApplications.resources | object | `{"limits":{"cpu":"2000m","memory":"1Gi"},"requests":{"cpu":"100m","memory":"256Mi"}}` | APPS resources per pod; these are minimal requirements, it's suggested to increase these values in production environments |
| enterpriseFeatures.clearmlApplications.tolerations | list | `[]` | APPS tolerations setup |
| enterpriseFeatures.defaultCompanyGuid | string | `"d1bd92a3b039400cbafc60a7a5b1e52b"` | Company ID |
| enterpriseFeatures.enabled | bool | `false` | Enable/Disable Enterprise features |
| enterpriseFeatures.extraIndexUrl | string | `""` | extra index URL for Enterprise packages |
| enterpriseFeatures.fileserverImageTagOverride | string | `"3.15.3-909"` | Image tag override for fileserver enterprise version |
| enterpriseFeatures.overrideReferenceApiUrl | string | `""` | set this value AND overrideReferenceFileUrl if external endpoint exposure is in place (like a LoadBalancer) example: "https://api.clearml.local" |
| enterpriseFeatures.overrideReferenceFileUrl | string | `""` | set this value AND overrideReferenceAPIUrl if external endpoint exposure is in place (like a LoadBalancer) example: "https://files.clearml.local" |
| enterpriseFeatures.webserverImageTagOverride | string | `"3.15.3-801"` | Image tag override for webserver enterprise version |
| externalServices | object | `{"elasticsearchHost":"","elasticsearchPort":9200,"mongodbConnectionStringAuth":"","mongodbConnectionStringBackend":"","redisHost":"","redisPort":6379}` | Definition of external services to use if not enabled as dependency charts here |
| externalServices.elasticsearchHost | string | `""` | Existing ElasticSearch Hostname to use if elasticsearch.enabled is false |
| externalServices.elasticsearchPort | int | `9200` | Existing ElasticSearch Port to use if elasticsearch.enabled is false |
| externalServices.mongodbConnectionStringAuth | string | `""` | Existing MongoDB connection string for BACKEND to use if mongodb.enabled is false |
| externalServices.mongodbConnectionStringBackend | string | `""` | Existing MongoDB connection string for AUTH to use if mongodb.enabled is false |
| externalServices.redisHost | string | `""` | Existing Redis Hostname to use if redis.enabled is false |
| externalServices.redisPort | int | `6379` | Existing Redis Port to use if redis.enabled is false |
| fileserver | object | `{"affinity":{},"enabled":true,"extraEnvs":[],"image":{"pullPolicy":"IfNotPresent","repository":"allegroai/clearml","tag":"1.9.2-317"},"ingress":{"annotations":{},"enabled":false,"hostName":"files.clearml.127-0-0-1.nip.io","ingressClassName":"","path":"/","tlsSecretName":""},"nodeSelector":{},"podAnnotations":{},"replicaCount":1,"resources":{"limits":{"cpu":"2000m","memory":"1Gi"},"requests":{"cpu":"100m","memory":"256Mi"}},"securityContext":{},"service":{"nodePort":30081,"port":8081,"type":"NodePort"},"storage":{"data":{"accessMode":"ReadWriteOnce","class":"","existingPVC":"","size":"50Gi"}},"tolerations":[]}` | File Server configurations |
| fileserver.affinity | object | `{}` | File Server affinity setup |
| fileserver.enabled | bool | `true` | Enable/Disable component deployment |
| fileserver.extraEnvs | list | `[]` | File Server extra envrinoment variables |
| fileserver.image | object | `{"pullPolicy":"IfNotPresent","repository":"allegroai/clearml","tag":"1.9.2-317"}` | File Server image configuration |
| fileserver.ingress | object | `{"annotations":{},"enabled":false,"hostName":"files.clearml.127-0-0-1.nip.io","ingressClassName":"","path":"/","tlsSecretName":""}` | Ingress configuration for File Server component |
| fileserver.ingress.annotations | object | `{}` | Ingress annotations |
| fileserver.ingress.enabled | bool | `false` | Enable/Disable ingress |
| fileserver.ingress.hostName | string | `"files.clearml.127-0-0-1.nip.io"` | Ingress hostname domain |
| fileserver.ingress.ingressClassName | string | `""` | ClassName (must be defined if no default ingressClassName is available) |
| fileserver.ingress.path | string | `"/"` | Ingress root path url |
| fileserver.ingress.tlsSecretName | string | `""` | Reference to secret containing TLS certificate. If set, it enables HTTPS on ingress rule. |
| fileserver.nodeSelector | object | `{}` | File Server nodeselector |
| fileserver.podAnnotations | object | `{}` | specific annotation for File Server pods |
| fileserver.replicaCount | int | `1` | File Server number of pods |
| fileserver.resources | object | `{"limits":{"cpu":"2000m","memory":"1Gi"},"requests":{"cpu":"100m","memory":"256Mi"}}` | File Server resources per pod; these are minimal requirements, it's suggested to increase these values in production environments |
| fileserver.securityContext | object | `{}` | File Server pod security context |
| fileserver.service | object | `{"nodePort":30081,"port":8081,"type":"NodePort"}` | File Server internal service configuration |
| fileserver.service.nodePort | int | `30081` | If service.type set to NodePort, this will be set to service's nodePort field. If service.type is set to others, this field will be ignored |
| fileserver.storage | object | `{"data":{"accessMode":"ReadWriteOnce","class":"","existingPVC":"","size":"50Gi"}}` | File server persistence settings |
| fileserver.storage.data.accessMode | string | `"ReadWriteOnce"` | Access mode (must be ReadWriteMany if fileserver replica > 1) |
| fileserver.storage.data.class | string | `""` | Storage class (use default if empty) |
| fileserver.storage.data.existingPVC | string | `""` | If set, it uses an already existing PVC instead of dynamic provisioning |
| fileserver.tolerations | list | `[]` | File Server tolerations setup |
| imageCredentials | object | `{"email":"someone@host.com","enabled":false,"existingSecret":"","password":"pwd","registry":"docker.io","username":"someone"}` | Container registry configuration |
| imageCredentials.email | string | `"someone@host.com"` | Email |
| imageCredentials.enabled | bool | `false` | Use private authentication mode |
| imageCredentials.existingSecret | string | `""` | If this is set, chart will not generate a secret but will use what is defined here |
| imageCredentials.password | string | `"pwd"` | Registry password |
| imageCredentials.registry | string | `"docker.io"` | Registry name |
| imageCredentials.username | string | `"someone"` | Registry username |
| mongodb | object | `{"architecture":"standalone","auth":{"enabled":false},"enabled":true,"persistence":{"accessModes":["ReadWriteOnce"],"enabled":true,"size":"50Gi","storageClass":null},"replicaCount":1}` | Configuration from https://github.com/bitnami/charts/blob/master/bitnami/mongodb/values.yaml |
| redis | object | `{"cluster":{"enabled":false},"databaseNumber":0,"enabled":true,"master":{"name":"{{ .Release.Name }}-redis-master","persistence":{"accessModes":["ReadWriteOnce"],"enabled":true,"size":"5Gi","storageClass":null},"port":6379},"usePassword":false}` | Configuration from https://github.com/bitnami/charts/blob/master/bitnami/redis/values.yaml |
| webserver | object | `{"additionalConfigs":{},"affinity":{},"enabled":true,"extraEnvs":[],"image":{"pullPolicy":"IfNotPresent","repository":"allegroai/clearml","tag":"1.9.2-317"},"ingress":{"annotations":{},"enabled":false,"hostName":"app.clearml.127-0-0-1.nip.io","ingressClassName":"","path":"/","tlsSecretName":""},"nodeSelector":{},"podAnnotations":{},"podSecurityContext":{},"replicaCount":1,"resources":{"limits":{"cpu":"2000m","memory":"1Gi"},"requests":{"cpu":"100m","memory":"256Mi"}},"service":{"nodePort":30080,"port":8080,"type":"NodePort"},"tolerations":[]}` | Web Server configurations |
| webserver.additionalConfigs | object | `{}` | Additional specific webserver configurations |
| webserver.affinity | object | `{}` | Web Server affinity setup |
| webserver.enabled | bool | `true` | Enable/Disable component deployment |
| webserver.extraEnvs | list | `[]` | Web Server extra envrinoment variables |
| webserver.image | object | `{"pullPolicy":"IfNotPresent","repository":"allegroai/clearml","tag":"1.9.2-317"}` | Web Server image configuration |
| webserver.ingress | object | `{"annotations":{},"enabled":false,"hostName":"app.clearml.127-0-0-1.nip.io","ingressClassName":"","path":"/","tlsSecretName":""}` | Ingress configuration for Web Server component |
| webserver.ingress.annotations | object | `{}` | Ingress annotations |
| webserver.ingress.enabled | bool | `false` | Enable/Disable ingress |
| webserver.ingress.hostName | string | `"app.clearml.127-0-0-1.nip.io"` | Ingress hostname domain |
| webserver.ingress.ingressClassName | string | `""` | ClassName (must be defined if no default ingressClassName is available) |
| webserver.ingress.path | string | `"/"` | Ingress root path url |
| webserver.ingress.tlsSecretName | string | `""` | Reference to secret containing TLS certificate. If set, it enables HTTPS on ingress rule. |
| webserver.nodeSelector | object | `{}` | Web Server nodeselector |
| webserver.podAnnotations | object | `{}` | specific annotation for Web Server pods |
| webserver.podSecurityContext | object | `{}` | Web Server pod security context |
| webserver.replicaCount | int | `1` | Web Server number of pods |
| webserver.resources | object | `{"limits":{"cpu":"2000m","memory":"1Gi"},"requests":{"cpu":"100m","memory":"256Mi"}}` | Web Server resources per pod; these are minimal requirements, it's suggested to increase these values in production environments |
| webserver.service | object | `{"nodePort":30080,"port":8080,"type":"NodePort"}` | Web Server internal service configuration |
| webserver.service.nodePort | int | `30080` | If service.type set to NodePort, this will be set to service's nodePort field. If service.type is set to others, this field will be ignored |
| webserver.tolerations | list | `[]` | Web Server tolerations setup |
