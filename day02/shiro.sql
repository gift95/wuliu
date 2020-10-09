/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50552
Source Host           : localhost:3306
Source Database       : shiro

Target Server Type    : MYSQL
Target Server Version : 50552
File Encoding         : 65001

Date: 2017-03-27 03:54:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_resource`;
CREATE TABLE `sys_resource` (
  `resource_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `resource_name` varchar(100) NOT NULL,
  `resource_type_code` varchar(50) NOT NULL,
  `resource_url` varchar(200) DEFAULT NULL,
  `parent_id` bigint(20) NOT NULL,
  `parent_ids` varchar(100) NOT NULL,
  `resource_permission` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`resource_id`),
  KEY `sys_resource_nk1` (`parent_id`) USING BTREE,
  KEY `sys_resource_nk2` (`parent_ids`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_resource
-- ----------------------------
INSERT INTO `sys_resource` VALUES ('1', '用户管理', 'MENU', '/system/user', '0', '0/', 'user:*');
INSERT INTO `sys_resource` VALUES ('2', '用户新增', 'BUTTON', '', '1', '0/1/', 'user:create');
INSERT INTO `sys_resource` VALUES ('3', '用户修改', 'BUTTON', '', '1', '0/1/', 'user:edit');
INSERT INTO `sys_resource` VALUES ('4', '用户删除', 'BUTTON', '', '1', '0/1/', 'user:delete');
INSERT INTO `sys_resource` VALUES ('5', '用户查看', 'BUTTON', '', '1', '0/1/', 'user:view');
INSERT INTO `sys_resource` VALUES ('6', '资源管理', 'MENU', '/system/resource', '0', '0/', 'menu:resource');
INSERT INTO `sys_resource` VALUES ('7', '资源新增', 'BUTTON', '', '6', '0/6/', 'resource:create');
INSERT INTO `sys_resource` VALUES ('8', '资源修改', 'BUTTON', '', '6', '0/6/', 'resource:edit');
INSERT INTO `sys_resource` VALUES ('9', '资源删除', 'BUTTON', '', '6', '0/6/', 'resource:delete');
INSERT INTO `sys_resource` VALUES ('10', '资源查看', 'BUTTON', '', '6', '0/6/', 'resource:view');
INSERT INTO `sys_resource` VALUES ('11', '角色管理', 'MENU', '/system/role', '0', '0/', 'role:*');
INSERT INTO `sys_resource` VALUES ('12', '角色新增', 'BUTTON', '', '11', '0/11/', 'role:create');
INSERT INTO `sys_resource` VALUES ('13', '角色修改', 'BUTTON', '', '11', '0/11/', 'role:edit');
INSERT INTO `sys_resource` VALUES ('14', '角色删除', 'BUTTON', '', '11', '0/11/', 'role:delete');
INSERT INTO `sys_resource` VALUES ('15', '角色查看', 'BUTTON', '', '11', '0/11/', 'role:view');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) NOT NULL,
  `role_desc` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `sys_role_uk` (`role_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '系统管理员', '系统管理员');
INSERT INTO `sys_role` VALUES ('2', '普通用户', '普通用户');

-- ----------------------------
-- Table structure for sys_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_resource`;
CREATE TABLE `sys_role_resource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NOT NULL,
  `resource_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sys_role_resource_uk1` (`role_id`,`resource_id`),
  KEY `sys_role_resource_nk1` (`role_id`) USING BTREE,
  KEY `sys_role_resource_nk2` (`resource_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=588 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_resource
-- ----------------------------
INSERT INTO `sys_role_resource` VALUES ('1', '2', '1');
INSERT INTO `sys_role_resource` VALUES ('2', '2', '2');
INSERT INTO `sys_role_resource` VALUES ('3', '2', '3');
INSERT INTO `sys_role_resource` VALUES ('4', '2', '4');
INSERT INTO `sys_role_resource` VALUES ('5', '2', '5');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) NOT NULL,
  `account_type_code` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `salt` varchar(100) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `sys_user_uk1` (`account`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', 'administrator', '系统管理员', 'd3c59d25033dbf980d29554025c23a75', '8d78869f470951332959580424d4bf4f');
INSERT INTO `sys_user` VALUES ('2', 'zhangsan', 'user', '张三', 'aed41093905e170c96e77d63f71dd6a3', 'ddbaab6eeb88ce2d5f9faa523f2e2c3c');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sys_user_role_uk` (`user_id`,`role_id`) USING BTREE,
  KEY `sys_user_role_nk1` (`user_id`) USING BTREE,
  KEY `sys_user_role_nk2` (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1', '1');
INSERT INTO `sys_user_role` VALUES ('2', '2', '2');
