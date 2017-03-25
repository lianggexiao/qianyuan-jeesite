package com.qing.jeesite.modules.im.service;

import com.qing.jeesite.modules.im.dao.FinanceDetailBillDao;
import com.qing.jeesite.modules.im.entity.FinanceDetailBill;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * File name and path : com.qing.jeesite.modules.im.service.FinanceDetailBillService
 * Author : 柳青 , Version : 1.0, First complete date : 2017/3/19 18:51
 * Description : 财务报销单明细
 * Others :
 */
@Service
@Transactional(readOnly = true)
public class FinanceDetailBillService {

    @Autowired
    private FinanceDetailBillDao financeDetailBillDao;

    public List<FinanceDetailBill> findFinanceBillList(FinanceDetailBill financeDetailBill) {
        return financeDetailBillDao.findList(financeDetailBill);
    }


}
