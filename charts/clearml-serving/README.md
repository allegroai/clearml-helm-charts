# clearml-serving

![Version: 0.7.0](https://img.shields.io/badge/Version-0.7.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.2.0](https://img.shields.io/badge/AppVersion-1.2.0-informational?style=flat-square)

ClearML Serving Helm Chart

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| valeriano-manassero |  | <https://github.com/valeriano-manassero> |

## Requirements

Kubernetes: `>= 1.19.0-0 < 1.26.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| alertmanager | object | `{"affinity":{},"image":{"repository":"prom/alertmanager","tag":"v0.23.0"},"nodeSelector":{},"resources":{},"tolerations":[]}` | ZAlertmanager generic configigurations |
| clearml | object | `{"apiAccessKey":"ClearML API Access Key","apiHost":"http://clearml-server-apiserver:8008","apiSecretKey":"ClearML API Secret Key","defaultBaseServeUrl":"http://127.0.0.1:8080/serve","filesHost":"http://clearml-server-fileserver:8081","servingTaskId":"ClearML Serving Task ID","webHost":"http://clearml-server-webserver:80"}` | ClearMl generic configurations |
| clearml_serving_inference | object | `{"affinity":{},"autoscaling":{"enabled":false,"maxReplicas":11,"minReplicas":1,"targetCPU":50,"targetMemory":50},"extraPythonPackages":[],"image":{"repository":"allegroai/clearml-serving-inference","tag":"1.2.0"},"ingress":{"annotations":{},"enabled":false,"hostName":"serving.clearml.127-0-0-1.nip.io","path":"/","tlsSecretName":""},"nodeSelector":{},"resources":{},"tolerations":[]}` | ClearML serving inference configurations |
| clearml_serving_inference.affinity | object | `{}` | Affinity configuration |
| clearml_serving_inference.autoscaling | object | `{"enabled":false,"maxReplicas":11,"minReplicas":1,"targetCPU":50,"targetMemory":50}` | Autoscaling configuration |
| clearml_serving_inference.extraPythonPackages | list | `[]` | Extra Python Packages to be installed in running pods |
| clearml_serving_inference.image | object | `{"repository":"allegroai/clearml-serving-inference","tag":"1.2.0"}` | Container Image |
| clearml_serving_inference.ingress | object | `{"annotations":{},"enabled":false,"hostName":"serving.clearml.127-0-0-1.nip.io","path":"/","tlsSecretName":""}` | Ingress exposing configurations |
| clearml_serving_inference.nodeSelector | object | `{}` | Node Selector configuration |
| clearml_serving_inference.resources | object | `{}` | Pod resources definition |
| clearml_serving_inference.tolerations | list | `[]` | Tolerations configuration |
| clearml_serving_statistics | object | `{"affinity":{},"extraPythonPackages":[],"image":{"repository":"allegroai/clearml-serving-statistics","tag":"1.2.0"},"nodeSelector":{},"resources":{},"tolerations":[]}` | ClearML serving statistics configurations |
| clearml_serving_statistics.affinity | object | `{}` | Affinity configuration |
| clearml_serving_statistics.extraPythonPackages | list | `[]` | Extra Python Packages to be installed in running pods |
| clearml_serving_statistics.image | object | `{"repository":"allegroai/clearml-serving-statistics","tag":"1.2.0"}` | Container Image |
| clearml_serving_statistics.nodeSelector | object | `{}` | Node Selector configuration |
| clearml_serving_statistics.resources | object | `{}` | Pod resources definition |
| clearml_serving_statistics.tolerations | list | `[]` | Tolerations configuration |
| clearml_serving_triton | object | `{"affinity":{},"autoscaling":{"enabled":false,"maxReplicas":11,"minReplicas":1,"targetCPU":50,"targetMemory":50},"enabled":true,"extraPythonPackages":[],"image":{"repository":"allegroai/clearml-serving-triton","tag":"1.2.0-22.07"},"ingress":{"annotations":{},"enabled":false,"hostName":"serving-grpc.clearml.127-0-0-1.nip.io","path":"/","tlsSecretName":""},"nodeSelector":{},"resources":{},"tolerations":[]}` | ClearML serving Triton configurations |
| clearml_serving_triton.affinity | object | `{}` | Affinity configuration |
| clearml_serving_triton.enabled | bool | `true` | Triton pod creation enable/disable |
| clearml_serving_triton.extraPythonPackages | list | `[]` | Extra Python Packages to be installed in running pods |
| clearml_serving_triton.image | object | `{"repository":"allegroai/clearml-serving-triton","tag":"1.2.0-22.07"}` | Container Image |
| clearml_serving_triton.ingress | object | `{"annotations":{},"enabled":false,"hostName":"serving-grpc.clearml.127-0-0-1.nip.io","path":"/","tlsSecretName":""}` | Ingress exposing configurations |
| clearml_serving_triton.nodeSelector | object | `{}` | Node Selector configuration |
| clearml_serving_triton.resources | object | `{}` | Pod resources definition |
| clearml_serving_triton.tolerations | list | `[]` | Tolerations configuration |
| grafana | object | `{"affinity":{},"image":{"repository":"grafana/grafana","tag":"8.4.4-ubuntu"},"ingress":{"annotations":{},"enabled":false,"hostName":"serving-grafana.clearml.127-0-0-1.nip.io","path":"/","tlsSecretName":""},"nodeSelector":{},"resources":{},"tolerations":[]}` | Grafana generic configigurations |
| kafka | object | `{"affinity":{},"image":{"repository":"bitnami/kafka","tag":"3.1.0"},"nodeSelector":{},"resources":{},"tolerations":[]}` | Kafka generic configigurations |
| prometheus | object | `{"affinity":{},"image":{"repository":"prom/prometheus","tag":"v2.34.0"},"nodeSelector":{},"resources":{},"tolerations":[]}` | Prometheus generic configigurations |
| zookeeper | object | `{"affinity":{},"image":{"repository":"bitnami/zookeeper","tag":"3.7.0"},"nodeSelector":{},"resources":{},"tolerations":[]}` | Zookeeper generic configigurations |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
