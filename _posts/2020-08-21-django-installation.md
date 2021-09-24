---
layout: post
title: Django 安装指南
description: use pip, venv to install django on ubuntu
date: 2020-08-21 19:13:54 +0800
excerpt: 在 Ubuntu 中使用 pip 和 venv 安装 Django
---

## 安装 pip

[pip](https://pypi.org/project/pip/) 是一个 Python 包管理工具，它被用来安装和更新包。

Debian 和大部分其他的发行版都包括一个 [python-pip](https://packages.debian.org/stable/python-pip) 包。你可以自己安装 pip 以确保你拥有最新的版本。建议使用系统 pip 在你的用户目录下安装 pip。

`python3 -m pip install --user --upgrade pip`

在这之后，你的用户目录下应该安装有最新版本的 pip。

```
~$ python3 -m pip --version
pip 21.1.2 from /home/xiangxin/.local/lib/python3.8/site-packages/pip (python 3.8)
```

## venv 相关

[venv](https://docs.python.org/3/library/venv.html) 允许你为不同的项目分别安装它们各自需要的包。它本质上是让你创建一个“虚拟”的 Python 环境并把包安装到虚拟环境中。当你切换项目时，你可以简单地创建一个虚拟环境而不用担心影响其他环境中安装的包。

### 创建虚拟环境

为了创建虚拟环境，进入你的项目目录并运行 venv。

`python3 -m venv env`

其中参数`env`是创建虚拟环境的位置。通常你只需要把它放在项目目录下并命名为`env`。venv 会在`env`目录下创建一个虚拟的 Python 环境。你应当使用类似于`.gitignore`的方式把虚拟环境文件排除在版本控制系统之外。

### 激活虚拟环境

在你开始安装和使用包之前需要先激活虚拟环境。激活虚拟环境其实就是把虚拟环境中的`python`和`pip`可执行文件加入到 shell 的`PATH`中。

`source env/bin/activate`

你可以通过查看 Python 解释器的位置来检查是否已激活虚拟环境，它应该在`env`目录下。

```
(env) ~/spider$ which python
/home/xiangxin/spider/env/bin/python
```

激活虚拟环境后，pip 就会在虚拟环境中安装包，你就能在你的 Python 项目中导入并使用包。

### 退出虚拟环境

如果你需要切换项目或者离开虚拟环境，只需要执行：

`deactivate`

如果你想要重新进入虚拟环境，只需要参照上面有关激活虚拟环境的指令。并不需要重新创建虚拟环境。

## 快速安装

### 安装 Python

作为一个 Python Web 框架，Django 需要 Python。可以使用命令`python`确定你是否安装过 Python：

```
(env) ~/web$ python
Python 3.8.5 (default, May 27 2021, 13:30:53)
[GCC 9.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

### 安装 Django

然后进入虚拟环境，使用 pip 安装 Django：

`pip install Django`

### 验证安装

使用命令`python`进入 Python Shell 并尝试导入 Django 以验证安装是否成功：

```
>>> import django
>>> print(django.get_version())
3.2.4
```

- [快速安装指南](https://docs.djangoproject.com/zh-hans/3.2/intro/install/)
- [如何安装Django](https://docs.djangoproject.com/zh-hans/3.2/topics/install/#installing-official-release)