---
layout: post
title: 基础教程
description: a tutorial on scrapy spider, interactive shell, data scraping, data saving and links following
category: Scrapy
date: 2020-08-26 19:19:52 +0800
---

这篇博客创建一个 Scrapy 项目，编写并运行爬虫，提取并保存数据

<!--more-->

## 创建项目

在你想要创建 Scrapy 项目的目录下执行命令：

`scrapy startproject showspider`

这行命令会创建一个名为 showspider 的目录，这个目录中包括以下内容：

```shell
showspider
├── scrapy.cfg          # 用于部署的配置文件
└── showspider
    ├── __init__.py
    ├── items.py        # 数据模型
    ├── middlewares.py  # 中间件
    ├── pipelines.py    # 流水线
    ├── settings.py     # 配置文件
    └── spiders         # 爬虫
        └── __init__.py
```

- items 是提取的数据对象
- middleware 是处理爬虫运行中的输入输出、请求和异常的中间件
- pipeline 是用于处理数据的流水线

## 编写爬虫

Scrapy 根据你对爬虫的定义从网站上提取信息。它们都必须继承`scrapy.Spider`并定义初始发起的请求。你还可以定义如何追踪网页上的链接或是如何分析下载的网页内容以提取数据。

在`showspider/spiders`目录下新建名为`showstart.py`的文件并编写一个简单的爬虫：

```python
import scrapy

class ShowstartSpider(scrapy.Spider):
    name = "showstart"

    def start_requests(self):
        urls = [
            'https://www.showstart.com/',
        ]
        for url in urls:
            yield scrapy.Request(url=url, callback=self.parse)

    def parse(self, response):
        filename = 'showstart.html'
        with open(filename, 'wb') as f:
            f.write(response.body)
```

这个爬虫继承`scrapy.Spider`并定义了一些属性和方法：
- `name`: 爬虫的名字
- `start_urls`: 初始请求，必须是可迭代的（列表或者生成器）
- `parse()`: 处理各个请求下载的响应的方法。`response`是`TextResponse`的一个实例，它包含网页的内容和一些用于处理网页的有用方法。

`parse()`方法一般用来分析响应的内容，提取数据并存入字典，追踪链接并发起新的请求。

## 运行爬虫

在项目目录下执行命令`scrapy crawl showstart`，这个命令将启动名为`showstart`的爬虫，你可以得到类似如下的输出：

```shell
2021-06-13 17:35:04 [scrapy.core.engine] INFO: Spider opened
2021-06-13 17:35:04 [scrapy.extensions.logstats] INFO: Crawled 0 pages (at 0 pages/min), scraped 0 items (at 0 items/min)
2021-06-13 17:35:04 [scrapy.extensions.telnet] INFO: Telnet console listening on 127.0.0.1:6023
2021-06-13 17:35:05 [scrapy.core.engine] DEBUG: Crawled (404) <GET https://www.showstart.com/robots.txt> (referer: None)
2021-06-13 17:35:05 [scrapy.core.engine] DEBUG: Crawled (200) <GET https://www.showstart.com/> (referer: None)
2021-06-13 17:35:05 [showstart] DEBUG: Saved file showstart.html
2021-06-13 17:35:05 [scrapy.core.engine] INFO: Closing spider (finished)
```

检查项目目录，应该能看到爬虫下载的`showstart.html`，这个文件保存了秀动网的首页。

## 交互式 shell

Scrapy shell 是一个交互式 shell，可用于快速地测试提取数据的代码而无需启动爬虫。执行命令`scrapy shell "https://www.showstart.com/"`进入交互式 shell，你可以看到类似下面的输出：

```shell
2021-06-13 19:16:24 [scrapy.core.engine] DEBUG: Crawled (200) <GET https://www.showstart.com/> (referer: None)
[s] Available Scrapy objects:
[s]   scrapy     scrapy module (contains scrapy.Request, scrapy.Selector, etc)
[s]   crawler    <scrapy.crawler.Crawler object at 0x7fb37ed650d0>
[s]   item       {}
[s]   request    <GET https://www.showstart.com/>
[s]   response   <200 https://www.showstart.com/>
[s]   settings   <scrapy.settings.Settings object at 0x7fb37ed60bb0>
[s]   spider     <DefaultSpider 'default' at 0x7fb37ea64ee0>
[s] Useful shortcuts:
[s]   fetch(url[, redirect=True]) Fetch URL and update local objects (by default, redirects are followed)
[s]   fetch(req)                  Fetch a scrapy.Request and update local objects
[s]   shelp()           Shell help (print this help)
[s]   view(response)    View response in a browser
```

在 shell 中，可以使用 CSS 选择响应中的元素：

```python
>>> response.css('title')
[<Selector xpath='descendant-or-self::title' data='<title>秀动网（showstart.com） - 和热爱音乐的朋友开...'>]
```

返回的结果被称为`SelectorList`，这是一种类似于列表的对象。它是一个包括 XML/HTML 元素的`Selector`对象列表，可用于执行进一步的查询以选择或提取数据。

