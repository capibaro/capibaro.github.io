---
layout: post
title: 添加功能
description: add excerpt, pagination and archive to jekyll blog
category: Jekyll
date: 2021-09-24 12:17:23 +0800
---

Jekyll 默认生成的网站比较简陋，这篇博客为 Jekyll 生成的博客网站增加摘要、分页和归档的功能。

<!--more-->

## 摘要

在默认的首页中，Jekyll 仅列出所有博客的标题。读者对博客的内容很难有一个直观的认识，我们可以通过添加摘要来解决这个问题。

### 使用摘要分隔符

在`_config.yml`中设置摘要分隔符：

`excerpt_separator: <!--more-->`

Jekyll 会提取博客中摘要分隔符之前的内容作为摘要。

### 直接编写摘要

在博客的 front matter 中直接编写摘要：

```yaml
---
layout: post
excerpt: 给 Jekyll 博客添加摘要、分页和归档功能
---
```

在首页使用 [Liquid](https://shopify.github.io/liquid/) 表达式显示摘要：

{% raw %}
```html
---
layout: default
---

{% for post in paginator.posts %}
  <h1><a href="{{ post.url }}">{{ post.title }}</a></h1>
  <div class="excerpt">
    {{ post.excerpt }}
  </div>
{% endfor %}
```
{% endraw %}

## 分页

当博客达到一定数量时，我们可以使用 jekyll-paginate 插件进行分页。

在 Gemfile 中添加 jekyll-paginate ：

```ruby
group :jekyll_plugins do
  gem "jekyll-paginate"
end
```

在`_config.yml`中添加 jekyll-paginate ：

```yaml
plugins:
  - jekyll-paginate
```

在`_config.yml`中指定每一页的博客数量：

`paginate: 5`

在首页中添加分页链接：

{% raw %}
```html
---
layout: default
---

{% for post in paginator.posts %}
  <h6>{{ post.date | date: '%b %d, %Y' }}</h6>
  <h3><a href="{{ post.url }}">{{ post.category }}&nbsp{{ post.title}}</a></h3>
  <div class="excerpt">
    {{ post.excerpt }}
  </div>
  <br/>
{% endfor %}

{% if paginator.total_pages > 1 %}
<div class="pagination">
  {% if paginator.previous_page %}
    <a href="{{ paginator.previous_page_path | relative_url }}">&laquo; Prev</a>
  {% else %}
    <span>&laquo; Prev</span>
  {% endif %}

  {% for page in (1..paginator.total_pages) %}
    {% if page == paginator.page %}
      {{ page }}
    {% elsif page == 1 %}
      <a href="{{ '/' | relative_url }}">{{ page }}</a>
    {% else %}
      <a href="{{ site.paginate_path | relative_url | replace: ':num', page }}">{{ page }}</a>
    {% endif %}
  {% endfor %}

  {% if paginator.next_page %}
    <a href="{{ paginator.next_page_path | relative_url }}">Next &raquo;</a>
  {% else %}
    <span>Next &raquo;</span>
  {% endif %}
</div>
{% endif %}
```
{% endraw %}

注意，分页功能只适用于HTML文件，所以你的首页应该使用`index.html`定义而不是`index.md`。

## 归档

### 直接添加归档

在博客的 front matter 中添加 category：

{% raw %}
```yaml
---
category: Jekyll
---
```

使用 Liquid 表达式编写一个根据 category 生成归档的页面：

```html
---
layout: page
title: 归档
permalink: /archive/
---
{% assign ordered_categories = site.categories | sort %}
{% for category in ordered_categories %}
  <h4>{{ category[0] }}</h4>
  <ul>
    {% assign ordered_posts = category[1] | sort:"date" %}
    {% for post in ordered_posts %}
      <li><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>
{% endfor %}
```
{% endraw %}

这里先对所有的 category 排序，其中`category[0]`是 category 的名称，`category[1]`是 category 下的博客，然后对同一个 category 下的博客按照`date`排序，最后依次生成每个博客的标题和链接。

### 使用归档插件

[jekyll-archives](https://github.com/jekyll/jekyll-archives) 是一个 Jekyll 归档插件，也可以使用这个插件来生成归档。

&nbsp;

- [1] [Posts \| Jekyll • Simple, blog-aware, static sites • post-excerpts](https://jekyllrb.com/docs/posts/#post-excerpts)
- [2] [Pagination \| Jekyll • Simple, blog-aware, static sites](https://jekyllrb.com/docs/pagination/)
- [3] [Posts \| Jekyll • Simple, blog-aware, static sites • tags-and-categories](https://jekyllrb.com/docs/posts/#tags-and-categories)