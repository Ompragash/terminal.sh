#!/bin/bash
#
# Install k3s with mode 644
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644

export PATH=$PATH:/usr/local/bin
