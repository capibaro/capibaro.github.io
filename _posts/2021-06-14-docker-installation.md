---
layout: post
title: 安装指南
description: install docker on windows and ubuntu
category: Docker
date: 2021-06-14 09:09:08 +0800
---

这篇博客在 Windows 中使用 WSL 安装 Docker Desktop，在 Ubuntu 中安装 Docker Engine 和 Docker Compose

<!--more-->

## 在 Windows 上安装 Docker

取决于你使用的 windows 版本，你需要选择 [WSL2](https://docs.microsoft.com/zh-cn/windows/wsl/install-win10) 或者 [Hyper-V](https://docs.microsoft.com/zh-cn/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v) 作为 Docker Desktop 的后端。在这里我们使用 WSL2，如果你需要使用 Hyper-V ，可以参考 [System requirements](https://docs.docker.com/docker-for-windows/install/#system-requirements)。

### 安装 WSL2

有关 WSL2 ，可以参考 [在 Windows 10 上安装 WSL](https://docs.microsoft.com/zh-cn/windows/wsl/install-win10)。

要在 Windows 10 上成功运行 WSL2 需要满足以下硬件要求：
- 带有 [二级地址转换](https://en.wikipedia.org/wiki/Second_Level_Address_Translation) 的64位处理器
- 4GB的系统内存
- 在BIOS设置中启用硬件 [虚拟化](https://docs.docker.com/docker-for-windows/troubleshoot/#virtualization-must-be-enabled) 

### 安装 Docker Desktop

Docker Desktop 的安装包包括 [Docker Engine](https://docs.docker.com/engine/) 、Docker CLI client、 [Docker Compose](https://docs.docker.com/compose/) 、 [Docker Content Trust](https://docs.docker.com/docker-for-windows/engine/security/trust.md) 、   [Kubernetes](https://github.com/kubernetes/kubernetes/) 和 [Credential Helper](https://github.com/docker/docker-credential-helpers/) 。

[点击此处](https://desktop.docker.com/win/stable/amd64/Docker%20Desktop%20Installer.exe) 下载`Docker Desktop Installer.exe`。

按照前面的要求启用 Hyper-V 或者安装 WSL2 后，你便可以运行`Docker Desktop Installer.exe`，像安装普通的应用程序一样安装 Docker Desktop。

## 在 Ubuntu 上安装 Docker

### 建立仓库

更新`apt`包索引：

`sudo apt-get update`

安装允许`apt`支持 HTTPS 的包：

```
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

添加 Docker 的官方 GPG 密钥：

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg`

建立起稳定版本的仓库：

```
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

### 安装 Docker Engine

更新`apt`包索引：

`sudo apt-get update`

安装最新版本的 Docker Engine 和 containerd ：

`sudo apt-get install docker-ce docker-ce-cli containerd.io`

运行镜像`hello-world`验证安装是否成功：

`sudo docker run hello-world`

这条命令会下载一个用于测试的镜像并将其作为容器运行。当这个容器开始运行，他会输出提示信息然后退出。

### 安装 Docker Compose

下载 Docker Compose 当下的稳定发行版：

`sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose`

赋予二进制文件可执行权限：

`sudo chmod +x /usr/local/bin/docker-compose`

验证安装：
 
```shell
~$ docker-compose --version
docker-compose version 1.17.0, build ac53b73
```

&nbsp;

- [1] [Install Docker Desktop on Windows \| Docker Documentation](https://docs.docker.com/docker-for-windows/install/)
- [2] [Install Docker Engine on Ubuntu \| Docker Documentation](https://docs.docker.com/engine/install/ubuntu/)
- [3] [Install Docker Compose \| Docker Documentation](https://docs.docker.com/compose/install/)