# ClearML Ecosystem for Kubernetes

![Version: 3.0.6](https://img.shields.io/badge/Version-3.0.6-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.1.1](https://img.shields.io/badge/AppVersion-1.1.1-informational?style=flat-square)

MLOps platform

**Homepage:** <https://clear.ml>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| valeriano-manassero |  | https://github.com/valeriano-manassero |

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
mkdir -pm 777 /tmp/clearml-kind

cat <<EOF > /tmp/clearml-kind.yaml
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

kind create cluster --config /tmp/clearml-kind.yaml

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

## Additional Configuration for ClearML Server

You can also configure the **clearml-server** for:

* fixed users (users with credentials)
* non-responsive experiment watchdog settings

For detailed instructions, see the [Optional Configuration](https://github.com/allegroai/clearml-server#optional-configuration) section in the **clearml-server** repository README file.

## Source Code

* <https://github.com/allegroai/clearml-helm-charts>
* <https://github.com/allegroai/clearml>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | mongodb | ~10.3.2 |
| https://charts.bitnami.com/bitnami | redis | ~10.9.0 |
| https://helm.elastic.co | elasticsearch | ~7.10.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| agentGroups.agent-group-cpu.affinity | object | `{}` |  |
| agentGroups.agent-group-cpu.agentVersion | string | `""` |  |
| agentGroups.agent-group-cpu.awsAccessKeyId | string | `nil` |  |
| agentGroups.agent-group-cpu.awsDefaultRegion | string | `nil` |  |
| agentGroups.agent-group-cpu.awsSecretAccessKey | string | `nil` |  |
| agentGroups.agent-group-cpu.azureStorageAccount | string | `nil` |  |
| agentGroups.agent-group-cpu.azureStorageKey | string | `nil` |  |
| agentGroups.agent-group-cpu.clearmlAccessKey | string | `nil` |  |
| agentGroups.agent-group-cpu.clearmlConfig | string | `"sdk {\n}"` |  |
| agentGroups.agent-group-cpu.clearmlGitPassword | string | `nil` |  |
| agentGroups.agent-group-cpu.clearmlGitUser | string | `nil` |  |
| agentGroups.agent-group-cpu.clearmlSecretKey | string | `nil` |  |
| agentGroups.agent-group-cpu.enabled | bool | `true` |  |
| agentGroups.agent-group-cpu.image.pullPolicy | string | `"IfNotPresent"` |  |
| agentGroups.agent-group-cpu.image.repository | string | `"ubuntu"` |  |
| agentGroups.agent-group-cpu.image.tag | string | `"18.04"` |  |
| agentGroups.agent-group-cpu.name | string | `"agent-group-cpu"` |  |
| agentGroups.agent-group-cpu.nodeSelector | object | `{}` |  |
| agentGroups.agent-group-cpu.nvidiaGpusPerAgent | int | `0` |  |
| agentGroups.agent-group-cpu.podAnnotations | object | `{}` |  |
| agentGroups.agent-group-cpu.queues | string | `"default"` |  |
| agentGroups.agent-group-cpu.replicaCount | int | `1` |  |
| agentGroups.agent-group-cpu.tolerations | list | `[]` |  |
| agentGroups.agent-group-cpu.updateStrategy | string | `"Recreate"` |  |
| agentGroups.agent-group-gpu.affinity | object | `{}` |  |
| agentGroups.agent-group-gpu.agentVersion | string | `""` |  |
| agentGroups.agent-group-gpu.awsAccessKeyId | string | `nil` |  |
| agentGroups.agent-group-gpu.awsDefaultRegion | string | `nil` |  |
| agentGroups.agent-group-gpu.awsSecretAccessKey | string | `nil` |  |
| agentGroups.agent-group-gpu.azureStorageAccount | string | `nil` |  |
| agentGroups.agent-group-gpu.azureStorageKey | string | `nil` |  |
| agentGroups.agent-group-gpu.clearmlAccessKey | string | `nil` |  |
| agentGroups.agent-group-gpu.clearmlConfig | string | `"sdk {\n}"` |  |
| agentGroups.agent-group-gpu.clearmlGitPassword | string | `nil` |  |
| agentGroups.agent-group-gpu.clearmlGitUser | string | `nil` |  |
| agentGroups.agent-group-gpu.clearmlSecretKey | string | `nil` |  |
| agentGroups.agent-group-gpu.enabled | bool | `true` |  |
| agentGroups.agent-group-gpu.image.pullPolicy | string | `"IfNotPresent"` |  |
| agentGroups.agent-group-gpu.image.repository | string | `"nvidia/cuda"` |  |
| agentGroups.agent-group-gpu.image.tag | string | `"11.0-base-ubuntu18.04"` |  |
| agentGroups.agent-group-gpu.name | string | `"agent-group-gpu"` |  |
| agentGroups.agent-group-gpu.nodeSelector | object | `{}` |  |
| agentGroups.agent-group-gpu.nvidiaGpusPerAgent | int | `1` |  |
| agentGroups.agent-group-gpu.podAnnotations | object | `{}` |  |
| agentGroups.agent-group-gpu.queues | string | `"default"` |  |
| agentGroups.agent-group-gpu.replicaCount | int | `0` |  |
| agentGroups.agent-group-gpu.tolerations | list | `[]` |  |
| agentGroups.agent-group-gpu.updateStrategy | string | `"Recreate"` |  |
| agentservices.affinity | object | `{}` |  |
| agentservices.agentVersion | string | `""` |  |
| agentservices.awsAccessKeyId | string | `nil` |  |
| agentservices.awsDefaultRegion | string | `nil` |  |
| agentservices.awsSecretAccessKey | string | `nil` |  |
| agentservices.azureStorageAccount | string | `nil` |  |
| agentservices.azureStorageKey | string | `nil` |  |
| agentservices.clearmlFilesHost | string | `nil` |  |
| agentservices.clearmlGitPassword | string | `nil` |  |
| agentservices.clearmlGitUser | string | `nil` |  |
| agentservices.clearmlHostIp | string | `nil` |  |
| agentservices.clearmlWebHost | string | `nil` |  |
| agentservices.clearmlWorkerId | string | `"clearml-services"` |  |
| agentservices.enabled | bool | `false` |  |
| agentservices.extraEnvs | list | `[]` |  |
| agentservices.googleCredentials | string | `nil` |  |
| agentservices.image.pullPolicy | string | `"IfNotPresent"` |  |
| agentservices.image.repository | string | `"allegroai/clearml-agent-services"` |  |
| agentservices.image.tag | string | `"latest"` |  |
| agentservices.nodeSelector | object | `{}` |  |
| agentservices.podAnnotations | object | `{}` |  |
| agentservices.replicaCount | int | `1` |  |
| agentservices.resources | object | `{}` |  |
| agentservices.storage.data.class | string | `"standard"` |  |
| agentservices.storage.data.size | string | `"50Gi"` |  |
| agentservices.tolerations | list | `[]` |  |
| apiserver.additionalConfigs | object | `{}` |  |
| apiserver.affinity | object | `{}` |  |
| apiserver.configDir | string | `"/opt/clearml/config"` |  |
| apiserver.extraEnvs | list | `[]` |  |
| apiserver.image.pullPolicy | string | `"IfNotPresent"` |  |
| apiserver.image.repository | string | `"allegroai/clearml"` |  |
| apiserver.image.tag | string | `"1.1.1"` |  |
| apiserver.livenessDelay | int | `60` |  |
| apiserver.nodeSelector | object | `{}` |  |
| apiserver.podAnnotations | object | `{}` |  |
| apiserver.prepopulateArtifactsPath | string | `"/mnt/fileserver"` |  |
| apiserver.prepopulateEnabled | string | `"true"` |  |
| apiserver.prepopulateZipFiles | string | `"/opt/clearml/db-pre-populate"` |  |
| apiserver.readinessDelay | int | `60` |  |
| apiserver.replicaCount | int | `1` |  |
| apiserver.resources | object | `{}` |  |
| apiserver.service.nodePort | int | `30008` | If service.type set to NodePort, this will be set to service's nodePort field. If service.type is set to others, this field will be ignored |
| apiserver.service.port | int | `8008` |  |
| apiserver.service.type | string | `"NodePort"` | This will set to service's spec.type field |
| apiserver.tolerations | list | `[]` |  |
| clearml.defaultCompany | string | `"d1bd92a3b039400cbafc60a7a5b1e52b"` |  |
| elasticsearch.clusterHealthCheckParams | string | `"wait_for_status=yellow&timeout=1s"` |  |
| elasticsearch.clusterName | string | `"clearml-elastic"` |  |
| elasticsearch.enabled | bool | `true` |  |
| elasticsearch.esConfig."elasticsearch.yml" | string | `"xpack.security.enabled: false\n"` |  |
| elasticsearch.esJavaOpts | string | `"-Xmx2g -Xms2g"` |  |
| elasticsearch.extraEnvs[0].name | string | `"bootstrap.memory_lock"` |  |
| elasticsearch.extraEnvs[0].value | string | `"false"` |  |
| elasticsearch.extraEnvs[1].name | string | `"cluster.routing.allocation.node_initial_primaries_recoveries"` |  |
| elasticsearch.extraEnvs[1].value | string | `"500"` |  |
| elasticsearch.extraEnvs[2].name | string | `"cluster.routing.allocation.disk.watermark.low"` |  |
| elasticsearch.extraEnvs[2].value | string | `"500mb"` |  |
| elasticsearch.extraEnvs[3].name | string | `"cluster.routing.allocation.disk.watermark.high"` |  |
| elasticsearch.extraEnvs[3].value | string | `"500mb"` |  |
| elasticsearch.extraEnvs[4].name | string | `"cluster.routing.allocation.disk.watermark.flood_stage"` |  |
| elasticsearch.extraEnvs[4].value | string | `"500mb"` |  |
| elasticsearch.extraEnvs[5].name | string | `"http.compression_level"` |  |
| elasticsearch.extraEnvs[5].value | string | `"7"` |  |
| elasticsearch.extraEnvs[6].name | string | `"reindex.remote.whitelist"` |  |
| elasticsearch.extraEnvs[6].value | string | `"*.*"` |  |
| elasticsearch.extraEnvs[7].name | string | `"xpack.monitoring.enabled"` |  |
| elasticsearch.extraEnvs[7].value | string | `"false"` |  |
| elasticsearch.extraEnvs[8].name | string | `"xpack.security.enabled"` |  |
| elasticsearch.extraEnvs[8].value | string | `"false"` |  |
| elasticsearch.httpPort | int | `9200` |  |
| elasticsearch.minimumMasterNodes | int | `1` |  |
| elasticsearch.persistence.enabled | bool | `true` |  |
| elasticsearch.replicas | int | `1` |  |
| elasticsearch.resources.limits.memory | string | `"4Gi"` |  |
| elasticsearch.resources.requests.memory | string | `"4Gi"` |  |
| elasticsearch.roles.data | string | `"true"` |  |
| elasticsearch.roles.ingest | string | `"true"` |  |
| elasticsearch.roles.master | string | `"true"` |  |
| elasticsearch.roles.remote_cluster_client | string | `"true"` |  |
| elasticsearch.volumeClaimTemplate.accessModes[0] | string | `"ReadWriteOnce"` |  |
| elasticsearch.volumeClaimTemplate.resources.requests.storage | string | `"50Gi"` |  |
| fileserver.affinity | object | `{}` |  |
| fileserver.extraEnvs | list | `[]` |  |
| fileserver.image.pullPolicy | string | `"IfNotPresent"` |  |
| fileserver.image.repository | string | `"allegroai/clearml"` |  |
| fileserver.image.tag | string | `"1.1.1"` |  |
| fileserver.nodeSelector | object | `{}` |  |
| fileserver.podAnnotations | object | `{}` |  |
| fileserver.replicaCount | int | `1` |  |
| fileserver.resources | object | `{}` |  |
| fileserver.service.nodePort | int | `30081` | If service.type set to NodePort, this will be set to service's nodePort field. If service.type is set to others, this field will be ignored |
| fileserver.service.port | int | `8081` |  |
| fileserver.service.type | string | `"NodePort"` | This will set to service's spec.type field |
| fileserver.storage.data.class | string | `"standard"` |  |
| fileserver.storage.data.size | string | `"50Gi"` |  |
| fileserver.tolerations | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.api.hostName | string | `"api.clearml.127-0-0-1.nip.io"` |  |
| ingress.api.tlsSecretName | string | `""` |  |
| ingress.app.hostName | string | `"app.clearml.127-0-0-1.nip.io"` |  |
| ingress.app.tlsSecretName | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.files.hostName | string | `"files.clearml.127-0-0-1.nip.io"` |  |
| ingress.files.tlsSecretName | string | `""` |  |
| ingress.name | string | `"clearml-server-ingress"` |  |
| mongodb.architecture | string | `"standalone"` |  |
| mongodb.auth.enabled | bool | `false` |  |
| mongodb.enabled | bool | `true` |  |
| mongodb.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| mongodb.persistence.enabled | bool | `true` |  |
| mongodb.persistence.size | string | `"50Gi"` |  |
| mongodb.replicaCount | int | `1` |  |
| mongodb.service.name | string | `"{{ .Release.Name }}-mongodb"` |  |
| mongodb.service.port | int | `27017` |  |
| mongodb.service.portName | string | `"mongo-service"` |  |
| mongodb.service.type | string | `"ClusterIP"` |  |
| redis.cluster.enabled | bool | `false` |  |
| redis.databaseNumber | int | `0` |  |
| redis.enabled | bool | `true` |  |
| redis.master.name | string | `"{{ .Release.Name }}-redis-master"` |  |
| redis.master.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| redis.master.persistence.enabled | bool | `true` |  |
| redis.master.persistence.size | string | `"5Gi"` |  |
| redis.master.port | int | `6379` |  |
| redis.usePassword | bool | `false` |  |
| secret.authToken | string | `"1SCf0ov3Nm544Td2oZ0gXSrsNx5XhMWdVlKz1tOgcx158bD5RV"` | Set for auth_token field |
| secret.credentials.apiserver.accessKey | string | `"5442F3443MJMORWZA3ZH"` | Set for apiserver_key field |
| secret.credentials.apiserver.secretKey | string | `"BxapIRo9ZINi8x25CRxz8Wdmr2pQjzuWVB4PNASZqCtTyWgWVQ"` | Set for apiserver_secret field |
| secret.credentials.tests.accessKey | string | `"ENP39EQM4SLACGD5FXB7"` | Set for tests_user_key field |
| secret.credentials.tests.secretKey | string | `"lPcm0imbcBZ8mwgO7tpadutiS3gnJD05x9j7afwXPS35IKbpiQ"` | Set for tests_user_secret field |
| secret.httpSession | string | `"9Tw20RbhJ1bLBiHEOWXvhplKGUbTgLzAtwFN2oLQvWwS0uRpD5"` | Set for http_session field |
| webserver.affinity | object | `{}` |  |
| webserver.extraEnvs | list | `[]` |  |
| webserver.image.pullPolicy | string | `"IfNotPresent"` |  |
| webserver.image.repository | string | `"allegroai/clearml"` |  |
| webserver.image.tag | string | `"1.1.1"` |  |
| webserver.nodeSelector | object | `{}` |  |
| webserver.podAnnotations | object | `{}` |  |
| webserver.replicaCount | int | `1` |  |
| webserver.resources | object | `{}` |  |
| webserver.service.nodePort | int | `30080` | If service.type set to NodePort, this will be set to service's nodePort field. If service.type is set to others, this field will be ignored |
| webserver.service.port | int | `80` |  |
| webserver.service.type | string | `"NodePort"` | This will set to service's spec.type field |
| webserver.tolerations | list | `[]` |  |
