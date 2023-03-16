# ClearML Kubernetes Agent

![Version: 4.0.0](https://img.shields.io/badge/Version-4.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.24](https://img.shields.io/badge/AppVersion-1.24-informational?style=flat-square)

MLOps platform Task running agent

**Homepage:** <https://clear.ml>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| valeriano-manassero |  | <https://github.com/valeriano-manassero> |

## Introduction

The **clearml-agent** is the Kubernetes agent for for [ClearML](https://github.com/allegroai/clearml).
It allows you to schedule distributed experiments on a Kubernetes cluster.

# Upgrading Chart

## Upgrades/ Values upgrades

Updating to latest version of this chart can be done in two steps:

```
helm repo update
helm upgrade clearml-agent allegroai/clearml-agent
```

Changing values on existing installation can be done with:

```
helm upgrade clearml-agent allegroai/clearml-agent --version <CURRENT CHART VERSION> -f custom_values.yaml
```

### Major upgrade from 5.* to 6.*

Before issuing helm upgrade:

* if using securityContexts check for new value form in values.yaml (podSecurityContext and containerSecurityContext)

## ENTERPRISE Version

There are some specific Enterprise version features that can be enabled only with specific Enterprise licensed images.
Enabling this features on OSS version can cause the entire installation to break.

### Non root/privileged environments

*This feature is available for Enterprise version only*

In environments like Openshift or Tanzu it can be required to run non-root/non-privileged pods/containers.
In this case it's recommended to use `values-enterprise-non-root-privileged.yaml` as base for override file.

Keep in mind it's not possible to install packages on non-root containers so images used for Tasks must already have python and pip installed.

## Source Code

* <https://github.com/allegroai/clearml-helm-charts>
* <https://github.com/allegroai/clearml>

## Requirements

Kubernetes: `>= 1.21.0-0 < 1.27.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| agentk8sglue | object | `{"additionalClusterRoleBindings":[],"additionalRoleBindings":[],"affinity":{},"annotations":{},"apiServerUrlReference":"https://api.clear.ml","basePodTemplate":{"affinity":{},"annotations":{},"containerSecurityContext":{},"env":[],"fileMounts":[],"hostAliases":[],"initContainers":[],"labels":{},"nodeSelector":{},"podSecurityContext":{},"priorityClassName":"","resources":{},"schedulerName":"","tolerations":[],"volumeMounts":[],"volumes":[]},"clearmlcheckCertificate":true,"containerCustomBashScript":"","containerSecurityContext":{},"customBashScript":"","debugMode":false,"defaultContainerImage":"ubuntu:18.04","extraEnvs":[],"fileMounts":[],"fileServerUrlReference":"https://files.clear.ml","image":{"registry":"","repository":"allegroai/clearml-agent-k8s-base","tag":"1.24-21"},"labels":{},"nodeSelector":{},"podSecurityContext":{},"queue":"default","replicaCount":1,"serviceExistingAccountName":"","taskAsJob":false,"tolerations":[],"volumeMounts":[],"volumes":[],"webServerUrlReference":"https://app.clear.ml"}` | This agent will spawn queued experiments in new pods, a good use case is to combine this with GPU autoscaling nodes. https://github.com/allegroai/clearml-agent/tree/master/docker/k8s-glue |
| agentk8sglue.additionalClusterRoleBindings | list | `[]` | additional existing ClusterRoleBindings |
| agentk8sglue.additionalRoleBindings | list | `[]` | additional existing RoleBindings |
| agentk8sglue.affinity | object | `{}` | affinity setup for Agent pod (example in values.yaml comments) |
| agentk8sglue.annotations | object | `{}` | annotations setup for Agent pod (example in values.yaml comments) |
| agentk8sglue.apiServerUrlReference | string | `"https://api.clear.ml"` | Reference to Api server url |
| agentk8sglue.basePodTemplate | object | `{"affinity":{},"annotations":{},"containerSecurityContext":{},"env":[],"fileMounts":[],"hostAliases":[],"initContainers":[],"labels":{},"nodeSelector":{},"podSecurityContext":{},"priorityClassName":"","resources":{},"schedulerName":"","tolerations":[],"volumeMounts":[],"volumes":[]}` | base template for pods spawned to consume ClearML Task |
| agentk8sglue.basePodTemplate.affinity | object | `{}` | affinity setup for pods spawned to consume ClearML Task |
| agentk8sglue.basePodTemplate.annotations | object | `{}` | annotations setup for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.containerSecurityContext | object | `{}` | securityContext setup for containers spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.env | list | `[]` | environment variables for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.fileMounts | list | `[]` | file definition for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.hostAliases | list | `[]` | hostAliases setup for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.initContainers | list | `[]` | initContainers definition for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.labels | object | `{}` | labels setup for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.nodeSelector | object | `{}` | nodeSelector setup for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.podSecurityContext | object | `{}` | securityContext setup for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.priorityClassName | string | `""` | priorityClassName setup for pods spawned to consume ClearML Task |
| agentk8sglue.basePodTemplate.resources | object | `{}` | resources declaration for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.schedulerName | string | `""` | schedulerName setup for pods spawned to consume ClearML Task |
| agentk8sglue.basePodTemplate.tolerations | list | `[]` | tolerations setup for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.volumeMounts | list | `[]` | volume mounts definition for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.volumes | list | `[]` | volumes definition for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.clearmlcheckCertificate | bool | `true` | Check certificates validity for evefry UrlReference below. |
| agentk8sglue.containerCustomBashScript | string | `""` | Custom Bash script for the Task Pods ran by Glue Agent |
| agentk8sglue.containerSecurityContext | object | `{}` | container securityContext setup for Agent pod (example in values.yaml comments) |
| agentk8sglue.customBashScript | string | `""` | Custom Bash script for the Agent pod ran by Glue Agent |
| agentk8sglue.debugMode | bool | `false` | Enable Debugging logs for Agent pod |
| agentk8sglue.defaultContainerImage | string | `"ubuntu:18.04"` | default container image for ClearML Task pod |
| agentk8sglue.extraEnvs | list | `[]` | Extra Environment variables for Glue Agent |
| agentk8sglue.fileMounts | list | `[]` | file definition for Glue Agent (example in values.yaml comments) |
| agentk8sglue.fileServerUrlReference | string | `"https://files.clear.ml"` | Reference to File server url |
| agentk8sglue.image | object | `{"registry":"","repository":"allegroai/clearml-agent-k8s-base","tag":"1.24-21"}` | Glue Agent image configuration |
| agentk8sglue.labels | object | `{}` | labels setup for Agent pod (example in values.yaml comments) |
| agentk8sglue.nodeSelector | object | `{}` | nodeSelector setup for Agent pod (example in values.yaml comments) |
| agentk8sglue.podSecurityContext | object | `{}` | container securityContext setup for Agent pod (example in values.yaml comments) |
| agentk8sglue.queue | string | `"default"` | ClearML queue this agent will consume |
| agentk8sglue.replicaCount | int | `1` | Glue Agent number of pods |
| agentk8sglue.serviceExistingAccountName | string | `""` | if set, don't create a serviceAccountName but use defined existing one |
| agentk8sglue.taskAsJob | bool | `false` | ClearML spawn tasks as jobs instead of pods |
| agentk8sglue.tolerations | list | `[]` | tolerations setup for Agent pod (example in values.yaml comments) |
| agentk8sglue.volumeMounts | list | `[]` | volume mounts definition for Glue Agent (example in values.yaml comments) |
| agentk8sglue.volumes | list | `[]` | volumes definition for Glue Agent (example in values.yaml comments) |
| agentk8sglue.webServerUrlReference | string | `"https://app.clear.ml"` | Reference to Web server url |
| clearml | object | `{"agentk8sglueKey":"ACCESSKEY","agentk8sglueSecret":"SECRETKEY","clearmlConfig":"sdk {\n}","existingAgentk8sglueSecret":"","existingClearmlConfigSecret":""}` | ClearMl generic configurations |
| clearml.agentk8sglueKey | string | `"ACCESSKEY"` | Agent k8s Glue basic auth key |
| clearml.agentk8sglueSecret | string | `"SECRETKEY"` | Agent k8s Glue basic auth secret |
| clearml.clearmlConfig | string | `"sdk {\n}"` | ClearML configuration file |
| clearml.existingAgentk8sglueSecret | string | `""` | If this is set, chart will not generate a secret but will use what is defined here |
| clearml.existingClearmlConfigSecret | string | `""` | If this is set, chart will not generate a secret but will use what is defined here |
| enterpriseFeatures | object | `{"agentImageTagOverride":"1.24-58","applyVaultEnvVars":true,"createQueues":false,"enabled":false,"maxPods":10,"monitoredResources":{"maxResources":0,"maxResourcesFieldName":"resources|limits|nvidia.com/gpu","minResourcesFieldName":"resources|limits|nvidia.com/gpu"},"queues":null,"serviceAccountClusterAccess":false,"useOwnerToken":true}` | Enterprise features (work only with an Enterprise license) |
| enterpriseFeatures.agentImageTagOverride | string | `"1.24-58"` | Image tag override for enterprise version |
| enterpriseFeatures.applyVaultEnvVars | bool | `true` | push env vars from Clear.ML Vault to task pods |
| enterpriseFeatures.createQueues | bool | `false` | Create queues if they don't exist |
| enterpriseFeatures.enabled | bool | `false` | Enable/Disable Enterprise features |
| enterpriseFeatures.maxPods | int | `10` | maximum concurrent consume ClearML Task pod |
| enterpriseFeatures.monitoredResources | object | `{"maxResources":0,"maxResourcesFieldName":"resources|limits|nvidia.com/gpu","minResourcesFieldName":"resources|limits|nvidia.com/gpu"}` | GPU resource general counters |
| enterpriseFeatures.monitoredResources.maxResources | int | `0` | Maximum resources counter |
| enterpriseFeatures.monitoredResources.maxResourcesFieldName | string | `"resources|limits|nvidia.com/gpu"` | Field name used by Agent to count maximum resources |
| enterpriseFeatures.monitoredResources.minResourcesFieldName | string | `"resources|limits|nvidia.com/gpu"` | Field name used by Agent to count minimum resources |
| enterpriseFeatures.queues | string | `nil` | ClearML queues and related template OVERRIDES used this agent will consume |
| enterpriseFeatures.serviceAccountClusterAccess | bool | `false` | service account access every namespace flag |
| enterpriseFeatures.useOwnerToken | bool | `true` | Agent must use owner Token |
| global | object | `{"imageRegistry":"docker.io"}` | Global parameters section |
| global.imageRegistry | string | `"docker.io"` | Images registry |
| imageCredentials | object | `{"email":"someone@host.com","enabled":false,"existingSecret":"","password":"pwd","registry":"docker.io","username":"someone"}` | Private image registry configuration |
| imageCredentials.email | string | `"someone@host.com"` | Email |
| imageCredentials.enabled | bool | `false` | Use private authentication mode |
| imageCredentials.existingSecret | string | `""` | If this is set, chart will not generate a secret but will use what is defined here |
| imageCredentials.password | string | `"pwd"` | Registry password |
| imageCredentials.registry | string | `"docker.io"` | Registry name |
| imageCredentials.username | string | `"someone"` | Registry username |
| sessions | object | `{"dynamicSvcs":false,"externalIP":"0.0.0.0","maxServices":20,"portModeEnabled":false,"setInteractiveQueuesTag":true,"startingPort":30000,"svcAnnotations":{},"svcType":"NodePort"}` | Sessions internal service configuration |
| sessions.dynamicSvcs | bool | `false` | Enable/Disable dynamic svc for sessions pods |
| sessions.externalIP | string | `"0.0.0.0"` | External IP sessions clients can connect to |
| sessions.maxServices | int | `20` | maximum number of NodePorts exposed |
| sessions.portModeEnabled | bool | `false` | Enable/Disable sessions portmode WARNING: only one Agent deployment can have this set to true |
| sessions.setInteractiveQueuesTag | bool | `true` | set interactive queue tags |
| sessions.startingPort | int | `30000` | starting range of exposed NodePorts |
| sessions.svcAnnotations | object | `{}` | specific annotations for session services |
| sessions.svcType | string | `"NodePort"` | service type ("NodePort" or "ClusterIP" or "LoadBalancer") |
