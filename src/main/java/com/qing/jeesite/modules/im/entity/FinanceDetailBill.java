package com.qing.jeesite.modules.im.entity;

import com.qing.jeesite.common.persistence.DataEntity;

import java.util.Date;

/**
 * File name and path : com.qing.jeesite.modules.im.entity.FinanceDetailBill
 * Author : 柳青 , Version : 1.0, First complete date : 2017/3/25 11:20
 * Description : 报销单明细财务报销单
 * Others :
 */
public class FinanceDetailBill extends DataEntity<FinanceDetailBill> {

    private String billId;         //报销单ID
    private String amount;         //数量
    private String totalAmount;    //总金额
    private String goodsName;

    public String getBillId() {
        return billId;
    }

    public void setBillId(String billId) {
        this.billId = billId;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(String totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }
}
