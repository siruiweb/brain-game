-- ----------------------------
-- 游戏表
-- ----------------------------
DROP TABLE IF EXISTS `fa_game`;
CREATE TABLE `fa_game` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `game_key` varchar(50) NOT NULL DEFAULT '' COMMENT '游戏标识',
  `game_name` varchar(100) NOT NULL DEFAULT '' COMMENT '游戏名称',
  `game_name_en` varchar(100) DEFAULT '' COMMENT '英文名称',
  `codename` varchar(50) DEFAULT '' COMMENT '项目代号',
  `version` varchar(20) DEFAULT 'v1.0.0' COMMENT '版本号',
  `icon` varchar(255) DEFAULT '' COMMENT '图标',
  `description` text COMMENT '描述',
  `modules` text COMMENT '模块配置JSON',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态:0=未上线,1=运行中,2=维护中',
  `players` int(11) DEFAULT '0' COMMENT '玩家数',
  `createtime` int(10) DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `game_key` (`game_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='游戏表';

-- ----------------------------
-- 天赋表
-- ----------------------------
DROP TABLE IF EXISTS `fa_game_talent`;
CREATE TABLE `fa_game_talent` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `game_id` int(10) unsigned NOT NULL COMMENT '游戏ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
  `key` varchar(30) NOT NULL DEFAULT '' COMMENT '标识',
  `icon` varchar(50) DEFAULT '' COMMENT '图标',
  `effect` varchar(255) DEFAULT '' COMMENT '效果描述',
  `value` int(11) DEFAULT '0' COMMENT '数值',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='天赋表';

-- ----------------------------
-- 章节表
-- ----------------------------
DROP TABLE IF EXISTS `fa_game_chapter`;
CREATE TABLE `fa_game_chapter` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `game_id` int(10) unsigned NOT NULL COMMENT '游戏ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '章节名称',
  `target_day` int(11) DEFAULT '0' COMMENT '目标天数',
  `description` varchar(255) DEFAULT '' COMMENT '描述',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='章节表';

-- ----------------------------
-- 行动表
-- ----------------------------
DROP TABLE IF EXISTS `fa_game_action`;
CREATE TABLE `fa_game_action` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `game_id` int(10) unsigned NOT NULL COMMENT '游戏ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
  `type` varchar(20) DEFAULT '' COMMENT '类型',
  `cost` int(11) DEFAULT '0' COMMENT '花费',
  `effect` varchar(255) DEFAULT '' COMMENT '效果',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='行动表';

-- ----------------------------
-- 成就表
-- ----------------------------
DROP TABLE IF EXISTS `fa_game_achievement`;
CREATE TABLE `fa_game_achievement` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `game_id` int(10) unsigned NOT NULL COMMENT '游戏ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
  `key` varchar(30) NOT NULL DEFAULT '' COMMENT '标识',
  `icon` varchar(50) DEFAULT '' COMMENT '图标',
  `condition` varchar(255) DEFAULT '' COMMENT '条件',
  `reward` int(11) DEFAULT '0' COMMENT '奖励',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='成就表';

-- ----------------------------
-- 玩家表
-- ----------------------------
DROP TABLE IF EXISTS `fa_game_player`;
CREATE TABLE `fa_game_player` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `game_id` int(10) unsigned NOT NULL COMMENT '游戏ID',
  `openid` varchar(64) DEFAULT '' COMMENT '用户ID',
  `nickname` varchar(50) DEFAULT '' COMMENT '昵称',
  `talent` varchar(30) DEFAULT '' COMMENT '天赋',
  `money` int(11) DEFAULT '0' COMMENT '金钱',
  `health` int(11) DEFAULT '100' COMMENT '健康',
  `mental` int(11) DEFAULT '100' COMMENT '精神',
  `current_day` int(11) DEFAULT '1' COMMENT '当前天数',
  `max_day` int(11) DEFAULT '1' COMMENT '最高天数',
  `chapter` int(11) DEFAULT '1' COMMENT '章节',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态:1=存活,0=结束',
  `createtime` int(10) DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='玩家表';

-- ----------------------------
-- 初始数据
-- ----------------------------
INSERT INTO `fa_game` (`id`, `game_key`, `game_name`, `game_name_en`, `codename`, `version`, `icon`, `description`, `modules`, `status`, `players`, `createtime`, `updatetime`) VALUES
(1, 'brain_agent', '头脑特工队', 'Brain Agent', 'VALHALLA', 'v1.1.0', '🧠', '人生365天模拟游戏', '["talent","action","chapter","achievement","event"]', 1, 12580, 1709700000, 1709700000);

INSERT INTO `fa_game_talent` (`id`, `game_id`, `name`, `key`, `icon`, `effect`, `value`, `status`) VALUES
(1, 1, '天选之人', 'lucky', '🌟', '正面效果+10%', 10, 1),
(2, 1, '富二代', 'rich', '🏠', '初始金钱+5000', 5000, 1),
(3, 1, '天才', 'genius', '🧠', '学习效率+20%', 20, 1),
(4, 1, '体育健将', 'healthy', '💪', '健康上限+20', 20, 1),
(5, 1, '万人迷', 'charmer', '💕', '魅力+20%', 20, 1),
(6, 1, '禅师', 'zen', '🧘', '负面效果-20%', -20, 1),
(7, 1, '赌徒', 'gambler', '🎰', '投资回报+30%', 30, 1);

INSERT INTO `fa_game_chapter` (`id`, `game_id`, `name`, `target_day`, `description`, `sort`, `status`) VALUES
(1, 1, '初入社会', 30, '刚刚毕业，进入社会闯荡', 1, 1),
(2, 1, '职场新人', 60, '努力工作，升职加薪', 2, 1),
(3, 1, '创业之路', 100, '辞职创业，追求梦想', 3, 1),
(4, 1, '人生巅峰', 200, '功成名就，颐养天年', 4, 1),
(5, 1, '传奇人生', 365, '终极挑战，完美人生', 5, 1);
