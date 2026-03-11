# 🎮 通用游戏后台管理系统

**GameAdmin Pro** | 基于 FastAdmin

---

## 📋 系统信息

| 属性 | 值 |
|------|------|
| **系统名称** | GameAdmin Pro |
| **版本** | v1.0.0 |
| **框架** | FastAdmin (ThinkPHP 5.1) |
| **适用** | 任意游戏 |

---

## 🛠️ 技术栈

| 组件 | 技术 |
|------|------|
| **后端** | FastAdmin / ThinkPHP 5.1 |
| **前端** | Bootstrap 3/jQuery |
| **数据库** | MySQL 5.7+ |
| **PHP** | >= 7.2.5 |

---

## 📁 项目结构

```
admin/
├── application/           # FastAdmin应用
│   └── admin/
│       ├── controller/    # 控制器
│       │   └── game/
│       │       └── Game.php
│       └── model/         # 模型
│           └── game/
│               └── Game.php
├── install.sql            # 数据库脚本
├── fastadmin.html        # 离线预览版
├── INSTALL.md            # 安装指南
└── README.md
```

---

## 🚀 安装步骤

### 1. 环境要求
- PHP >= 7.2.5
- MySQL >= 5.7
- Composer

### 2. 安装 FastAdmin

```bash
# 方式一：Composer
composer create-project fastadmin/fastadmin brain-admin

# 方式二：下载完整包
# https://www.fastadmin.net/download.html
```

### 3. 导入数据

```bash
# 创建数据库
mysql -u root -p create brain_game;

# 导入SQL
mysql -u root -p brain_game < admin/install.sql
```

### 4. 复制游戏模块

将 `admin/application` 下的文件复制到FastAdmin对应目录。

### 5. 访问后台

- 地址: `/admin`
- 账号: `admin`
- 密码: `123456`

---

## 📊 功能模块

| 模块 | 说明 |
|------|------|
| 🎮 游戏管理 | 游戏列表/添加/编辑/删除 |
| 🌟 天赋配置 | 游戏天赋设置 |
| 📖 章节配置 | 剧情章节设置 |
| ⚡ 行动配置 | 玩家行动设置 |
| 🏆 成就配置 | 成就系统设置 |
| 👥 玩家管理 | 玩家数据管理 |

---

## 🗃️ 数据库表

| 表名 | 说明 |
|------|------|
| fa_game | 游戏表 |
| fa_game_talent | 天赋表 |
| fa_game_chapter | 章节表 |
| fa_game_action | 行动表 |
| fa_game_achievement | 成就表 |
| fa_game_player | 玩家表 |

---

## 📝 快速预览

不想安装PHP环境？可以先预览效果：

直接打开 `admin/fastadmin.html` 查看离线版！

---

## 🎯 添加新游戏

在后台直接添加游戏记录，系统会自动管理：

```php
// 数据库直接添加
INSERT INTO fa_game (game_key, game_name, codename, version, icon) 
VALUES ('my_game', '我的游戏', 'PROJECT_X', 'v1.0.0', '🎮');
```

---

## 📝 版本

| 版本 | 日期 | 说明 |
|------|------|------|
| v1.0.0 | 2026-03-11 | 初版发布 |

---

**通用游戏后台管理系统** - 一次开发，重复使用！

GitHub: https://github.com/siruiweb/brain-game
