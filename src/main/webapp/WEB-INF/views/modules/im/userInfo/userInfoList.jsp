<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>用户信息管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctx}/im/userInfo/list");
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
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/im/userInfo/list">用户列表</a></li>
    <li><a href="${ctx}/im/userInfo/form">用户添加</a></li>
</ul>
<form:form id="searchForm" modelAttribute="userInfo" action="${ctx}/im/userInfo/list" method="post"
           class="breadcrumb form-search ">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
    <ul class="ul-form">
        <li>
            <label>姓名：</label>
            <form:input path="userName" htmlEscape="false" maxlength="50" class="input-medium"/>
        </li>
        <li>
            <label>微信号：</label>
            <form:input path="wechatId" htmlEscape="false" maxlength="50" class="input-medium"/>
        </li>
        <li>
            <label>旺旺/京东：</label>
            <form:input path="wangId" htmlEscape="false" maxlength="50" class="input-medium"/>
        </li>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
      <tr>
        <th>用户名称</th>
        <th>微信号</th>
        <th>旺旺账号</th>
        <th>京东账号</th>
        <th>手机号</th>
        <th>创建时间</th>
        <th>操作</th>
      </tr>
    </thead>
    <tbody>
    <c:if test="${page.list=='[]'}">
        <tr>
            <td colspan="7">
                没有数据!
            </td>
        </tr>
    </c:if>
    <c:forEach items="${page.list}" var="userInfo">
        <tr>
            <td>${userInfo.userName}</td>
            <td>${userInfo.wechatId}</td>
            <td>${userInfo.wangId}</td>
            <td>${userInfo.jdId}</td>
            <td>${userInfo.mobile}</td>
            <td style="word-wrap:break-word;"><fmt:formatDate value="${userInfo.createDate}" pattern="yyyy-MM-dd" /> </td>
            <td>
                <a href="javascript:void(0)" onclick="show('${userInfo.id}')">查看</a>
                <a href="${ctx}/im/userInfo/form?id=${userInfo.id}">修改</a>
                <a href="${ctx}/im/userInfo/delete?id=${userInfo.id}" onclick="return confirmx('确认要删除吗？', this.href)">删除</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>