/**
 * 七情六欲大脑模拟器 - 精品完整版
 * Cocos Creator 2.x
 */

cc.Class({
    extends: cc.Component,

    properties: {
        // UI组件引用
        dayLabel: cc.Label,
        chapterLabel: cc.Label,
        healthLabel: cc.Label,
        mentalLabel: cc.Label,
        energyLabel: cc.Label,
        moneyLabel: cc.Label,
        
        // 预制体
        actionButtonPrefab: cc.Prefab,
        emotionBarPrefab: cc.Prefab,
        
        // 容器
        emotionContainer: cc.Node,
        desireContainer: cc.Node,
        actionContainer: cc.Node,
        logContainer: cc.Node,
        achievementContainer: cc.Node,
        
        // 游戏状态
        gameData: {
            day: 1,
            chapter: 1,
            health: 100,
            mentalHealth: 100,
            energy: 100,
            money: 1000,
            reputation: 50,
            talent: null,
            countdown: 30,
            achievements: [],
            
            emotions: {
                joy: 50, anger: 30, sad: 30, fear: 20, love: 60, hate: 25
            },
            
            desires: {
                food: 60, money: 70, fame: 50, sleep: 55, play: 65
            },
            
            history: []
        }
    },

    onLoad: function() {
        this.loadGame();
        this.initUI();
        this.startGameLoop();
        
        this.addLog("🎮 欢迎来到七情六欲大脑模拟器!");
    },

    // ==================== 游戏循环 ====================
    startGameLoop: function() {
        this.schedule(this.onTick, 1);
    },

    onTick: function() {
        if (this.gameData.countdown > 0) {
            this.gameData.countdown--;
            this.updateTimerUI();
        } else {
            this.triggerRandomEvent();
            this.nextDay();
            this.gameData.countdown = 30;
        }
    },

    nextDay: function() {
        this.gameData.day++;
        
        // 自然变化
        this.gameData.emotions.joy = this.clamp(this.gameData.emotions.joy - 2, 0, 100);
        this.gameData.desires.food = this.clamp(this.gameData.desires.food - 5, 0, 100);
        this.gameData.desires.sleep = this.clamp(this.gameData.desires.sleep - 8, 0, 100);
        this.gameData.energy = this.clamp(this.gameData.energy + 10, 0, 100);
        
        // 检查章节
        this.checkChapter();
        
        // 检查成就
        this.checkAchievements();
        
        // 检查游戏结束
        this.checkGameOver();
        
        this.saveGame();
        this.updateUI();
    },

    // ==================== 行动系统 ====================
    performAction: function(actionData) {
        if (this.gameData.money < actionData.cost) {
            this.addLog("💸 金钱不足!");
            return false;
        }
        
        this.gameData.money -= actionData.cost;
        this.applyEffects(actionData.effects);
        
        this.addLog("📅 第" + this.gameData.day + "天 - " + actionData.name);
        
        this.checkAchievements();
        this.checkGameOver();
        
        return true;
    },

    applyEffects: function(effects) {
        for (var key in effects) {
            var value = effects[key];
            
            if (key in this.gameData.emotions) {
                this.gameData.emotions[key] = this.clamp(this.gameData.emotions[key] + value, 0, 100);
            } else if (key in this.gameData.desires) {
                this.gameData.desires[key] = this.clamp(this.gameData.desires[key] + value, 0, 100);
            } else if (key === 'money') {
                this.gameData.money = Math.max(0, this.gameData.money + value);
            } else if (key === 'health') {
                this.gameData.health = this.clamp(this.gameData.health + value, 0, 120);
            } else if (key === 'mentalHealth') {
                this.gameData.mentalHealth = this.clamp(this.gameData.mentalHealth + value, 0, 100);
            } else if (key === 'energy') {
                this.gameData.energy = this.clamp(this.gameData.energy + value, 0, 100);
            } else if (key === 'reputation') {
                this.gameData.reputation = this.clamp(this.gameData.reputation + value, 0, 100);
            }
        }
    },

    // ==================== 随机事件 ====================
    triggerRandomEvent: function() {
        if (Math.random() > 0.4) return;
        
        var events = [
            { text: "🌧️ 下雨天...", effects: { sad: 10, joy: -5 } },
            { text: "☀️ 阳光明媚!", effects: { joy: 10, sad: -5 } },
            { text: "💼 工作压力大!", effects: { anger: 10, sleep: -10 } },
            { text: "🎂 有人生日!", effects: { joy: 15, money: -10 } },
            { text: "🐔 遇到骗子!", effects: { money: -20, anger: 15 } },
            { text: "💪 健身成功!", effects: { joy: 10, health: 10 } },
            { text: "📱 手机坏了!", effects: { anger: 20, money: -10 } },
            { text: "💔 分手!", effects: { love: -30, sad: 25, mentalHealth: -15 } },
            { text: "🎉 中彩票!", effects: { joy: 35, money: 500 } },
            { text: "📚 读完一本书!", effects: { money: 10, joy: 10 } },
            { text: "😴 失眠...", effects: { sleep: -25, energy: -15 } },
            { text: "🤒 生病!", effects: { health: -20, money: -50 } }
        ];
        
        var event = events[Math.floor(Math.random() * events.length)];
        this.applyEffects(event.effects);
        this.addLog("📅 第" + this.gameData.day + "天 - " + event.text);
    },

    // ==================== 章节系统 ====================
    checkChapter: function() {
        var chapters = [
            { id: 1, name: "初入社会", target: 30 },
            { id: 2, name: "职场新人", target: 60 },
            { id: 3, name: "创业之路", target: 100 },
            { id: 4, name: "人生巅峰", target: 200 },
            { id: 5, name: "传奇人生", target: 365 }
        ];
        
        var currentChapter = chapters[this.gameData.chapter - 1];
        
        if (this.gameData.day >= currentChapter.target && this.gameData.chapter < 5) {
            this.gameData.chapter++;
            this.addLog("📖 进入第" + this.gameData.chapter + "章: " + chapters[this.gameData.chapter - 1].name);
            this.unlockAchievement("chapter" + this.gameData.chapter);
        }
    },

    // ==================== 成就系统 ====================
    checkAchievements: function() {
        var checks = [
            ["day10", this.gameData.day >= 10],
            ["day30", this.gameData.day >= 30],
            ["day100", this.gameData.day >= 100],
            ["day365", this.gameData.day >= 365],
            ["money1k", this.gameData.money >= 1000],
            ["money10k", this.gameData.money >= 10000],
            ["money100k", this.gameData.money >= 100000],
            ["millionaire", this.gameData.money >= 1000000],
            ["rich", this.gameData.money >= 10000000],
            ["health100", this.gameData.health >= 100]
        ];
        
        var self = this;
        checks.forEach(function(check) {
            if (check[1] && !self.gameData.achievements.includes(check[0])) {
                self.unlockAchievement(check[0]);
            }
        });
    },

    unlockAchievement: function(id) {
        if (this.gameData.achievements.includes(id)) return;
        
        this.gameData.achievements.push(id);
        
        var achievementNames = {
            "day10": "🌱 生存10天",
            "day30": "🌿 生存30天",
            "day100": "🌳 生存100天",
            "day365": "👑 生存365天",
            "money1k": "💵 千元户",
            "money10k": "💰 万元户",
            "money100k": "💎 十万富翁",
            "millionaire": "🏦 百万富翁",
            "rich": "👑 千万富翁",
            "health100": "💪 百岁老人",
            "chapter1": "📖 初入社会",
            "chapter2": "📗 职场新人",
            "chapter3": "📘 创业之路",
            "chapter4": "📙 人生巅峰",
            "chapter5": "📕 传奇人生"
        };
        
        this.addLog("🏆 成就解锁: " + (achievementNames[id] || id) + "!");
    },

    // ==================== 游戏结束 ====================
    checkGameOver: function() {
        var reason = "";
        var isWin = false;
        
        if (this.gameData.health <= 0) {
            reason = "💀 身体垮掉了!";
        } else if (this.gameData.mentalHealth <= 0) {
            reason = "💀 心理崩溃了!";
        } else if (this.gameData.energy <= 0) {
            reason = "💀 累死了!";
        } else if (this.gameData.emotions.anger > 95) {
            reason = "💀 气死了!";
        } else if (this.gameData.em 95) {
            reason = "💀 抑郁死了!";
       otions.sad > } else if (this.gameData.money <= 0 && this.gameData.day > 10) {
            reason = "💀 穷死了!";
        } else if (this.gameData.day >= 365) {
            isWin = true;
            reason = "🎉 恭喜通关!";
        }
        
        if (reason) {
            this.unscheduleAllCallbacks();
            this.showGameOver(reason, isWin);
        }
    },

    showGameOver: function(reason, isWin) {
        // 这里可以切换到游戏结束场景
        cc.log("Game Over: " + reason);
        cc.log("存活天数: " + this.gameData.day);
        cc.log("成就数量: " + this.gameData.achievements.length);
    },

    // ==================== UI ====================
    initUI: function() {
        this.createEmotionBars();
        this.createDesireBars();
        this.createActionButtons();
        this.updateUI();
    },

    createEmotionBars: function() {
        // 情绪配置
        var emotions = [
            { key: "joy", icon: "😄", name: "喜", color: cc.Color.YELLOW },
            { key: "anger", icon: "😤", name: "怒", color: cc.Color.RED },
            { key: "sad", icon: "😢", name: "哀", color: new cc.Color(108, 92, 231) },
            { key: "fear", icon: "😰", name: "惧", color: new cc.Color(162, 155, 254) },
            { key: "love", icon: "❤️", name: "爱", color: new cc.Color(253, 121, 168) },
            { key: "hate", icon: "🤢", name: "恶", color: new cc.Color(99, 110, 114) }
        ];
        
        // 动态创建情绪条
        // 实际项目中通过预制体实例化
    },

    createDesireBars: function() {
        // 欲望配置
        var desires = [
            { key: "food", icon: "🍔", name: "食欲", color: new cc.Color(225, 112, 85) },
            { key: "money", icon: "💰", name: "财欲", color: new cc.Color(253, 203, 110) },
            { key: "fame", icon: "🏆", name: "名欲", color: new cc.Color(116, 185, 255) },
            { key: "sleep", icon: "😴", name: "睡欲", color: new cc.Color(162, 155, 254) },
            { key: "play", icon: "🎮", name: "玩欲", color: new cc.Color(85, 239, 196) }
        ];
        
        // 动态创建欲望条
    },

    createActionButtons: function() {
        // 行动配置
        var actions = {
            emotions: [
                { name: "💰 赚钱", cost: 0, effects: { joy: 15, money: 30, sleep: -5 } },
                { name: "🎮 玩游戏", cost: 10, effects: { joy: 20, play: 15, money: -10, sleep: -5 } },
                { name: "🏋️ 健身", cost: 20, effects: { anger: -20, health: 10, energy: -10 } },
                { name: "🧘 冥想", cost: 0, effects: { anger: -25, mentalHealth: 15, sleep: 5 } },
                { name: "😢 哭一场", cost: 0, effects: { sad: -15, mentalHealth: 5 } },
                { name: "🍔 美食", cost: 30, effects: { sad: -10, food: 25, money: -30, joy: 10 } },
                { name: "❤️ 告白", cost: 0, effects: { love: 25, joy: 20, fear: 15, reputation: 5 } },
                { name: "💕 约会", cost: 100, effects: { love: 30, money: -100, joy: 25 } }
            ],
            desires: [
                { name: "🍔 吃饭", cost: 20, effects: { food: 35, joy: 10, money: -20, health: 5 } },
                { name: "💵 省钱", cost: 0, effects: { money: 20, joy: 5 } },
                { name: "💼 工作", cost: 0, effects: { money: 100, energy: -30, sleep: -15 } },
                { name: "🏆 比赛", cost: 30, effects: { fame: 30, joy: 25, money: -30 } },
                { name: "😴 睡觉", cost: 0, effects: { sleep: 50, energy: 40, health: 10 } },
                { name: "🎮 玩游戏", cost: 20, effects: { play: 35, joy: 25, money: -20, sleep: -10 } },
                { name: "✈️ 旅游", cost: 500, effects: { play: 50, joy: 40, money: -500, energy: -20 } },
                { name: "💊 保健品", cost: 100, effects: { health: 20 } }
            ],
            social: [
                { name: "👥 交朋友", cost: 0, effects: { joy: 15, reputation: 10 } },
                { name: "🎂 聚会", cost: 50, effects: { joy: 30, love: 20, money: -50 } },
                { name: "🎁 送礼", cost: 50, effects: { reputation: 20, money: -50, love: 10 } }
            ],
            health: [
                { name: "🏃 跑步", cost: 0, effects: { health: 15, energy: -15, joy: 10 } },
                { name: "🧘 瑜伽", cost: 20, effects: { health: 10, mentalHealth: 15 } },
                { name: "🏋️ 健身房", cost: 50, effects: { health: 20, money: -50, energy: -20 } },
                { name: "🏥 看病", cost: 50, effects: { health: 30, money: -50 } }
            ]
        };
        
        // 动态创建按钮
    },

    updateUI: function() {
        if (this.dayLabel) {
            this.dayLabel.string = "第" + this.gameData.day + "天";
        }
        
        if (this.chapterLabel) {
            var chapterNames = ["初入社会", "职场新人", "创业之路", "人生巅峰", "传奇人生"];
            this.chapterLabel.string = "第" + this.gameData.chapter + "章 " + chapterNames[this.gameData.chapter - 1];
        }
        
        if (this.healthLabel) {
            this.healthLabel.string = "❤️ " + Math.round(this.gameData.health) + "%";
        }
        
        if (this.mentalLabel) {
            this.mentalLabel.string = "🧠 " + Math.round(this.gameData.mentalHealth) + "%";
        }
        
        if (this.energyLabel) {
            this.energyLabel.string = "⚡ " + Math.round(this.gameData.energy) + "%";
        }
        
        if (this.moneyLabel) {
            this.moneyLabel.string = "💰 " + this.gameData.money;
        }
    },

    updateTimerUI: function() {
        // 更新计时器UI
    },

    addLog: function(text) {
        cc.log(text);
        this.gameData.history.unshift({
            day: this.gameData.day,
            text: text,
            time: Date.now()
        });
        
        // 限制历史长度
        if (this.gameData.history.length > 50) {
            this.gameData.history.pop();
        }
    },

    // ==================== 存档 ====================
    saveGame: function() {
        var saveData = {
            gameData: this.gameData,
            saveTime: Date.now()
        };
        cc.sys.localStorage.setItem("brainSimulatorSave", JSON.stringify(saveData));
    },

    loadGame: function() {
        var saved = cc.sys.localStorage.getItem("brainSimulatorSave");
        if (saved) {
            var saveData = JSON.parse(saved);
            this.gameData = saveData.gameData || this.gameData;
            cc.log("游戏已加载");
        }
    },

    // ==================== 工具 ====================
    clamp: function(value, min, max) {
        return Math.max(min, Math.min(max, value));
    }
});
