<?php
// +----------------------------------------------------------------------
// | 头脑特工队后台管理系统
// | Project: VALHALLA
// | Framework: ThinkPHP 6.0
// +----------------------------------------------------------------------

namespace app\controller;

class IndexController
{
    // 首页/仪表盘
    public function index()
    {
        $data = [
            'total_users' => 12580,
            'total_games' => 56820,
            'today_games' => 1256,
            'avg_days' => 25.6,
            'win_rate' => 23.5,
            'version' => 'VALHALLA-II v1.1.0'
        ];
        
        return view('admin/index', $data);
    }
    
    // 游戏数据
    public function games()
    {
        $list = [];
        for ($i = 0; $i < 20; $i++) {
            $list[] = [
                'id' => $i + 1,
                'user_id' => 'user_' . rand(1000, 9999),
                'talent' => ['富二代', '天选之人', '天才', '禅师'][rand(0, 3)],
                'max_day' => rand(1, 365),
                'status' => rand(0, 1) ? '存活' : '结束'
            ];
        }
        return view('admin/games', ['list' => $list]);
    }
    
    // 游戏配置
    public function config()
    {
        return view('admin/config');
    }
}
