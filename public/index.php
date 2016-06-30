<?php
define('APPLICATION_PATH', realpath(dirname(__FILE__) . '/../'));
define('APPLICATION_CONFIG_FILE', APPLICATION_PATH . '/conf/application.ini');

date_default_timezone_set('Asia/Shanghai');
$app = new Yaf_Application(APPLICATION_CONFIG_FILE);
$app->bootstrap()->run();
?>
