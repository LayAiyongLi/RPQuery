-------------------------------------------------------------------��ṹ
CREATE TABLE `admin_group`(
`groupid` TINYINT NOT NULL AUTO_INCREMENT,
`groupname` CHAR(32) DEFAULT '' COMMENT '����',
`m`  VARCHAR(10) NOT NULL COMMENT '�ӿ�module',
`c`  VARCHAR(10) NOT NULL COMMENT '�ӿ�control',
`a`  VARCHAR(10) NOT NULL COMMENT '�ӿ�action',
PRIMARY KEY (`groupid`),
KEY `m_c_a` (`m`,`c`,`a`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='����Ա��Ȩ�ޱ�';


CREATE TABLE `admin_role`(
`adminid` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
`email` CHAR(32)  NOT NULL   COMMENT '��¼����',
`pwd`   CHAR(256) NOT NULL   COMMENT '��¼����',
`salt`  CHAR(4)   NOT NULL   COMMENT '������ֵ',
`mobile`  CHAR(13)   DEFAULT '' COMMENT '�ֻ�',
`groupid` TINYINT NOT NULL COMMENT '������ID',
PRIMARY KEY (`adminid`),
KEY `admin_group` (`groupid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='����Ա��ɫ��';


CREATE TABLE `user_account`(
`actid` INT UNSIGNED NOT NULL AUTO_INCREMENT,
`balance` INT UNSIGNED DEFAULT 0 COMMENT '�˻����(��)',
PRIMARY KEY (`actid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�û��˻���';


CREATE TABLE `user_actlog`(
`actid` INT UNSIGNED NOT NULL COMMENT '�˻�ID',
`money` INT DEFAULT 0 COMMENT '�䶯�ʽ�.+/-',
`memo`  VARCHAR(255) DEFAULT '' COMMENT '�䶯˵��',
FOREIGN KEY `actid` REFERENCES `user_account` (`actid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�˻���֧��ϸ';


CREATE TABLE `user`(
`uid` INT UNSIGNED NOT NULL AUTO_INCREMENT,
`mobile` CHAR(13) NOT NULL   COMMENT 'ע���ֻ�',
`email`  CHAR(32) DEFAULT '' COMMENT '�û�����',
`pwd`    CHAR(256) NOT NULL  COMMENT '��¼����',
`salt`   CHAR(4)   NOT NULL  COMMENT '������ֵ',
`status` SMALLINT UNSIGNED DEFAULT 0 COMMENT '�û�״̬.',
`actid`  INT UNSIGNED NOT NULL COMMENT '�û��˻�',
PRIMARY KEY (`uid`),
UNIQUE KEY `mobile` (`mobile`),
FOREIGN KEY `actid` REFERENCES `user_account` (`actid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�û���';


CREATE TABLE `user_prof`(
`uid` INT UNSIGNED NOT NULL,
`name` VARCHAR(30) DEFAULT '' COMMENT '�û�����',
`identifyID` VARCHAR(32) DEFAULT '' COMMET '���֤��',
`qq` VARCHAR(16) DEFAULT '' COMMENT 'QQ', 
`wechat` VARCHAR(16) DEFAULT '' COMMENT '΢��', 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='�û�������Ϣ';


--����һ���û����ܷ�������¼�,Ϊ�˷�ֹ�¼��������,��Ҫ�����û�ID���зֱ�
--�ֱ�����û�IDĩβ���֣���ʱ��֧�ֲ���ͼƬ
--��ǩֵ�ܺ;���:
--		�磺TAG1 = 0��TAG2 = 1��TAG3=2��TAG4=3�����¼�����TAG2��TAG4����ô��tags=2��3�η� + 2��һ�η�
CREATE TABLE `event0`(
`eventid` INT UNSIGNED NOT NULL AUTO_INCREMENT,
`uid` INT UNSIGNED NOT NULL COMMENT '������ID',
`content` TEXT NOT NULL,
`tags` INT UNSIGNED DEFAULT 0 COMMENT '��ǩֵ�ܺ�',
`reporteduid` INT UNSIGNED DEFAULT 0 COMMENT '���ٱ���ID',
`status` SMALLINT UNSIGNED DEFAULT 0 COMMENT '�¼�״̬.0-�����',
PRIMARY KEY (`eventid`),
FOREIGN KEY `uid` REFERENCES `user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�¼���';


CREATE TABLE `event_tag`(
`tagname` VARCHAR(8) NOT NULL COMMENT '��ǩ��',
`tagpos` SMALLINT UNSIGNED NOT NULL COMMENT '��ǩ�����λ��ֵ',
PRIMARY KEY (`tagname`),
UNIQUE KEY `tagpos`(`tagpos`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='�¼���ǩ��';
