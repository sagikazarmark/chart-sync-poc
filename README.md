# Chart sync PoC

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

PoC for synchronizing charts from third-party repositories to a local one using Bitnami's [charts syncer](https://github.com/bitnami-labs/charts-syncer).

## Usage

Launch ChartMuseum as a local registry:

```shell
docker compose up -d
```

Sync all charts from a third-party repository:

```shell
charts-syncer sync --config config/reloader.yaml
```

Sync the latest version from a third-party repository:

```shell
charts-syncer sync --config config/aws-load-balancer-controller.yaml --latest-version-only
```

Based on the `DEPTH` var in `docker-compose.yaml`, the syncer can either synchronize to multiple repos OR in a single repo on a single level.
Unfortunately, ChartMuseum does not seem to support multi-level paths in a single repository.
