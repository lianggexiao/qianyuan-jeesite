package com.qing.jeesite.modules.im.service;

import com.qing.jeesite.common.persistence.Page;
import com.qing.jeesite.common.utils.DateUtils;
import com.qing.jeesite.common.utils.IdGen;
import com.qing.jeesite.common.utils.StringUtils;
import com.qing.jeesite.modules.im.dao.UserInfoDao;
import com.qing.jeesite.modules.im.entity.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * File name and path : com.qing.jeesite.modules.im.service.UserInfoService
 * Author : 柳青 , Version : 1.0, First complete date : 2018/7/28 18:51
 * Description :
 * Others :
 */
@Service
@Transactional(readOnly = true)
public class UserInfoService {

    @Autowired
    private UserInfoDao userInfoDao;

    public Page<UserInfo> findUserInfoList(Page<UserInfo> page, UserInfo userInfo) {
        // 设置分页参数
        userInfo.setPage(page);
        // 执行分页查询
        page.setList(userInfoDao.findList(userInfo));
        return page;
    }

    public UserInfo getUserInfo(String id){
        return userInfoDao.get(id);
    }

    @Transactional(readOnly = false)
    public boolean saveUserInfo(UserInfo userInfo) {
        if (StringUtils.isBlank(userInfo.getId())) {

            List<UserInfo> list = userInfoDao.getUserInfoByWJ(userInfo);
            if (list.size() > 0){
                return false;
            }

            userInfo.setId(IdGen.uuid());
            int seqId = userInfoDao.getSeqId();
            userInfo.setWechatId("QY" + String.format("%03d", seqId));
            userInfoDao.insert(userInfo);
            return true;
        }else {
            userInfoDao.update(userInfo);
            return true;
        }
    }

    @Transactional(readOnly = false)
    public void deleteUserInfo(UserInfo userInfo) {
        userInfoDao.delete(userInfo);
    }

}
