<?php
/**
 * 通用游戏配置模型
 * 可以用于任何游戏的配置管理
 */

namespace app\model;

use think\Model;

class GameModel extends Model
{
    protected $name = 'games';
    
    // 游戏状态
    const STATUS_OFFLINE = 0;  // 未上线
    const STATUS_ONLINE = 1;    // 运行中
    const STATUS_MAINTAIN = 2;  // 维护中
    
    // 允许的字段
    protected $fillable = [
        'game_key',        // 游戏唯一标识(英文)
        'game_name',      // 游戏名称(中文)
        'game_name_en',   // 游戏名称(英文)
        'codename',       // 项目代号
        'version',        // 当前版本
        'icon',           // 游戏图标
        'description',    // 游戏描述
        'status',         // 状态
        'config',         // 游戏配置(JSON)
        'settings',       // 运营设置(JSON)
    ];
    
    // 获取游戏配置
    public function getConfig()
    {
        return json_decode($this->config, true) ?? [];
    }
    
    // 获取运营设置
    public function getSettings()
    {
        return json_decode($this->settings, true) ?? [];
    }
    
    // 游戏模块配置
    public function getModules()
    {
        $config = $this->getConfig();
        
        $defaultModules = [
            [
                'key' => 'talent',
                'name' => '天赋系统',
                'name_en' => 'Talent System',
                'icon' => '🌟',
                'table' => 'game_talents'
            ],
            [
                'key' => 'level',
                'name' => '关卡系统',
                'name_en' => 'Level System',
                'icon' => '🎯',
                'table' => 'game_levels'
            ],
            [
                'key' => 'item',
                'name' => '道具系统',
                'name_en' => 'Item System',
                'icon' => '🎁',
                'table' => 'game_items'
            ],
            [
                'key' => 'shop',
                'name' => '商城系统',
                'name_en' => 'Shop System',
                'icon' => '🛒',
                'table' => 'game_shops'
            ],
            [
                'key' => 'chapter',
                'name' => '章节系统',
                'name_en' => 'Chapter System',
                'icon' => '📖',
                'table' => 'game_chapters'
            ],
            [
                'key' => 'achievement',
                'name' => '成就系统',
                'name_en' => 'Achievement',
                'icon' => '🏆',
                'table' => 'game_achievements'
            ],
            [
                'key' => 'gacha',
                'name' => '抽卡系统',
                'name_en' => 'Gacha System',
                'icon' => '🎰',
                'table' => 'game_gacha'
            ],
            [
                'key' => 'event',
                'name' => '活动系统',
                'name_en' => 'Event System',
                'icon' => '🎉',
                'table' => 'game_events'
            ],
            [
                'key' => 'mail',
                'name' => '邮件系统',
                'name_en' => 'Mail System',
                'icon' => '📧',
                'table' => 'game_mails'
            ],
            [
                'key' => 'rank',
                'name' => '排行榜',
                'name_en' => 'Ranking',
                'icon' => '📊',
                'table' => 'game_ranks'
            ]
        ];
        
        return $config['modules'] ?? $defaultModules;
    }
}
