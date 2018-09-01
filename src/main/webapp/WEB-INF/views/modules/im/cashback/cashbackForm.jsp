<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>返现管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#order_id").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });

        function toSelectGoods(){
            top.$.jBox.open("iframe:${ctx}/im/goods/toSelectGoods", "产品选择", 810, $(top.document).height() - 240, {
                buttons: {"确定分配": "ok", "关闭": true},
                bottomText: "通过列出所有的产品，然后选择产品。",
                submit: function (v, h, f) {
                    if (v == "ok") {
                        var radio = h.find("iframe")[0].contentWindow.document.getElementsByName("optionsRadios2");
                        for (i=0; i<radio.length; i++) {
                            if (radio[i].checked) {
                                $('#goodsId').val(radio[i].id);
                                $('#goodsName').val(radio[i].value);
                            }
                        }
                        return true;
                    }
                },
                loaded: function (h) {
                    $(".jbox-content", top.document).css("overflow-y", "hidden");
                }
            });
        }

        function toSelectUserInfo(){
            top.$.jBox.open("iframe:${ctx}/im/userInfo/toSelectUserInfo", "用户选择", 810, $(top.document).height() - 240, {
                buttons: {"确定分配": "ok", "关闭": true},
                bottomText: "通过列出所有的用户，然后选择用户。",
                submit: function (v, h, f) {
                    if (v == "ok") {
                        var radio = h.find("iframe")[0].contentWindow.document.getElementsByName("optionsRadios3");
                        for (i=0; i<radio.length; i++) {
                            if (radio[i].checked) {
                                $('#userId').val(radio[i].id);
                                $('#userName').val(radio[i].value);
                            }
                        }
                        return true;
                    }
                },
                loaded: function (h) {
                    $(".jbox-content", top.document).css("overflow-y", "hidden");
                }
            });
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/im/cashback/">好评返现列表</a></li>
    <li class="active"><a href="form?id=${cashback.id}">${not empty cashback.id?'修改':'添加'}</a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="cashback" action="${ctx}/im/cashback/save" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <form:hidden path="goodsId"/>
    <form:hidden path="userId"/>
    <sys:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">订单号:</label>
        <div class="controls">
            <form:input path="orderId" htmlEscape="false" maxlength="50" class="required"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">返现用户:</label>
        <div class="controls">
            <input id="userName" name="userName" onclick="toSelectUserInfo();" readonly="true" value="${cashback.userName}"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">购买产品:</label>
        <div class="controls">
            <input id="goodsName" name="goodsName" onclick="toSelectGoods();" readonly="true" value="${cashback.goodsName}"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">返现金额:</label>
        <div class="controls">
            <form:input path="amount" htmlEscape="false" maxlength="50"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">成交地址:</label>
        <div class="controls">
            <form:input path="address" htmlEscape="false" maxlength="50"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">购物时间:</label>
        <div class="controls">
            <input name="shopTime" id="shopTime" htmlEscape="false" maxlength="20" readonly="readonly"
                   value="<fmt:formatDate value='${cashback.shopTime}' pattern='yyyy-MM-dd' />"
                   class="input-medium Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"  placeholder="购物时间"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">店铺:</label>
        <div class="controls">
            <form:select path="shop" class="input-medium">
                <form:options items="${fns:getDictList('im_shop_classify')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">备注:</label>
        <div class="controls">
            <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
        </div>
    </div>
    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>