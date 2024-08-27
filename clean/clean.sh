#!/bin/bash

podman stop -a &&
podman rm -f -a &&
podman image prune -f &&
podman network prune -f &&
podman volume prune -f