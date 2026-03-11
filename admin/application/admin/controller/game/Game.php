<?php

namespace app\admin\controller\game;

use app\common\controller\Backend;
use think\Db;

/**
 * 游戏管理
 */
class Game extends Backend
{
    protected $model = null;
    protected $searchFields = 'id,game_name,game_key';

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\game\Game;
    }

    /**
     * 查看列表
     */
    public function index()
    {
        if ($this->request->isAjax()) {
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            
            $list = $this->model
                ->where($where)
                ->order($sort, $order)
                ->paginate($limit);
            
            $result = ['total' => $list->total(), 'rows' => $list->items()];
            
            return json($result);
        }
        
        return $this->view->fetch();
    }

    /**
     * 添加
     */
    public function add()
    {
        if ($this->request->isPost()) {
            $params = $this->request->post('row/a');
            if ($params) {
                $params['createtime'] = time();
                $params['updatetime'] = time();
                
                $result = $this->model->save($params);
                if ($result !== false) {
                    $this->success('添加成功');
                } else {
                    $this->error('添加失败');
                }
            }
            $this->error('参数错误');
        }
        
        return $this->view->fetch();
    }

    /**
     * 编辑
     */
    public function edit($ids = null)
    {
        $row = $this->model->get($ids);
        if (!$row) {
            $this->error('记录未找到');
        }
        
        if ($this->request->isPost()) {
            $params = $this->request->post('row/a');
            if ($params) {
                $params['updatetime'] = time();
                
                $result = $row->save($params);
                if ($result !== false) {
                    $this->success('更新成功');
                } else {
                    $this->error('更新失败');
                }
            }
            $this->error('参数错误');
        }
        
        $this->view->assign('row', $row);
        return $this->view->fetch();
    }

    /**
     * 删除
     */
    public function del($ids = '')
    {
        if ($ids) {
            $pk = $this->model->getPk();
            $list = $this->model->where($pk, 'in', $ids)->select();
            
            if ($list) {
                $result = $this->model->where($pk, 'in', $ids)->delete();
                if ($result) {
                    $this->success('删除成功');
                }
            }
        }
        $this->error('删除失败');
    }

    /**
     * 批量更新
     */
    public function multi($ids = '')
    {
        $ids = $ids ?: $this->request->post('ids');
        if (empty($ids)) {
            $this->error('参数错误');
        }

        $column = $this->request->post('column');
        $value = $this->request->post('value');
        
        if (!in_array($column, ['status', 'sort'])) {
            $this->error('字段不允许');
        }

        $result = $this->model->where('id', 'in', $ids)->update([$column => $value]);
        if ($result !== false) {
            $this->success('更新成功');
        }
        $this->error('更新失败');
    }
}
