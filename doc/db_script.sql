-------------------------------------------------------------------表结构
CREATE TABLE `admin_group`(
`groupid` TINYINT NOT NULL AUTO_INCREMENT,
`groupname` CHAR(32) DEFAULT '' COMMENT '组名',
`m`  VARCHAR(10) NOT NULL COMMENT '接口module',
`c`  VARCHAR(10) NOT NULL COMMENT '接口control',
`a`  VARCHAR(10) NOT NULL COMMENT '接口action',
PRIMARY KEY (`groupid`),
KEY `m_c_a` (`m`,`c`,`a`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员组权限表';


CREATE TABLE `admin_role`(
`adminid` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
`email` CHAR(32)  NOT NULL   COMMENT '登录邮箱',
`pwd`   CHAR(256) NOT NULL   COMMENT '登录密码',
`salt`  CHAR(4)   NOT NULL   COMMENT '密码盐值',
`mobile`  CHAR(13)   DEFAULT '' COMMENT '手机',
`groupid` TINYINT NOT NULL COMMENT '从属组ID',
PRIMARY KEY (`adminid`),
KEY `admin_group` (`groupid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员角色表';


CREATE TABLE `user_account`(
`actid` INT UNSIGNED NOT NULL AUTO_INCREMENT,
`balance` INT UNSIGNED DEFAULT 0 COMMENT '账户余额(分)',
PRIMARY KEY (`actid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户账户表';


CREATE TABLE `user_actlog`(
`actid` INT UNSIGNED NOT NULL COMMENT '账户ID',
`money` INT DEFAULT 0 COMMENT '变动资金.+/-',
`memo`  VARCHAR(255) DEFAULT '' COMMENT '变动说明',
FOREIGN KEY `actid` REFERENCES `user_account` (`actid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='账户收支明细';


CREATE TABLE `user`(
`uid` INT UNSIGNED NOT NULL AUTO_INCREMENT,
`mobile` CHAR(13) NOT NULL   COMMENT '注册手机',
`email`  CHAR(32) DEFAULT '' COMMENT '用户邮箱',
`pwd`    CHAR(256) NOT NULL  COMMENT '登录密码',
`salt`   CHAR(4)   NOT NULL  COMMENT '密码盐值',
`status` SMALLINT UNSIGNED DEFAULT 0 COMMENT '用户状态.',
`actid`  INT UNSIGNED NOT NULL COMMENT '用户账户',
PRIMARY KEY (`uid`),
UNIQUE KEY `mobile` (`mobile`),
FOREIGN KEY `actid` REFERENCES `user_account` (`actid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';


CREATE TABLE `user_prof`(
`uid` INT UNSIGNED NOT NULL,
`name` VARCHAR(30) DEFAULT '' COMMENT '用户姓名',
`identifyID` VARCHAR(32) DEFAULT '' COMMET '身份证号',
`qq` VARCHAR(16) DEFAULT '' COMMENT 'QQ', 
`wechat` VARCHAR(16) DEFAULT '' COMMENT '微信', 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户附加信息';


--由于一个用户可能发布多个事件,为了防止事件表的膨胀,需要根据用户ID进行分表
--分表规则用户ID末尾数字，暂时不支持插入图片
--标签值总和举例:
--		如：TAG1 = 0、TAG2 = 1、TAG3=2、TAG4=3，此事件满足TAG2和TAG4，那么此tags=2的3次方 + 2的一次方
CREATE TABLE `event0`(
`eventid` INT UNSIGNED NOT NULL AUTO_INCREMENT,
`uid` INT UNSIGNED NOT NULL COMMENT '发布者ID',
`content` TEXT NOT NULL,
`tags` INT UNSIGNED DEFAULT 0 COMMENT '标签值总和',
`reporteduid` INT UNSIGNED DEFAULT 0 COMMENT '被举报者ID',
`status` SMALLINT UNSIGNED DEFAULT 0 COMMENT '事件状态.0-待审核',
PRIMARY KEY (`eventid`),
FOREIGN KEY `uid` REFERENCES `user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='事件表';


CREATE TABLE `event_tag`(
`tagname` VARCHAR(8) NOT NULL COMMENT '标签名',
`tagpos` SMALLINT UNSIGNED NOT NULL COMMENT '标签代表的位置值',
PRIMARY KEY (`tagname`),
UNIQUE KEY `tagpos`(`tagpos`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='事件标签表';
