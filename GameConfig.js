/**
 * 🧠 Brain Agent - 头脑特工队
 * Project: VALHALLA
 * Bilingual Version (中英双语)
 */

const GameConfig = {
    // ==================== 版本信息 ====================
    project: {
        name: { zh: "头脑特工队", en: "Brain Agent" },
        codename: "VALHALLA",
        version: "1.1.0",
        codename_v: "VALHALLA-II"
    },

    // ==================== 语言配置 ====================
    language: "zh", // 默认中文

    // ==================== 双语文本 ====================
    i18n: {
        // 菜单
        menu: {
            newGame: { zh: "新游戏", en: "New Game" },
            continue: { zh: "继续游戏", en: "Continue" },
            achievements: { zh: "成就", en: "Achievements" },
            settings: { zh: "设置", en: "Settings" },
            exit: { zh: "退出", en: "Exit" }
        },
        
        // 天赋
        talent: {
            title: { zh: "选择天赋", en: "Select Talent" },
            start: { zh: "开始游戏", en: "Start Game" }
        },
        
        // 属性
        stats: {
            day: { zh: "第{0}天", en: "Day {0}" },
            health: { zh: "生命", en: "Health" },
            mental: { zh: "精神", en: "Mental" },
            energy: { zh: "精力", en: "Energy" },
            money: { zh: "金钱", en: "Money" },
            reputation: { zh: "声望", en: "Reputation" }
        },
        
        // 情绪
        emotions: {
            joy: { zh: "喜", en: "Joy" },
            anger: { zh: "怒", en: "Anger" },
            sad: { zh: "哀", en: "Sad" },
            fear: { zh: "惧", en: "Fear" },
            love: { zh: "爱", en: "Love" },
            hate: { zh: "恶", en: "Hate" }
        },
        
        // 欲望
        desires: {
            food: { zh: "食欲", en: "Appetite" },
            money: { zh: "财欲", en: "Greed" },
            fame: { zh: "名欲", en: "Fame" },
            sleep: { zh: "睡欲", en: "Sleep" },
            play: { zh: "玩欲", en: "Play" }
        },
        
        // 章节
        chapters: [
            { zh: "初入社会", en: "Enter Society" },
            { zh: "职场新人", en: "Work新人" },
            { zh: "创业之路", en: "Entrepreneurship" },
            { zh: "人生巅峰", en: "Peak of Life" },
            { zh: "传奇人生", en: "Legendary Life" }
        ],
        
        // 行动分类
        actions: {
            emotions: { zh: "情绪", en: "Emotions" },
            desires: { zh: "欲望", en: "Desires" },
            social: { zh: "社交", en: "Social" },
            health: { zh: "健康", en: "Health" },
            work: { zh: "工作", en: "Work" }
        },
        
        // 系统
        system: {
            save: { zh: "存档", en: "Save" },
            load: { zh: "读档", en: "Load" },
            settings: { zh: "设置", en: "Settings" },
            language: { zh: "语言", en: "Language" },
            back: { zh: "返回", en: "Back" }
        },
        
        // 游戏结果
        gameover: {
            title: { zh: "游戏结束", en: "Game Over" },
            win: { zh: "通关成功!", en: "You Win!" },
            reason: { zh: "原因: {0}", en: "Reason: {0}" },
            days: { zh: "存活: {0}天", en: "Survived: {0} days" },
            restart: { zh: "再来一次", en: "Restart" }
        }
    },

    // ==================== 天赋系统 ====================
    talents: {
        lucky: { name: { zh: "🌟 天选之人", en: "🌟 Lucky Star" }, desc: { zh: "正面效果+10%", en: "Positive effects +10%" } },
        rich: { name: { zh: "🏠 富二代", en: "🏠 Rich Kid" }, desc: { zh: "初始金钱+5000", en: "Start money +5000" } },
        genius: { name: { zh: "🧠 天才", en: "🧠 Genius" }, desc: { zh: "学习效率+20%", en: "Learning +20%" } },
        healthy: { name: { zh: "💪 体育健将", en: "💪 Athlete" }, desc: { zh: "健康上限+20", en: "Max health +20" } },
        charmer: { name: { zh: "💕 万人迷", en: "💕 Charmer" }, desc: { zh: "魅力+20%", en: "Charm +20%" } },
        zen: { name: { zh: "🧘 禅师", en: "🧘 Zen Master" }, desc: { zh: "负面效果-20%", en: "Negative -20%" } },
        gambler: { name: { zh: "🎰 赌徒", en: "🎰 Gambler" }, desc: { zh: "投资回报+30%", en: "Investment +30%" } }
    },

    // ==================== 章节配置 ====================
    chapters: [
        { id: 1, target: 30, missions: ["first_job", "first_salary", "make_friend"] },
        { id: 2, target: 60, missions: ["promotion", "skill_up", "find_lover"] },
        { id: 3, target: 100, missions: ["start_company", "first_customer", "team_build"] },
        { id: 4, target: 200, missions: ["company_ipo", "family", "legacy"] },
        { id: 5, target: 365, missions: ["legend", "perfect_life"] }
    ],

    // ==================== 行动定义 ====================
    actions: {
        emotions: [
            { n: { zh: "💰 赚钱", en: "💰 Earn Money" }, c: 0, e: { joy: 15, money: 30, sleep: -5 } },
            { n: { zh: "🎮 玩游戏", en: "🎮 Play Games" }, c: 10, e: { joy: 20, play: 15, money: -10, sleep: -5 } },
            { n: { zh: "🏋️ 健身", en: "🏋️ Exercise" }, c: 20, e: { anger: -20, health: 10, energy: -10 } },
            { n: { zh: "🧘 冥想", en: "🧘 Meditate" }, c: 0, e: { anger: -25, mental: 15, sleep: 5 } },
            { n: { zh: "😢 哭一场", en: "😢 Cry" }, c: 0, e: { sad: -15, mental: 5 } },
            { n: { zh: "🍔 美食", en: "🍔 Good Food" }, c: 30, e: { sad: -10, food: 25, money: -30, joy: 10 } },
            { n: { zh: "❤️ 告白", en: "❤️ Confess" }, c: 0, e: { love: 25, joy: 20, fear: 15, reputation: 5 } },
            { n: { zh: "💕 约会", en: "💕 Date" }, c: 100, e: { love: 30, money: -100, joy: 25 } }
        ],
        desires: [
            { n: { zh: "🍔 吃饭", en: "🍔 Eat" }, c: 20, e: { food: 35, joy: 10, money: -20, health: 5 } },
            { n: { zh: "💵 省钱", en: "💵 Save Money" }, c: 0, e: { money: 20, joy: 5 } },
            { n: { zh: "💼 工作", en: "💼 Work" }, c: 0, e: { money: 100, energy: -30, sleep: -15 } },
            { n: { zh: "🏆 比赛", en: "🏆 Competition" }, c: 30, e: { fame: 30, joy: 25, money: -30 } },
            { n: { zh: "😴 睡觉", en: "😴 Sleep" }, c: 0, e: { sleep: 50, energy: 40, health: 10 } },
            { n: { zh: "🎮 玩游戏", en: "🎮 Gaming" }, c: 20, e: { play: 35, joy: 25, money: -20, sleep: -10 } },
            { n: { zh: "✈️ 旅游", en: "✈️ Travel" }, c: 500, e: { play: 50, joy: 40, money: -500, energy: -20 } },
            { n: { zh: "💊 保健品", en: "💊 Medicine" }, c: 100, e: { health: 20 } }
        ],
        social: [
            { n: { zh: "👥 交朋友", en: "👥 Make Friends" }, c: 0, e: { joy: 15, reputation: 10 } },
            { n: { zh: "🎂 聚会", en: "🎂 Party" }, c: 50, e: { joy: 30, love: 20, money: -50 } },
            { n: { zh: "🎁 送礼", en: "🎁 Give Gift" }, c: 50, e: { reputation: 20, money: -50, love: 10 } }
        ],
        health: [
            { n: { zh: "🏃 跑步", en: "🏃 Jogging" }, c: 0, e: { health: 15, energy: -15, joy: 10 } },
            { n: { zh: "🧘 瑜伽", en: "🧘 Yoga" }, c: 20, e: { health: 10, mental: 15 } },
            { n: { zh: "🏋️ 健身房", en: "🏋️ Gym" }, c: 50, e: { health: 20, money: -50, energy: -20 } },
            { n: { zh: "🏥 看病", en: "🏥 See Doctor" }, c: 50, e: { health: 30, money: -50 } }
        ]
    },

    // ==================== 随机事件 ====================
    events: [
        { t: { zh: "🌧️ 下雨天...", en: "🌧️ Rainy day..." }, e: { sad: 10, joy: -5 } },
        { t: { zh: "☀️ 阳光明媚!", en: "☀️ Sunny day!" }, e: { joy: 10, sad: -5 } },
        { t: { zh: "💼 工作压力大!", en: "💼 Work stress!" }, e: { anger: 10, sleep: -10 } },
        { t: { zh: "🎂 有人生日!", en: "🎂 Birthday!" }, e: { joy: 15, money: -10 } },
        { t: { zh: "🐔 遇到骗子!", en: "🐔 Scammed!" }, e: { money: -20, anger: 15 } },
        { t: { zh: "💪 健身成功!", en: "💪 Workout success!" }, e: { joy: 10, health: 10 } },
        { t: { zh: "📱 手机坏了!", en: "📱 Phone broken!" }, e: { anger: 20, money: -10 } },
        { t: { zh: "💔 分手!", en: "💔 Break up!" }, e: { love: -30, sad: 25, mental: -15 } },
        { t: { zh: "🎉 中彩票!", en: "🎉 Lottery!" }, e: { joy: 35, money: 500 } },
        { t: { zh: "📚 读完一本书!", en: "📚 Read a book!" }, e: { money: 10, joy: 10 } },
        { t: { zh: "😴 失眠...", en: "😴 Insomnia..." }, e: { sleep: -25, energy: -15 } },
        { t: { zh: "🤒 生病!", en: "🤒 Sick!" }, e: { health: -20, money: -50 } }
    ],

    // ==================== 成就 ====================
    achievements: {
        day10: { zh: "🌱 生存10天", en: "🌱 Survive 10 days" },
        day30: { zh: "🌿 生存30天", en: "🌿 Survive 30 days" },
        day100: { zh: "🌳 生存100天", en: "🌳 Survive 100 days" },
        day365: { zh: "👑 生存365天", en: "👑 Survive 365 days" },
        money1k: { zh: "💵 千元户", en: "💵 1K Wealth" },
        money10k: { zh: "💰 万元户", en: "💰 10K Wealth" },
        money100k: { zh: "💎 十万富翁", en: "💎 100K Wealth" },
        rich: { zh: "👑 千万富翁", en: "👑 Millionaire" },
        health100: { zh: "💪 百岁老人", en: "💪 Healthy 100" },
        married: { zh: "💍 结婚", en: "💍 Marriage" }
    }
};

// ==================== 国际化函数 ====================
function t(key, lang) {
    lang = lang || GameConfig.language;
    const keys = key.split('.');
    let value = GameConfig.i18n;
    for (const k of keys) {
        value = value[k];
        if (!value) return key;
    }
    return value[lang] || value.zh || key;
}

// 切换语言
function setLanguage(lang) {
    GameConfig.language = lang;
    localStorage.setItem('brainGame_lang', lang);
}

// 初始化语言
function initLanguage() {
    const saved = localStorage.getItem('brainGame_lang');
    if (saved) {
        GameConfig.language = saved;
    }
}

// 导出
if (typeof module !== 'undefined' && module.exports) {
    module.exports = { GameConfig, t, setLanguage, initLanguage };
}
