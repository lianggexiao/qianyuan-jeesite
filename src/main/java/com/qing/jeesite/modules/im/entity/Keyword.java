package com.qing.jeesite.modules.im.entity;

import com.qing.jeesite.common.persistence.DataEntity;

import java.util.Date;

/**
 * File name and path : com.qing.jeesite.modules.im.entity.Keyword
 * Author : 柳青 , Version : 1.0, First complete date : 2019/2/15 18:20
 * Description : 搜索关键词统计
 * Others :
 */
public class Keyword extends DataEntity<Keyword> {

    private String keyword;       //关键词
    private Date keyDate;         //关键词出现的日期
    private Integer appearNumber; //出现次数
    private Integer payNumber;    //支付买家数
    private String goodsName;
    private String shopName;

    private String goodsNameStr;
    private String shopNameStr;

    private String startKeyTime;  //统计开始时间
    private String endKeyTime;    //统计结束时间

    private String statisStatus;  //统计类型
    private String keyTime;

    private String rate;          //转化率

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public Date getKeyDate() {
        return keyDate;
    }

    public void setKeyDate(Date keyDate) {
        this.keyDate = keyDate;
    }

    public Integer getAppearNumber() {
        return appearNumber;
    }

    public void setAppearNumber(Integer appearNumber) {
        this.appearNumber = appearNumber;
    }

    public Integer getPayNumber() {
        return payNumber;
    }

    public void setPayNumber(Integer payNumber) {
        this.payNumber = payNumber;
    }

    public String getStartKeyTime() {
        return startKeyTime;
    }

    public void setStartKeyTime(String startKeyTime) {
        this.startKeyTime = startKeyTime;
    }

    public String getEndKeyTime() {
        return endKeyTime;
    }

    public void setEndKeyTime(String endKeyTime) {
        this.endKeyTime = endKeyTime;
    }

    public String getStatisStatus() {
        return statisStatus;
    }

    public void setStatisStatus(String statisStatus) {
        this.statisStatus = statisStatus;
    }

    public String getKeyTime() {
        return keyTime;
    }

    public void setKeyTime(String keyTime) {
        this.keyTime = keyTime;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public String getGoodsNameStr() {
        return goodsNameStr;
    }

    public void setGoodsNameStr(String goodsNameStr) {
        this.goodsNameStr = goodsNameStr;
    }

    public String getShopNameStr() {
        return shopNameStr;
    }

    public void setShopNameStr(String shopNameStr) {
        this.shopNameStr = shopNameStr;
    }

    public String getRate() {
        return rate;
    }

    public void setRate(String rate) {
        this.rate = rate;
    }
}
