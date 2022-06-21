#!/usr/bin/env bash

apt-get update
apt install -y vim gnupg twine
pip install antsibull
cd ~
git clone https://github.com/Ompragash/ansible-build-data.git
git clone https://github.com/ansible-community/antsibull.git
cd antsibull

