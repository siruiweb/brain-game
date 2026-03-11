# FastAdmin 安装指南

## 环境要求

| 环境 | 版本 |
|------|------|
| PHP | >= 7.2.5 |
| MySQL | >= 5.7 |
| Apache/Nginx | - |
| Composer | >= 1.0 |

## 快速安装

### 方式一：Composer 安装（推荐）

```bash
# 1. 安装 Composer
# https://getcomposer.org/download/

# 2. 创建项目
composer create-project fastadmin/fastadmin brain-admin

# 3. 进入目录
cd brain-admin

# 4. 配置数据库
# 修改 application/database.php
```

### 方式二：完整包安装

```bash
# 1. 下载完整包
# https://www.fastadmin.net/download.html

# 2. 解压到网站目录

# 3. 访问安装
# http://localhost/brain-admin/
```

## 数据库配置

修改 `application/database.php`:

```php
<?php
return [
    'type'            => 'mysql',
    'hostname'        => '127.0.0.1',
    'database'        => 'brain_game',
    'username'        => 'root',
    'password'        => '',
    'hostport'        => '3306',
    'params'          => [],
    'charset'         => 'utf8mb4',
    'prefix'          => 'fa_',
];
```

## 伪静态配置

### Nginx

```nginx
location / {
    if (!-e $request_filename) {
        rewrite ^(.*)$ /index.php?s=$1 last;
        break;
    }
}
```

### Apache (.htaccess 已内置)

## 初始化数据

访问后台: `/admin`

初始账号: `admin`  
初始密码: `123456`

## 游戏后台模块

安装完成后，将 `application` 目录下的模块复制到FastAdmin的 `application` 目录即可。
