package com.qing.jeesite.modules.im.entity;

import com.qing.jeesite.common.persistence.DataEntity;

/**
 * File name and path : com.qing.jeesite.modules.im.entity.UserInfo
 * Author : 柳青 , Version : 1.0, First complete date : 2018/7/28 18:20
 * Description : 用户信息
 * Others :
 */
public class UserInfo extends DataEntity<UserInfo> {

    private String userName;           //用户名称
    private String wangId;             //旺旺名
    private String jdId;               //京东账号
    private String wechatId;           //微信号
    private String originWechatId;    //原始微信号
    private String mobile;
    private String sex;
    private String birthday;
    private String relationWechatId;  //关联账号(微信号）

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getWangId() {
        return wangId;
    }

    public void setWangId(String wangId) {
        this.wangId = wangId;
    }

    public String getJdId() {
        return jdId;
    }

    public void setJdId(String jdId) {
        this.jdId = jdId;
    }

    public String getWechatId() {
        return wechatId;
    }

    public void setWechatId(String wechatId) {
        this.wechatId = wechatId;
    }

    public String getOriginWechatId() {
        return originWechatId;
    }

    public void setOriginWechatId(String originWechatId) {
        this.originWechatId = originWechatId;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getRelationWechatId() {
        return relationWechatId;
    }

    public void setRelationWechatId(String relationWechatId) {
        this.relationWechatId = relationWechatId;
    }
}
