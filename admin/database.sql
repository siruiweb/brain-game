-- =====================================================
-- 头脑特工队 - 完整数据库设计
-- Project: VALHALLA
-- Author: AI Assistant
-- Date: 2026-03-11
-- =====================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- 1. 游戏表
-- ----------------------------
DROP TABLE IF EXISTS `fa_game`;
CREATE TABLE `fa_game` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `game_key` varchar(50) NOT NULL DEFAULT '' COMMENT '游戏标识(英文)',
  `game_name` varchar(100) NOT NULL DEFAULT '' COMMENT '游戏名称',
  `game_name_en` varchar(100) DEFAULT '' COMMENT '英文名称',
  `codename` varchar(50) DEFAULT '' COMMENT '项目代号',
  `version` varchar(20) DEFAULT 'v1.0.0' COMMENT '版本号',
  `icon` varchar(255) DEFAULT '' COMMENT '图标',
  `description` text COMMENT '游戏描述',
  `modules` varchar(500) DEFAULT '[]' COMMENT '模块配置JSON',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态:0=未上线,1=运行中,2=维护中',
  `players` int(11) DEFAULT '0' COMMENT '玩家数',
  `createtime` int(10) DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_game_key` (`game_key`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='游戏表';

-- ----------------------------
-- 2. 天赋表
-- ----------------------------
DROP TABLE IF EXISTS `fa_game_talent`;
CREATE TABLE `fa_game_talent` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `game_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '游戏ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
  `name_en` varchar(50) DEFAULT '' COMMENT '英文名称',
  `key` varchar(30) NOT NULL DEFAULT '' COMMENT '标识',
  `icon` varchar(50) DEFAULT '' COMMENT '图标',
  `description` varchar(255) DEFAULT '' COMMENT '描述',
  `effect_type` varchar(30) DEFAULT '' COMMENT '效果类型',
  `effect_value` int(11) DEFAULT '0' COMMENT '效果数值',
  `rarity` tinyint(1) DEFAULT '1' COMMENT '稀有度:1=普通,2=稀有,3=史诗,4=传说',
  `price` int(11) DEFAULT '0' COMMENT '价格',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `createtime` int(10) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_game_id` (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='天赋表';

-- ----------------------------
-- 3. 章节表
-- ----------------------------
DROP TABLE IF EXISTS `fa_game_chapter`;
CREATE TABLE `fa_game_chapter` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `game_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '游戏ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '章节名称',
  `name_en` varchar(50) DEFAULT '' COMMENT '英文名称',
  `target_day` int(11) DEFAULT '0' COMMENT '目标天数',
  `description` varchar(255) DEFAULT '' COMMENT '描述',
  `description_en` varchar(255) DEFAULT '' COMMENT '英文描述',
  `bg_image` varchar(255) DEFAULT '' COMMENT '背景图',
  `music` varchar(255) DEFAULT '' COMMENT '背景音乐',
  `reward_money` int(11) DEFAULT '0' COMMENT '通关奖励金钱',
  `reward_item` varchar(255) DEFAULT '' COMMENT '通关奖励道具',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  PRIMARY KEY (`id`),
  KEY `idx_game_id` (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='章节表';

-- ----------------------------
-- 4. 行动表
-- ----------------------------
DROP TABLE IF EXISTS `fa_game_action`;
CREATE TABLE `fa_game_action` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `game_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '游戏ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
  `name_en` varchar(50) DEFAULT '' COMMENT '英文名称',
  `type` varchar(20) DEFAULT '' COMMENT '类型:emotion=情绪,desire=欲望,health=健康,work=工作',
  `icon` varchar(50) DEFAULT '' COMMENT '图标',
  `description` varchar(255) DEFAULT '' COMMENT '描述',
  `cost_type` varchar(20) DEFAULT 'money' COMMENT '花费类型:money=金钱,energy=精力,time=时间',
  `cost_value` int(11) DEFAULT '0' COMMENT '花费数值',
  `effects` varchar(500) DEFAULT '' COMMENT '效果JSON:[{"type":"joy","value":15},{"type":"money","value":30}]',
  `unlock_day` int(11) DEFAULT '0' COMMENT '解锁天数',
  `unlock_chapter` int(11) DEFAULT '0' COMMENT '解锁章节',
  `cooldown` int(11) DEFAULT '0' COMMENT '冷却时间(秒)',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  PRIMARY KEY (`id`),
  KEY `idx_game_id` (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='行动表';

-- ----------------------------
-- 5. 随机事件表
-- ----------------------------
DROP TABLE IF EXISTS `fa_game_event`;
CREATE TABLE `fa_game_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `game_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '游戏ID',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '事件标题',
  `title_en` varchar(100) DEFAULT '' COMMENT '英文标题',
  `content` text COMMENT '事件内容',
  `content_en` text COMMENT '英文内容',
  `type` varchar(20) DEFAULT 'neutral' COMMENT '类型:good=好事,bad=坏事,neutral=中性',
  `effects` varchar(500) DEFAULT '' COMMENT '效果JSON',
  `weight` int(11) DEFAULT '10' COMMENT '权重',
  `min_day` int(11) DEFAULT '0' COMMENT '最小出现天数',
  `max_day` int(11) DEFAULT '365' COMMENT '最大出现天数',
  `chapters` varchar(100) DEFAULT '' COMMENT '出现的章节ID,逗号分隔',
  `can_skip` tinyint(1) DEFAULT '1' COMMENT '是否可以跳过:0=否,1=是',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  PRIMARY KEY (`id`),
  KEY `idx_game_id` (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='随机事件表';

-- ----------------------------
-- 6. 成就表
-- ----------------------------
DROP TABLE IF EXISTS `fa_game_achievement`;
CREATE TABLE `fa_game_achievement` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `game_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '游戏ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
  `name_en` varchar(50) DEFAULT '' COMMENT '英文名称',
  `key` varchar(30) NOT NULL DEFAULT '' COMMENT '标识',
  `icon` varchar(50) DEFAULT '' COMMENT '图标',
  `description` varchar(255) DEFAULT '' COMMENT '描述',
  `condition_type` varchar(30) DEFAULT '' COMMENT '条件类型:day=天数,money=金钱,chapter=章节',
  `condition_value` int(11) DEFAULT '0' COMMENT '条件数值',
  `reward_type` varchar(20) DEFAULT 'money' COMMENT '奖励类型:money=金钱,item=道具',
  `reward_value` int(11) DEFAULT '0' COMMENT '奖励数值',
  `reward_item` varchar(255) DEFAULT '' COMMENT '奖励道具',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  PRIMARY KEY (`id`),
  KEY `idx_game_id` (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='成就表';

-- ----------------------------
-- 7. 道具表
-- ----------------------------
DROP TABLE IF EXISTS `fa_game_item`;
CREATE TABLE `fa_game_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `game_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '游戏ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
  `name_en` varchar(50) DEFAULT '' COMMENT '英文名称',
  `key` varchar(30) NOT NULL DEFAULT '' COMMENT '标识',
  `type` varchar(20) DEFAULT '' COMMENT '类型:consume=消耗品,equipment=装备,material=材料',
  `icon` varchar(50) DEFAULT '' COMMENT '图标',
  `description` varchar(255) DEFAULT '' COMMENT '描述',
  `effect_type` varchar(30) DEFAULT '' COMMENT '效果类型',
  `effect_value` int(11) DEFAULT '0' COMMENT '效果数值',
  `price` int(11) DEFAULT '0' COMMENT '价格',
  `rarity` tinyint(1) DEFAULT '1' COMMENT '稀有度',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_game_id` (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='道具表';

-- ----------------------------
-- 8. 商城表
-- ----------------------------
DROP TABLE IF EXISTS `fa_game_shop`;
CREATE TABLE `fa_game_shop` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `game_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '游戏ID',
  `item_id` int(11) DEFAULT '0' COMMENT '道具ID',
  `item_type` varchar(20) DEFAULT '' COMMENT '物品类型:item=道具,talent=天赋,skin=皮肤',
  `price` int(11) DEFAULT '0' COMMENT '价格',
  `original_price` int(11) DEFAULT '0' COMMENT '原价',
  `discount` decimal(3,2) DEFAULT '1.00' COMMENT '折扣',
  `stock` int(11) DEFAULT '-1' COMMENT '库存:-1=无限',
  `limit_day` int(11) DEFAULT '0' COMMENT '每日限购',
  `limit_total` int(11) DEFAULT '0' COMMENT '总限购',
  `start_time` int(10) DEFAULT '0' COMMENT '开始时间',
  `end_time` int(10) DEFAULT '0' COMMENT '结束时间',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_game_id` (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='商城表';

-- ----------------------------
-- 9. 玩家表
-- ----------------------------
DROP TABLE IF EXISTS `fa_player`;
CREATE TABLE `fa_player` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `game_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '游戏ID',
  `openid` varchar(64) DEFAULT '' COMMENT '用户唯一ID',
  `nickname` varchar(50) DEFAULT '' COMMENT '昵称',
  `avatar` varchar(255) DEFAULT '' COMMENT '头像',
  `talent` varchar(30) DEFAULT '' COMMENT '选择的天赋',
  `gender` tinyint(1) DEFAULT '0' COMMENT '性别:0=未知,1=男,2=女',
  
  -- 核心属性
  `money` int(11) DEFAULT '1000' COMMENT '金钱',
  `health` int(11) DEFAULT '100' COMMENT '健康值(0-100)',
  `mental` int(11) DEFAULT '100' COMMENT '精神值(0-100)',
  `energy` int(11) DEFAULT '100' COMMENT '精力值(0-100)',
  
  -- 情绪值 (0-100)
  `emotion_joy` int(11) DEFAULT '50' COMMENT '喜悦',
  `emotion_anger` int(11) DEFAULT '50' COMMENT '愤怒',
  `emotion_sad` int(11) DEFAULT '50' COMMENT '悲伤',
  `emotion_fear` int(11) DEFAULT '50' COMMENT '恐惧',
  `emotion_love` int(11) DEFAULT '50' COMMENT '爱意',
  `emotion_disgust` int(11) DEFAULT '50' COMMENT '厌恶',
  
  -- 欲望值 (0-100)
  `desire_food` int(11) DEFAULT '50' COMMENT '食欲',
  `desire_money` int(11) DEFAULT '50' COMMENT '财欲',
  `desire_fame` int(11) DEFAULT '50' COMMENT '名欲',
  `desire_sleep` int(11) DEFAULT '50' COMMENT '睡欲',
  `desire_play` int(11) DEFAULT '50' COMMENT '玩欲',
  
  -- 游戏进度
  `current_day` int(11) DEFAULT '1' COMMENT '当前天数',
  `max_day` int(11) DEFAULT '1' COMMENT '最高存活天数',
  `chapter` int(11) DEFAULT '1' COMMENT '当前章节',
  
  -- 统计
  `total_games` int(11) DEFAULT '0' COMMENT '总游戏次数',
  `win_games` int(11) DEFAULT '0' COMMENT '胜利次数',
  `total_score` int(11) DEFAULT '0' COMMENT '总分',
  
  -- 状态
  `status` tinyint(1) DEFAULT '1' COMMENT '状态:0=结束,1=存活',
  `end_reason` varchar(50) DEFAULT '' COMMENT '结束原因',
  
  -- 背包(JSON)
  `inventory` varchar(1000) DEFAULT '[]' COMMENT '背包JSON',
  `achievements` varchar(500) DEFAULT '[]' COMMENT '已解锁成就',
  
  -- 时间
  `last_play_time` int(10) DEFAULT '0' COMMENT '最后游戏时间',
  `createtime` int(10) DEFAULT '0' COMMENT '注册时间',
  `updatetime` int(10) DEFAULT '0' COMMENT '更新时间',
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_game_openid` (`game_id`,`openid`),
  KEY `idx_game_id` (`game_id`),
  KEY `idx_max_day` (`max_day`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='玩家表';

-- ----------------------------
-- 10. 玩家日志表
-- ----------------------------
DROP TABLE IF EXISTS `fa_player_log`;
CREATE TABLE `fa_player_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `player_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `game_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '游戏ID',
  `day` int(11) DEFAULT '0' COMMENT '天数',
  `action` varchar(50) DEFAULT '' COMMENT '行动',
  `before_state` varchar(500) DEFAULT '' COMMENT '行动前状态JSON',
  `after_state` varchar(500) DEFAULT '' COMMENT '行动后状态JSON',
  `event` varchar(255) DEFAULT '' COMMENT '触发事件',
  `score_change` int(11) DEFAULT '0' COMMENT '分数变化',
  `createtime` int(10) DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`id`),
  KEY `idx_player_id` (`player_id`),
  KEY `idx_game_id` (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='玩家日志表';

-- ----------------------------
-- 11. 管理员表
-- ----------------------------
DROP TABLE IF EXISTS `fa_admin`;
CREATE TABLE `fa_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) DEFAULT '' COMMENT '昵称',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(4) DEFAULT '' COMMENT '密码盐',
  `email` varchar(100) DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(20) DEFAULT '' COMMENT '手机',
  `avatar` varchar(255) DEFAULT '' COMMENT '头像',
  `level` tinyint(1) DEFAULT '1' COMMENT '等级:1=普通,2=超级',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态:0=禁用,1=正常',
  `last_login_time` int(10) DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` varchar(50) DEFAULT '' COMMENT '最后登录IP',
  `createtime` int(10) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='管理员表';

-- ----------------------------
-- 12. 操作日志表
-- ----------------------------
DROP TABLE IF EXISTS `fa_admin_log`;
CREATE TABLE `fa_admin_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `username` varchar(50) DEFAULT '' COMMENT '用户名',
  `module` varchar(50) DEFAULT '' COMMENT '模块',
  `action` varchar(50) DEFAULT '' COMMENT '操作',
  `content` varchar(500) DEFAULT '' COMMENT '内容',
  `ip` varchar(50) DEFAULT '' COMMENT 'IP地址',
  `useragent` varchar(255) DEFAULT '' COMMENT '用户代理',
  `createtime` int(10) DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`id`),
  KEY `idx_admin_id` (`admin_id`),
  KEY `idx_createtime` (`createtime`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志表';

-- ----------------------------
-- 13. 系统配置表
-- ----------------------------
DROP TABLE IF EXISTS `fa_config`;
CREATE TABLE `fa_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '配置名称',
  `group` varchar(20) DEFAULT 'basic' COMMENT '分组',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '配置标题',
  `value` text COMMENT '配置值',
  `type` varchar(20) DEFAULT 'text' COMMENT '类型:text,textarea,number,select,switch',
  `options` varchar(500) DEFAULT '' COMMENT '选项JSON',
  `tip` varchar(255) DEFAULT '' COMMENT '提示',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='系统配置表';

-- =====================================================
-- 模拟数据
-- =====================================================

-- 游戏数据
INSERT INTO `fa_game` (`id`, `game_key`, `game_name`, `game_name_en`, `codename`, `version`, `icon`, `description`, `modules`, `status`, `players`, `createtime`, `updatetime`) VALUES
(1, 'brain_agent', '头脑特工队', 'Brain Agent', 'VALHALLA', 'VALHALLA-II v1.1.0', '🧠', '一款模拟人生365天的情绪管理游戏，玩家需要平衡七情六欲，经历5个章节，最终完成365天的人生挑战。', '["talent","chapter","action","event","achievement","item","shop"]', 1, 12580, 1709700000, 1709700000);

-- 天赋数据
INSERT INTO `fa_game_talent` (`id`, `game_id`, `name`, `name_en`, `key`, `icon`, `description`, `effect_type`, `effect_value`, `rarity`, `price`, `sort`, `status`) VALUES
(1, 1, '天选之人', 'Lucky Star', 'lucky', '🌟', '正面效果提升10%', 'all_positive', 10, 2, 0, 1, 1),
(2, 1, '富二代', 'Rich Kid', 'rich', '🏠', '初始金钱+5000', 'money', 5000, 3, 0, 2, 1),
(3, 1, '天才', 'Genius', 'genius', '🧠', '学习效率提升20%', 'study', 20, 3, 0, 3, 1),
(4, 1, '体育健将', 'Athletes', 'healthy', '💪', '健康上限+20', 'health_max', 20, 2, 0, 4, 1),
(5, 1, '万人迷', 'Charmer', 'charmer', '💕', '魅力+20%,更容易获得爱情', 'charm', 20, 2, 0, 5, 1),
(6, 1, '禅师', 'Zen Master', 'zen', '🧘', '负面效果减少20%', 'negative_reduce', -20, 3, 0, 6, 1),
(7, 1, '赌徒', 'Gambler', 'gambler', '🎰', '投资回报+30%', 'invest', 30, 4, 0, 7, 1);

-- 章节数据
INSERT INTO `fa_game_chapter` (`id`, `game_id`, `name`, `name_en`, `target_day`, `description`, `description_en`, `reward_money`, `reward_item`, `sort`, `status`) VALUES
(1, 1, '初入社会', 'Enter Society', 30, '刚刚毕业，进入社会闯荡，面对种种挑战', 'Just graduated, entering society to face challenges', 500, '', 1, 1),
(2, 1, '职场新人', 'Office Worker', 60, '努力工作，升职加薪，走向人生巅峰', 'Work hard, get promoted and increase salary', 1000, '', 2, 1),
(3, 1, '创业之路', 'Entrepreneurship', 100, '辞职创业，追求梦想，成为人生赢家', 'Quit job to start business, pursue dreams', 2000, '', 3, 1),
(4, 1, '人生巅峰', 'Peak of Life', 200, '功成名就，颐养天年，享受生活', 'Achieve success, enjoy life', 5000, '', 4, 1),
(5, 1, '传奇人生', 'Legendary Life', 365, '终极挑战，完美人生，流芳百世', 'Ultimate challenge, perfect life', 10000, '', 5, 1);

-- 行动数据
INSERT INTO `fa_game_action` (`id`, `game_id`, `name`, `name_en`, `type`, `icon`, `description`, `cost_type`, `cost_value`, `effects`, `unlock_day`, `cooldown`, `sort`, `status`) VALUES
(1, 1, '赚钱', 'Make Money', 'work', '💰', '努力工作赚钱', 'energy', 30, '[{"type":"money","value":100},{"type":"emotion_joy","value":10}]', 0, 0, 1, 1),
(2, 1, '吃饭', 'Eat', 'desire', '🍚', '好好吃一顿', 'money', 20, '[{"type":"desire_food","value":35},{"type":"health","value":5}]', 0, 0, 2, 1),
(3, 1, '睡觉', 'Sleep', 'desire', '😴', '好好休息一下', 'time', 0, '[{"type":"desire_sleep","value":50},{"type":"energy","value":40}]', 0, 0, 3, 1),
(4, 1, '玩游戏', 'Play Games', 'desire', '🎮', '玩会儿游戏放松一下', 'money', 10, '[{"type":"emotion_joy","value":20},{"type":"desire_play","value":15}]', 0, 0, 4, 1),
(5, 1, '健身', 'Exercise', 'health', '🏃', '去健身房锻炼', 'money', 50, '[{"type":"health","value":15},{"type":"emotion_anger","value":-10}]', 0, 0, 5, 1),
(6, 1, '冥想', 'Meditate', 'emotion', '🧘', '静心冥想', 'time', 0, '[{"type":"mental","value":20},{"type":"emotion_anger","value":-15}]', 0, 0, 6, 1),
(7, 1, '旅游', 'Travel', 'desire', '✈️', '出去旅游放松', 'money', 500, '[{"type":"desire_play","value":50},{"type":"emotion_joy","value":40}]', 30, 0, 7, 1),
(8, 1, '投资', 'Invest', 'work', '📈', '进行投资理财', 'money', 1000, '[{"type":"money","value":{"min":-200,"max":500}}]', 60, 86400, 8, 1),
(9, 1, '创业', 'Start Business', 'work', '🚀', '创办自己的公司', 'money', 10000, '[{"type":"money","value":{"min":-5000,"max":20000}}]', 100, 0, 9, 1),
(10, 1, '结婚', 'Marry', 'emotion', '💒', '和心爱的人结婚', 'money', 5000, '[{"type":"emotion_love","value":50},{"type":"desire_fame","value":20}]', 60, 0, 10, 1);

-- 随机事件数据
INSERT INTO `fa_game_event` (`id`, `game_id`, `title`, `title_en`, `content`, `content_en`, `type`, `effects`, `weight`, `min_day`, `max_day`, `can_skip`, `status`) VALUES
(1, 1, '阳光明媚', 'Sunny Day', '今天天气特别好，心情愉悦！', 'The weather is great today, feeling happy!', 'good', '[{"type":"emotion_joy","value":15}]', 10, 0, 365, 1, 1),
(2, 1, '雨天心情', 'Rainy Mood', '下雨天，心情有点低落...', 'Rainy day, feeling a bit down...', 'bad', '[{"type":"emotion_sad","value":10}]', 10, 0, 365, 1, 1),
(3, 1, '工作压力', 'Work Pressure', '工作压力好大，感觉很累...', 'Work pressure is high, feeling tired...', 'bad', '[{"type":"mental","value":-10},{"type":"emotion_anger","value":10}]', 8, 10, 365, 1, 1),
(4, 1, '中奖了', 'Win Lottery', '居然中奖了！太开心了！', 'You won the lottery! So happy!', 'good', '[{"type":"money","value":500},{"type":"emotion_joy","value":30}]', 2, 0, 365, 1, 1),
(5, 1, '遇到骗子', 'Scam', '遇到骗子了，损失了一些钱...', 'Met a scammer, lost some money...', 'bad', '[{"type":"money","value":-200},{"type":"emotion_anger","value":15}]', 5, 0, 365, 1, 1),
(6, 1, '生日礼物', 'Birthday Gift', '收到一份生日礼物！', 'Received a birthday gift!', 'good', '[{"type":"emotion_joy","value":20},{"type":"desire_food","value":10}]', 5, 0, 365, 1, 1),
(7, 1, '生病了', 'Sick', '不小心生病了，需要休息...', 'Got sick, need to rest...', 'bad', '[{"type":"health","value":-20},{"type":"desire_sleep","value":-15}]', 8, 0, 365, 1, 1),
(8, 1, '加薪了', 'Get Raise', '老板给加薪了！', 'Boss gave you a raise!', 'good', '[{"type":"money","value":500},{"type":"emotion_joy","value":25}]', 3, 30, 365, 1, 1),
(9, 1, '失恋', 'Broken Heart', '失恋了，心情很低落...', 'Broken heart, feeling sad...', 'bad', '[{"type":"emotion_love","value":-30},{"type":"mental","value":-15}]', 5, 20, 365, 1, 1),
(10, 1, '捡到钱', 'Find Money', '在路上捡到了钱！', 'Found money on the road!', 'good', '[{"type":"money","value":100},{"type":"emotion_joy","value":15}]', 5, 0, 365, 1, 1);

-- 成就数据
INSERT INTO `fa_game_achievement` (`id`, `game_id`, `name`, `name_en`, `key`, `icon`, `description`, `condition_type`, `condition_value`, `reward_type`, `reward_value`, `sort`, `status`) VALUES
(1, 1, '初出茅庐', 'Novice', 'day10', '🌱', '存活10天', 'day', 10, 'money', 50, 1, 1),
(2, 1, '小有所成', 'Intermediate', 'day30', '🌿', '存活30天', 'day', 30, 'money', 100, 2, 1),
(3, 1, '职场老手', 'Professional', 'day60', '🌳', '存活60天', 'day', 60, 'money', 200, 3, 1),
(4, 1, '创业先锋', 'Entrepreneur', 'day100', '🏢', '存活100天', 'day', 100, 'money', 500, 4, 1),
(5, 1, '人生赢家', 'Winner', 'day200', '🏆', '存活200天', 'day', 200, 'money', 1000, 5, 1),
(6, 1, '传奇人物', 'Legend', 'day365', '👑', '存活365天完成游戏', 'day', 365, 'money', 5000, 6, 1),
(7, 1, '千元户', 'Rich', 'money1k', '💵', '拥有1000元', 'money', 1000, 'money', 10, 7, 1),
(8, 1, '万元户', 'Millionaire', 'money10k', '💰', '拥有10000元', 'money', 10000, 'money', 50, 8, 1),
(9, 1, '百万富翁', 'Tycoon', 'money100k', '💎', '拥有100000元', 'money', 100000, 'money', 200, 9, 1),
(10, 1, '健康达人', 'Health', 'health100', '💪', '保持健康100天', 'health', 100, 'money', 100, 10, 1);

-- 道具数据
INSERT INTO `fa_game_item` (`id`, `game_id`, `name`, `name_en`, `key`, `type`, `icon`, `description`, `effect_type`, `effect_value`, `price`, `rarity`, `sort`, `status`) VALUES
(1, 1, '体力药水', 'Energy Potion', 'potion_energy', 'consume', '🧪', '恢复30点精力', 'energy', 30, 50, 1, 1, 1),
(2, 1, '精神药水', 'Mental Potion', 'potion_mental', 'consume', '🧠', '恢复30点精神', 'mental', 30, 50, 1, 2, 1),
(3, 1, '健康药水', 'Health Potion', 'potion_health', 'consume', '❤️', '恢复30点健康', 'health', 30, 50, 1, 3, 1),
(4, 1, '幸运符', 'Lucky Charm', 'charm_lucky', 'equipment', '🍀', '提升10%正面效果', 'luck', 10, 200, 2, 4, 1),
(5, 1, '护身符', 'Amulet', 'amulet_protect', 'equipment', '🛡️', '减少10%负面效果', 'protect', 10, 200, 2, 5, 1);

-- 商城数据
INSERT INTO `fa_game_shop` (`id`, `game_id`, `item_id`, `item_type`, `price`, `original_price`, `discount`, `stock`, `sort`, `status`) VALUES
(1, 1, 1, 'item', 40, 50, 0.80, -1, 1, 1),
(2, 1, 2, 'item', 40, 50, 0.80, -1, 2, 1),
(3, 1, 3, 'item', 40, 50, 0.80, -1, 3, 1),
(4, 1, 4, 'item', 150, 200, 0.75, -1, 4, 1),
(5, 1, 5, 'item', 150, 200, 0.75, -1, 5, 1);

-- 模拟玩家数据
INSERT INTO `fa_player` (`id`, `game_id`, `openid`, `nickname`, `avatar`, `talent`, `money`, `health`, `mental`, `energy`, `emotion_joy`, `emotion_anger`, `emotion_sad`, `emotion_fear`, `emotion_love`, `emotion_disgust`, `desire_food`, `desire_money`, `desire_fame`, `desire_sleep`, `desire_play`, `current_day`, `max_day`, `chapter`, `total_games`, `win_games`, `total_score`, `status`, `createtime`, `updatetime`) VALUES
(1, 1, 'user_10001', '玩家小明', '', 'lucky', 2500, 85, 70, 60, 65, 40, 35, 30, 55, 45, 60, 55, 50, 45, 50, 45, 25, 25, 1, 15, 1, 2500, 1, 1709700000, 1709700000),
(2, 1, 'user_10002', '玩家小红', '', 'rich', 8000, 90, 80, 75, 70, 35, 30, 25, 60, 40, 65, 60, 55, 50, 55, 45, 45, 45, 2, 25, 2, 8000, 1, 1709700000, 1709700000),
(3, 1, 'user_10003', '玩家小刚', '', 'genius', 3200, 75, 65, 50, 55, 50, 45, 40, 50, 55, 50, 45, 40, 35, 40, 60, 15, 15, 1, 8, 0, 800, 0, '健康归零', 1709700000, 1709700000),
(4, 1, 'user_10004', '玩家小丽', '', 'zen', 1800, 95, 90, 85, 80, 20, 25, 20, 70, 50, 70, 65, 60, 55, 60, 55, 68, 68, 2, 40, 1, 6800, 1, 1709700000, 1709700000),
(5, 1, 'user_10005', '玩家阿强', '', 'gambler', 15000, 80, 60, 45, 50, 55, 40, 35, 45, 40, 55, 50, 45, 40, 45, 70, 35, 35, 1, 12, 0, 3500, 0, '没钱了', 1709700000, 1709700000);

-- 管理员数据 (密码: 123456, salt: 3a5f)
INSERT INTO `fa_admin` (`id`, `username`, `nickname`, `password`, `salt`, `email`, `mobile`, `level`, `status`, `createtime`) VALUES
(1, 'admin', '超级管理员', '019d5ed99c2e18d4d7e9c0e3c0a0c8d4', '3a5f', 'admin@brain-game.com', '13800138000', 2, 1, 1709700000);

-- 系统配置
INSERT INTO `fa_config` (`id`, `name`, `group`, `title`, `value`, `type`, `sort`) VALUES
(1, 'game_name', 'basic', '游戏名称', '头脑特工队', 'text', 1),
(2, 'game_version', 'basic', '游戏版本', 'VALHALLA-II v1.1.0', 'text', 2),
(3, 'maintenance', 'basic', '维护状态', '0', 'switch', 3),
(4, 'register_enabled', 'basic', '允许注册', '1', 'switch', 4),
(5, 'initial_money', 'game', '初始金钱', '1000', 'number', 5),
(6, 'initial_health', 'game', '初始健康', '100', 'number', 6),
(7, 'initial_energy', 'game', '初始精力', '100', 'number', 7);

SET FOREIGN_KEY_CHECKS = 1;
