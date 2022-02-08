---
layout: post
title: HTML 基础
description: a basic tutorial on html
category: Web
date: 2021-12-8 14:22:36 +0800
---

超文本标记语言（HTML, HyperText Markup Language）是用来结构化网页及其内容的代码。具体来说，这些内容可以由一系列段落、一个要点列表或者使用图像和数据表构建而成。这篇文章会简要介绍 HTML 及其用途。

<!--more-->

## 什么是 HTML ？

HTML 是定义网页结构的标记语言。HTML 由一系列元素组成，这些元素可以用来包裹网页的不同部分以让它们以特定的方式出现或者起作用。用于包裹的标签可以让文字或者图像链接到其他地方、让文字倾斜、让字体变大或变小等等。例如，对于下面这行内容

`My cat is very grumpy`

如果想要此行自成一段，可以使用段落标签包裹它并将它指定为一个段落：

`<p>My cat is very grumpy</p>`

## 分析 HTML 元素

下面略微深入地研究这个段落元素

![HTML 元素](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/HTML_basics/grumpy-cat-small.png")

这个元素的主要组成部分有：

1. 开始标签：由元素的名称（在这里是 p）组成，使用一对尖括号包裹。这表明元素在哪里开始并发挥相应作用——在这里是表示段落开始。
2. 结束标签：除了在元素名称前多了一条斜线，其他都和开始标签相同。这表明元素在哪里结束——在这里是表示段落结束。忘记添加结束标签是初学者常犯的错误，并会导致奇怪的结果。
3. 内容：由元素的内容组成，在这里是文字
4. 元素：开始标签、结束标签和内容组成了元素

元素还可以有像下面这样的属性：

![HTML 属性](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/HTML_basics/grumpy-cat-attribute-small.png)

属性包含关于元素的，不想出现在实际内容中的额外信息。在这里，`class`是属性名，`editor-note`是属性值。`class`属性可以为元素指定非唯一的标识符，标识符会在指定元素（和其他具有相同`class`值的元素）的样式信息或者其他内容时被用到。

属性需要包括以下内容：

1. 属性和元素名称（或上一个属性，如元素已有一个或更多属性）之间的空格。
2. 属性名后的等号。
3. 使用一对引号括起来的属性值。

注意：不包含 ASCII 空格（或者任何"'`=<>）的简单属性值可以不使用括号，但是推荐所有的属性值使用引号，因为这能让代码保持一致并易于理解。

## 嵌套元素

可以把元素放到其他元素里面——这叫做嵌套。如果想要表明猫咪非常暴躁，可以使用`<strong>`元素把`very`包裹起来，这表明这个单词被特别强调：

```html
<p>My cat is <strong>very</strong> grumpy.</p>
```

需要确保元素的嵌套是正确的。在上面的例子中，首先打开了`<p>`元素，然后是`<strong>`元素；因此，需要首先关闭`<strong>`元素，然后是`<p>`元素。下面是一个错误的例子：

```html
<p>My cat is <strong>very grumpy.</p></strong>
```

元素需要正确地被打开和关闭才能清楚地表明它们之间的嵌套关系。如果它们像上面那样发生重叠，浏览器会尽可能地进行猜测并可能得到意外的结果。因此不要这样做！

## 空元素

有些元素不包含内容并被称为空元素，比如`<img>`元素：

```html
<img src="images/firefox-icon.png" alt="My test image">
```

这里有两个属性，但没有结束标签`</img>`以及内容。这是因为图像元素不需要包含内容。它的目的是在网页中它出现的地方嵌入图像。

## 分析 HTML 文档

前面介绍了基本的单个 HTML 元素，但仅使用它们并不方便。现在看看单个 HTML 元素如何组成完整的网页：

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>My test page</title>
  </head>
  <body>
    <img src="images/firefox-icon.png" alt="My test image">
  </body>
</html>
```

这里包括以下内容：

- `<!DOCTYPE html>`——文档类型。这是符合要求的文档开头。在 HTML 刚刚诞生的时期（大概是 1991/92 年），文档类型是指向编写好的 HTML 文档需要遵守的一系列规则的链接，包括自动错误检查和其他有用的内容。但事到如今，它们的作用不大且基本只被用来确保文档正常工作。现在只需要知道这些。
- `<html></html>`——`<html>`元素。这个元素包裹整个页面上的所有内容，有时被称为根元素。
- `<head></head>`——`<head>`元素。这个元素是所有包含在 HTML 页面中但并不出现在实际内容中的东西的容器。这些东西通常包括在搜索结果中显示的关键词和页面描述、指定内容样式的 CSS 、字符集声明等等。
- `<meta charset="utf-8">`——这个元素把文档使用的字符集设为 UTF-8 ，这个字符集包含了绝大多数书面语言中的字符。基本上它能够处理输入的任何文本内容。没有理由不使用这个字符集，它还能避免后面可能会出现的某些问题。
- `<title></title>`——`<title>`元素。这指定了页面的标题，并会出现在加载这个页面的浏览器标签页上。他还被用来在书签/收藏中描述这个页面。
- `<body></body>`——`<body>`元素。这包含用户访问页面时展示的所有内容，无论是文本、图像、视频、游戏、音乐还是任何其他内容。

## 图像

下面回到前面介绍过的`<img>`元素：

```html
<img src="images/firefox-icon.png" alt="My test image">
```

正如前面提到的，这个元素在网页中它出现的位置嵌入图片。它通过`src`（source）属性完成这个任务，这个属性包含指向图像文件的路径。

这里还有一个`alt`（alternative）属性。这个属性用于指定在用户看不到图像时的描述性的文字，这通常是因为：

1. 他们有视力障碍。有视力障碍的用户通常使用屏幕阅读器朗读作为替代的文字。
2. 出现错误导致图像无法显示。例如可以试着故意把`src`属性中的路径写错。保存并重新加载页面，应该会在图片的位置看到：

<image src="https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/HTML_basics/alt-text-example.png"/>

替代文字的关键在于是描述性的文字。替代文字需要能够向读者提供足够的信息并使其理解图像传达的内容。在这里，目前的文字“My test image”做得并不好。对于 Firefox 的标志来说，一个更好的替代是“The Firefox logo: a flaming fox surrounding the Earth”。

## 标记文本

这部分包括用来标记文本的一些基本 HTML 元素。

### 标题

标题元素可以用来指定内容中的特定部分为标题——或子标题。就像书有书名、章节名和小标题一样，HTML 文档也有这样的内容。HTML 包括 6 个标题级别，尽管最常使用的是 3 到 4 个：

```
<h1>My main title</h1>
<h2>My top level heading</h2>
<h3>My subheading</h3>
<h4>My sub-subheading</h4>
```

注意：一级标题具有隐式的样式。不要使用标题元素来增大或加粗文本，因为它们被用于无障碍阅读和 SEO 。试着在页面上创建一系列有意义的标题并且不要跳跃标题级别。

### 段落

正如在上面提到的，`<p>`元素被用于容纳文本的段落；在标记常规文本内容时会频繁地使用它：

```html
<p>This is a single paragraph</p>
```

### 列表

大量的 web 内容都是列表，而 HTML 中有与之对应的特殊元素。标记列表总是包括至少 2 个元素。最常用的列表类型是有序和无序列表：

1. 无序列表用于表项顺序无关紧要的列表，比如购物清单。这些使用`<ul>`元素包裹。
2. 有序列表用于表项顺序比较重要的列表，比如烹饪清单，这些使用`<ol>`元素包裹。

列表中的每个表项都被放在一个`<li>`（list item）元素中。

例如，如果要把下面的段落片段转换成一个列表：

```html
<p>At Mozilla, we’re a global community of technologists, thinkers, and builders working together ... </p>
```

可以把标记改成这样

```html
<p>At Mozilla, we’re a global community of</p>

<ul>
  <li>technologists</li>
  <li>thinkers</li>
  <li>builders</li>
</ul>

<p>working together ... </p>
```

### 链接

链接非常的重要——它们是 web 的重要组成部分！要添加链接，需要使用一个简单的元素——`<a>`——“a”是“anchor”的缩写。按照以下步骤把段落中的文字变成一个链接：

1. 选择一些文字。比如“Mozilla Manifesto”。
2. 像下面这样把文字包裹在`<a>`元素中：
   `<a>Mozilla Manifesto</a>`
3. 像下面这样给`<a>`元组添加一个`href`属性：
   `<a href="">Mozilla Manifesto</a>`
4. 在这个属性的值中填写想要链接到的 web 地址：
   `<a href="https://www.mozilla.org/en-US/about/manifesto/">Mozilla Manifesto</a>`

如果忽略 web 地址中起始的`https://`或者`http://`，即协议，可能会得到意外的结果。标记一个链接后，点击它以确认链接指向正确的地方。

注意：作为一个属性名，href 一开始看起来比较奇怪。如果觉得难以记忆，要明白它的含义是\*hypertext reference\*。

&nbsp;

- [1] [HTML basics - Learn web development \| MDN](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/HTML_basics)