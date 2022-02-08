---
layout: post
title: CSS 基础
description: a basic tutorial on css
category: Web
date: 2021-12-09 13:36:14 +0800
---

CSS（Cascading Style Sheets）是样式化 web 内容的代码。CCS 基础介绍基本的入门内容，并解答这样的问题：如何把文字变成红色？如何让内容在（网页）布局的特定位置显示？如何使用背景图片和颜色装饰网页？

<!--more-->

## 什么是 CSS ？

与 HTML 类似，CSS 并不是编程语言。它也不是标记语言。CSS 是样式表语言。CSS 用于选择性地样式化 HTML 元素。例如，这里的 CSS 选择段落中的文字，并把颜色设为红色：

```css
p {
    color: red;
}
```

使用文本编辑器把这三行 CSS 粘贴到一个新文件中。把这个文件命名为`style.css`并保存到名为`styles`的目录中。

为了让代码正常工作，还需要把这里的 CSS 应用到 HTML 文档中。不然这些样式不会改变 HTML 的外观。

1. 打开`index.html`。在 head（标签`<head>`与`</head>`之间） 中粘贴下面这一行：
   `<link href="styles/style.css" rel="stylesheet">`
2. 保存`index.html`并在浏览器中加载它，应该可以看到：

![CSS 样例](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/CSS_basics/website-screenshot-styled.png)

如果段落中的文字是红色的，那么表明 CSS 在正常工作。

### 分析 CSS 规则集

下面分析红色段落文字的 CSS 代码来理解它是如何工作的：

![CSS 代码](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/CSS_basics/css-declaration-small.png)

这整个结构被称为规则集（或简称为规则）。注意每个单独部分的名字:

#### 选择器

这是规则集开头的 HTML 元素名称。它定义了要样式化的元素（在这里是`<p>`）。改变选择器以样式化不同的元素。

#### 声明

这是一个像是`color: red;`的简单规则。它定义了想要样式化的元素属性

#### 属性

这是样式化 HTML 元素的方式。（在这里`color`是`<p>`元素的属性）。在 CSS 中，可以选择想要在规则中改变的属性。

#### 属性值

属性的右边——冒号之后——就是属性值。这里从许多可能出现的值中选择了一个（例如，除了`red`还有许多其他的`color`值）

注意语法中其他的重要部分：

- 除了选择器，每个规则集必须包裹在花括号中。（`{}`）
- 在每个声明中，必须使用一个冒号（`:`）来分隔属性和属性值
- 在每个规则集中，必须使用分号（`;`）来分隔下一个声明

要在一个规则集中修改多个属性值，像这样使用分号来分隔它们：

```css
p {
  color: red;
  width: 500px;
  border: 1px solid black;
}
```

### 选择多个元素

还可以选择多个元素然后对它们使用同一个规则集。用逗号分隔多个选择器，例如：

```css
p, li, h1 {
  color: red;
}
```

### 不同类型的选择器

有许多不同类型的选择器。上面的例子使用了元素选择器，它选择给定类型的所有元素。但也可以进行更精确的选择。下面是一些更常见的选择器：

| 选择器名 | 选择的内容 | 例子 |
| ------------- | ------------------- | ------- |
| 元素选择器（有时被称作标签或类型选择器） | 特定类型的所有 HTML 元素 | p 选择 \<p> |
| ID 选择器 | 页面中有特定 ID 的元素。在一个给定的 HTML 页面中，每个 id 的取值应该是唯一的 | #my-id 选择 \<p id="my-id"> or \<a id="my-id"> |
| 类选择器 | 页面中有特定类的元素。相同类的多个实例可以出现在一个页面上 | .my-class 选择 \<p class="my-class"> 和 \<a class="my-class"> |
| 属性选择器 | 页面中有特定属性的元素 | img\[src] 选择 \<img src="myimage.png"> 而不是 \<img> |
| 伪类选择器 | 处于特定状态的特定元素（例如有鼠标指针悬停的链接） |

## 字体与文本

前面已经介绍了一些 CSS 基础，下面通过向`style.css`中添加更多的规则和信息来梅花样例的外观。

1. 首先，从字体网站找到合适的字体。在`index.html`的头部（`<head>`标签与`</head>`标签之间）里添加`<link>`元素，看起来就像这样：  
  `<link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">`
2. 然后，删除`style.css`中现有的规则。它一个好的尝试，但接下来不再需要大量的红色文字
3. 用下面几行代码替代前面选择的`font-family`。`font-family`属性表示想要对文本使用的字体。这条规则为整个页面定义了基础全局字体以及字体大小。因为`<html>`是整个页面的父元素，它里面的所有元素都会继承相同的`font-size`和`font-family`。  
   ```css
   html {
    font-size: 10px; /* px means "pixels": the base font size is now 10 pixels high  */
    font-family: "Open Sans", sans-serif; /* this should be the rest of the output you got from Google fonts */
   }
   ```
   注意：CSS 中在`/*`和`*/`之间的是 CSS 注释。浏览器在渲染代码时会忽略注释。CSS 注释是编写对代码或逻辑有帮助的笔记的一种方式。
