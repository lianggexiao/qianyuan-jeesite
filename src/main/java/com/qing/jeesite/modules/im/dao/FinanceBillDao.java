package com.qing.jeesite.modules.im.dao;

import com.qing.jeesite.common.persistence.CrudDao;
import com.qing.jeesite.modules.im.entity.FinanceBill;
import org.apache.ibatis.annotations.Mapper;

/**
 * File name and path : com.qing.jeesite.modules.im.dao.FinanceBillDao
 * Author : 柳青 , Version : 1.0, First complete date : 2017/3/25 18:56
 * Description : 财务报销单
 * Others :
 */
@Mapper
public interface FinanceBillDao extends CrudDao<FinanceBill> {

}
