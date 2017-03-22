<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>用户管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctx}/im/goods/list");
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/im/goods/list">产品列表</a></li>
    <li><a href="${ctx}/im/goods/form">产品添加</a></li>
</ul>
<form:form id="searchForm" modelAttribute="goods" action="${ctx}/im/goods/list" method="post"
           class="breadcrumb form-search ">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
    <ul class="ul-form">
        <li>
            <label>产品名称：</label>
            <form:input path="goodsName" htmlEscape="false" maxlength="50" class="input-medium"/>
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
        <th class="sort-column goods_code">产品编号</th>
        <th>分类</th>
        <th>采购地点</th>
        <th>型号</th>
        <th>品牌</th>
        <th>操作</th>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="goods">
        <tr>
            <td>${goods.goodsName}</td>
            <td>${goods.goodsCode}</td>
            <td>${goods.classify}</td>
            <td>${goods.address}</td>
            <td>${goods.model}</td>
            <td>${goods.brand}</td>
            <td>
                <a href="${ctx}/im/goods/form?id=${goods.id}">修改</a>
                <a href="${ctx}/im/goods/delete?id=${goods.id}" onclick="return confirmx('确认要删除吗？', this.href)">删除</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>