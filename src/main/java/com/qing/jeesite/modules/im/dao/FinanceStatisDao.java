package com.qing.jeesite.modules.im.dao;

import com.qing.jeesite.common.persistence.CrudDao;
import com.qing.jeesite.modules.im.entity.FinanceBill;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * File name and path : com.qing.jeesite.modules.im.dao.FinanceStatisDao
 * Author : 柳青 , Version : 1.0, First complete date : 2017/6/24 18:56
 * Description : 财务统计
 * Others :
 */
@Mapper
public interface FinanceStatisDao extends CrudDao<FinanceBill> {

    List<FinanceBill> getStatisByTime(FinanceBill financeBill);



}
