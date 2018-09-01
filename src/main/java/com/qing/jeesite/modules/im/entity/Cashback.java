package com.qing.jeesite.modules.im.entity;

import com.qing.jeesite.common.persistence.DataEntity;

import java.util.Date;

/**
 * File name and path : com.qing.jeesite.modules.im.entity.Cashback
 * Author : 柳青 , Version : 1.0, First complete date : 2018/7/28 18:20
 * Description : 好评返现表
 * Others :
 */
public class Cashback extends DataEntity<Cashback> {

    private String orderId;     //订单号
    private String shop;        //购买店铺
    private Date shopTime;      //购物时间
    private String goodsId;     //购买产品
    private String amount;      //返现金额
    private String address;     //成交地址
    private String userId;      //用户ID


    private String wangId;
    private String wechatId;    //微信号
    private String userName;    //用户名
    private String goodsName;   //产品名称
    private String startShopTime;
    private String endShopTime;

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getShop() {
        return shop;
    }

    public void setShop(String shop) {
        this.shop = shop;
    }

    public Date getShopTime() {
        return shopTime;
    }

    public void setShopTime(Date shopTime) {
        this.shopTime = shopTime;
    }

    public String getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(String goodsId) {
        this.goodsId = goodsId;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getWechatId() {
        return wechatId;
    }

    public void setWechatId(String wechatId) {
        this.wechatId = wechatId;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

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

    public String getStartShopTime() {
        return startShopTime;
    }

    public void setStartShopTime(String startShopTime) {
        this.startShopTime = startShopTime;
    }

    public String getEndShopTime() {
        return endShopTime;
    }

    public void setEndShopTime(String endShopTime) {
        this.endShopTime = endShopTime;
    }
}
