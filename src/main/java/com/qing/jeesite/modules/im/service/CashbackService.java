package com.qing.jeesite.modules.im.service;

import com.qing.jeesite.common.persistence.Page;
import com.qing.jeesite.common.utils.IdGen;
import com.qing.jeesite.common.utils.StringUtils;
import com.qing.jeesite.modules.im.dao.CashbackDao;
import com.qing.jeesite.modules.im.entity.Cashback;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * File name and path : com.qing.jeesite.modules.im.service.CashbackService
 * Author : 柳青 , Version : 1.0, First complete date : 2018/7/28 18:51
 * Description :
 * Others :
 */
@Service
@Transactional(readOnly = true)
public class CashbackService {

    @Autowired
    private CashbackDao cashbackDao;

    public Page<Cashback> findCashbackList(Page<Cashback> page, Cashback cashback) {
        // 设置分页参数
        cashback.setPage(page);
        // 执行分页查询
        page.setList(cashbackDao.findList(cashback));
        return page;
    }

    public Cashback getCashback(String id){
        return cashbackDao.get(id);
    }

    @Transactional(readOnly = false)
    public void saveCashback(Cashback cashback) {
        if (StringUtils.isBlank(cashback.getId())) {
            cashback.setId(IdGen.uuid());
            cashbackDao.insert(cashback);
        }else {
            cashbackDao.update(cashback);
        }
    }

    @Transactional(readOnly = false)
    public void deleteCashback(Cashback cashback) {
        cashbackDao.delete(cashback);
    }

    public List<Cashback> findByUserId(String userId){
        Cashback cashback = new Cashback();
        cashback.setUserId(userId);
        List<Cashback> brushOrderList = cashbackDao.findList(cashback);
        return brushOrderList;
    }
}
