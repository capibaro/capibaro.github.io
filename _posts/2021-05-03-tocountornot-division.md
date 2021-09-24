---
layout: post
title: 爱记不记 一级分类
description: tocountornot division api document
date: 2021-05-03 14:26:18 +0800
excerpt: 爱记不记一级分类接口文档
---

## 新增一级分类

### URL

`POST https://localhost:443/division`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### RequestBody

`{"name":"饮食"}`

### ResponseBody

#### 新增成功

```
{
    "code": 201,
    "message": "created",
    "data": 1
}
```

#### 一级分类名过长

```
{
    "code": 400,
    "message": "name length cannot exceed 10",
}
```

#### 一级分类名为空

```
{
    "code": 400,
    "message": "name cannot be blank",
}
```

## 修改一级分类

### URL

`PUT https://localhost:443/division/{id}`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### RequestBody

`{"name":"日用"}`

### ResponseBody

#### 修改成功

```
{
    "code": 200,
    "message": "success",
    "data": 3
}
```

#### 一级分类不存在

```
{
    "code": 404,
    "message": "division not found",
}
```

## 删除一级分类

### URL

`DELETE https://localhost:443/division/{id}`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### ResponseBody

#### 删除成功

```
{
    "code": 200,
    "message": "success",
    "data": 3
}
```

#### 一级分类不存在

```
{
    "code": 404,
    "message": "division not found",
}
```

#### 一级分类下存在二级分类

```
{
    "code": 403,
    "message": "cannot delete division cause there is at least a category under it",
}
```

## 查找一级分类

### URL

`GET https://localhost:443/division/{id}`

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
        "name": "出行"
    }
}
```

#### 一级分类不存在

```
{
    "code": 404,
    "message": "division not found",
}
```

## 所有一级分类

### URL

`GET https://localhost:443/divisions`

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
            "name": "饮食"
        },
        {
            "id": 2,
            "name": "出行"
        }
    ]
}
```