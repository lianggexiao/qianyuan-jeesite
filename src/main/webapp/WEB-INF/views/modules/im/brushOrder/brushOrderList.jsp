<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>刷单管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctx}/im/brushOrder/list");
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
    <li class="active"><a href="${ctx}/im/brushOrder/list">刷单列表</a></li>
    <li><a href="${ctx}/im/brushOrder/form">添加</a></li>
</ul>
<form:form id="searchForm" modelAttribute="brushOrder" action="${ctx}/im/brushOrder/list" method="post"
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
            <label>谁介绍刷单：</label>
            <form:select path="isFriend" class="input-medium">
                <form:option value="">请选择</form:option>
                <form:option value="非朋友刷单">非朋友刷单</form:option>
                <form:options items="${fns:getDictList('im_bill_user')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
        <li>
            <label>店铺：</label>
            <form:select path="shop" class="input-medium">
                <form:option value="">请选择</form:option>
                <form:options items="${fns:getDictList('im_shop_classify')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
        <li>
            <label>刷单日期:</label>
            <form:input path="startBrushTime" name="createDate" id="createDate" type="text" readonly="readonly" maxlength="20"
                        class="input-medium Wdate"
                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"  placeholder="开始日期"/>
            <span>--</span>
            <form:input path="endBrushTime" name="endDate" id="endDate" type="text" readonly="readonly" maxlength="20"
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
        <th>产品名称</th>
        <th>微信号</th>
        <th>店铺</th>
        <th>订单号</th>
        <th>刷单时间</th>
        <th>谁介绍刷单</th>
        <th>刷单金额/赠品</th>
        <th>刷单积极性</th>
        <th>操作</th>
    </thead>
    <tbody>
    <c:if test="${page.list=='[]'}">
        <tr>
            <td colspan="8">
                没有数据!
            </td>
        </tr>
    </c:if>
    <c:forEach items="${page.list}" var="brushOrder">
        <tr>
            <td>${brushOrder.goodsName}</td>
            <td>${brushOrder.wechatId}</td>
            <td>${brushOrder.shop}</td>
            <td>${brushOrder.orderId}</td>
            <td style="word-wrap:break-word;"><fmt:formatDate value="${brushOrder.brushTime}" pattern="yyyy-MM-dd" /> </td>
            <td>${brushOrder.isFriend}</td>
            <td>${brushOrder.gift}</td>
            <td>${brushOrder.positivity}</td>
            <td>
                <a href="javascript:void(0)" onclick="show('${brushOrder.userId}')">查看</a>
                <a href="${ctx}/im/brushOrder/form?id=${brushOrder.id}">修改</a>
                <a href="${ctx}/im/brushOrder/delete?id=${brushOrder.id}" onclick="return confirmx('确认要删除吗？', this.href)">删除</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>