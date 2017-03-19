package com.qing.jeesite.modules.im.service;

import com.qing.jeesite.common.persistence.Page;
import com.qing.jeesite.common.utils.StringUtils;
import com.qing.jeesite.modules.im.dao.GoodsDao;
import com.qing.jeesite.modules.im.entity.Goods;
import com.qing.jeesite.modules.sys.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * File name and path : com.qing.jeesite.modules.im.service.GoodsService
 * Author : 柳青 , Version : 1.0, First complete date : 2017/3/19 18:51
 * Description :
 * Others :
 */
@Service
@Transactional(readOnly = true)
public class GoodsService {

    @Autowired
    private GoodsDao goodsDao;

    public Page<Goods> findGoodsList(Page<Goods> page, Goods goods) {
        // 设置分页参数
        goods.setPage(page);
        // 执行分页查询
        page.setList(goodsDao.findList(goods));
        return page;
    }

    public Goods getGoods(String id){
        return goodsDao.get(id);
    }

    @Transactional(readOnly = false)
    public void saveGoods(Goods goods) {
        if (StringUtils.isBlank(goods.getId())) {
            goodsDao.insert(goods);
        }else {
            goodsDao.update(goods);
        }
    }

    @Transactional(readOnly = false)
    public void deleteGoods(Goods goods) {
        goodsDao.delete(goods);
    }
}
