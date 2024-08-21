# selfhosted-grafana-alloy

## Introduction
Grafana Alloy is a vendor-neutral distribution of the OpenTelemetry (OTel) Collector. Alloy uniquely combines the very best OSS observability signals in the community.

## Prerequisites
### Loki and Prometheus Server
- FQDN (Fully Qualified Domain Name)
- Loki Server
- Prometheus Server
- Grafana Dashboard
- Server with superuser (root) access

### Grafana Alloy Client
- Grafana Alloy
- Server with superuser (root) access

## How To Use
1. Clone this repository
2. Edit ```config/alloy/config.alloy``` file change this lines with your own credentials
    ```
        prometheus.remote_write "metrics_service" {
    endpoint {
        url = "https://<PROMETHEUS_SERVER_ADDRESS>/api/v1/write"

        basic_auth {
        username = "<PROMETHEUS_USERNAME>"
        password = "<PROMETHEUS_PASSWORD>"
        }
    ...
    ...
        loki.write "grafana_loki" {
    endpoint {
        url = "https://<LOKI_SERVER_ADDRESS>/loki/api/v1/push"

        basic_auth {
        username = "<LOKI_USERNAME>"
        password = "<LOKI_PASSWORD>"
        }

    ```
3. Execute ```install_alloy.sh``` in your client server
    ```
    sudo chmod +x install_alloy.sh
    ./install_alloy.sh
    ```

## Medium Post
https://medium.com/@taufiqpsumarna/how-to-configure-grafana-alloy-with-self-hosted-prometheus-and-loki-server-cf4cb783eecf