4. 现在设置 HTML 主体中包含文本的元素（`<h1>`，`<li>`和`<p>`）的字体大小并让标题居中。最后，通过设定行高和字间距扩展第二个规则集以提高主题内容的可读性。
   ```css
    h1 {
    font-size: 60px;
    text-align: center;
    }

    p, li {
    font-size: 16px;
    line-height: 2;
    letter-spacing: 1px;
    }
   ```

把`px`修改为想要的值。现在的样例页面看起来应该像是这样：

![样例页面](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/CSS_basics/website-screenshot-font-small.png)

## CSS：一切皆盒子

编写 CSS 代码时会发现：大部分的内容都与盒子有关。这包括设定大小、颜色和位置。页面上的大部分 HTML 元素都可以被看做堆叠在其他盒子上面的盒子。

![盒子](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/CSS_basics/boxes.jpg)

CSS 的布局大多基于盒模型。每个在页面上占据空间的盒子都包含下面的属性：

- `padding`，内容周围的空间。在下面的例子中，它是段落文字周围的空间。
- `border`，内边距（padding）周围的边框线。
- `margin`，边框线（border）周围的空间。

![CSS 布局](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/CSS_basics/box-model.png)

在这里还用到了：

- `width`，元素的宽度。
- `background-color`，元素内容与内边距之后的颜色。
- `color`，元素内容（通常是文字）的颜色。
- `text-shadow`为元素内部的文字设置阴影。
- `display`设置元素的显示模式。

接下来添加更多的 CSS 代码。在`style.css`的底部添加新的规则。改变元素的值并观察页面发生的变化。

### 修改页面颜色

```css
html {
  background-color: #00539F;
}
```

这个规则设定了整个页面的背景颜色。

### 设定主题元素样式

```css
body {
  width: 600px;
  margin: 0 auto;
  background-color: #FF9500;
  padding: 0 20px 20px 20px;
  border: 5px solid black;
}
```

这里有一些对`<body>`元素的声明，下面逐行解释它们的作用：

- `width: 600px;`，强制主体元素总是保持 600 像素的宽度。
- `margin: 0 auto;`，在给像是`margin`或者`padding`这样的属性设定两个值时，第一个值影响元素的顶部和底部（这个例子中设为`0`）；第二个值影响左右两侧。（这里的`auto`是一个特殊值，它为左右两侧平均划分空余的水平空间）。还可以使用一个，两个，三个或四个值，具体需要参考外边距语法文档。
- `background-color: #FF9500;`，这设定了元素的背景颜色。这里主体元素的背景使用了橘红色，以和`<html>`元素的深蓝色形成对比。（可以进行自由地尝试。）
- `padding: 0 20px 20px 20px;`，这里给内边距设定了四个值。目的是在内容周围保留一些空间。在这个例子中，主体元素顶部的内边距为 0，底部和左右两侧的内边距为 20 个像素。这几个值设定的顺序是上，右，下，左。就像`margin`一样，可以使用一个，两个，三个或四个值，具体需要参考内边距语法文档。
- `border: 5px solid black;`，这里设定了边界的宽度，样式和颜色。在这个例子中，它是一个环绕主题元素四周的五个像素宽的黑色实线。

### 安置页面主标题并设定样式

```css
h1 {
  margin: 0;
  padding: 20px 0;
  color: #00539F;
  text-shadow: 3px 3px 1px black;
}
```

可能注意到在主体元素的顶部有一个巨大的空白。这是因为浏览器对`<h1>`元素应用了默认的样式。这看起来像是个坏主意，但这样做可以为没有设定样式的页面提供基本的可读性。为了消除这个空白，使用设置`margin: 0;`来覆盖浏览器的默认样式。

接着把标题的顶部和底部的内边距设为 20 个像素。

然后把标题的文字设为和网页背景一样的颜色。

最后，`text-shadow`为元素的文本内容添加阴影。它的四个值表示：

- 第一个像素值设定了阴影相对文本的水平偏移：它会向右移动多远。
- 第二个像素值设定了阴影相对文本的垂直偏移：它会向下移动多远。
- 第三个像素值设定了阴影的模糊半径。更大的值会让阴影看起来更加模糊。
- 第四个值设定了阴影的基本颜色。

可以使用不同的值进行实验并观察它如何改变元素的外观。

### 让图像居中

```css
img {
  display: block;
  margin: 0 auto;
}
```

现在让图像居中以让它更加美观。可以使用在主体元素中用过的`margin: 0 auto`技巧。但这里有一些不同，需要一个附加设置以让 CSS 正常工作。

`<body>`是块级元素，意思是它会在页面上占据空间。页面上的其他元素会考虑应用在块级元素上的外边距。相比之下，图像是内联元素，为了让自动外边距的技巧在图像上正常工作，一定要使用`display: block;`赋予它块级别的行为。

注意：上面的指南假定使用的图片小于设定的主体元素宽度（600 像素）。如果图像更大的话，它会溢出主体元素并占据页面的余下部分。要解决这个问题，可以：1）使用图像编辑器减少图像的宽度；2）使用 CSS 设定图像的大小，将`<img>`元素的`width`属性设为更小的值

注意：如果暂时不能完全理解`display: block;`或者块级元素与内联元素的区别也没关系。在之后的 CSS 学习过程中应该能够更加清晰地理解这些内容。可以在 MDN 的参考页面中找到关于 display 属性的更多信息。

&nbsp;

- [1] [CSS basics - Learn web development \| MDN](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/CSS_basics)