/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.qing.jeesite.modules.sys.dao;

import com.qing.jeesite.common.persistence.CrudDao;
import com.qing.jeesite.modules.sys.entity.Log;
import org.apache.ibatis.annotations.Mapper;

/**
 * 日志DAO接口
 *
 */
@Mapper
public interface LogDao extends CrudDao<Log> {

}
