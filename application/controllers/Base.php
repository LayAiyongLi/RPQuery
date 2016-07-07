<?php

/**
 * 基础控制器，新增控制器的所有基类
 */


abstract class BaseController extends Yaf_Controller_Abstract{
    protected $_layout;

    public function init(){
        $this->_layout = Yaf_Registry::get('layout');
    }


}