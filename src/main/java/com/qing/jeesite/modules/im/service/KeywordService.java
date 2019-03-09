package com.qing.jeesite.modules.im.service;

import com.qing.jeesite.common.persistence.Page;
import com.qing.jeesite.common.utils.DateUtils;
import com.qing.jeesite.common.utils.IdGen;
import com.qing.jeesite.common.utils.StringUtils;
import com.qing.jeesite.modules.im.dao.KeywordDao;
import com.qing.jeesite.modules.im.entity.Keyword;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DecimalFormat;
import java.util.List;

/**
 * File name and path : com.qing.jeesite.modules.im.service.KeywordService
 * Author : 柳青 , Version : 1.0, First complete date : 2019/2/15 18:51
 * Description : 搜索关键词统计
 * Others :
 */
@Service
public class KeywordService {

    @Autowired
    private KeywordDao keywordDao;

    public Page<Keyword> findKeywordList(Page<Keyword> page, Keyword keyword) {
        if(org.apache.commons.lang3.StringUtils.isBlank(keyword.getStartKeyTime())){
            keyword.setStartKeyTime(DateUtils.getNowDay(-60,null));
        }
        if(org.apache.commons.lang3.StringUtils.isBlank(keyword.getEndKeyTime())){
            keyword.setEndKeyTime(DateUtils.getNowDay(1,null));
        }
        // 设置分页参数
        keyword.setPage(page);
        // 执行分页查询
        List<Keyword> keywordList = keywordDao.findKeywordList(keyword);
        float rate = 0f;
        DecimalFormat df=new DecimalFormat("0.00");
        for(Keyword keywordData:keywordList){
            int appearNumber = keywordData.getAppearNumber();
            if(appearNumber != 0){
                rate = (float)keywordData.getPayNumber()/appearNumber * 100;
                keywordData.setRate(df.format(rate)+"%");
            }
            keywordData.setKeyTime(keyword.getStartKeyTime() + " 至 " + keyword.getEndKeyTime());
        }
        page.setList(keywordList);
        return page;
    }

    //正常增删改查的
    public Page<Keyword> findKeywordList2(Page<Keyword> page, Keyword keyword) {
        // 设置分页参数
        keyword.setPage(page);
        // 执行分页查询
        List<Keyword> keywordList = keywordDao.findList(keyword);
        float rate = 0f;
        DecimalFormat df=new DecimalFormat("0.00");
        for(Keyword keywordData:keywordList){
            int appearNumber = keywordData.getAppearNumber();
            if(appearNumber != 0){
                rate = (float)keywordData.getPayNumber()/appearNumber * 100;
                keywordData.setRate(df.format(rate)+"%");
            }
        }
        page.setList(keywordList);
        return page;
    }

    public Keyword getKeyword(String id){
        return keywordDao.get(id);
    }

    @Transactional(readOnly = false)
    public void saveKeyword(Keyword keyword) {
        if (StringUtils.isBlank(keyword.getId())) {
            keyword.setId(IdGen.uuid());
            if (keyword.getAppearNumber() == null){
                keyword.setAppearNumber(new Integer(0));
            }
            if (keyword.getPayNumber() == null){
                keyword.setPayNumber(new Integer(0));
            }
            keywordDao.insert(keyword);
        }else {
            keywordDao.update(keyword);
        }
    }

    @Transactional(readOnly = false)
    public void deleteKeyword(Keyword keyword) {
        keywordDao.delete(keyword);
    }

    @Transactional(readOnly = false)
    public void saveKeywordByBatch(List<Keyword> keywordList) {
        for(Keyword keyword:keywordList){
            keyword.setId(IdGen.uuid());
            if (keyword.getAppearNumber() == null){
                keyword.setAppearNumber(new Integer(0));
            }
            if (keyword.getPayNumber() == null){
                keyword.setPayNumber(new Integer(0));
            }
        }
        keywordDao.insertOrUpdateByBatch(keywordList);
    }

    public List<Keyword> getKeywordList(Keyword keyword) {
        return keywordDao.getKeywordList(keyword);
    }

    public List<Keyword> getListByKeyword(Keyword keyword) {
        return keywordDao.getListByKeyword(keyword);
    }

}
