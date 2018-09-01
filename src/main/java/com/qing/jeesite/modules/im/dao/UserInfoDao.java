package com.qing.jeesite.modules.im.dao;

import com.qing.jeesite.common.persistence.CrudDao;
import com.qing.jeesite.modules.im.entity.UserInfo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * File name and path : com.qing.jeesite.modules.im.dao.UserInfoDao
 * Author : 柳青 , Version : 1.0, First complete date : 2018/7/28 18:56
 * Description :
 * Others :
 */
@Mapper
public interface UserInfoDao extends CrudDao<UserInfo> {

    int getSeqId();

    List<UserInfo> getUserInfoByWJ(UserInfo userInfo);
}
