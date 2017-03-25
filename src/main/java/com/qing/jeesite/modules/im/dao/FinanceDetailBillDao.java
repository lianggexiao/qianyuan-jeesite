package com.qing.jeesite.modules.im.dao;

import com.qing.jeesite.common.persistence.CrudDao;
import com.qing.jeesite.modules.im.entity.FinanceBill;
import com.qing.jeesite.modules.im.entity.FinanceDetailBill;
import org.apache.ibatis.annotations.Mapper;

/**
 * File name and path : com.qing.jeesite.modules.im.dao.FinanceDetailBillDao
 * Author : 柳青 , Version : 1.0, First complete date : 2017/3/25 18:56
 * Description : 财务报销单明细
 * Others :
 */
@Mapper
public interface FinanceDetailBillDao extends CrudDao<FinanceDetailBill> {

    void deleteByBillId(String billId);
}
