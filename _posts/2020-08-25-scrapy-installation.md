---
layout: post
title: 安装指南
description: use pip, venv to install scrapy on wsl
category: Scrapy
date: 2020-08-25 19:02:08 +0800
---

这篇博客使用 pip 包管理工具和 venv 虚拟环境在 WSL 中安装 Scrapy

<!--more-->

## 安装 pip

[pip](https://pypi.org/project/pip/) 是一个 Python 包管理工具，它被用来安装和更新包。

Debian 和大部分其他发行版都包含一个 [python-pip](https://packages.debian.org/stable/python-pip) 包。你也可以自己安装 pip 以确保拥有最新的版本。最好使用系统的 pip 在你的用户目录下安装 pip：

`python3 -m pip install --user --upgrade pip`

在这之后，你的用户目录下应该安装有最新版本的 pip：

```shell
~$ python3 -m pip --version
pip 21.1.2 from /home/xiangxin/.local/lib/python3.8/site-packages/pip (python 3.8)
```

## 使用 venv

[venv](https://docs.python.org/3/library/venv.html) 允许你为不同的项目各自安装它们需要的包。它本质上是让你创建一个虚拟的 Python 环境，并把包安装到这个虚拟的环境中。当你在不同的项目间切换时，你可以简单地创建一个虚拟环境而无需担心对其他环境中安装的包的影响。

### 创建虚拟环境

为了创建虚拟环境，进入你的项目所在的目录并运行 venv：

`python3 -m venv env`

参数`env`表示创建虚拟环境的位置。通常你只需要把它放在项目的目录下并命名为`env`。venv 会在`env`目录下创建一个虚拟的 Python 环境。你应该使用类似于`.gitignore`的方式把虚拟环境所在的目录排除到版本控制系统之外。

### 激活虚拟环境

在你开始安装和使用包之前需要先激活虚拟环境。激活虚拟环境其实就是把虚拟环境中的`python`和`pip`可执行文件加入到 shell 的`PATH`中：

`source env/bin/activate`

你可以通过查看 Python 解释器的位置来确认是否已激活虚拟环境，它应该在`env`目录下：

```shell
(env) ~/spider$ which python
/home/xiangxin/spider/env/bin/python
```

激活虚拟环境后，pip 就会在虚拟环境中安装包，你就能在你的 Python 项目中导入并使用它们了。

### 退出虚拟环境

如果你需要切换项目或者离开虚拟环境，只需要执行命令：

`deactivate`

如果你想要重新进入虚拟环境，只需要参照上面有关激活虚拟环境的指令，并不需要重新创建虚拟环境。

## 安装 Scrapy

Scrapy 使用纯 Python 实现，它依赖于下面的 Python 包：
- [lxml](https://lxml.de/index.html) ，一个高效 XML 和 HTML 语法分析器
- [parsel](https://pypi.org/project/parsel/) ，一个基于 lxml 编写的 HTML/XML 数据提取库
- [w3lib](https://pypi.org/project/w3lib/) ，一个多目标的用于处理 URL 和网页编码的工具
- [twisted](https://twistedmatrix.com/trac/) ，一个异步网络框架
- [cryptography](https://cryptography.io/en/latest/) 和 [pyOpenSSL](https://pypi.org/project/pyOpenSSL/) ，处理各种网络层级的安全需求

安装依赖：

`sudo apt-get install python3 python3-dev python3-pip libxml2-dev libxslt1-dev zlib1g-dev libffi-dev libssl-dev`

进入虚拟环境，使用 pip 安装 Scrapy：

`pip install scrapy`

使用`pip show`检查 Scrapy 是否成功安装：

```shell
(env) ~/spider$ pip show Scrapy
Name: Scrapy
Version: 2.5.0
Summary: A high-level Web Crawling and Web Scraping framework
Home-page: https://scrapy.org
Author: Scrapy developers
Author-email: None
License: BSD
Location: /home/xiangxin/spider/env/lib/python3.8/site-packages
Requires: pyOpenSSL, itemloaders, queuelib, protego, parsel, w3lib, lxml, cryptography, cssselect, itemadapter, zope.interface, service-identity, h2, PyDispatcher, Twisted
Required-by:
```

&nbsp;

- [1] [Installation guide — Scrapy 2.5.0 documentation](https://docs.scrapy.org/en/latest/intro/install.html#intro-install)
- [2] [Installing packages using pip and virtual environments — Python Packaging User Guide](https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/)