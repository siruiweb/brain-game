<?php

namespace app\admin\model\game;

use think\Model;

class Game extends Model
{
    protected $name = 'game';
    protected $autoWriteTimestamp = 'int';
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';

    // 状态
    const STATUS_OFFLINE = 0;
    const STATUS_ONLINE = 1;
    const STATUS_MAINTAIN = 2;

    public static function getStatusList()
    {
        return [
            self::STATUS_OFFLINE => '未上线',
            self::STATUS_ONLINE => '运行中',
            self::STATUS_MAINTAIN => '维护中',
        ];
    }

    public function getStatusTextAttr($value, $data)
    {
        $list = self::getStatusList();
        return $list[$data['status']] ?? '';
    }

    // 获取游戏模块
    public function getModulesAttr($value)
    {
        return $value ? json_decode($value, true) : [];
    }

    // 设置游戏模块
    public function setModulesAttr($value)
    {
        return is_array($value) ? json_encode($value) : $value;
    }
}
