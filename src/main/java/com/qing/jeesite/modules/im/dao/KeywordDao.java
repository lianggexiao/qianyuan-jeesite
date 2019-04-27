package com.qing.jeesite.modules.im.dao;

import com.qing.jeesite.common.persistence.CrudDao;
import com.qing.jeesite.modules.im.entity.Keyword;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * File name and path : com.qing.jeesite.modules.im.dao.KeywordDao
 * Author : 柳青 , Version : 1.0, First complete date : 2019/2/15 18:56
 * Description : 搜索关键词统计
 * Others :
 */
@Mapper
public interface KeywordDao extends CrudDao<Keyword> {

    //批量新增or更新数据
    void insertOrUpdateByBatch(List<Keyword> keyword);

    List<Keyword> findKeywordList(Keyword keyword);

    List<Keyword> getKeywordList(Keyword keyword);

    List<Keyword> getListByKeyword(Keyword keyword);
}
