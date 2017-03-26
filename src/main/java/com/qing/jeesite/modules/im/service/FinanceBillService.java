package com.qing.jeesite.modules.im.service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.qing.jeesite.common.persistence.Page;
import com.qing.jeesite.common.utils.IdGen;
import com.qing.jeesite.common.utils.StringUtils;
import com.qing.jeesite.modules.im.dao.FinanceBillDao;
import com.qing.jeesite.modules.im.dao.FinanceDetailBillDao;
import com.qing.jeesite.modules.im.entity.FinanceBill;
import com.qing.jeesite.modules.im.entity.FinanceDetailBill;
import com.qing.jeesite.modules.sys.entity.User;
import com.qing.jeesite.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * File name and path : com.qing.jeesite.modules.im.service.FinanceBillService
 * Author : 柳青 , Version : 1.0, First complete date : 2017/3/19 18:51
 * Description : 财务报销单
 * Others :
 */
@Service
@Transactional(readOnly = true)
public class FinanceBillService {

    @Autowired
    private FinanceBillDao financeBillDao;
    @Autowired
    private FinanceDetailBillDao financeDetailBillDao;

    public Page<FinanceBill> findFinanceBillList(Page<FinanceBill> page, FinanceBill financeBill) {
        // 设置分页参数
        financeBill.setPage(page);
        // 执行分页查询
        page.setList(financeBillDao.findList(financeBill));
        return page;
    }

    public FinanceBill getFinanceBill(String id){
        return financeBillDao.get(id);
    }

    @Transactional(readOnly = false)
    public void saveFinanceBill(FinanceBill financeBill) {
        //数据准备
        String objStr = financeBill.getObjStr();
        List<FinanceDetailBill> list = new ArrayList<FinanceDetailBill>();
        if(StringUtils.isNotEmpty(objStr)){
            String jsonListStr = objStr.replaceAll("&quot;", "\"");
            Gson gson = new Gson();
            list = gson.fromJson(jsonListStr, new TypeToken<List<FinanceDetailBill>>(){}.getType());
        }

        if (StringUtils.isBlank(financeBill.getId())) {
            //添加
            financeBill.setId(IdGen.uuid());
            financeBill.setFinanceStatus("0");
            financeBill.setDelFlag("0");
            financeBill.setOperator(UserUtils.getUser().getLoginName());
            //添加报销单
            financeBillDao.insert(financeBill);
            //添加报销单详情
            saveFinaceDetailBill(list,financeBill.getId());
        }else {
            //更新报销单
            financeBillDao.update(financeBill);
            //先删除详情
            financeDetailBillDao.deleteByBillId(financeBill.getId());
            //再添加报销单详情
            saveFinaceDetailBill(list,financeBill.getId());
        }
    }

    private void saveFinaceDetailBill(List<FinanceDetailBill> list,String billId){
        if(list.size() > 0){
            for(int i = 0;i < list.size(); i++){
                FinanceDetailBill financeDetailBill = list.get(i);
                financeDetailBill.setId(IdGen.uuid());
                financeDetailBill.setBillId(billId);
                financeDetailBillDao.insert(financeDetailBill);
            }
        }
    }

    @Transactional(readOnly = false)
    public void deleteFinanceBill(FinanceBill financeBill) {
        financeBillDao.delete(financeBill);
        //删除详情
        financeDetailBillDao.deleteByBillId(financeBill.getId());
    }

    //修改审核状态
    public void updateFinanceBill(FinanceBill financeBill) {
        financeBillDao.updateFinanceBill(financeBill);
    }
}
