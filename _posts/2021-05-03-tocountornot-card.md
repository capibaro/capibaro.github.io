---
layout: post
title: 爱记不记 账户
description: tocountornot card api document
date: 2021-05-03 11:32:51 +0800
excerpt: 爱记不记账户接口文档
---

## 新增账户

### URL

`POST https://localhost:443/card`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### RequestBody

`{"name":"现金"}`

### ResponseBody

#### 新增成功

```
{
    "code": 201,
    "message": "created",
    "data": 1
}
```

#### 账户名过长

```
{
    "code": 400,
    "message": "name length cannot exceed 20",
}
```

#### 账户名为空

```
{
    "code": 400,
    "message": "name cannot be blank",
}
```

## 修改账户

### URL

`PUT https://localhost:443/card/{id}`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### RequestBody

`{"name":"零钱"}`

### ResponseBody

#### 修改成功

```
{
    "code": 200,
    "message": "success",
    "data": 1
}
```

#### 账户不存在

```
{
    "code": 404,
    "message": "card not found",
}
```

## 删除账户

### URL

`DELETE https://localhost:443/card/{id}`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### ResponseBody

#### 删除成功

```
{
    "code": 200,
    "message": "success",
    "data": 1
}
```

#### 账户不存在

```
{
    "code": 404,
    "message": "card not found",
}
```

#### 账户下存在账单

```
{
    "code": 403,
    "message": "cannot delete card cause there is at least a bill under it",
}
```

## 查找账户

### URL

`GET https://localhost:443/card/{id}`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### ResponseBody

#### 查找成功

```
{
    "code": 200,
    "message": "success",
    "data": {
        "id": 2,
        "name": "微信"
    }
}
```

#### 账户不存在

```
{
    "code": 404,
    "message": "card not found",
}
```

## 所有账户

### URL

`GET https://localhost:443/cards`

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
            "name": "现金"
        },
        {
            "id": 2,
            "name": "微信"
        },
        {
            "id": 3,
            "name": "支付宝"
        }
    ]
}
```