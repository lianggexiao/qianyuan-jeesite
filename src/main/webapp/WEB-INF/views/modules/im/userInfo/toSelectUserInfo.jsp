<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>用户信息查询</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctx}/im/userInfo/toSelectUserInfo");
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<form:form id="searchForm" modelAttribute="userInfo" action="${ctx}/im/userInfo/toSelectUserInfo" method="post"
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
        <li class="btns">
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
        </li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="dialogTbody" class="table table-striped table-bordered table-condensed">
    <thead>
      <tr>
          <th width="20px;">选择</th>
          <th width="25px;">序号</th>
          <th>用户名称</th>
          <th>微信号</th>
          <th>旺旺账号</th>
          <th>京东账号</th>
          <th>手机号</th>
          <th>创建时间</th>
      </tr>
    </thead>
    <tbody>
    <c:if test="${page.list=='[]'}">
        <tr>
            <td colspan="8">
                没有数据!
            </td>
        </tr>
    </c:if>
    <c:forEach items="${page.list}" var="userInfo" varStatus="status">
        <tr class="odd gradeX" data-id="${userInfo.id}" data-prd-name="${userInfo.userName}">
            <td style="word-wrap:break-word;">
                <div class="controls">
                    <label class="radio line">
	                    <input type="radio" name="optionsRadios3" value="${userInfo.userName}" id="${userInfo.id}">
                    </label>
                </div>
            </td>
            <td style="word-wrap:break-word;">${status.count}</td>
            <td>${userInfo.userName}</td>
            <td>${userInfo.wechatId}</td>
            <td>${userInfo.wangId}</td>
            <td>${userInfo.jdId}</td>
            <td>${userInfo.mobile}</td>
            <td style="word-wrap:break-word;"><fmt:formatDate value="${userInfo.createDate}" pattern="yyyy-MM-dd" /> </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>