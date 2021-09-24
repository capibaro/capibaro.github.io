---
layout: post
title: 爱记不记 用户
description: tocountornot user api document
date: 2021-05-03 17:27:47 +0800
excerpt: 爱记不记用户接口文档
---

## 注册

### URL

`POST https://localhost:443/user/register`

### RequestBody

`{"name":"tom","password":"I am tom"}`

### ResponseBody

#### 注册成功

```
{
    "code": 201,
    "message": "created",
}
```

#### 用户名已占用

```
{
    "code": 409,
    "message": "username already taken",
}
```

#### 用户名过长

```
{
    "code": 400,
    "message": "name length cannot exceed 20",
}
```

#### 用户名或密码为空

```
{
    "code": 400,
    "message": "password cannot be blank",
}
```

## 登录

### URL

`POST https://localhost:443/user/login`

### RequestBody

`{"name":"tom","password":"I am tom"}`

### ResponseHeader

`Set-Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### ResponseBody

#### 登录成功

```
{
    "code": 200,
    "message": "success",
}
```

#### 用户不存在

```
{
    "code": 404,
    "message": "user not exist",
}
```

#### 密码错误

```
{
    "code": 403,
    "message": "wrong password",
}
```

## 修改密码

### URL

`PUT https://localhost:443/user`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### RequestBody

`{"name":"tom","password":"I am not tom"}`

### ResponseBody

#### 修改成功

```
{
    "code": 200,
    "message": "success",
}
```

#### 修改用户名

```
{
    "code": 403,
    "message": "cannot modify username",
}
```

#### 无token

```
{
    "code": 400,
    "message": "no token found",
}
```

#### 无效token

```
{
    "code": 400,
    "message": "invalid token",
}
```

#### 失效token

```
{
    "code": 400,
    "message": "expired token",
}
```

## 删除用户

### URL

`DELETE https://localhost:443/user`

### RequestHeader

`Cookie: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyIiwiZXhwIjoxNjI3MDE1MTY1fQ.iLAL7lqJDok6HAev5BXuAHfdqnN43dsYGJc8-EdEYao`

### ResponseBody

#### 删除成功

```
{
    "code": 200,
    "message": "success",
}
```

#### 用户下存在账户

```
{
    "code": 403,
    "message": "cannot delete user cause there is at least a card under it"
}
```

#### 用户下存在成员

```
{
    "code": 403,
    "message": "cannot delete user cause there is at least a member under it"
}
```

#### 用户下存在一级分类 

```
{
    "code": 403,
    "message": "cannot delete user cause there is at least a division under it"
}
```