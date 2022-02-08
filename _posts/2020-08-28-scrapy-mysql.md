---
layout: post
title: 数据持久化
description: persist data using pymysql and pipeline in scrapy spider
category: Scrapy
date: 2020-08-28 20:00:39 +0800
---

PyMySQL 是基于 [PEP 249](https://www.python.org/dev/peps/pep-0249/) ，纯 Python 实现的 MySQL 客户端程序库。

<!--more-->

## 安装 PyMySQL

使用 pip 安装 PyMySQL：

`pip install PyMySQL`

## 定义数据对象

在 Scrapy 中，`item`类似于字典。它是`scrapy.Item`的子类，可以使用简单的类定义语法和`Field`对象定义。在`showspider/items.py`中，定义要处理的数据对象：

```python
import scrapy


class ShowspiderItem(scrapy.Item):
    id = scrapy.Field()
    title = scrapy.Field()
    url = scrapy.Field()
    date = scrapy.Field()
    time = scrapy.Field()
    venue = scrapy.Field()
    artist = scrapy.Field()
    source = scrapy.Field()
```

可以注意到 Scrapy Item 的定义类似于 [Django Models](https://docs.djangoproject.com/en/dev/topics/db/models/) ，不过因为没有不同的 field 类型的概念，Scrapy Item 要简单得多。

## 定义数据表

对应于 Scrapy Item ，在 MySQL 数据库中创建相应的数据表。

```sql
CREATE TABLE `search_show` (
    `id` bigint NOT NULL PRIMARY KEY, 
    `title` longtext NOT NULL, 
    `url` varchar(50) NOT NULL, 
    `date` varchar(30) NOT NULL, 
    `time` datetime(6) NOT NULL, 
    `venue` longtext NOT NULL, 
    `artist` longtext NOT NULL, 
    `source` varchar(10) NOT NULL
);
```

## 编写流水线

在 Scrapy 中，一个 item 在被爬虫提取出来后，会被送到 Item Pipeline ，在这里它将会被多个流水线按顺序先后处理。

每条流水线都是实现了一个简单方法的 Python 类。它们接收 item，对其执行操作，决定是否将其送入下一条流水线或者丢弃且不再处理。

在`showspider/pipelines.py`中编写流水线：

```python
from itemadapter import ItemAdapter


class ShowspiderPipeline:
    def process_item(self, item, spider):
        return item
```

在`showspider/settings.py`中启用流水线：

```
ITEM_PIPELINES = {
   'showspider.pipelines.ShowspiderPipeline': 300,
}
```

## 连接到数据库

在`ShowspiderPipeline`类的`__init__`方法中连接到MySQL数据库：

```python
import pymysql.cursors
from showspider import settings

...

    def __init__(self) -> None:
        self.connection = pymysql.connect(
            host=settings.MYSQL_HOST,
            user=settings.MYSQL_USER,
            password=settings.MYSQL_PASSWORD,
            database=settings.MYSQL_DATABASE,
            charset='utf8mb4',
            cursorclass=pymysql.cursors.DictCursor)
```

在`showspider/settings.py`配置 MySQL 的域名、用户、密码和数据库：

```python
import os

MYSQL_HOST = 'db'
MYSQL_DATABASE = 'findshow'
MYSQL_USER = os.environ['MYSQL_USER']
MYSQL_PASSWORD = os.environ['MYSQL_PASSWORD']
```

## 持久化数据

在`ShowspiderPipeline`类的`process_item`方法中持久化数据：

```python
import logging

...

    def process_item(self, item, spider):
            self.connection.ping(reconnect=True)
            with self.connection as conn:
                with conn.cursor() as cursor:
                    try:
                        sql = "select * from search_show where id = %s"
                        cursor.execute(sql, (item["id"],))
                        result = cursor.fetchone()
                        if result is not None:
                            sql = """update search_show set title=%s,url=%s,date=%s,
                                time=%s,venue=%s,artist=%s,source=%s where id=%s"""
                            cursor.execute(sql, (item['title'], item['url'], item['date'], 
                                item['time'], item['venue'], item['artist'], item['source'], item['id']))
                        else:
                            sql = """insert into search_show(id,title,url,date,time,venue,artist,source)
                                value (%s,%s,%s,%s,%s,%s,%s,%s)"""
                            cursor.execute(sql, (item['id'], item['title'], item['url'], 
                                item['date'], item['time'], item['venue'], item['artist'], item['source']))
                        conn.commit()
                    except Exception as e:
                        logging.error(e)
                    return item
```

`self.connection.ping(reconnect=True)`用于保持与数据库的连接。这里我们根据 id 查找演出是否存在，若存在则更新演出信息；若不存在则插入演出信息。最后使用`conn.commit()`提交执行的修改。

&nbsp;

- [1] [Items — Scrapy 2.5.0 documentation](https://docs.scrapy.org/en/latest/topics/items.html)
- [2] [Item Pipeline — Scrapy 2.5.0 documentation](https://docs.scrapy.org/en/latest/topics/item-pipeline.html)
- [3] [PyMySQL · PyPI](https://pypi.org/project/PyMySQL/)