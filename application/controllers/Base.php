<?php

/**
 * ���������������������������л���
 */


abstract class BaseController extends Yaf_Controller_Abstract{
    protected $_layout;

    public function init(){
        $this->_layout = Yaf_Registry::get('layout');
    }


}