#!/bin/bash
#
# Fix "Failed to download metadata for repo ‘appstream’: Cannot prepare internal mirrorlist: No URLs in mirrorlist".
# And install "Development Tools"

sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-*

sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Linux-*

dnf install centos-release-stream -y

dnf swap centos-{linux,stream}-repos -y

dnf distro-sync -y

yum group install "Development Tools" -y