要提取 title 中的文字，可以这样做：

```python
>>> response.css('title::text').getall()
['秀动网（showstart.com） - 和热爱音乐的朋友开启原创音乐现场之旅']
```

CSS 查询中的`::text`表示选择`<title>`中的文字。如果不用`::text`说明这一点，则会得到整个 title 元素，包括它的标签：

```python
>>> response.css('title').getall()
['<title>秀动网（showstart.com） - 和热爱音乐的朋友开启原创音乐现场之旅</title>']
```

调用`.getall()`返回的结果是一个列表，因为有可能一个选择器会返回多个结果，所以把它们全都提取出来。当只需要第一个结果时，可以使用`get()`：

```python
>>> response.css('title::text').get()
'秀动网（showstart.com） - 和热爱音乐的朋友开启原创音乐现场之旅'
```

除了`getall()`和`get()`方法，还可以通过`re()`使用正则表达式：

```python
>>> response.css('title::text').re(r'（(.+?)）')
['showstart.com']
```

为了找到合适的 CSS 选择器，可以使用`view(response)`在浏览器中打开响应的页面，然后使用浏览器的开发者工具查看网页元素并得到所需的选择器。

## 提取数据

使用浏览器的开发者工具，可以发现在 https://www.showstart.com 中，演出是用类似如下的 HTML 元素表示的：

```html
<a href="/event/91204" class="activity-item image-scale">
    <div class="el-image"><img
            src="https://s2.showstart.com/img/2020/20200405/af132ebd5e764a07b57c3a21b31c4832_600_800_106992.0x0.jpg?imageMogr2/thumbnail/!204x272r/gravity/Center/crop/!204x272"
            class="el-image__inner" style="object-fit: cover;">
        <!---->
    </div>
    <div class="name">#展览#北京奇葩减压馆·保龄球·射箭·分娩体验·蹦床·星空水床·团建·发泄·摔碗一站畅玩 </div>
    <p>¥88<span>起</span></p>
</a>
```

在 Scrapy shell 中，使用 CSS 选择器得到表示演出的 HTML 元素的选择器列表：

```python
>>> response.css('a.activity-item')
[<Selector xpath="descendant-or-self::a[@class and contains(concat(' ', normalize-space(@class), ' '), ' activity-item ')]" data='<a href="/event/91204" class="activit...'>, <Selector xpath="descendant-or-self::a[@class and contains(concat(' ', normalize-space(@class), ' '), ' activity-item ')]" data='<a href="/event/133984" class="activi...'>, ...]
```

上面的查询中返回的每一个选择器都允许对其子元素执行进一步的查询。把第一个选择器赋值给一个变量：

```python
>>> show = response.css('a.activity-item')[0]
```

提取出选择器中的链接，名字和票价：

```python
>>> show.css('a::attr(href)').get()
'/event/91204'
>>> show.css('div.name::text').get()
'#展览#北京奇葩减压馆·保龄球·射箭·分娩体验·蹦床·星空水床·团建·发泄·摔碗一站
畅玩 '
>>> show.css('p::text').get()
'¥88'
```

## 在爬虫中提取数据

前面的爬虫并没有提取任何数据，它只是把整个 HTML 页面保存到本地。现在我们把提取数据的逻辑整合到爬虫中。

在`parse()`方法中使用`yield`关键字以字典的形式保存数据：

```python
import scrapy


class ShowstartSpider(scrapy.Spider):
    name = "showstart"

    def start_requests(self):
        urls = [
            'https://www.showstart.com/',
        ]
        for url in urls:
            yield scrapy.Request(url=url, callback=self.parse)

    def parse(self, response):
        for show in response.css('a.activity-item'):
            yield {
                'href': show.css('a::attr(href)').get(),
                'name': show.css('div.name::text').get(),
                'price': show.css('p::text').get()
            }
```

运行爬虫，Scrapy 会在日志中输出提取的数据：

