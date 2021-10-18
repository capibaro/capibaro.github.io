---
layout: post
title: 基础教程
description: a tutorial on servlet and jsp
category: J2EE
tags: java servlet jsp
date: 2021-04-27 18:31:51 +0800
excerpt: 创建一个简单的 J2EE 项目
---

IDEA 是广受欢迎的 Java 开发集成环境。如果你是学生，可以通过 [免费教育许可证](https://www.jetbrains.com/zh-cn/community/education/#students) 获取License 并下载使用 IntelliJ IDEA Ultimate 。

## 新建项目

打开 IDEA ，点击右上角的`New Project`新建项目。

在左侧的目录中选择`Java Enterprise`，然后完成项目配置：

```
Name: demo

Location: E:\IDEA\demo

Project template: Web application

Application server: Tomcat 9.0.44

Build system: Maven

Language: Java

Test framework: JUnit

Group: com.example

Artifact: demo

Project SDK: 1.8
```

- [Tomcat](https://tomcat.apache.org/) 是一个 Servlet 的容器，它可以动态地创建，调用和销毁 Servlet 实例
- [Maven](http://maven.apache.org/) 是一个依赖管理工具，用于构建项目
- [JUnit](https://junit.org/junit5/) 是一个单元测试框架，用于编写单元测试

点击`Next`进入项目依赖页面。因为`Servlet`已添加到依赖中。所以点击`Finish`创建项目即可。

## 项目文件

IDEA 为项目生成了如下文件：

```
E:.
│  demo.iml
│  pom.xml
│
└─src
    ├─main
    │  ├─java
    │  │  └─com
    │  │      └─example
    │  │          └─demo
    │  │                  HelloServlet.java
    │  │
    │  ├─resources
    │  └─webapp
    │      │  index.jsp
    │      │
    │      └─WEB-INF
    │              web.xml
    │
    └─test
        ├─java
        └─resources
```

`demo.iml`是 IDEA 的配置文件。

`WEB-INF/web.xml`是项目的配置文件。

`pom.xml`是 Maven 用于构建项目的文件，可用于管理依赖：

```
<dependencies>
    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>javax.servlet-api</artifactId>
        <version>4.0.1</version>
        <scope>provided</scope>
    </dependency>
    <dependency>
        <groupId>org.junit.jupiter</groupId>
        <artifactId>junit-jupiter-api</artifactId>
        <version>${junit.version}</version>
        <scope>test</scope>
    </dependency>
    <dependency>
        <groupId>org.junit.jupiter</groupId>
        <artifactId>junit-jupiter-engine</artifactId>
        <version>${junit.version}</version>
        <scope>test</scope>
    </dependency>
</dependencies>
```

## Servlet

Web 服务主要包含接收请求、处理请求和响应请求三个步骤。对于不同的 Web 服务，接收请求和响应请求都是相似的，所以这部分可由 Web 服务器完成，比如 Tomcat 。而对于处理请求中不同的业务逻辑，则需要通过 Servlet 编写。

在 Web 服务中，Tomcat 会解析收到的 HTTP 请求并将其封装成 Request 对象，接着读取`web.xml`中 Servlet 的配置信息，然后通过反射创建相应的 Servlet 实例，并传入参数 Request 对象和空的 Response 对象进行调用。Servlet 则根据 Request 对 Response 做出相应的处理。最后 Tomcat 把处理后的 Response 组装成 HTTP 响应发给客户端。

在 Servlet 中，我们主要需要实现init(), service(), destroy()三个方法。其中init()和destroy()分别在 Servlet 创建和销毁时被调用。service()则会在每次有新的请求时被调用，所以我们需要在里面实现业务逻辑。

又因为 HTTP 请求具有多种方式，所以 HttpServlet 在service()方法中实现了对请求方法的判断但并未给出有效的实现（因为具体的业务逻辑是未知的）。所以我们只需要继承 HttpServlet 并重写doGet()和doPost()方法以实现具体的业务逻辑。

下面我们看看模板生成的 Servlet 文件：

HelloServlet.java

```
package com.example.demo;

import java.io.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class HelloServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + message + "</h1>");
        out.println("</body></html>");
    }

    public void destroy() {
    }
}
```

在这里，我们使用`@WebServlet`注解代替了`web.xml`中的配置，并指定`helloServlet`对应的请求为`/hello-servlet`。

在init()方法中，我们初始化了要发送的信息。

在doGet()方法中，我们指定了 response 的类型，并向其写入作为响应的 HTML 文件。

## JSP

在上面的部分中，你可能注意到 Servlet 生成 HTML 文件的方式相当繁琐。我们可以使用 JSP 来解决这个问题。JSP 看起来就像是嵌入 Java 代码的 HTML 文件，但它并不会被作为响应发给客户端。实际上，JSP 会在服务器被编译为 Servlet 并通过内嵌的 Java 代码获取数据并拼接到 HTML 文件中，进而生成静态的 HTML 文件作为响应发送到客户端。

下面我们看看模板生成的JSP文件：

index.jsp

```
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1><%= "Hello World!" %>
</h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>
</body>
</html>
```

在这里，我们向 HTML 文件中嵌入了 Java 字符串`Hello World!`。

## 运行项目

点击 IDEA 右上方的绿色运行运行按钮。Tomcat 启动后会打开浏览器。你可以在浏览器看到`Hello World!`和一个超链接`Hello Servlet`，这是`index.jsp`生成的响应。点击超链接`Hello Servlet`，你可以看到`Hello World!`，这是 helloServlet 生成的响应。

- [servlet的本质是什么，它是如何工作的？ - 知乎](https://www.zhihu.com/question/21416727/answer/690289895)
- [怎样学习JSP？ - 知乎](https://www.zhihu.com/question/23984162/answer/689106407)