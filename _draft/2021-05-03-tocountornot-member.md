---
layout: post
title: 成员
description: tocountornot member api document
category: to-count-or-not
tag: document
date: 2021-05-03 16:25:18 +0800
excerpt: 爱记不记成员接口文档
---

## 新增成员

### URL

`POST https://localhost:443/member`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### RequestBody

`{"name":"我"}`

### ResponseBody

#### 新增成功

```
{
    "code": 201,
    "message": "created",
    "data": 1
}
```

#### 成员名过长

```
{
    "code": 400,
    "message": "name length cannot exceed 10",
}
```

#### 成员名为空

```
{
    "code": 400,
    "message": "name cannot be blank",
}
```

## 修改成员

### URL

`PUT https://localhost:443/member/{id}`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### RequestBody

`{"name":"自己"}`

### ResponseBody

#### 修改成功

```
{
    "code": 200,
    "message": "success",
    "data": 1
}
```

#### 成员不存在

```
{
    "code": 404,
    "message": "member not found",
}
```

## 删除成员

### URL

`DELETE https://localhost:443/member/{id}`

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

#### 成员不存在

```
{
    "code": 404,
    "message": "member not found",
}
```

#### 成员下存在账单

```
{
    "code": 403,
    "message": "cannot delete member cause there is at least a bill under it",
}
```

## 查找成员

### URL

`GET https://localhost:443/member/{id}`

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
        "name": "我"
    }
}
```

#### 成员不存在

```
{
    "code": 404,
    "message": "member not found",
}
```

## 所有成员

### URL

`GET https://localhost:443/members`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### ResponseBody

```
{
    "code": 200,
    "message": "success",
    "data": [
        {
            "id": 1,
            "name": "我"
        },
        {
            "id": 2,
            "name": "爸爸"
        },
        {
            "id": 3,
            "name": "妈妈"
        }
    ]
}
```