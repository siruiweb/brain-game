# 🎮 通用游戏后台管理系统

**GameAdmin Pro** | 支持任意游戏

---

## 📋 系统信息

| 属性 | 值 |
|------|------|
| **系统名称** | GameAdmin Pro |
| **版本** | v1.0.0 |
| **框架** | ThinkPHP 6.0 / FastAdmin |
| **适用** | 任意游戏 |

---

## 🛠️ 技术栈

| 组件 | 技术 |
|------|------|
| **后端** | ThinkPHP 6.0 / FastAdmin |
| **前端** | Bootstrap 5 + jQuery |
| **数据库** | MySQL 5.7+ |
| **缓存** | Redis |

---

## 📁 项目结构

```
admin/
├── app/
│   ├── controller/
│   │   ├── IndexController.php   # 仪表盘
│   │   ├── GameController.php   # 游戏管理
│   │   └── PlayerController.php # 玩家管理
│   └── model/
│       └── GameModel.php       # 游戏模型
├── public/
│   ├── index.html            # 管理页面
│   └── assets/               # 静态资源
└── README.md
```

---

## 🎮 支持的游戏模块

| 模块 | 功能 | 示例游戏 |
|------|------|----------|
| 🌟 天赋系统 | 角色天赋/属性 | 头脑特工队 |
| 🎯 关卡系统 | 关卡配置 | 益智拼图 |
| 🎁 道具系统 | 物品/装备 | 卡牌RPG |
| 🛒 商城系统 | 充值/内购 | 所有游戏 |
| 📖 章节系统 | 剧情推进 | 头脑特工队 |
| 🏆 成就系统 | 任务/成就 | 所有游戏 |
| 🎰 抽卡系统 | 抽奖/扭蛋 | 卡牌游戏 |
| 🎉 活动系统 | 限时活动 | 所有游戏 |
| 📧 邮件系统 | 道具发放 | 所有游戏 |
| 📊 排行榜 | 排名系统 | 竞技游戏 |

---

## 🎯 添加新游戏

只需在数据库添加游戏记录，系统会自动生成对应的配置界面：

```php
// 添加新游戏
$game = GameModel::create([
    'game_key' => 'my_game',
    'game_name' => '我的游戏',
    'codename' => 'PROJECT_X',
    'version' => 'v1.0.0',
    'icon' => '🎮',
    'config' => json_encode([
        'modules' => ['talent', 'level', 'item', 'shop']
    ])
]);
```

---

## 📊 数据统计

- 总游戏数
- 总玩家数
- 活跃玩家
- 收入报表
- 用户分析

---

## 🚀 快速开始

```bash
# 1. 克隆项目
git clone https://github.com/siruiweb/brain-game.git

# 2. 安装依赖
composer install

# 3. 配置数据库
# 修改 .env 文件

# 4. 访问后台
# 打开 admin/index.html
```

---

## 📝 版本

| 版本 | 日期 | 说明 |
|------|------|------|
| v1.0.0 | 2026-03-11 | 初版发布 |

---

**通用游戏后台管理系统** - 一次开发，重复使用！

GitHub: https://github.com/siruiweb/brain-game
