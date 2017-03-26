package com.qing.jeesite.modules.im.entity;

import com.qing.jeesite.common.persistence.DataEntity;

import java.util.Date;

/**
 * File name and path : com.qing.jeesite.modules.im.entity.FinanceBill
 * Author : 柳青 , Version : 1.0, First complete date : 2017/3/25 11:20
 * Description : 财务报销单
 * Others :
 */
public class FinanceBill extends DataEntity<FinanceBill> {

    private Date billTime;         //报销日期
    private String matter;         //报销事项
    private String amountCapital;  //金额大写
    private String amount;         //报销金额
    private String billUser;       //报销人
    private String payment;        //支付情况 1=公司支付，2=个人支付
    private String operator;       //操作人
    private String financeStatus;  //财务状态 0=未审核,1=审核通过，2=审核不通过
    private String opinion;        //审核意见
    private String title;          //标题

    private String objStr;         //传参 参数
    private String startBillTime;  //报销开始时间
    private String endBillTime;    //报销结束时间


    public Date getBillTime() {
        return billTime;
    }

    public void setBillTime(Date billTime) {
        this.billTime = billTime;
    }

    public String getMatter() {
        return matter;
    }

    public void setMatter(String matter) {
        this.matter = matter;
    }

    public String getAmountCapital() {
        return amountCapital;
    }

    public void setAmountCapital(String amountCapital) {
        this.amountCapital = amountCapital;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getBillUser() {
        return billUser;
    }

    public void setBillUser(String billUser) {
        this.billUser = billUser;
    }

    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public String getFinanceStatus() {
        return financeStatus;
    }

    public void setFinanceStatus(String financeStatus) {
        this.financeStatus = financeStatus;
    }

    public String getOpinion() {
        return opinion;
    }

    public void setOpinion(String opinion) {
        this.opinion = opinion;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getObjStr() {
        return objStr;
    }

    public void setObjStr(String objStr) {
        this.objStr = objStr;
    }

    public String getStartBillTime() {
        return startBillTime;
    }

    public void setStartBillTime(String startBillTime) {
        this.startBillTime = startBillTime;
    }

    public String getEndBillTime() {
        return endBillTime;
    }

    public void setEndBillTime(String endBillTime) {
        this.endBillTime = endBillTime;
    }
}
