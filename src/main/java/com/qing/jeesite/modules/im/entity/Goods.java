package com.qing.jeesite.modules.im.entity;

import com.qing.jeesite.common.persistence.DataEntity;

/**
 * File name and path : com.qing.jeesite.modules.im.entity.Goods
 * Author : 柳青 , Version : 1.0, First complete date : 2017/3/19 18:20
 * Description : 产品
 * Others :
 */
public class Goods extends DataEntity<Goods> {

    private String goodsName;//商品名称
    private String goodsCode;//商品编号
    private String classify; //商品分类，如键盘、防摔壳等
    private String model;    //型号
    private String brand;    //品牌
    private String address;  //采购地点
    private String brief;    //商品简介
    private String shelves;  //是否上家：0=上架 1=下架

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public String getGoodsCode() {
        return goodsCode;
    }

    public void setGoodsCode(String goodsCode) {
        this.goodsCode = goodsCode;
    }

    public String getClassify() {
        return classify;
    }

    public void setClassify(String classify) {
        this.classify = classify;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getBrief() {
        return brief;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }

    public String getShelves() {
        return shelves;
    }

    public void setShelves(String shelves) {
        this.shelves = shelves;
    }
}
