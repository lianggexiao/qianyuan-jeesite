<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>区域管理</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}/ueditor/ueditor.config.js" charset="utf-8" type="text/javascript" ></script>
    <script src="${ctxStatic}/ueditor/ueditor.all.min.js" charset="utf-8" type="text/javascript" ></script>
    <script type="text/javascript" charset="utf-8" src="${ctxStatic}/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script src="${ctxStatic}/ueditor/jbase64.js" charset="utf-8" type="text/javascript" ></script>
    <script type="text/javascript">
        var editor = null;

        $(document).ready(function () {
            var item = {
                toolbars:[['FullScreen', 'Source', 'Undo', 'Redo','bold','test']],
                wordCount:false,
                elementPathEnabled:false
            };
            editor = UE.getEditor('editor', item);
        });
    </script>
</head>
<body>
<br>
<form:form id="inputForm" modelAttribute="userInfo" action="${ctx}/im/userInfo/save" method="post" class="form-horizontal">
    <form:hidden path="remarks"/>
    <table>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">用户名:</label>
                    <div class="controls">
                        <form:input path="userName" htmlEscape="false" maxlength="50" class="required"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">手机号:</label>
                    <div class="controls">
                        <form:input path="mobile" htmlEscape="false" maxlength="50"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">旺旺名称::</label>
                    <div class="controls">
                        <form:input path="wangId" htmlEscape="false" maxlength="50" class="required"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">京东账号:</label>
                    <div class="controls">
                        <form:input path="jdId" htmlEscape="false" maxlength="50"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">微信号:</label>
                    <div class="controls">
                        <form:input path="wechatId" htmlEscape="false" maxlength="50" readonly="true"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">原始微信号:</label>
                    <div class="controls">
                        <form:input path="originWechatId" htmlEscape="false" maxlength="50"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">生日:</label>
                    <div class="controls">
                        <form:input path="birthday" htmlEscape="false" maxlength="50"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">性别:</label>
                    <div class="controls">
                        <c:if test="${userInfo.sex == '1'}">
                            <input type="text" value="男">
                        </c:if>
                        <c:if test="${userInfo.sex == '2'}">
                            <input type="text" value="女">
                        </c:if>
                        <c:if test="${userInfo.sex == '3'}">
                            <input type="text" value="不确定">
                        </c:if>
                    </div>
                </div>
            </td>
        </tr>
    </table>

    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <caption align="top">刷单详情</caption>
        <thead>
        <tr>
            <th>产品名称</th>
            <th>微信号</th>
            <th>店铺</th>
            <th>订单号</th>
            <th>刷单时间</th>
            <th>谁介绍刷单</th>
            <th>刷单积极性</th>
        </thead>
        <tbody>
        <c:if test="${brushOrderList=='[]'}">
            <tr>
                <td colspan="7">
                    没有数据!
                </td>
            </tr>
        </c:if>
        <c:forEach items="${brushOrderList}" var="brushOrder" varStatus="status">
            <tr>
                <td>${brushOrder.goodsName}</td>
                <td>${brushOrder.wechatId}</td>
                <td>${brushOrder.shop}</td>
                <td>${brushOrder.orderId}</td>
                <td style="word-wrap:break-word;"><fmt:formatDate value="${brushOrder.brushTime}" pattern="yyyy-MM-dd" /> </td>
                <td>${brushOrder.isFriend}</td>
                <td>${brushOrder.positivity}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <caption align="top">返现详情</caption>
        <thead>
        <tr>
            <th>订单号</th>
            <th>产品名称</th>
            <th>微信号</th>
            <th>购物时间</th>
            <th>店铺</th>
            <th>返现金额</th>
        </thead>
        <tbody>
        <c:if test="${cashbackList=='[]'}">
            <tr>
                <td colspan="6">
                    没有数据!
                </td>
            </tr>
        </c:if>
        <c:forEach items="${cashbackList}" var="cashback" varStatus="status">
            <tr>
                <td>${cashback.orderId}</td>
                <td>${cashback.goodsName}</td>
                <td>${cashback.wechatId}</td>
                <td style="word-wrap:break-word;"><fmt:formatDate value="${cashback.shopTime}" pattern="yyyy-MM-dd" /> </td>
                <td>${cashback.shop}</td>
                <td>${cashback.amount}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</form:form>
<script type="text/javascript">
    $(document).ready(function () {
        editor.ready(function() {
            editor.setContent($('#remarks').val());  //赋值给UEditor
        });
    });
</script>
</body>
</html>