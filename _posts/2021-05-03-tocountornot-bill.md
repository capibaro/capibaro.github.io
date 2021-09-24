---
layout: post
title: 爱记不记 账单
description: tocountornot bill api document
date: 2021-05-03 10:21:41 +0800
excerpt: 爱记不记账单接口文档
---

## 新增账单

### URL

`POST https://localhost:443/bill`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### RequestBody

```
{
    "card": "2",
    "member": "1",
    "category": "3",
    "price": "12.00",
    "type": "1",
    "time": "1624857024"
}
```

### ResponseBody

#### 新建成功

```
{
    "code": 201,
    "message": "created",
    "data": 1
}
```

#### 账户为空或不存在

```
{
    "code": 400,
    "message": "card cannot be null",
}
```

{
    "code": 404,
    "message": "card not found",
}

#### 成员为空或不存在

```
{
    "code": 400,
    "message": "member cannot be null",
}
```

```
{
    "code": 404,
    "message": "member not found",
}
```

#### 二级分类为空或不存在

```
{
    "code": 400,
    "message": "category cannot be null",
}
```

```
{
    "code": 404,
    "message": "member not found",
}
```

#### 金额为空或不合法

```
{
    "code": 400,
    "message": "price cannot be null",
}
```

```
{
    "code": 400,
    "message": "price should have no more than 9 integer digits or 2 decimal digits",
}
```

```
{
    "code": 400,
    "message": "price cannot be less than zero",
}
```

#### 类型为空或不合法

```
{
    "code": 400,
    "message": "type cannot be null",
}
```

```
{
    "code": 400,
    "message": "type should be 0(income) 1(expense) or 2(transfer)",
}
```

#### 时间戳为空或不合法

```
{
    "code": 400,
    "message": "time cannot be null",
}
```

```
{
    "code": 400,
    "message": "time cannot be a future time",
}
```

## 修改账单

### URL

`PUT https://localhost:443/bill/{id}`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### RequestBody

#### 修改成功

```
{
    "card": "2",
    "member": "1",
    "category": "3",
    "price": "12.00",
    "type": "1",
    "time": "1625130521000"
}
```

#### 账单不存在

```
{
    "code": 404,
    "message": "bill not found",
}
```

#### 修改账户成员或二级分类

```
{
    "code": 403,
    "message": "cannot modify card member or category",
}
```

## 删除账单

### URL

`DELETE https://localhost:443/bill/{id}`

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

#### 账单不存在

```
{
    "code": 404,
    "message": "bill not found",
}
```

## 查找账单

### URL

`GET https://localhost:443/bill/{id}`

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
        "card": 2,
        "member": 1,
        "category": 2,
        "price": 15,
        "type": 1,
        "time": "2021-04-30T09:08:41.000+00:00"
    }
}
```

#### 账单不存在

```
{
    "code": 404,
    "message": "bill not found",
}
```