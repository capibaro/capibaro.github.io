---
layout: post
title: JavaScript 基础
description: a basic tutorial on javascript
category: web
date: 2021-12-24 16:10:52 +0800
---

JavaScript 是为网站添加交互的编程语言。这些交互通常发生在游戏里，按下按钮或填写表单时的回应中，动态样式以及动画里面。这篇博客介绍简单的 JavaScript 入门内容和主要用途。

<!--more-->

## 什么是 JavaScript

JavaScript 是能够为网站添加交互的强大编程语言。它由 Brendan Eich （Mozilla项目，Mozilla 基金会和 Mozilla 公司的联合创始人）发明。

JavaScript 用途广泛并对新手友好。在有了更多的经验后，还能够创作游戏，2D 动画和 3D 图形，复杂的数据库驱动应用和许多其他的东西！

JavaScript 本身相当简洁，同时也非常灵活。开发者们基于 JavaScript 核心编写了大量的工具，用很少的工作就能实现大量的功能。这些包括：

- 浏览器内置的应用编程接口（API），提供了像是动态创建 HTML 和设定 CSS 样式；收集并操纵来自用户摄像头的视频流；或是生成 3D 图形和音频样例这样的功能
- 第三方应用编程接口，允许开发者在网站中包含像是 Twitter 或者 Facebook 的内容提供商的内容。
- 第三方框架和库，可以用于 HTML 以加速构建网站和应用的工作。

解释 JavaScript 核心如何不同于上面列出的工具的细节超出了这篇博客——浅显的 JavaScript 介绍的内容。可以在 MDN 的 JavaScript 学习区域或者 MDN 的其他部分学习更多的内容。

下面的部分介绍 JavaScript 核心的某些方面，并提供接触浏览器的一些 API 特性的机会。

## 一个 Hello world! 示例

JavaScript 是最受欢迎的现代 Web 技术之一。随着你的 JavaScript 技巧的熟练，你的网站会在功能和创造性上步入更深的维度。

然而，熟练使用 JavaScript 要比熟练使用 HTML 和 CSS 更具有挑战性。你也许需要从细微的地方开始，并逐渐进步。作为开始，下面在网页中加入 JavaScript 来创建一个 Hello, world! 的例子。

1. 在测试站点创建一个新的名为`scripts`的文件夹。在这个文件夹中创建一个新的名为`main.js`的文件并保存。
2. 在`index.html`文件中的结束标签`</body>`前另起一行输入下面的代码：
   `<script src="scripts/main.js"></script>`
3. 这行代码和 CSS 中`<link>`元素的作用是一样的。它把 JavaScript 应用到这个页面并作用于 HTML (还有 CSS 和任何页面上的其他内容)。
4. 在`main.js`中添加下面的代码：
   ```js
   const myHeading = document.querySelector('h1');
   myHeading.textContent = 'Hello world!';
   ```
5. 确保 HTML 和 JavaScript 文件都已经保存。然后在浏览器中加载`index.html`，应该能看到如下内容：

![helloworld 示例](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/JavaScript_basics/hello-world.png)

注意：在（上面的）指南中，把`<script>`元素放在 HTML 文件结尾是因为浏览器以代码出现在文件中的顺序读取它们。如果 JavaScript 在开始时被加载并被希望能够影响还未加载的 HTML，这样会出现问题。把 JavaScript 放到 HTML 页面中靠近结尾的地方是顺应这种依赖的一种方式。

### 发生了什么？

标题中的文字被 JavaScript 修改成了 Hello world!。这里通过使用一个名为`querySelector()`的函数获取了对标题的引用，然后把它保存到一个名为`myHeading`的变量中。这和使用 CSS 选择器是相似的。如果想要对元素做点什么，首先需要选出它。

在这之后，代码把`myHeading`变量的`textContent`属性（这是标题的内容）的值设为 Hello world!。

注意：在这个练习中用到的两个特性都是文档对象模型（DOM, Document Object Model）API 的一部分，它们可以对文档进行操纵。

## 语言基础速成

为了对 JavaScript 的原理有更好的理解，下面会解释这个语言的一些核心特性。这些特性对于所有的编程语言都是通用的。如果掌握了这些基础，对于使用其他语言进行编程也有好处。

