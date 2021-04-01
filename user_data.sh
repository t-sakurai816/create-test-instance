#!/bin/bash
yum -y update
yum -y upgrade

timedatectl set-timezone Asia/Tokyo
systemctl restart crond.service
yum -y install git

# fish shell install
cd /etc/yum.repos.d/
wget https://download.opensuse.org/repositories/shells:fish:release:3/CentOS_7/shells:fish:release:3.repo
yum -y install fish