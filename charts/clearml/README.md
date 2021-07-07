# ClearML Ecosystem for Kubernetes

![Version: 2.0.0-alpha2](https://img.shields.io/badge/Version-2.0.0--alpha2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.2](https://img.shields.io/badge/AppVersion-1.0.2-informational?style=flat-square)

MLOps platform

**Homepage:** <https://clear.ml>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| valeriano-manassero |  | https://github.com/valeriano-manassero |

## Introduction

The **clearml-server** is the backend service infrastructure for [ClearML](https://github.com/allegroai/clearml).
It allows multiple users to collaborate and manage their experiments.
By default, *ClearML is set up to work with the ClearML Demo Server, which is open to anyone and resets periodically.
In order to host your own server, you will need to install **clearml-server** and point ClearML to it.

**clearml-server** contains the following components:

* The ClearML Web-App, a single-page UI for experiment management and browsing
* RESTful API for:
    * Documenting and logging experiment information, statistics and results
    * Querying experiments history, logs and results
* Locally-hosted file server for storing images and models making them easily accessible using the Web-App

## Port Mapping

After **clearml-server** is deployed, the services expose the following node ports:

* API server on `30008`
* Web server on `30080`
* File server on `30081`

## Accessing ClearML Server

Access **clearml-server** by creating a load balancer and domain name with records pointing to the load balancer.

Once you have a load balancer and domain name set up, follow these steps to configure access to clearml-server on your k8s cluster:

1. Create domain records

   * Create 3 records to be used for Web-App, File server and API access using the following rules:
     * `app.<your domain name>`
     * `files.<your domain name>`
     * `api.<your domain name>`
    
     (*for example, `app.clearml.mydomainname.com`, `files.clearml.mydomainname.com` and `api.clearml.mydomainname.com`*)
2. Point the records you created to the load balancer
3. Configure the load balancer to redirect traffic coming from the records you created:
     * `app.<your domain name>` should be redirected to k8s cluster nodes on port `30080`
     * `files.<your domain name>` should be redirected to k8s cluster nodes on port `30081`
     * `api.<your domain name>` should be redirected to k8s cluster nodes on port `30008`

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
| agentGroups.agent-group0.affinity | object | `{}` |  |
| agentGroups.agent-group0.agentVersion | string | `""` |  |
| agentGroups.agent-group0.awsAccessKeyId | string | `nil` |  |
| agentGroups.agent-group0.awsDefaultRegion | string | `nil` |  |
| agentGroups.agent-group0.awsSecretAccessKey | string | `nil` |  |
| agentGroups.agent-group0.azureStorageAccount | string | `nil` |  |
| agentGroups.agent-group0.azureStorageKey | string | `nil` |  |
| agentGroups.agent-group0.clearmlAccessKey | string | `nil` |  |
| agentGroups.agent-group0.clearmlConfig | string | `"sdk {\n}"` |  |
| agentGroups.agent-group0.clearmlGitPassword | string | `nil` |  |
| agentGroups.agent-group0.clearmlGitUser | string | `nil` |  |
| agentGroups.agent-group0.clearmlSecretKey | string | `nil` |  |
| agentGroups.agent-group0.image.pullPolicy | string | `"IfNotPresent"` |  |
| agentGroups.agent-group0.image.repository | string | `"nvidia/cuda"` |  |
| agentGroups.agent-group0.image.tag | string | `"11.0-base-ubuntu18.04"` |  |
| agentGroups.agent-group0.name | string | `"agent-group0"` |  |
| agentGroups.agent-group0.nodeSelector | object | `{}` |  |
| agentGroups.agent-group0.nvidiaGpusPerAgent | int | `1` |  |
| agentGroups.agent-group0.podAnnotations | object | `{}` |  |
| agentGroups.agent-group0.queues | string | `"default"` |  |
| agentGroups.agent-group0.replicaCount | int | `0` |  |
| agentGroups.agent-group0.tolerations | list | `[]` |  |
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
| apiserver.affinity | object | `{}` |  |
| apiserver.configDir | string | `"/opt/clearml/config"` |  |
| apiserver.extraEnvs | list | `[]` |  |
| apiserver.image.pullPolicy | string | `"IfNotPresent"` |  |
| apiserver.image.repository | string | `"allegroai/clearml"` |  |
| apiserver.image.tag | string | `"1.0.2"` |  |
| apiserver.livenessDelay | int | `60` |  |
| apiserver.nodeSelector | object | `{}` |  |
| apiserver.podAnnotations | object | `{}` |  |
| apiserver.prepopulateArtifactsPath | string | `"/mnt/fileserver"` |  |
| apiserver.prepopulateEnabled | string | `"true"` |  |
| apiserver.prepopulateZipFiles | string | `"/opt/clearml/db-pre-populate"` |  |
| apiserver.readinessDelay | int | `60` |  |
| apiserver.replicaCount | int | `1` |  |
| apiserver.resources | object | `{}` |  |
| apiserver.service.port | int | `8008` |  |
| apiserver.service.type | string | `"NodePort"` |  |
| apiserver.storage.config.class | string | `"standard"` |  |
| apiserver.storage.config.size | string | `"1Gi"` |  |
| apiserver.storage.enableConfigVolume | bool | `false` |  |
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
| fileserver.image.tag | string | `"1.0.2"` |  |
| fileserver.nodeSelector | object | `{}` |  |
| fileserver.podAnnotations | object | `{}` |  |
| fileserver.replicaCount | int | `1` |  |
| fileserver.resources | object | `{}` |  |
| fileserver.service.port | int | `8081` |  |
| fileserver.service.type | string | `"NodePort"` |  |
| fileserver.storage.data.class | string | `"standard"` |  |
| fileserver.storage.data.size | string | `"50Gi"` |  |
| fileserver.tolerations | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.host | string | `""` |  |
| ingress.name | string | `"clearml-server-ingress"` |  |
| ingress.tls.secretName | string | `""` |  |
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
| webserver.affinity | object | `{}` |  |
| webserver.extraEnvs | list | `[]` |  |
| webserver.image.pullPolicy | string | `"IfNotPresent"` |  |
| webserver.image.repository | string | `"allegroai/clearml"` |  |
| webserver.image.tag | string | `"1.0.2"` |  |
| webserver.nodeSelector | object | `{}` |  |
| webserver.podAnnotations | object | `{}` |  |
| webserver.replicaCount | int | `1` |  |
| webserver.resources | object | `{}` |  |
| webserver.service.port | int | `80` |  |
| webserver.service.type | string | `"NodePort"` |  |
| webserver.tolerations | list | `[]` |  |
