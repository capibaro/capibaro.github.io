---
layout: post
title: 基础教程
description: a tutorial on how to convert markdown text to static blog site in jekyll
category: Jekyll
date: 2021-09-22 11:44:58 +0800
excerpt: 使用 Jekyll 根据 Markdown 文本生成静态博客网站
---

## 快速开始

[Jekyll](https://jekyllrb.com/) 是一个静态网站生成器。它使用你最喜爱的标记语言编写的文本和布局生成静态的网站。你可以细微地调整网站的外观，链接和页面上展示的数据等内容。

### 先决条件

Jekyll 需要以下内容：
- Ruby 2.5.0 或更高的版本
- RubyGems
- GCC 和 Make

### 使用说明

1. 安装所有的先决条件
2. 安装 Jekyll 和 Bundler  
  `gem install jekyll bundler`
3. 在`./myblog`中创建一个新的 Jekyll 网站  
  `jekyll new myblog`
4. 进入新建的目录  
  `cd myblog` 
5. 构建网站让它在本地服务器上可用  
  `bundle exec jekyll serve`
6. 打开 http://localhost:4000

## 安装

Jekyll 是一个可以在大多数系统安装的 [Ruby Gem](https://jekyllrb.com/docs/ruby-101/#gems)

### 必要条件

- [Ruby 2.5.0](https://www.ruby-lang.org/en/downloads/) 或更高的版本，包括所有用于开发的头文件 (使用`ruby -v`查看你的 Ruby 版本)
- [RubyGems](https://rubygems.org/pages/download) (使用`gem -v`查看你的 Gems 版本)
- [GCC](https://gcc.gnu.org/install/) 和 [Make](https://www.gnu.org/software/make/) (使用`gcc -v`，`g++ -v`和`make -v`查看版本)

### 在 Ubuntu 中安装 Jekyll

安装 Ruby 和其他前置条件

`sudo apt-get install ruby-full build-essential zlib1g-dev`

避免以 root 用户身份安装 RubyGems 包（gems）。更好的方式是为你的用户设置一个 gem 安装目录。下面的命令会向你的`~/.bashrc`文件中添加环境变量以配置 gem 安装路径：

```shell
echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

最后，安装 Jekyll 和 Bundler：

`gem install jekyll bundler`

## Ruby 101

Jekyll 是用 Ruby 编写的。如果你之前没接触过 Ruby，这部分内容可以帮助你了解一些术语。

### Gems

Gems 是你在 Ruby 项目中能够包含的代码。Gems 包具有特定的功能。你可以在多个项目间或者与他人共享 Gems。

Gems 可以执行类似如下的任务：
- 把 Ruby 对象转换为 JSON
- 分页
- 与 Github 的 API 交互

Jekyll 是一个 gem 。许多 Jekyll [插件](https://jekyllrb.com/docs/plugins/) 也是 gems ，包括 [jekyll-feed](https://jekyllrb.com/docs/plugins/) , [jekyll-seo-tag](https://github.com/jekyll/jekyll-seo-tag) 和 [jekyll-archives](https://github.com/jekyll/jekyll-archives) 。

### Gemfile

`Gemfile`是你的网站用到的 gems 的清单。每个 Jekyll 网站在主目录下都有一个 Gemfile。

对于一个简单的 Jekyll 网站来说，它通常看起来像是这样：

```ruby
source "https://rubygems.org"

gem "jekyll"

group :jekyll_plugins do
  gem "jekyll-feed"
  gem "jekyll-seo-tag"
end
```

### Bundler

[Bundler](https://rubygems.org/gems/bundler) 是一个在你的`Gemfile`中安装所有 gems 的一个 gem。

尽管使用 `Gemfile` 和 `bundler`并不是必须的，但我们强烈推荐它，因为它能够确保你在不同的环境中运行相同版本的 Jekyll 和 Jekyll 插件。

使用`gem install bundler`安装 Bundler 。你只需要安装一次，而不是每次你创建一个新的 Jekyll 项目的时候。

要使用 Bundler 安装你的 Gemfile 中的 gems ，在 Gemfile 所在的目录下执行下面的命令：

```shell
bundle install
bundle exec jekyll serve
```

如果你不使用 Gemfile ，可以忽略 Bundler 直接执行`jekyll serve`。

## 目录结构

在`myblog`目录下，可以看到 Jekyll 创建的文件：

```
myblog
├── 404.html
├── Gemfile
├── Gemfile.lock
├── _config.yml
├── _posts
│   └── 2021-09-22-title.md
├── about.md
└── index.md
```

`404.html`是网站的404页面，当试图访问不存在的页面时，会被重定向到这个页面。

`Gemfile`是网站所用到的 Gems 列表。

`_config.yml`是网站的配置文件。

`_posts`目录用于存放用标记语言编写的博客。

`about.md`是网站的关于页面。

`index.md`是网站的首页。

## 编写博客

要编写博客，只需要在`_posts`目录下新建以`yyyy-mm-dd-title`格式命名的文件，并在开头用 [YAML](https://yaml.org/) 配置 fromt matter。

front matter 被包括在两行`---`中间，用于定义博客的一些信息，它通常看起来像是这样：

```yaml
---
layout: post
title: Blogging Like a Hacker
---
```

layout 是根据博客内容生成网页的模板。在 Jekyll 的默认主题 miminima 中，包括的 layout 有`home`，`default`，`page`和`post`，分别用于不同的页面。

&nbsp;

- [1] [Quickstart \| Jekyll • Simple, blog-aware, static sites](https://jekyllrb.com/docs/)
- [2] [Ruby 101 \| Jekyll • Simple, blog-aware, static sites](https://jekyllrb.com/docs/ruby-101/)