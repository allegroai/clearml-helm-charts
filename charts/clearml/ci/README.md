Place values files with different values in this directory to ensure these cases are tested by the CI as well.

https://github.com/helm/chart-testing/blob/main/doc/ct_install.md

```
"Charts may have multiple custom values files matching the glob pattern '*-values.yaml' in a directory named 'ci' in the root of the chart's directory. The chart is installed and tested for each of these files. If no custom values file is present, the chart is installed and tested with defaults."
```