提醒：在这篇文章中，试着在 JavaScript 控制台中输入示例代码并观察会发生什么。

### 变量

变量是存储值得容器。可以使用`var`（不被推荐，会在后面进行解释）或`let`关键字声明和紧随的变量名称声明变量：

```js
let myVariable;
```

注意：结尾处的分号表明一个语句的结束。这在同一行中区分不同的语句时是必要的。但是，一些人认为在每一个语句的结尾都加上分号是好的实践。

注意：虽然几乎可以使用任何名字命名变量，但有一些限制（参见命名规则）。如果不确定可以检查变量名以确定它是否合法。

注意：JavaScript 是大小写敏感的。这意味着`myVariable`和`myvariable`是不同的。如果代码中有问题，可以对大小写进行检查。

注意：要了解更多关于`var`和`let`的区别，参见 var 和 let 的区别。

在声明变量后，可以对它赋值：

```js
myVaribale = 'Bob';
```

当然，也可以在同一行中完成声明和复制：

```js
let myVariable = 'Bob';
```

通过变量名取得它的值：

```js
myVaribale
```

在对变量赋值后，可以在之后的代码中改变它：

```js
let myVariable = 'Bob';
myVaribale = 'Steve';
```

变量包含的值可能具有不同的数据类型

| 变量 | 解释 | 示例 |
| -------- | ----------- | ------- |
| String | 被称为字符串的文本序列。要表明某个值是字符串，需要用单引号包围它。 | let myVariable = 'Bob'; |
| Number | 数字。数字不需要用引号包围。 | let myVariable = 10; |
| Boolean | 布尔值（真/假）。true 和 false 是不需要引号的特殊字符 | let myVaribale = true; |
| Array | 在一个引用中存放多个值的数据结构 | let myVariable = [1, 'Bob', 'Steve', 10]; 像这样引用数组的每个成员: myVaribale[0], myVaribale[1], ... |
| Object | 可以是任何东西。JavaScript 中的一切都是对象并可以存储在变量中。在学习中需要记住这一点 | let myVariable = document.querySelector('h1'); 以及上面的所有例子 |

为什么需要变量？变量对于编程中任何有趣的事都非常重要。要是值不能发生变化，就无法完成任何动态的任务，比如个性化的问候信息或改变图片画廊中展示的图像。

### 注释

注释是可以添加到代码中的文本片段。浏览器会忽略被标记为注释的文本。可以像在 CSS 中那样在 JavaScript 中编写注释：

```js
/*
Everything in between is a comment.
*/
```

如果注释不需要换行，也可以把它放到双斜线之后：

```js
// This is a comment
```

### 运算符

运算符是基于两个值（或者变量）产生一个结果的数学符号。下面的表格中展示了最简单的运算符和可以在 JavaScript 控制台中尝试的例子。

| 运算符 | 解释 | 符号 | 例子 |
| -------- | ----------- | --------- | ------- |
| 加 | 两个数字相加或者拼接两个字符串 | + | 6 + 9; 'Hello' + 'world!'; |
| 减，乘，除 | 与基础算术运算一致 | -, *, / | 9 - 3; 8 * 2; // 在 JS 中乘是星号 9 / 3; |
| 赋值 | 给某个变量赋予一个值 | = | let myVaribale = 'Bob'; |
| 相等 | 测试两个值是否相等。结果以布尔值的形式返回 | === | let myVariable = 3; myvaribale === 4; |
| 非，不等于 | 返回与接收的值逻辑相反的值。它会把真转换为假。当它与相等运算符一起使用时，这个否定运算符会测试两个值是否是不等的。 | !, !== | 对于“非”来说，下面的表达式本来为真，但因为被取反所以变为假：let myVaribale = 3; !(myVariable === 3); “不等于”也能得到相同的结果，只不过在语法上不同。下面测试“myVaribale 是否不等于 3”。因为 myVaribale 和 3 是相等的，所以这里会返回假： let myVaribale  3; myVariable !== 3; |

除此之外还有许多运算符，不过这些目前来说够用了。

注意：对不同的数据类型进行运算会得到奇怪的结果。要小心地正确引用变量，才得到期望的结果。举例来说，在控制台中输入`'35' + '25'`。为什么没能得到期望的结果？因为引号会把数字转换为字符串，所以这样会拼接两个字符串而不是让两个数字相加。如果输入`35 + 25`就能得到两个数字的和。

