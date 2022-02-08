---
layout: post
title: 全文检索
description: implement full-text search using haystack and elasticsearch in django
category: Django
date: 2020-08-24 17:56:33 +0800
---

Haystack 为 Django 提供了模块化的搜索，它支持的搜索引擎有 [Solr](http://lucene.apache.org/solr) 、 [Elasticsearch](http://elasticsearch.org/) 、 [Whoosh](http://whoosh.ca/) 以及 [Xapian](http://xapian.org/) 。其中 Elasticsearch 是广受欢迎的开源搜索解决方案。

<!--more-->

## 安装 Haystack

使用 pip 安装 haystack：

`pip install django-haystack`

使用 pip 安装 elasticsearch：

`pip install elasticsearch==5`

目前 Haystack 支持 Elasticsearch 1.x 、2.x 以及 5.x 。elasticsearch 会调用 Elasticsearch 服务的 HTTP API。还需要安装并运行 Elasticsearch 服务。有关 Elasticsearch 的安装，可以参考 [下载Elasticsearch](https://www.elastic.co/downloads/elasticsearch) 。

如果你使用 Docker，也可以使用下面的命令先拉取镜像：

`docker pull elasticsearch:5.0`

然后创建自定义网络：

`docker network create somenetwork`

最后运行 Elasticsearch 服务：

`docker run -d --name elasticsearch --net somenetwork -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" elasticsearch:5.0`

## 配置 Haystack

与许多 Django 应用一样，你需要把 Haystack 加入到配置文件（通常是`settings.py`）中的`INSTALLED_APPS`中：

```python
INSTALLED_APPS = [
    'search.apps.SearchConfig',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'haystack',
]
```

在`settings.py`中，还需要指定使用的搜索引擎并进行相应的配置，以 Elasitcsearch 5.x 为例：

```python
HAYSTACK_CONNECTIONS = {
    'default': {
        'ENGINE': 'haystack.backends.elasticsearch5_backend.Elasticsearch5SearchEngine',
        'URL': 'http://localhost:9200/',
        'INDEX_NAME': 'haystack',
    },
}
```

## 处理数据

### 定义索引

Haystack 通过`SearchIndex`对象决定哪些数据应该被放到搜索引擎的索引中，并使用它们处理输入的数据流。你可以认为它们与 Django 的`Models`或者`Forms`类似，因为它们都基于域变量（Field），且用于操纵和存储数据。

为了创建`SearchIndex`，你需要继承`indexes.SearchIndex`和`indexes.Indexable`并定义你想要用于存储数据的域（Field）以及一个`get_model`方法。

下面在`search`应用的目录下创建文件`search_indexes.py`，为演出模型（Show）模型创建下面的`ShowIndex`：

```python
from datetime import datetime
from haystack import indexes
from search.models import Show

class ShowIndex(indexes.SearchIndex, indexes.Indexable):
    text = indexes.CharField(document=True, use_template=True)
    time = indexes.DateTimeField(model_attr="time")
    
    def get_model(self):
        return Show

    def index_queryset(self, using=None):
        """
        Used when the entire index for model is updated.
        """
        return self.get_model().objects.filter(time__gte=datetime.now())
```

每一个`SearchIndex`都需要（且只能）指定一个域（Field）为`document=True`，这个域是 Haystack 和搜索引擎在搜索中的首要的域（Field）。通常这个域的名称是`text`，如果你想使用其他的名字，则需要在`settings.py`中配置`HAYSTACK_DOCUMENT_FIELD`为你使用的其他名字。

除此之外，我们还指定`text`域为`use_template=True`。这允许我们使用一个数据模板来建立搜索引擎需要索引的文档。在 template 目录下创建一个新的模板`search/indexes/search/show_text.txt`：

{% raw %}
```
{{ object.title }}
{{ object.venue }}
{{ object.artist }}
```
{% endraw %}

我们还添加了一个名为`time`的域，我们用这个域在`index_queryset`中过滤掉过时的演出。

## 编写视图

### 配置 URLconf

在`findshow/urls.py`的`urlpatterns`中添加 Haystack 的视图：

`path('search/', include('haystack.urls')),`

### 搜索模板

在`templates/search`目录中创建模板文件`search.html`：

{% raw %}
```html
{% extends 'base.html' %}

{% block content %}
    <h2>Search</h2>

    <form method="get" action=".">
        <table>
            {{ form.as_table }}
            <tr>
                <td>&nbsp;</td>
                <td>
                    <input type="submit" value="Search">
                </td>
            </tr>
        </table>

        {% if query %}
            <h3>Results</h3>

            {% for result in page.object_list %}
                <p>
                    <a href="{{ result.object.get_absolute_url }}">{{ result.object.title }}</a>
                </p>
            {% empty %}
                <p>No results found.</p>
            {% endfor %}

            {% if page.has_previous or page.has_next %}
                <div>
                    {% if page.has_previous %}<a href="?q={{ query }}&amp;page={{ page.previous_page_number }}">{% endif %}&laquo; Previous{% if page.has_previous %}</a>{% endif %}
                    |
                    {% if page.has_next %}<a href="?q={{ query }}&amp;page={{ page.next_page_number }}">{% endif %}Next &raquo;{% if page.has_next %}</a>{% endif %}
                </div>
            {% endif %}
        {% else %}
            {# Show some example queries to run, maybe query syntax, something else? #}
        {% endif %}
    </form>
{% endblock %}
```
{% endraw %}

`page.object_list`实际上是`SearchResult`对象的列表而不是独立的模型。这些对象包括从记录中按照搜索引擎的索引和排序返回的所有数据。可以通过`{{ result.object }}`访问模型得到结果。所以`{{ result.object.title }}`使用数据库中实际的`Show`对象并访问它的`title`域。

### 重建索引

执行下面的命令为数据库中的数据建立索引：

`python manage.py rebuild_index`

使用标准的`SearchIndex`，索引只会在你使用`python manage.py rebuild_index`重建索引或使用`python manage.py update_index`更新索引时才会发生变化。可以通过 cron 定时任务定期更新索引，有关定时任务的内容可以参考 [使用 cron 调度任务](https://linux.cn/article-13383-1.html) 。

当然，如果你的业务流量不大或者你的搜索引擎足够强大。你也可以考虑使用`RealtimeSignalProcessor`自动处理数据的更新和删除并即时更新索引。

### 完成

现在你可以访问你网站的搜索页面，输入一个查询并查看相应的搜索结果。

&nbsp;

- [1] [Getting Started with Haystack — Haystack 2.5.0 documentation](https://django-haystack.readthedocs.io/en/master/tutorial.html)
- [2] [Elasticsearch - Official Image \| Docker Hub](https://hub.docker.com/_/elasticsearch)