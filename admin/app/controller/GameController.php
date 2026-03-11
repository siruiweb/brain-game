<?php
/**
 * 通用游戏后台管理系统
 * Game Admin System
 * 支持任意游戏配置
 */

namespace app\controller;

use think\facade\View;

class GameController
{
    /**
     * 游戏列表
     */
    public function index()
    {
        $games = [
            [
                'id' => 1,
                'key' => 'brain_agent',
                'name' => '头脑特工队',
                'codename' => 'VALHALLA',
                'version' => 'v1.1.0',
                'status' => 1,
                'players' => 12580,
                'icon' => '🧠'
            ],
            [
                'id' => 2,
                'key' => 'puzzle_game',
                'name' => '益智拼图',
                'codename' => 'PUZZLE',
                'version' => 'v2.0.0',
                'status' => 1,
                'players' => 5680,
                'icon' => '🧩'
            ],
            [
                'id' => 3,
                'key' => 'card_game',
                'name' => '卡牌对战',
                'codename' => 'CARD',
                'version' => 'v1.5.0',
                'status' => 0,
                'players' => 0,
                'icon' => '🃏'
            ]
        ];
        
        return View::fetch('games', ['games' => $games]);
    }
    
    /**
     * 游戏详情/配置
     */
    public function config($game_key)
    {
        // 根据game_key加载不同配置
        $config = $this->loadGameConfig($game_key);
        
        return View::fetch('game_config', [
            'game' => $config['game'],
            'modules' => $config['modules']
        ]);
    }
    
    /**
     * 加载游戏配置
     */
    private function loadGameConfig($game_key)
    {
        $configs = [
            'brain_agent' => [
                'game' => [
                    'name' => '头脑特工队',
                    'key' => 'brain_agent',
                    'codename' => 'VALHALLA',
                    'version' => 'VALHALLA-II'
                ],
                'modules' => [
                    [
                        'name' => '天赋系统',
                        'key' => 'talents',
                        'icon' => '🌟',
                        'items' => [
                            ['name' => '天选之人', 'effect' => '正面+10%'],
                            ['name' => '富二代', 'effect' => '金钱+5000'],
                            ['name' => '天才', 'effect' => '学习+20%']
                        ]
                    ],
                    [
                        'name' => '行动系统',
                        'key' => 'actions',
                        'icon' => '⚡',
                        'items' => [
                            ['name' => '赚钱', 'cost' => 0, 'effect' => '金钱+30'],
                            ['name' => '吃饭', 'cost' => 20, 'effect' => '饱食+35']
                        ]
                    ],
                    [
                        'name' => '章节系统',
                        'key' => 'chapters',
                        'icon' => '📖',
                        'items' => [
                            ['name' => '初入社会', 'days' => '0-30'],
                            ['name' => '职场新人', 'days' => '30-60']
                        ]
                    ]
                ]
            ],
            'puzzle_game' => [
                'game' => [
                    'name' => '益智拼图',
                    'key' => 'puzzle_game',
                    'codename' => 'PUZZLE',
                    'version' => 'v2.0.0'
                ],
                'modules' => [
                    [
                        'name' => '关卡配置',
                        'key' => 'levels',
                        'icon' => '🎯',
                        'items' => [
                            ['name' => '第1关', 'difficulty' => '简单'],
                            ['name' => '第2关', 'difficulty' => '中等']
                        ]
                    ],
                    [
                        'name' => '道具系统',
                        'key' => 'items',
                        'icon' => '🎁',
                        'items' => [
                            ['name' => '提示卡', 'price' => 10],
                            ['name' => '时间加成', 'price' => 20]
                        ]
                    ]
                ]
            ]
        ];
        
        return $configs[$game_key] ?? ['game' => ['name' => '未知游戏'], 'modules' => []];
    }
    
    /**
     * 新增游戏
     */
    public function addGame()
    {
        return View::fetch('game_form');
    }
    
    /**
     * 游戏数据统计
     */
    public function statistics($game_key)
    {
        $stats = [
            'total_players' => rand(10000, 50000),
            'today_new' => rand(100, 500),
            'active' => rand(1000, 5000),
            'retention_d1' => rand(30, 50) . '%',
            'retention_d7' => rand(10, 20) . '%',
            'retention_d30' => rand(5, 10) . '%'
        ];
        
        return View::fetch('statistics', ['stats' => $stats, 'game_key' => $game_key]);
    }
}
