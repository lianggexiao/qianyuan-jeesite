package com.qing.jeesite.modules.im.entity;

import com.qing.jeesite.common.persistence.DataEntity;

import java.util.Date;

/**
 * File name and path : com.qing.jeesite.modules.im.entity.BrushOrder
 * Author : 柳青 , Version : 1.0, First complete date : 2018/7/28 18:20
 * Description : 刷单信息表
 * Others :
 */
public class BrushOrder extends DataEntity<BrushOrder> {

    private String goodsId;     //刷单产品
    private Date brushTime;     //刷单时间
    private String orderId;     //订单号
    private String shop;        //刷单店铺
    private String address;      //地址
    private String gift;         //赠送礼品
    private String positivity;   //刷单积极性(友好度)
    private String isFriend;    //是否朋友刷单
    private String userId;      //用户ID


    private String wangId;
    private String wechatId;    //微信号
    private String userName;    //用户名
    private String goodsName;   //产品名称
    private String startBrushTime;
    private String endBrushTime;

    public String getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(String goodsId) {
        this.goodsId = goodsId;
    }

    public Date getBrushTime() {
        return brushTime;
    }

    public void setBrushTime(Date brushTime) {
        this.brushTime = brushTime;
    }

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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getGift() {
        return gift;
    }

    public void setGift(String gift) {
        this.gift = gift;
    }

    public String getPositivity() {
        return positivity;
    }

    public void setPositivity(String positivity) {
        this.positivity = positivity;
    }

    public String getIsFriend() {
        return isFriend;
    }

    public void setIsFriend(String isFriend) {
        this.isFriend = isFriend;
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

    public String getStartBrushTime() {
        return startBrushTime;
    }

    public void setStartBrushTime(String startBrushTime) {
        this.startBrushTime = startBrushTime;
    }

    public String getEndBrushTime() {
        return endBrushTime;
    }

    public void setEndBrushTime(String endBrushTime) {
        this.endBrushTime = endBrushTime;
    }

    public String getWangId() {
        return wangId;
    }

    public void setWangId(String wangId) {
        this.wangId = wangId;
    }
}
