---
layout: post
title: 搭建环境
description: install tools for xv6 development in virtualbox
category: Xv6
date: 2020-12-14 20:13:39 +0800
---

这篇博客使用 VirtualBox 虚拟机下载，安装并编译 Xv6 开发工具链

<!--more-->

## 安装 VirtualBox

进入 [VirtualBox 下载](https://www.virtualbox.org/wiki/Downloads) ，根据你所在的平台，下载并安装 VirtualBox。

## 安装 Ubuntu

进入 [Ubuntu 下载](https://cn.ubuntu.com/download/desktop) 下载系统光盘映像。

在 VirtualBox 中新建一个虚拟机并使用光盘映像安装 Ubuntu 系统。

## 安装扩展程序

安装扩展程序`VBoxGuestAdditions`以使用修改分辨率、共享文件夹和共享剪切板等扩展功能。

进入 [VirtualBox 下载](http://download.virtualbox.org/virtualbox) ，根据 VirtualBox 的版本进入相应页面下载扩展程序的光盘映像`VBoxGuestAdditions_x.x.x.iso`，然后在 VirtualBox 中把它添加到虚拟机。

为了能够编译并安装扩展程序，需要在虚拟机中安装 [gcc](https://gcc.gnu.org/) 和 [make](http://www.gnu.org/software/make/) ：

`sudo apt-get install gcc make`

打开虚拟机任务栏中光盘映像，点击右上角的`Run Software`安装扩展程序。安装完成后重启虚拟机。

通过`视图->虚拟显示屏`可以修改虚拟机分辨率。

通过`设备->共享剪切板`可以启用共享剪切板。

启用共享文件夹要复杂一点。首先在 VirtualBox 中指定宿主机的共享文件夹路径。然后在虚拟机中创建共享文件夹

`sudo mkdir /mnt/share`

最后挂载共享文件夹

`sudo mount -t vboxsf VirtualBox_Share /mnt/share`

这里的 VirtualBox_Share 是 VirtualBox 中宿主机的共享文件夹名。

## 安装工具链

安装编译 Xv6 工具链需要的依赖：

`sudo apt-get install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev`

下载 Xv6 工具链源码：

`git clone --recursive https://github.com/riscv/riscv-gnu-toolchain`

生成 Makefile：

`cd riscv-gnu-toolchain`

`./configure --prefix=/usr/local`

编译工具链：

`sudo make`

检查是否成功安装：

```shell
$ riscv64-unknown-elf-gcc --version
riscv64-unknown-elf-gcc (GCC) 10.1.0
Copyright (C) 2020 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

## 安装 QEMU

安装编译 QEMU 需要的依赖

`sudo apt-get install libglib2.0-dev libpixman-1-dev`

下载 QEMU：

`wget https://download.qemu.org/qemu-4.1.0.tar.xz`

解压文件：

`tar xvJf qemu-4.1.0.tar.xz`

生成 Makefile：

`cd qemu-4.1.0`

`./configure --disable-kvm --disable-werror --prefix=/usr/local --target-list="riscv64-softmmu"`

编译 QEMU：

`make`

安装 QEMU：

`sudo make install`

检查是否成功安装：

```shell
$ qemu-system-riscv64 --version
QEMU emulator version 4.1.0
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
```

## 运行 xv6

下载 Xv6 源码：

`git clone https://github.com/mit-pdos/Xv6-fall19.git`

编译运行 Xv6：

`cd xv6-fall19`

`make qemu`

```shell
xv6 kernel is booting

virtio disk init 0
init: starting sh
$ 
```

要退出 Xv6 ，先按下`ctrl+a`，然后按下`x`。

## 安装开发工具

获取 Microsoft GPG key：

`wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -`

启用 edge 仓库：

`sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main"`

安装 edge

`sudo apt install microsoft-edge-dev`

启用 vscode 仓库：

`sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"`

安装 vscode：

`sudo apt install code`

&nbsp;

- [1] [6.S081 / Fall 2019](https://pdos.csail.mit.edu/6.828/2019/tools.html)