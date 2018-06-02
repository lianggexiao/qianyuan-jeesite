/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.qing.jeesite.modules.sys.dao;

import com.qing.jeesite.common.persistence.CrudDao;
import com.qing.jeesite.modules.sys.entity.Dict;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 字典DAO接口
 *
 */
@Mapper
public interface DictDao extends CrudDao<Dict> {

    List<String> findTypeList(Dict dict);

}
