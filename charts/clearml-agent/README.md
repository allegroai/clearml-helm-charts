# ClearML Kubernetes Agent

![Version: 3.1.4](https://img.shields.io/badge/Version-3.1.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.24](https://img.shields.io/badge/AppVersion-1.24-informational?style=flat-square)

MLOps platform

**Homepage:** <https://clear.ml>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| valeriano-manassero |  | <https://github.com/valeriano-manassero> |

## Introduction

The **clearml-agent** is the Kubernetes agent for for [ClearML](https://github.com/allegroai/clearml).
It allows you to schedule distributed experiments on a Kubernetes cluster.

## Source Code

* <https://github.com/allegroai/clearml-helm-charts>
* <https://github.com/allegroai/clearml>

## Requirements

Kubernetes: `>= 1.19.0-0 < 1.26.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| agentk8sglue | object | `{"annotations":{},"apiServerUrlReference":"https://api.clear.ml","basePodTemplate":{"annotations":{},"env":[],"fileMounts":[],"hostAliases":{},"initContainers":[],"labels":{},"nodeSelector":{},"resources":{},"schedulerName":"","securityContext":{},"tolerations":[],"volumeMounts":[],"volumes":[]},"clearmlcheckCertificate":true,"containerCustomBashScript":"","customBashScript":"","debugMode":false,"defaultContainerImage":"ubuntu:18.04","extraEnvs":[],"fileMounts":[],"fileServerUrlReference":"https://files.clear.ml","image":{"repository":"allegroai/clearml-agent-k8s-base","tag":"1.24-21"},"labels":{},"nodeSelector":{},"queue":"default","replicaCount":1,"serviceExistingAccountName":"","volumeMounts":[],"volumes":[],"webServerUrlReference":"https://app.clear.ml"}` | This agent will spawn queued experiments in new pods, a good use case is to combine this with GPU autoscaling nodes. https://github.com/allegroai/clearml-agent/tree/master/docker/k8s-glue |
| agentk8sglue.annotations | object | `{}` | annotations setup for Agent pod (example in values.yaml comments) |
| agentk8sglue.apiServerUrlReference | string | `"https://api.clear.ml"` | Reference to Api server url |
| agentk8sglue.basePodTemplate | object | `{"annotations":{},"env":[],"fileMounts":[],"hostAliases":{},"initContainers":[],"labels":{},"nodeSelector":{},"resources":{},"schedulerName":"","securityContext":{},"tolerations":[],"volumeMounts":[],"volumes":[]}` | base template for pods spawned to consume ClearML Task |
| agentk8sglue.basePodTemplate.annotations | object | `{}` | annotations setup for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.env | list | `[]` | environment variables for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.fileMounts | list | `[]` | file definition for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.hostAliases | object | `{}` | hostAliases setup for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.initContainers | list | `[]` | initContainers definition for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.labels | object | `{}` | labels setup for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.nodeSelector | object | `{}` | nodeSelector setup for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.resources | object | `{}` | resources declaration for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.schedulerName | string | `""` | schedulerName setup for pods spawned to consume ClearML Task |
| agentk8sglue.basePodTemplate.securityContext | object | `{}` | securityContext setup for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.tolerations | list | `[]` | tolerations setup for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.volumeMounts | list | `[]` | volume mounts definition for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.basePodTemplate.volumes | list | `[]` | volumes definition for pods spawned to consume ClearML Task (example in values.yaml comments) |
| agentk8sglue.clearmlcheckCertificate | bool | `true` | Check certificates validity for evefry UrlReference below. |
| agentk8sglue.containerCustomBashScript | string | `""` | Custom Bash script for the Task Pods ran by Glue Agent |
| agentk8sglue.debugMode | bool | `false` | Enable Debugging logs for Agent pod |
| agentk8sglue.defaultContainerImage | string | `"ubuntu:18.04"` | default container image for ClearML Task pod |
| agentk8sglue.extraEnvs | list | `[]` | Extra Environment variables for Glue Agent |
| agentk8sglue.fileMounts | list | `[]` | file definition for Glue Agent (example in values.yaml comments) |
| agentk8sglue.fileServerUrlReference | string | `"https://files.clear.ml"` | Reference to File server url |
| agentk8sglue.image | object | `{"repository":"allegroai/clearml-agent-k8s-base","tag":"1.24-21"}` | Glue Agent image configuration |
| agentk8sglue.labels | object | `{}` | labels setup for Agent pod (example in values.yaml comments) |
| agentk8sglue.nodeSelector | object | `{}` | nodeSelector setup for Agent pod (example in values.yaml comments) |
| agentk8sglue.queue | string | `"default"` | ClearML queue this agent will consume |
| agentk8sglue.replicaCount | int | `1` | Glue Agent number of pods |
| agentk8sglue.serviceExistingAccountName | string | `""` | if set, don't create a serviceAccountName but use defined existing one |
| agentk8sglue.volumeMounts | list | `[]` | volume mounts definition for Glue Agent (example in values.yaml comments) |
| agentk8sglue.volumes | list | `[]` | volumes definition for Glue Agent (example in values.yaml comments) |
| agentk8sglue.webServerUrlReference | string | `"https://app.clear.ml"` | Reference to Web server url |
| clearml | object | `{"agentk8sglueKey":"ACCESSKEY","agentk8sglueSecret":"SECRETKEY","clearmlConfig":"sdk {\n}","existingAgentk8sglueSecret":"","existingClearmlConfigSecret":""}` | ClearMl generic configurations |
| clearml.agentk8sglueKey | string | `"ACCESSKEY"` | Agent k8s Glue basic auth key |
| clearml.agentk8sglueSecret | string | `"SECRETKEY"` | Agent k8s Glue basic auth secret |
| clearml.clearmlConfig | string | `"sdk {\n}"` | ClearML configuration file |
| clearml.existingAgentk8sglueSecret | string | `""` | If this is set, chart will not generate a secret but will use what is defined here |
| clearml.existingClearmlConfigSecret | string | `""` | If this is set, chart will not generate a secret but will use what is defined here |
| enterpriseFeatures | object | `{"agentImageTagOverride":"1.24-57","applyVaultEnvVars":true,"enabled":false,"maxPods":10,"monitoredResources":{"maxResources":0,"maxResourcesFieldName":"resources|limits|nvidia.com/gpu","minResourcesFieldName":"resources|limits|nvidia.com/gpu"},"queues":null,"serviceAccountClusterAccess":false,"useOwnerToken":true}` | Enterprise features (work only with an Enterprise license) |
| enterpriseFeatures.agentImageTagOverride | string | `"1.24-57"` | Image tag override for enterprise version |
| enterpriseFeatures.applyVaultEnvVars | bool | `true` | push env vars from Clear.ML Vault to task pods |
| enterpriseFeatures.enabled | bool | `false` | Enable/Disable Enterprise features |
| enterpriseFeatures.maxPods | int | `10` | maximum concurrent consume ClearML Task pod |
| enterpriseFeatures.monitoredResources | object | `{"maxResources":0,"maxResourcesFieldName":"resources|limits|nvidia.com/gpu","minResourcesFieldName":"resources|limits|nvidia.com/gpu"}` | GPU resource general counters |
| enterpriseFeatures.monitoredResources.maxResources | int | `0` | Maximum resources counter |
| enterpriseFeatures.monitoredResources.maxResourcesFieldName | string | `"resources|limits|nvidia.com/gpu"` | Field name used by Agent to count maximum resources |
| enterpriseFeatures.monitoredResources.minResourcesFieldName | string | `"resources|limits|nvidia.com/gpu"` | Field name used by Agent to count minimum resources |
| enterpriseFeatures.queues | string | `nil` | ClearML queues and related template OVERRIDES used this agent will consume |
| enterpriseFeatures.serviceAccountClusterAccess | bool | `false` | service account access every namespace flag |
| enterpriseFeatures.useOwnerToken | bool | `true` | Agent must use owner Token |
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

# Upgrading Chart

### From v1.x to v2.x

Chart 1.x was under the assumption that all mounted volumes would be PVC's. Version > 2.x allows for more flexibility and will inject the yaml from podTemplate.volumes and podtemplate.volumeMounts directly.

v1.x
```
    volumes:
     - name: "yourvolume"
       path: "/yourpath"
```

v2.x
```
    volumes:
     - name: "yourvolume"
       persistentVolumeClaim:
         claimName: "yourvolume"
    volumeMounts:
     - name: "yourvolume"
       mountPath: "/yourpath"
```
