package com.qing.jeesite.modules.im.dao;

import com.qing.jeesite.common.persistence.CrudDao;
import com.qing.jeesite.modules.im.entity.Goods;
import org.apache.ibatis.annotations.Mapper;

/**
 * File name and path : com.qing.jeesite.modules.im.dao.GoodsDao
 * Author : 柳青 , Version : 1.0, First complete date : 2017/3/19 18:56
 * Description :
 * Others :
 */
@Mapper
public interface GoodsDao extends CrudDao<Goods> {

}
