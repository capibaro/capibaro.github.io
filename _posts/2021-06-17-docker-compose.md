---
layout: post
title: 部署应用程序
description: deploy django application by docker-compose
category: Docker
date: 2021-06-17 21:33:37 +0800
---

这篇博客使用 Docker Compose 部署 Django 应用程序

<!--more-->

## 编写 docker-compose 文件

新建`docker-compose.yml`文件，我们将在这里编排需要使用的容器。其中`version`指定了`docker-compose.yml`文件的版本，这需要与你的 Docker Engine 的版本相对应。

### 数据库

```yaml
version: '3.3'

services:
  db:
    image: mysql
    container_name: mysql
    command:
      --default-authentication-plugin=mysql_native_password
      --character-set-server=utf8mb4 
      --collation-server=utf8mb4_unicode_ci
    environment:
      - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
      - MYSQL_DATABASE=findshow
      - MYSQL_USER=${MYSQL_USER}
      - MYSQL_PASSWORD=${MYSQL_PASSWORD}
    volumes:
      - data:/var/lib/mysql
    ports:
      - 3306:3306

volumes:
  data:
```

`db`定义了数据库服务的名称。

`image`指定了使用的镜像。

`container_name`指定了容器的名称。

`command`中的选项为不支持 [caching_sha2_password](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html) 验证方式的数据库驱动保留了 mysql_native_password 的认证方式，并指定使用 utf8mb4 字符集。

`environment`中定义了一系列环境变量。

数据卷（volumes）是 Docker 持久化数据的一种方式，在这里我们定义了名为`data`的数据卷并把 MySQL 的数据映射到它。你可以使用`docker volume`命令管理数据卷，比如`docker volume ls`查看所有数据卷，`docker volume prune`移除未使用的数据卷。

`ports`将虚拟机的`3306`端口映射到宿主机的`3306`端口。

### 应用服务器

```yaml
version: '3.3'

services:
  web:
    image: capibaro/findshow
    container_name: django
    command: bash -c "
      wait-for-it db:3306 -t 60
      && python3 manage.py makemigrations 
      && python3 manage.py migrate 
      && gunicorn findshow.wsgi:application --bind 0.0.0.0:8000"
    expose: 
      - "8000"
    environment: 
      - SECRET_KEY=${SECRET_KEY}
      - MYSQL_USER=${MYSQL_USER}
      - MYSQL_PASSWORD=${MYSQL_PASSWORD}
    depends_on: 
      - db
```

因为 Django 应用程序依赖于 MySQL 数据库，所以如果 Django 先于 MySQL 完成初始化并向仍在初始化的 MySQL 发起连接便会发生错误。仅通过`depends_on`指明服务的依赖并不能解决这个问题，因为`depends_on`只能决定容器的启动和停止顺序，并不能保证 MySQL 在 Django 之前完成初始化。

比较好的解决方案是使用 [wait-for-it](https://tracker.debian.org/pkg/wait-for-it) ，许多发行版都包含这个包，建议在构建镜像时使用`apt-get`预先安装这个包。`wait-for-it`命令可以保持等待直到指定的主机上指定的端口可用，可以使用`-t`选项指定超时时间。可以使用服务的名字直接作为主机名，比如这里的`db`。

在这里，我们保持等待直至 MySQL 服务可用，然后执行数据库迁移的相关命令，最后使用 [gunicorn](https://gunicorn.org/) 运行 Django 应用程序。

可以使用`bash -c`和`&&`执行多条命令。

使用`expose`暴露`8000`端口。

### Web 服务器

```nginx
upstream web {
    ip_hash;
    server web:8000;
}

server {
    listen 80;
    server_name localhost;

    location / {
        proxy_pass http://web/;
    }
}
```

在`nginx`目录下编写 Nginx 配置文件`nginx.conf`并使用数据卷映射到容器的 Nginx 配置文件中。

```yaml
version: '3.3'

services:
  nginx:
    image: capibaro/nginx
    container_name: nginx
    ports: 
      - 80:80
    volumes: 
      - ./nginx:/etc/nginx/conf.d
    command: bash -c "
      wait-for-it web:8000 -t 60
      && nginx -g 'daemon off;'"
    depends_on: 
      - web
```

因为 Docker 容器会在前台进程执行完毕后退出，所以这里需要使用命令`nginx -g 'daemon off;'`在前台运行 Nginx。

&nbsp;

- [1] [Quickstart: Compose and Django \| Docker Documentation](https://docs.docker.com/samples/django/)
- [2] [Control startup and shutdown order in Compose \| Docker Documentation](https://docs.docker.com/compose/startup-order/)