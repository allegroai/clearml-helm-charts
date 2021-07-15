# ClearML Helm Charts Library for Kubernetes

Helm charts provided by [Allegro AI](https://clear.ml), ready to launch on Kubernetes using [Kubernetes Helm](https://github.com/helm/helm).

## Requirements

### Setup a Kubernetes Cluster

For setting up Kubernetes on various platforms refer to the Kubernetes [getting started guide](http://kubernetes.io/docs/getting-started-guides/).

### Setup a single node LOCAL Kubernetes on laptop/desktop

For setting up Kubernetes on your laptop/desktop we suggest [kind](https://kind.sigs.k8s.io).

### Install Helm

Helm is a tool for managing Kubernetes charts. Charts are packages of pre-configured Kubernetes resources.

To install Helm, refer to the [Helm install guide](https://github.com/helm/helm#install) and ensure that the `helm` binary is in the `PATH` of your shell.

## Usage

```bash
$ helm repo add allegroai https://allegroai.github.io/clearml-helm-charts
$ helm repo update
$ helm search repo allegroai
$ helm install <release-name> allegroai/<chart>
```
