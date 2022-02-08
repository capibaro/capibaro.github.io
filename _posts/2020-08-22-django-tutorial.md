---
layout: post
title: 基础教程
description: a tutorial on django application and view
category: Django
date: 2020-08-22 15:17:05 +0800
---

这篇博客创建一个简单 Django 项目，编写应用并定义视图

<!--more-->

## 创建项目

在你想要创建 Django 项目的目录下执行下面的命令：

`django-admin startproject findshow`

这行命令会创建一个名为 findshow 的目录，这个目录中包括以下内容：

```shell
findshow
├── manage.py       # 命令行工具
└── findshow        # 名为 findshow 的 Python 包
    ├── __init__.py
    ├── settings.py # 配置文件
    ├── urls.py     # URL 声明
    ├── asgi.py     # 在 ASGI 兼容的 Web 服务器上的入口
    └── wsgi.py     # 在 WSGI 兼容的 Web 服务器上的入口
```

## 运行项目

Django 包含一个用于开发的简易服务器，执行命令`python manage.py runserver`启动这个服务器：

```shell
Watching for file changes with StatReloader
Performing system checks...

System check identified no issues (0 silenced).

You have 18 unapplied migration(s). Your project may not work properly until you apply the migrations for app(s): admin, auth, contenttypes, sessions.
Run 'python manage.py migrate' to apply them.
June 15, 2021 - 11:05:37
Django version 3.2.4, using settings 'findshow.settings'
Starting development server at http://127.0.0.1:8000/
Quit the server with CONTROL-C.
```

暂时忽略未应用最新数据库迁移的警告，使用浏览器访问 http://127.0.0.1:8000 ，你应该能看到一个“祝贺”页面，随着一只火箭发射，服务器已经开始正常运行。

默认情况下，`runserver`命令让服务器监听本地主机的 8000 端口，可以使用命令行参数改变服务器监听的端口：

`python manage.py runserver 8080`

这个服务器会在必要的情况下为每一次请求重新载入 Python 代码。因此你不用频繁重启服务器以让修改的代码生效。但是某些动作并不会触发自动重新加载，比如添加新的文件。这时你需要手动重启服务器。

## 创建应用

执行命令`python manage.py startapp search`创建一个名为 search 的应用，这行代码将会创建一个名为`search`的目录，这个目录包含有下面的文件：

```shell
search
├── __init__.py
├── admin.py
├── apps.py
├── migrations
│   └── __init__.py
├── models.py
├── tests.py
└── views.py
```

## 编写视图

打开`search/views.py`输入下面的代码：

```python
from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.
def index(request):
    return HttpResponse("Hello, you're at search page.")
```

这是一个最简单的视图，为了让它出现在页面上，我们还需要将一个 URL 映射到它。在`search`目录下新建一个名为`urls.py`的文件，输入下面的内容创建 search 应用的 URLconf：

```python
from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
]
```

我们还需要在根 URLconf 文件中添加上面的`search.urls`模块。在`findshow/urls.py`文件的`urlpatterns`列表里插入一个`include()`：

```python
from django.contrib import admin
from django.urls import path
from django.urls.conf import include

urlpatterns = [
    path('search/', include('search.urls')),
    path('admin/', admin.site.urls),
]
```

函数`include()`允许引用其他 URLconfs。每当 Django 遇到`include()`时，它将截断与此项匹配的 URL 部分，并将 URL 余下的部分发送给 URLconf 做进一步处理。

现在我们已经把`search`的视图添加进了 URLconf。运行服务器，访问 http://localhost:8000/search ，你应该能看到：

`Hello, you're at search index.`

&nbsp;

- [1] [编写你的第一个 Django 应用，第 1 部分](https://docs.djangoproject.com/zh-hans/3.2/intro/tutorial01/)