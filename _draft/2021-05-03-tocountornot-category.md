---
layout: post
title: 二级分类
description: tocountornot category api document
category: to-count-or-not
tag: document
date: 2021-05-03 13:32:15 +0800
excerpt: 爱记不记二级分类接口文档
---

## 新增二级分类

### URL

`POST https://localhost:443/category`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### RequestBody

`{"division":"1","name":"早餐"}`

### ResponseBody

#### 新增成功

```
{
    "code": 201,
    "message": "created",
    "data": 1
}
```

#### 二级分类名过长

```
{
    "code": 400,
    "message": "name length cannot exceed 10",
}
```

#### 二级分类名为空

```
{
    "code": 400,
    "message": "name cannot be blank",
}
```

#### 未指定一级分类

```
{
    "code": 400,
    "message": "division cannot be null",
}
```

#### 指定的一级分类不存在

```
{
    "code": 404,
    "message": "division not found",
}
```

## 修改二级分类

### URL

`PUT https://localhost:443/category/{id}`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### RequestBody

`{"division":"1","name":"午餐"}`

### ResponseBody

#### 修改成功

```
{
    "code": 200,
    "message": "success",
    "data": 3
}
```

#### 二级分类不存在

```
{
    "code": 404,
    "message": "category not found",
}
```

#### 未指定一级分类

```
{
    "code": 400,
    "message": "division cannot be null",
}
```

#### 指定的一级分类不存在

```
{
    "code": 404,
    "message": "division not found",
}
```

#### 修改一级分类

```
{
    "code": 403,
    "message": "cannot modify division",
}
```

## 删除二级分类

### URL

`DELETE https://localhost:443/category/{id}`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### ResponseBody

#### 删除成功

```
{
    "code": 200,
    "message": "success",
    "data": 4
}
```

#### 二级分类不存在

```
{
    "code": 404,
    "message": "category not found",
}
```

#### 二级分类下存在账单

```
{
    "code": 403,
    "message": "cannot delete category cause there is at least a bill under it",
}
```

## 查找二级分类

### URL

`GET https://localhost:443/category/{id}`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### ResponseBody

#### 查找成功

```
{
    "code": 200,
    "message": "success",
    "data": {
        "id": 1,
        "division": 1,
        "name": "早餐"
    }
}
```

#### 二级分类不存在

```
{
    "code": 404,
    "message": "category not found",
}
```

## 一级分类下的所有二级分类

### URL

`GET https://localhost:443/categories/{division}`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### ResponseBody

#### 成功

```
{
    "code": 200,
    "message": "success",
    "data": [
        {
            "id": 1,
            "division": 1,
            "name": "早餐"
        },
        {
            "id": 2,
            "division": 1,
            "name": "晚餐"
        },
        {
            "id": 3,
            "division": 1,
            "name": "午餐"
        }
    ]
}
```

#### 指定的一级分类不存在

```
{
    "code": 404,
    "message": "division not found",
}
```