```shell
2021-06-13 20:08:16 [scrapy.core.scraper] DEBUG: Scraped from <200 https://www.showstart.com/>
{'href': '/event/91204', 'name': '#展览#北京奇葩减压馆·保龄球·射箭·分娩体验·蹦床·星空水床·团建·发泄·摔碗一站畅玩 ', 'price': '¥88'}
2021-06-13 20:08:16 [scrapy.core.scraper] DEBUG: Scraped from <200 https://www.showstart.com/>
{'href': '/event/133984', 'name': '2021北京国际光影艺术季  “万物共生-蔚蓝”户外光影艺术沉浸式体验展', 'price': '¥68'}
2021-06-13 20:08:16 [scrapy.core.scraper] DEBUG: Scraped from <200 https://www.showstart.com/>
{'href': '/event/152620', 'name': '【北喜脱口秀之夜】西直门-开心爆笑专场（单口+即兴+漫才）吐槽大会｜网红打卡胜地', 'price': '¥100'}
2021-06-13 20:08:16 [scrapy.core.scraper] DEBUG: Scraped from <200 https://www.showstart.com/>
{'href': '/event/152459', 'name': '【精品脱口秀节】爆笑段子专场｜北京喜剧中 心｜巨制盛宴X解压开心大会笑心果｜爆梗之夜', 'price': '¥100'}
2021-06-13 20:08:16 [scrapy.core.scraper] DEBUG: Scraped from <200 https://www.showstart.com/>
{'href': '/event/153038', 'name': '【周六喜剧之夜】北京脱口秀大会 『开心演出』单口吐槽 ×喜剧中心 高品质超大笑果-明星联盟！', 'price': '¥99'}
2021-06-13 20:08:16 [scrapy.core.scraper] DEBUG: Scraped from <200 https://www.showstart.com/>
{'href': '/event/153000', 'name': '【周中喜剧之夜】爆笑精品｜脱口秀大会X单口吐槽演出年会专场！', 'price': '¥99'}
2021-06-13 20:08:16 [scrapy.core.scraper] DEBUG: Scraped from <200 https://www.showstart.com/>
{'href': '/event/153030', 'name': '【精品脱口秀大会】解压爆梗之夜｜北京喜剧 中心巨制盛宴--吐槽现场（周中演出｜大剧场-超好笑X开心果演出）', 'price': '¥100'}
2021-06-13 20:08:16 [scrapy.core.scraper] DEBUG: Scraped from <200 https://www.showstart.com/>
{'href': '/event/153285', 'name': ' 三里屯 周六【爆笑脱口秀专场】袋鼠喜剧搞 笑零距离', 'price': '¥79'}
2021-06-13 20:08:16 [scrapy.core.scraper] DEBUG: Scraped from <200 https://www.showstart.com/>
{'href': '/event/153471', 'name': '【脱口秀专场】精品喜剧大会X北喜2021年巨制--解压狂欢｜东城爆笑专场', 'price': '¥100'}
2021-06-13 20:08:16 [scrapy.core.scraper] DEBUG: Scraped from <200 https://www.showstart.com/>
{'href': '/event/153472', 'name': '【脱口秀专场】精品喜剧大会X北喜2021年巨制--解压狂欢｜东城爆笑专场', 'price': '¥100'}
```

## 保存数据

最简单的保存数据的方式是使用下面的命令：

`scrapy crawl showstart -O showstart.json`

这个命令会以 [JSON](https://www.json.org/json-en.html) 文件的形式把提取的数据保存到`showstart.json`中。

选项`-O`覆盖已有的文件；选项`-o`向已有文件添加新的内容。因为直接向 JSON 文件添加新的内容会违背 JSON 的格式，所以在向已有文件添加内容时应该使用另外的序列化格式，例如 [JSON Lines](http://jsonlines.org/) ：

`scrapy crawl showstart -o showstart.jl`

## 追踪链接

如果希望不只提取秀动网首页的演出，就需要追踪网页中的链接。

使用浏览器的开发者工具，可以发现 查看更多演出 的链接是用下面的 HTML 元素表示的

```html
<div class="more-bar">
    <a href="/event/list" class="">查看更多演出<span class="m-icon icon-arrow"></span></a>
</div>
```

可以试着在 shell 中提取它：

```python
>>> response.css('div.more-bar a').get()
'<a href="/event/list">查看更多演出<span class="m-icon icon-arrow"></span></a>'
```

这样可以得到 anchor 元素，但需要的是属性`href`。可以使用 CSS 扩展来选择元素属性的内容：

```python
>>> response.css('div.more-bar a::attr(href)').get()
'/event/list'
```

也可以使用`attrib`：

```python
>>> response.css('div.more-bar a').attrib['href']
'/event/list'
```

把追踪链接的逻辑加入到爬虫中：

```python
import scrapy


class ShowstartSpider(scrapy.Spider):
    name = "showstart"

    def start_requests(self):
        urls = [
            'https://www.showstart.com/',
        ]
        for url in urls:
            yield scrapy.Request(url=url, callback=self.parse)

    def parse(self, response):
        for show in response.css('a.activity-item'):
            yield {
                'href': show.css('a::attr(href)').get(),
                'name': show.css('div.name::text').get(),
                'price': show.css('p::text').get()
            }

        more_page = response.css('div.more-bar a::attr(href)').get()
        if more_page is not None:
            more_page = response.urljoin(more_page)
            yield scrapy.Request(more_page, callback=self.parse)
```

现在，在提取数据之后，`parse()`方法还会查找 查看更多演出 的链接，然后使用`urljoin()`拼接得到完整的 URL 并发起一个新的请求。

这就是 Scrapy 追踪链接的机制：当你在回调方法中发起新的请求时，Scrapy 将安排发送这个请求并注册一个回调方法以在这个请求完成时执行。

使用这种方式，你可以编写复杂的爬虫，根据你定义的规则追踪链接，并根据它访问的页面提取不同类型的数据。

&nbsp;

- [1] [Scrapy Tutorial — Scrapy 2.5.0 documentation](https://docs.scrapy.org/en/latest/intro/tutorial.html)