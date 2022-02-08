---
layout: post
title: 数据模型
description: configure database, define data model, get familiar with data api and admin page in django
category: Django
date: 2020-08-23 19:42:52 +0800
---

这篇博客对数据库进行配置，定义数据模型并介绍数据库 API 以及管理页面

<!--more-->

## 配置数据库

打开`findshow/settings.py`，这是一个包含 Django 项目设置的 Python 模块。通常，这个配置文件使用 [SQLite](https://sqlite.org/index.html) 作为默认数据库。Python 内置 SQLite，所以你不必为使用它安装任何额外的东西。但当你开始一个真正的项目时，你可能更倾向使用一个更具有扩展性的数据库，例如 [PostgreSQL](https://www.postgresql.org/) 。

如果你想使用其他的数据库，你需要安装合适的数据库驱动，然后修改配置文件中`DATABASES 'default'`项目中的一些键值，以 MySQL 数据库为例，你需要安装 [mysqlclient](https://pypi.org/project/mysqlclient/) 并在`settings.py`添加如下配置：

```python
import os

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'findshow',
        'USER': os.environ['MYSQL_USER'],
        'PASSWORD': os.environ['MYSQL_PASSWORD'],
        'HOST': 'localhost',
        'POST': '3306'
    }
}
```

配置中的`NAME`表示数据库的名称，`USER`表示数据库的用户名，`PASSWORD`表示数据库的密码，`HOST`是数据库服务所在的域名，`POST`是数据库服务运行的端口。

## 创建数据库

在 MySQL 中创建相应的数据库：

`CREATE DATABASE findshow;`

`settings.py`中的`INSTALLED_APPS`中包含项目中启用的所有 Django 应用，通常它们包括以下 Django 自带的应用：

| Application | Function |
| ----------- | -------- |
| [django.contrib.admin](https://docs.djangoproject.com/zh-hans/3.2/ref/contrib/admin/#module-django.contrib.admin) | 管理员站点 |
| [django.contrib.auth](https://docs.djangoproject.com/zh-hans/3.2/topics/auth/#module-django.contrib.auth) | 认证授权系统 |
| [django.contrib.contenttypes](https://docs.djangoproject.com/zh-hans/3.2/ref/contrib/contenttypes/#module-django.contrib.contenttypes) | 内容类型框架 |
| [django.contrib.sessions](https://docs.djangoproject.com/zh-hans/3.2/topics/http/sessions/#module-django.contrib.sessions) | 会话框架 |
| [django.contrib.messages](https://docs.djangoproject.com/zh-hans/3.2/ref/contrib/messages/#module-django.contrib.messages) | 消息框架 |
| [django.contrib.staticfiles](https://docs.djangoproject.com/zh-hans/3.2/ref/contrib/staticfiles/#module-django.contrib.staticfiles) | 管理静态文件的框架 |

默认开启的某些应用需要至少一个数据表。所以，在使用他们之前需要执行下面的命令，在数据库中创建表：

`python manage.py migrate`

`migrate`命令会检查`INSTALLED_APPS`，为其中每个应用创建所需的数据表。

## 定义模型

在`search`应用中，需要一个用于表示演出（Show）的模型。它包括演出的时间、地点和艺人等信息。这些概念可以通过一个 Python 类来描述。在`search/models.py`中定义模型：

```python
from django.db import models

class Show(models.Model):
    id = models.BigIntegerField(primary_key=True)
    title = models.TextField()
    url = models.URLField(max_length=50)
    date = models.CharField(max_length=30)
    time = models.DateTimeField()
    venue = models.TextField()
    artist = models.TextField()
    source = models.CharField(max_length=10)
```

每个模型都是`django.db.models.Model`的子类。它们包含许多的类变量，用于表示对应的数据库字段。

每个字段都是`Field`类的实例，例如字符字段`CharField`，日期时间字段`DateTimeField`。这会告诉 Django 每个字段需要处理的数据类型。

每个`Field`类实例变量的名字（例如time或venue）是字段名，最好使用机器友好的格式。因为你会在 Python 代码里使用它们，数据库也会将它们用作列名。

定义某些`Field`类实例需要参数。例如`CharField`需要一个`max_length`参数来指定最大长度。可以使用参数`primary_key=True`将某一列设置为主键。

## 激活模型

定义模型的代码给了 Django 很多信息。通过这些信息，Django 可以：
- 为这个应用创建数据库的模式（生成CREATE TABLE语句）
- 创建可以与模型对象进行交互的 Python 数据库API

不过我们首先需要把`search`应用添加到我们的项目中。

为了在工程中包含这个应用，需要在`INSTALLED_APPS`中添加相关的设置。因为`SearchConfig`类在文件`polls/apps.py`中，所以它的点式路径是`search.apps.PollsConfig`。在文件`findshow/settings.py`中`INSTALLED_APPS`中添加应用的点式路径：

```shell
INSTALLED_APPS = [
    'search.apps.SearchConfig',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]
```

现在项目中包含了`search`应用，运行下面的命令：

`python manage.py makemigrations search`

你将会看到类似如下的输出：

```shell
Migrations for 'search':
  search/migrations/0001_initial.py
    - Create model Show
```

通过运行`makemigrations`命令，Django 会检测对模型文件的修改，并把修改的部分储存为一次迁移。

迁移是 Django 对于模型定义变化的储存形式，它们被存储在`search/migrations/0001_initial.py`中。可以使用`sqlmigrate`命令查看迁移对应的 SQL 语句：

```shell
--
-- Create model Show
--
CREATE TABLE `search_show` (`id` bigint NOT NULL PRIMARY KEY, `title` longtext NOT NULL, `url` varchar(50) NOT NULL, `date` varchar(30) NOT NULL, `time` datetime(6) NOT NULL, `venue` longtext NOT NULL, `artist` longtext NOT NULL, `source` varchar(10) NOT NULL);
```

`sqlmigrate`命令不会在数据库中执行迁移，它只是把命令输出到屏幕上，让你看看 Django 认为需要执行哪些 SQL 语句。下面执行`migrate`命令，在数据库中创建数据表:

`python manage.py migrate`

`migrate`命令会选中所有未执行过的迁移并应用到数据库，即把模型的更改同步到数据库的模式中。

## 数据库 API

现在我们进入 Python shell，熟悉 Django 创建的数据库 API：

`python manage.py shell`

`manage.py`会设置`DJANGO_SETTINGS_MODULE`环境变量，这个变量会让 Django 根据`findshow/settings.py`设置 Python 包的导入路径。

```python
# 导入模型
>>> from search.models import Show
# 现在还没有演出
>>> Show.objects.all()
<QuerySet []>
# 创建一个新的演出
>>> import datetime
>>> s = Show(id=1, title="show tonight", time=datetime.datetime.now())
# 把演出保存到数据库
>>> s.save()
# 通过Python属性查看演出的信息
>>> s.id
1
>>> s.title
'show tonight'
>>> s.time
datetime.datetime(2021, 6, 15, 13, 10, 36, 732051)
# 改变属性并保存
>>> s.title = "show now."
>>> s.save()
# 展示数据库中的所有演出
>>> Show.objects.all()
<QuerySet [<Show: Show object (1)>]>
```

`<Show: Show object (1)>`对我们了解演出的细节没有什么帮助，我们可以通过在`search/models.py`中修改`Show`模型来解决这个问题：

```python
class Show(models.Model):
    ...

    def __str__(self):
        return self.title
```

完成以上修改后，Django 会在返回结果中展示演出的名字。

## Django 管理页面

Django 能够全自动地根据模型的定义创建一个用户可以添加、修改和删除内容的管理界面。

### 创建管理员账号

执行以下命令创建一个管理员用户：

`python manage.py createsuperuser`

输入用户名：

`Username: admin`

输入邮件地址：

`Email address: admin@example.com`

输入密码并确认：

```
Password: **********
Password (again): *********
Superuser created successfully.
```

### 启动开发服务器

执行以下命令启动开发服务器：

`python manage.py runserver`

在浏览器中打开 http://127.0.0.1:8000/admin ，你应该会看到管理员登录界面。

### 进入管理站点页面

使用前面创建的用户信息登录，进入 Django 管理页面的索引页。在这里你能看到可编辑的组和用户，它们是由 [django.contrib.auth](https://docs.djangoproject.com/zh-hans/3.2/topics/auth/#module-django.contrib.auth) 提供的，这是 Django 的用户认证框架。

### 向管理页面中加入搜索应用

但现在索引页中并没有显示我们的`search`应用，我们还需要告诉管理应用演出（Show）模型需要一个管理接口。编辑`search/admin.py`文件：

```python
from django.contrib import admin
from .models import Show

admin.site.register(Show)
```

### 便捷的管理功能

现在可以在管理页面的索引页看到`search`应用和演出（Show）模型。在这里，管理人员可以方便地添加，删除或者修改演出。

&nbsp;

- [1] [编写你的第一个 Django 应用，第 2 部分](https://docs.djangoproject.com/zh-hans/3.2/intro/tutorial02/)