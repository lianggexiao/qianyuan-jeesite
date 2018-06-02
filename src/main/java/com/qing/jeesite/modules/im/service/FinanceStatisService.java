package com.qing.jeesite.modules.im.service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.qing.jeesite.common.persistence.Page;
import com.qing.jeesite.common.utils.IdGen;
import com.qing.jeesite.common.utils.StringUtils;
import com.qing.jeesite.modules.im.dao.FinanceBillDao;
import com.qing.jeesite.modules.im.dao.FinanceDetailBillDao;
import com.qing.jeesite.modules.im.dao.FinanceStatisDao;
import com.qing.jeesite.modules.im.entity.FinanceBill;
import com.qing.jeesite.modules.im.entity.FinanceDetailBill;
import com.qing.jeesite.modules.sys.utils.UserUtils;
import org.apache.shiro.codec.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * File name and path : com.qing.jeesite.modules.im.service.FinanceStatisService
 * Author : 柳青 , Version : 1.0, First complete date : 2017/6/24 18:51
 * Description : 财务统计
 * Others :
 */
@Service
@Transactional(readOnly = true)
public class FinanceStatisService {

    @Autowired
    private FinanceStatisDao financeStatisDao;


    //按时间统计财务报销
    public List<FinanceBill> getStatisByTime(FinanceBill financeBill) {
        List<FinanceBill> list = financeStatisDao.getStatisByTime(financeBill);
        return list;
    }
}
