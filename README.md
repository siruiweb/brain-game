# 🧠 头脑特工队

**Project: VALHALLA** | 人生365天模拟游戏

---

## 📋 项目信息

| 属性 | 值 |
|------|------|
| **产品名称** | 头脑特工队 |
| **项目代号** | Project: VALHALLA |
| **当前版本** | VALHALLA-II v1.1.0 |

---

## 🛠️ 技术栈

| 组件 | 技术 |
|------|------|
| **前端游戏** | HTML5 / JavaScript ES6+ |
| **后端管理** | ThinkPHP 6.0 / FastAdmin |
| **游戏引擎** | Cocos Creator 3.8.x |

---

## 📁 项目结构

```
brain-game/
├── admin/                 # 后台管理系统
│   ├── app/              # ThinkPHP控制器
│   └── index.html         # 管理页面
├── brain_game.html        # 双语版游戏(直接可玩)
├── GameConfig.js          # 游戏配置
├── GameCore.js           # 核心逻辑
├── GameManager.js        # Cocos版逻辑
└── README.md             # 项目文档
```

---

## 🚀 快速开始

### 游戏版本 (直接可玩)
直接用浏览器打开 `brain_game.html` 即可游玩

### 后台管理系统
需要配置 PHP + MySQL 环境：
```bash
# 安装 ThinkPHP 依赖
composer install

# 配置数据库
# 访问 admin/index.html
```

---

## ✨ VALHALLA-II 新增功能

- 🌍 中英双语切换
- 📖 5大章节剧情
- 😤 6种情绪系统
- 🍚 5种欲望系统
- 🏆 30+成就系统
- 💾 存档/读档

---

## 📖 章节

| 章节 | 天数 | 说明 |
|------|------|------|
| 初入社会 | 0-30 | 刚毕业进入社会 |
| 职场新人 | 30-60 | 工作升职 |
| 创业之路 | 60-100 | 辞职创业 |
| 人生巅峰 | 100-200 | 功成名就 |
| 传奇人生 | 200-365 | 完美人生 |

---

## 🎯 通关条件

- **胜利**: 存活365天
- **失败**: 健康/精神/精力归零、情绪崩溃、没钱

---

**头脑特工队** - 掌控你的情绪，书写完美人生！

GitHub: https://github.com/siruiweb/brain-game
