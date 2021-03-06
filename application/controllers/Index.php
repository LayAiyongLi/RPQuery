<?php
/**
 * @name IndexController
 * @author root
 * @desc 默认控制器
 * @see http://www.php.net/manual/en/class.yaf-controller-abstract.php
 */
class IndexController extends BaseController {

	public function init(){
		parent::init();
	}

	/** 
     * 默认动作
     * Yaf支持直接把Yaf_Request_Abstract::getParam()得到的同名参数作为Action的形参
     * 对于如下的例子, 当访问http://yourhost/RPQuery/index/index/index/name/root 的时候, 你就会发现不同
     */
	public function indexAction() {
		$this->_layout->sub_title = '测试副标题';
	}
}
