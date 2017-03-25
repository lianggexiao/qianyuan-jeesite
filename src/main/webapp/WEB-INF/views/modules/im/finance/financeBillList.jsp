<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>报销单管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctx}/im/finance/bill/list");
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/im/finance/bill/list">报销单列表</a></li>
    <li><a href="${ctx}/im/finance/bill/form">报销单添加</a></li>
</ul>
<form:form id="searchForm" modelAttribute="financeBill" action="${ctx}/im/finance/bill/list" method="post"
           class="breadcrumb form-search ">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
    <ul class="ul-form">
        <li>
            <label>标题：</label>
            <form:input path="title" htmlEscape="false" maxlength="50" class="input-medium"/>
        </li>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>标题</th>
        <th class="sort-column matter">报销事项</th>
        <th>报销日期</th>
        <th>金额</th>
        <th>报销人</th>
        <th>支付情况</th>
        <th>审核状态</th>
        <th>操作</th>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="financeBill">
        <tr>
            <td>${financeBill.title}</td>
            <td>${financeBill.matter}</td>
            <td><fmt:formatDate value="${financeBill.billTime}" pattern="yyyy-MM-dd" /> </td>
            <td>${financeBill.amount}</td>
            <td>${financeBill.billUser}</td>
            <td>${financeBill.payment}</td>
            <td>${financeBill.financeStatus}</td>
            <td>
                <a href="${ctx}/im/finance/bill/form?id=${financeBill.id}">修改</a>
                <a href="${ctx}/im/finance/bill/delete?id=${financeBill.id}" onclick="return confirmx('确认要删除吗？', this.href)">删除</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>