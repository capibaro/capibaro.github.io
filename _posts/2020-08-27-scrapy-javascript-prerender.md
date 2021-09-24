---
layout: post
title: Scrapy JavaScript预渲染
description: use scrapy-splash to integrate splash in scrapy
date: 2020-08-27 17:51:58 +0800
excerpt: 使用 scrapy-splash 在 Scrapy 中整合 Splash JavaScript 预渲染服务
---

## 安装

使用 pip 安装 scrapy-splash：

`pip install scrapy-splash`

scrapy-splash 会调用 Splash 的HTTP API，所以你需要一个 Splash 实例。你可以使用下面的命令通过 [Docker](https://www.docker.com/) 运行 Splash 服务：

`docker run -p 8050:8050 scrapinghub/splash`

这条命令会拉取 splash 的镜像并在 8050 端口上运行 Splash 服务。Docker 是广受欢迎的容器技术，有关 Docker 的内容可以参考 [Docker](https://capibaro.github.io//#docker)。

## 配置

在你的Scrapy项目的`settings.py`文件里添加 Splash 服务的地址：

`SPLASH_URL = 'http://localhost:8050'`

把 Splash 中间件添加到`settings.py`文件的`DOWNLOADER_MIDDLEWARES`中并改变 HttpCompressionMiddleware 的优先级：

```
DOWNLOADER_MIDDLEWARES = {
    'scrapy_splash.SplashCookiesMiddleware': 723,
    'scrapy_splash.SplashMiddleware': 725,
    'scrapy.downloadermiddlewares.httpcompression.HttpCompressionMiddleware': 810,
}
```

在默认的 scrapy 设置中优先级723在 HttpProxyMiddleware (750) 的前面。改变 HttpCompressionMiddleware 的优先级是为了进行高级响应处理，具体可以参考 [issues/1895](https://github.com/scrapy/scrapy/issues/1895)

把`SplashDeduplicateArgsMiddleware`添加到`settings.py`文件的`SPIDER_MIDDLEWARES`中：

```
SPIDER_MIDDLEWARES = {
    'scrapy_splash.SplashDeduplicateArgsMiddleware': 100,
}
```

这个中间件是用来支持`cache_args`特性的，它通过不多次在磁盘请求队列中存储重复的 Splash 参数来节省磁盘空间。

设定自定义的`DUPEFILTER_CLASS`：

`DUPEFILTER_CLASS = 'scrapy_splash.SplashAwareDupeFilter'`

如果你使用 Scrapy HTTP 缓存，那么还需要一个自定义的缓存存储后端。scrapy-splash 提供了一个`scrapy.contrib.httpcache.FilesystemCacheStorage`的子类：

`HTTPCACHE_STORAGE = 'scrapy_splash.SplashAwareFSCacheStorage'`

## 使用

通过`scrapy_splash.SplashRequest`即可使用 Splash 渲染请求：

```
from scrapy_splash import SplashRequest

...

    def start_requests(self):
        for url in self.start_urls:
            yield SplashRequest(url, self.parse, args={'wait': 0.5})
```

在稍为复杂的情形中，你可能需要编写 [Lua](http://www.lua.org/) 脚本：

```
def start_requests(self):
    script = """
        function main(splash)
            splash:go(splash.args.url)
            splash:wait(1)
            local offset
            local scroll_to = splash:jsfunc("window.scrollTo")
            for i = 1,10 do
                offset = splash:evaljs("document.documentElement.scrollHeight")
                scroll_to(0, offset)
                splash:wait(1)
            end
            return splash:html()
        end
    """
    for url in self.start_urls:
        yield SplashRequest(url, self.parse, endpoint='execute', args={'lua_source': script})
```

这里的脚本执行了10次向下滚动页面的操作，使用脚本需要在`SplashRequest`的`args`中指定脚本源。

Splash 服务在`localhost:8050`提供了一个简单的界面，建议预先在这里编写你的 Lua 脚本并验证效果。你可以在 Lua 脚本中执行 JavaScript 代码，比如上面的脚本使用`splash:jsfunc`获取 JavaScript 函数，使用`splash:evaljs`得到网页的某些属性。

使用`splash:wait`是因为每次操作后需要一定时间来相应地渲染网页。

`splash:html()`表示获取渲染完成后网页的HTML文本，你还可以使用`splash:png()`来获取渲染完成后的网页截图。

- [scrapy-plugins/scrapy-splash: Scrapy+Splash for JavaScript integration](https://github.com/scrapy-plugins/scrapy-splash)
- [Splash Scripts Tutorial — Splash 3.5 documentation](https://splash.readthedocs.io/en/latest/scripting-tutorial.html)