<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>好评返管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctx}/im/cashback/list");
            $("#searchForm").submit();
            return false;
        }

        function show(id){
            $.jBox.open("iframe:${ctx}/im/userInfo/toShow?id="+id, "查看", 850, 550, {
                buttons:{"关闭":true}, submit:function(v, h, f){}, loaded:function(h){
                    $(".jbox-content", document).css("overflow-y","hidden");
                }
            });
        }

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
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/im/cashback/list">好评返现列表</a></li>
    <li><a href="${ctx}/im/cashback/form">添加</a></li>
</ul>
<form:form id="searchForm" modelAttribute="cashback" action="${ctx}/im/cashback/list" method="post"
           class="breadcrumb form-search ">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
    <ul class="ul-form">
        <li>
            <label>微信号：</label>
            <form:input path="wechatId" htmlEscape="false" maxlength="50" class="input-medium"/>
        </li>
        <li>
            <label>旺旺/京东：</label>
            <form:input path="wangId" htmlEscape="false" maxlength="50" class="input-medium"/>
        </li>
        <li>
            <label>订单号：</label>
            <form:input path="orderId" htmlEscape="false" maxlength="50" class="input-medium"/>
        </li>
        <li>
            <label>刷单产品:</label>
            <form:hidden path="goodsId"/>
            <input id="goodsName" name="goodsName" onclick="toSelectGoods();" readonly="true"/>
        </li>
        <br/>
        <li>
            <label>店铺：</label>
            <form:select path="shop" class="input-medium">
                <form:option value="">请选择</form:option>
                <form:options items="${fns:getDictList('im_shop_classify')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
        <li>
            <label>购买日期:</label>
            <form:input path="startShopTime" name="createDate" id="createDate" type="text" readonly="readonly" maxlength="20"
                        class="input-medium Wdate"
                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"  placeholder="开始日期"/>
            <span>--</span>
            <form:input path="endShopTime" name="endDate" id="endDate" type="text" readonly="readonly" maxlength="20"
                        class="input-medium Wdate"
                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"  placeholder="结束日期"/>
        </li>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>订单号</th>
        <th>产品名称</th>
        <th>微信号</th>
        <th>购物时间</th>
        <th>店铺</th>
        <th>返现金额</th>
        <th>操作</th>
    </thead>
    <tbody>
    <c:if test="${page.list=='[]'}">
        <tr>
            <td colspan="7">
                没有数据!
            </td>
        </tr>
    </c:if>
    <c:forEach items="${page.list}" var="cashback">
        <tr>
            <td>${cashback.orderId}</td>
            <td>${cashback.goodsName}</td>
            <td>${cashback.wechatId}</td>
            <td style="word-wrap:break-word;"><fmt:formatDate value="${cashback.shopTime}" pattern="yyyy-MM-dd" /> </td>
            <td>${cashback.shop}</td>
            <td>${cashback.amount}</td>
            <td>
                <a href="javascript:void(0)" onclick="show('${cashback.userId}')">查看</a>
                <a href="${ctx}/im/cashback/form?id=${cashback.id}">修改</a>
                <a href="${ctx}/im/cashback/delete?id=${cashback.id}" onclick="return confirmx('确认要删除吗？', this.href)">删除</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>