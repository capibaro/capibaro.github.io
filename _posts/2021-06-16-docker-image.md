---
layout: post
title: 构建、运输并运行镜像
description: a tutorial on how to build, ship and run docker image
category: Docker
date: 2021-06-16 20:51:17 +0800
---

这篇博客编写 Dockerfile 构建镜像，通过 Dockerhub 运输镜像并运行镜像

<!--more-->

## 编写 Dockerfile

在你的项目目录下新建`Dockerfile`文件：

```dockerfile
FROM python:3.8
ENV PYTHONUNBUFFERED=1
WORKDIR /code
COPY requirements.txt /code/
RUN sed -i "s@deb.debian.org@mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
RUN sed -i "s@security.debian.org@mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
RUN apt-get update
RUN apt-get install wait-for-it
RUN pip install -i https://pypi.mirrors.ustc.edu.cn/simple -r requirements.txt
COPY . /code/
```

`FROM`用于拉取 Scrapy 需要的 Python3.8 环境。

`ENV`用于指定环境变量`PYTHONUNBUFFERED`为`1`以确保 Python 的输出不被缓冲直接送到终端。

`WORKDIR`表示在虚拟机中创建工作文件夹`code`。

`COPY`用于复制文件，在这里把用`pip freeze > requirements.txt`指令生成的 Python 依赖包文件从宿主机复制到虚拟机。

`RUN`用于在虚拟机中执行指令。考虑到 Docker 提供基础 Linux 镜像缺乏可用于编辑文件的软件，所以建议使用`sed`指令进行诸如此类的换源操作。其中`s@deb.debian.org@mirrors.tuna.tsinghua.edu.cn@g`表示要查找替换的字符串，`/etc/apt/sources.list`表示进行操作的文件。至于`pip`指令可以通过`-i`选项换源。

## 构建镜像

完成`Dockerfile`的编写后，便可以使用以下`docker build`命令构建镜像：

`docker build -t spider .`

其中`-t`指定了镜像的标签，`.`指定了`Dockerfile`的路径。

## 运输镜像

为了上传镜像，我们首先需要在 Dockerhub 中创建仓库：
- [注册](https://www.docker.com/pricing?utm_source=docker&utm_medium=webreferral&utm_campaign=docs_driven_upgrade) 并使用 Dockerhub 分享镜像
- 登录到 [Dockerhub](https://hub.docker.com/)
- 点击`Create Repository`
- 把仓库命名为`spider`并选择可见性为`Public`
- 点击`Create`

使用`docker login`命令登录到 DockerHub ：

`docker login -u YOUR-USER-NAME`

使用`docker tag`命令给赋予镜像`spider`一个新的名字：

`docker tag spider YOUR-USER-NAME/spider`

使用`docker push`上传镜像到 Dockerhub ：

`docker push YOUR-USER-NAME/spider`

## 运行镜像

使用`docker run`命令运行镜像：

`docker run YOUR-USER-NAME/spider`

docker 会从 Dockerhub 拉取对应的镜像并运行，当然你也可以预先使用`docker pull`命令拉取镜像：

`docker pull YOUR-USER-NAME/spider`

&nbsp;

- [1] [Sample application \| Docker Documentation](https://docs.docker.com/get-started/02_our_app/)
- [2] [Share the application \| Docker Documentation](https://docs.docker.com/get-started/04_sharing_app/)