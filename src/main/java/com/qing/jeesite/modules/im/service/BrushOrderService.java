package com.qing.jeesite.modules.im.service;

import com.qing.jeesite.common.persistence.Page;
import com.qing.jeesite.common.utils.IdGen;
import com.qing.jeesite.common.utils.StringUtils;
import com.qing.jeesite.modules.im.dao.BrushOrderDao;
import com.qing.jeesite.modules.im.entity.BrushOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * File name and path : com.qing.jeesite.modules.im.service.BrushOrderService
 * Author : 柳青 , Version : 1.0, First complete date : 2018/7/28 18:51
 * Description :
 * Others :
 */
@Service
@Transactional(readOnly = true)
public class BrushOrderService {

    @Autowired
    private BrushOrderDao brushOrderDao;

    public Page<BrushOrder> findBrushOrderList(Page<BrushOrder> page, BrushOrder brushOrder) {
        // 设置分页参数
        brushOrder.setPage(page);
        // 执行分页查询
        page.setList(brushOrderDao.findList(brushOrder));
        return page;
    }

    public BrushOrder getBrushOrder(String id){
        return brushOrderDao.get(id);
    }

    @Transactional(readOnly = false)
    public void saveBrushOrder(BrushOrder brushOrder) {
        if (StringUtils.isBlank(brushOrder.getId())) {
            brushOrder.setId(IdGen.uuid());
            brushOrderDao.insert(brushOrder);
        }else {
            brushOrderDao.update(brushOrder);
        }
    }

    @Transactional(readOnly = false)
    public void deleteBrushOrder(BrushOrder brushOrder) {
        brushOrderDao.delete(brushOrder);
    }

    public List<BrushOrder> findByUserId(String userId){
        BrushOrder brushOrder = new BrushOrder();
        brushOrder.setUserId(userId);
        List<BrushOrder> brushOrderList = brushOrderDao.findList(brushOrder);
        return brushOrderList;
    }
}
