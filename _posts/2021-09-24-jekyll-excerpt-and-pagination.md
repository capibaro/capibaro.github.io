---
layout: post
title: Jekyll 添加功能
description: add excerpt, pagination to jekyll generated blog
date: 2021-09-24 12:17:23 +0800
excerpt: 为 Jekyll 博客添加摘要和分页功能
---

## 摘要

在默认的首页中，Jekyll 仅列出所有博客的标题。读者对博客的内容很难有一个直观的认识，我们可以通过添加摘要来解决这个问题。

### 使用摘要分隔符

在`_config.yml`中设置摘要分隔符：

`excerpt_separator: <!--more-->`

Jekyll 会提取博客中摘要分隔符之前的内容作为摘要。

### 直接编写摘要

在博客的 front matter 中直接编写摘要：

```
---
layout: post
excerpt: 给 Jekyll 博客添加摘要、分页和归档功能
---
```

在首页使用 [Liquid](https://shopify.github.io/liquid/) 表达式显示摘要：

{% raw %}
```
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

```
group :jekyll_plugins do
  gem "jekyll-paginate"
end
```

在`_config.yml`中添加 jekyll-paginate ：

```
plugins:
  - jekyll-paginate
```

在`_config.yml`中指定每一页的博客数量：

`paginate: 5`

在首页添加分页链接：

{% raw %}
```
{% if paginator.total_pages > 1 %}
<div class="pagination">
  {% if paginator.previous_page %}
    <a href="{{ paginator.previous_page_path | relative_url }}">&laquo; Prev</a>
  {% else %}
    <span>&laquo; Prev</span>
  {% endif %}

  {% for page in (1..paginator.total_pages) %}
    {% if page == paginator.page %}
      <em>{{ page }}</em>
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

- [Posts \| Jekyll • Simple, blog-aware, static sites](https://jekyllrb.com/docs/posts/#post-excerpts)
- [Pagination \| Jekyll • Simple, blog-aware, static sites](https://jekyllrb.com/docs/pagination/)