### 条件语句

条件语句是用来测试表达式是否为真的代码结构。条件语句的一种常见形式是 if ... else 语句。举例来说：

```js
let iceCream = 'chocolate';
if (iceCream === 'chocolate') {
   alert('Yay, I love chocolate ice cream!');
} else {
   alert('Awwww, but chocolate is my favorite...');
}
}
```

位于 if(...) 中的表达式是要进行的测试。这里使用相等运算符检查变量 iceCream 和字符串 chocolate 是否相等。如果比较的结果为真，执行第一个语句块。如果比较的结果不为真，执行 else 语句之后的第二个语句块。

### 函数

函数是封装可复用功能的一种方式。可以把一段代码定义为函数，这个函数会在代码中有对函数名的调用时执行。这对于重复编写相同的代码是很好的替代。在前面已经用到了一些函数，例如：

1. let myVaribale = document.querySelector('h1');
2. alert('hello!');

这些函数，document.querySelector 和 alert ，都是浏览器内置的。

如果看到一些东西像是变量名，但在后面紧跟有括号——()——那它很可能就是函数。函数通常会接收参数：它们需要用来完成工作的数据。变量在括号之中，并使用逗号分隔超过一个的变量。

例如，alert()函数可以在浏览器窗口中弹出提示信息，但需要提供一个字符串参数以告知它要展示的信息。

还可以定义自己的函数。下面的例子创建了一个简单的函数，它接收两个数字作为参数并将它们相乘：

```js
function multiply(num1, num2) {
   let result = num1 * num2;
   return result;
}
```

试着在控制台运行这段代码；然后使用一些参数进行测试。例如：

```js
multiply(4, 7);
multiply(20, 20);
multiply(0.5, 3);
```

注意：return 语句告诉浏览器将 result 变量从函数中返回以供后续使用。这是有必要的，因为在函数中定义的变量只有在其对应的函数中是可用的。这叫做变量的作用域。

### 事件

网站上真实的互动需要使用事件处理器。这是监听浏览器中的活动并运行代码作为回应的代码结构。最显而易见的例子是处理鼠标点击，这会在使用鼠标点击某些东西时触发。为了展示这一点，在控制台中输入下面的代码，然后再当前的网页上点击一下：

```js
document.querySelector('html').onclick = function() {
   alert('Ouch! stop poling me!');
}
```

有许多方式能够将事件处理器与元素绑定。这里选择了 \<html> 元素，并把它的 onclick 属性设为一个匿名函数，这个函数包含了点击时想要运行的代码。

注意

```js
document.querySelector('html').onclick = function() {};
```

和

```js
let myHTML = document.querySelector('html');
myHTML.onclick = function() {};
```

是等价的，只是后者更短而已。

## 完善示例网站

现在完成了对 JavaScript 基础的回顾，下面为示例网站添加新的特性。

在做进一步操作之前，删除 main.js 文件目前的内容——在之前的“Hello world!"示例中添加的代码——并保存空的文件。如果不这样做的话，现存的代码会与将要添加的新代码发生冲突。

### 添加图像切换器

在这个部分，会学习如果使用 JavaScript 和 DOM API 展示两个图像中的一个并进行切换。这个切换会在用户点击展示的图像时发生。

1. 选择一张想要在样例页面展示的图像。这个图像最好与之前添加的图像具有相同的大小，或者尽可能地相同。
2. 在 images 目录中保存这个图像。
3. 把这个图像重命名为 firefox2.png。
4. 把下面的 JavaScript 代码添加到 main.js 文件中。
   ```js
   let myImage = document.querySelector('img');

   myImage.onclick = function() {
      let mySrc = myImage.getAttribute('src');
      if (mySrc == 'images/firefox-icon.png') {
         myImage.setAttribute('src', 'images/firefox2.png');
      } else {
         myImage.setAttribute('src', 'images/firefox-icon.png');
      }
   }
   ```
5. 保存所有的文件并在浏览器中加载 index.html。当点击图片时，它应该会切换为另一个图片。

