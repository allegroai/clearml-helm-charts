# ClearML Helm Charts Installation guide

## Requirements

### Setup a Kubernetes Cluster

For setting up Kubernetes on various platforms refer to the Kubernetes [getting started guide](http://kubernetes.io/docs/getting-started-guides/).

#### Setup a single node LOCAL Kubernetes on laptop/desktop (development)

For setting up Kubernetes on your laptop/desktop we suggest [kind](https://kind.sigs.k8s.io).

#### [Kubernetes Tanzu users only] Additional setup requirements

For setting up Clear.ML on a Tanzu cluster, check [prerequisites](https://github.com/allegroai/clearml-helm-charts/tree/main/platform-specific-configs/tanzu).

#### [Kubernetes Openshift users only] Additional setup requirements

For setting up Clear.ML on a Openshift cluster, check [prerequisites](https://github.com/allegroai/clearml-helm-charts/tree/main/platform-specific-configs/openshift).

### Install Helm

Helm is a tool for managing Kubernetes charts. Charts are packages of pre-configured Kubernetes resources.

To install Helm, refer to the [Helm install guide](https://github.com/helm/helm#install) and ensure that the `helm` binary is in the `PATH` of your shell.

## Helm charts installation

### Helm Repo

```bash
$ helm repo add allegroai https://allegroai.github.io/clearml-helm-charts
$ helm repo update
```
### ClearML server ecosystem

```bash
$ helm install clearml allegroai/clearml
```

### ClearML agent

Agent is always related a ClearML server ecosystem (by default using `app.clear.ml` public service but can be on same or another Kubernetes cluster or a single server installation).

On ClearML UI, Settings -> Workspace and Create new Credentials.

In following Helm chart install command:

* set ACCESSKEY to resuted credentials access_key
* set SECRETKEY to resuted credentials secret_key
* set APIERVERURL to resuted credentials api_server
* set FILESSERVERURL to resuted credentials files_server
* set WEBSERVERURL to resuted credentials web_server

```bash
$ helm install clearml-agent allegroai/clearml-agent --set clearml.agentk8sglueKey=ACCESSKEY --set clearml.agentk8sglueSecret=SECRETKEY --set agentk8sglue.apiServerUrlReference=APISERVERURL --set agentk8sglue.fileServerUrlReference=FILESERVERURL --set agentk8sglue.webServerUrlReference=WEBSERVERURL
```
