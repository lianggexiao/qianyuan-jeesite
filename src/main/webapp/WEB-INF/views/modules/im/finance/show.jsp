<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>区域管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">

    </script>
</head>
<body>
<br>
<form:form id="inputForm" modelAttribute="financeBill" action="${ctx}/im/finance/bill/save" method="post" class="form-horizontal">
    <table>
        <tr>
            <td colspan="2">
                <div class="control-group">
                    <label class="control-label">标题:</label>
                    <div class="controls">
                        <form:input path="title" htmlEscape="false" maxlength="50" class="required"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">报销日期:</label>
                    <div class="controls">
                        <input name="billTime" id="billTime" htmlEscape="false" maxlength="20" readonly="readonly"
                               value="<fmt:formatDate value='${financeBill.billTime}' pattern='yyyy-MM-dd' />"
                               class="input-medium Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"  placeholder="报销日期"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">报销事项:</label>
                    <div class="controls">
                        <form:select path="matter" class="input-medium">
                            <form:options items="${fns:getDictList('im_matter')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">支付情况:</label>
                    <div class="controls">
                        <form:select path="payment" class="input-medium">
                            <form:options items="${fns:getDictList('im_payment')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">报销人:</label>
                    <div class="controls">
                        <form:select path="billUser" class="input-medium">
                            <form:options items="${fns:getDictList('im_bill_user')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="control-group">
                    <label class="control-label">报销金额:</label>
                    <div class="controls">
                        <form:input path="amount" htmlEscape="false" maxlength="50"/>
                        <form:input path="amountCapital" htmlEscape="false" maxlength="50" placeholder="金额大写"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="control-group">
                    <label class="control-label">备注:</label>
                    <div class="controls">
                        <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="control-group">
                    <label class="control-label">报销产品:</label>
                    <table id="page-tbody" class="table table-striped table-bordered table-condensed">
                        <c:if test="${financeDetailBillList.size() == 0}">
                            &nbsp;空
                        </c:if>
                        <c:forEach items="${financeDetailBillList}" var="financeDetailBill">
                            <tr class="odd gradeX" data-id="${financeDetailBill.id}"  data-prd-name="${financeDetailBill.goodsName}">
                                <td style="width:24px">
                                    <div class="checker"><span><input type="checkbox" class="checkboxes"></span></div>
                                </td>
                                <td>
                                    <div>
                                        <p>产品名称：<span>${financeDetailBill.goodsName}</span></p>
                                    </div>
                                </td>
                                <td>
                                    <p>数量：<input type="text" class="prd-amount" style="width:100px;" value="${financeDetailBill.amount}">
                                        &nbsp;&nbsp; 总金额：<input type="text" class="prd-totalAmount" style="width:100px;" value="${financeDetailBill.totalAmount}"></p>
                                </td>
                                <td>
                                    <div>
                                        备注：
                                        <input type="text" class="prd-remarks" maxlength="12" value="${financeDetailBill.remarks}" style="width:100px;">
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </td>
        </tr>
    </table>
</form:form>
</body>
</html>