下面介绍发生了什么。首先把对 \<img> 元素的引用存放在变量 myImage 中。然后把这个变量的 onclick 属性设为一个匿名函数。因此每次点击这个元素时：

1. 代码会获取图像 src 属性的值。
2. 代码使用条件语句检查 src 的值是否与最初图像的路径相同：
   1. 如果是的，代码把 src 的值改为第二个图片的路径，让 \<img> 元素加载另一个图像。
   2. 如果不是（这意味着图像已经发生过改变了），src 的值会被改回原有的值，并回到最初的状态。

### 添加个性化的欢迎信息

下面把页面的标题换成用户初次访问网站时的个性化欢迎信息。这个欢迎信息会长期保存。用户可以离开网站并在之后返回，这个信息会使用 Web Storage API 进行保存。还会包含一个切换用户的选项，进而切换欢迎信息。

1. 在 index.html 中的 \<script> 元素之前添加下面的代码：
   `<button>Change user</button>`
2. 在 main.js 的结尾原封不动地添加下面的代码。这段代码获取对西南流和标题的引用并保存到变量中：
   ```js
   let myButton = document.querySelector('button');
   let myHeading = document.querySelector('h1');
   ```
3. 添加下面的函数以设置个性化的问候。这不会马上生效，但很快就会发生改变。
   ```js
   function setUserName() {
      let myName = prompt('Please enter your name.');
      localStorage.setItem('name', myName);
      myHeading.textContent = 'Mozilla is cool, ' + myName;
   }
   ```
   setUserName() 函数包含了一个 prompt() 函数，这个函数会展示一个对话框，类似于 alert()。与 alert() 相比，prompt() 函数还会让用户输入数据并在用户点击 OK 后把它保存到变量中。在这个例子中，让用户输入了一个名字。然后，代码调用了 localStorage API，它能够将数据存储到浏览器中并在稍后取出。使用 localStorage 的 setItem() 函数创建并保存了名为“name” 的数据项，并把它的值设为包含用户输入的名字的 myName 变量。最后，把标题的 textContent 设为字符串和保存用户名的拼接。
4. 添加（下面的） if ... else 代码块。这是一段初始化代码，它会在页面首次加载时进行构建。
   ```js
   if (!localStoreage.getItem('name')) {
      setUserName();
   } else {
      let storeName = localStorage.getItem('name');
      myHeading.textContent = 'Mozilla is cool, ' + storedName;
   }
   ```
   代码块的第一行用到了否定运算符（逻辑非，使用 ! 表示）检查 name 数据是否存在。如果不存在，运行 setUserName() 函数进行创建。如果已经存在（也就是用户在之前的访问中设定了用户名），使用 getItem() 取出存储的名字并把标题的 textContent 设为字符串和用户名的拼接，就像在 setUserName() 中做的那样。
5. 把下面的事件处理器与按钮绑定。当被点击时，setUserName() 会运行。用户可以点击按钮并输入一个不同的名字。
   ```js
   myButton.onclick = function() {
      setUserName();
   }
   ```

### 用户名为空？

运行示例代码，在对话框提示输入用户名时点击 Cancel 按钮。这样得到的标题会显示为 Mozilla is cool, null。这是因为——在取消输入用户名时——这个值会被设为 null。在 JavaScript 中，Null 是用于指代缺失值的特殊值。

同样的，试着不输入名字就点击 OK。显而易见，这样得到的标题会显示为 Mozilla is cool。

为了避免这些问题，需要检查用户时候输入了空白名称。像下面这样更新 setUserName() 函数：

```js
function setUserName() {
   let myName = prompt('Please enter your name.');
   if (!myName) {
      setUserName();
   } else {
      localStorage.setItem('name', myName);
      myHeading.textContent = 'Mozilla is cool, ' + myName;
   }
}
```

用人类的语言来说，这段代码的意思是：如果 myName 没有值，从新运行 setUserName()。如果它有一个值（如果上面的语句不为真），就把值存储到 localStorege 中并把它设为标题的文本。

## 结论

如果遵循这篇文章中的所有指示，可以得到像是下面这样的页面。

![sample](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/JavaScript_basics/website-screen-scripted.png)

&nbsp;

- [1] [JavaScript basics - Learn web development | MDN](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/JavaScript_basics)