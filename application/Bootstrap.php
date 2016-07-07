<?php
/**
 * @name Bootstrap
 * @author root
 * @desc 所有在Bootstrap类中, 以_init开头的方法, 都会被Yaf调用,
 * @see http://www.php.net/manual/en/class.yaf-bootstrap-abstract.php
 * 这些方法, 都接受一个参数:Yaf_Dispatcher $dispatcher
 * 调用的次序, 和申明的次序相同
 */
class Bootstrap extends Yaf_Bootstrap_Abstract{

    public function _initConfig() {
		//把配置保存起来
		$arrConfig = Yaf_Application::app()->getConfig();
		Yaf_Registry::set('config', $arrConfig);
		
		//自动加载library下的库
		set_include_path( get_include_path() . PATH_SEPARATOR . $arrConfig->application->library );
	}
	

	public function _initPlugin(Yaf_Dispatcher $dispatcher) {
		// 注册layout插件
		$layout = new LayoutPlugin('layout.phtml');
		Yaf_Registry::set('layout', $layout);
		$dispatcher->registerPlugin($layout);
	}

	public function _initRoute(Yaf_Dispatcher $dispatcher) {
		//在这里注册自己的路由协议,默认使用简单路由
	}

	public function _initDefaultName(Yaf_Dispatcher $dispatcher){
	        $dispatcher->setDefaultModule("Index")->setDefaultController("Index")->setDefaultAction("index");
    }

	
	public function _initView(Yaf_Dispatcher $dispatcher){
		//在这里注册自己的view控制器，例如smarty,firekylin
	}
}
