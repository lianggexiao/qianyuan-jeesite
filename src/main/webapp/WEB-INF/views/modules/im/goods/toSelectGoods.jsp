<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>产品查询</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctx}/im/goods/toSelectGoods");
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<form:form id="searchForm" modelAttribute="goods" action="${ctx}/im/goods/toSelectGoods" method="post"
           class="breadcrumb form-search ">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
    <ul class="ul-form">
       <li>
            <label>产品名称：</label>
            <form:input path="goodsName" htmlEscape="false" maxlength="50" class="input-medium"/>
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
        <th>产品名称</th>
        <th class="sort-column goods_code">产品编号</th>
        <th>分类</th>
        <th>采购地点</th>
        <th>型号</th>
      </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="rp" varStatus="status">
        <tr class="odd gradeX" data-id="${rp.id}" data-prd-name="${rp.goodsName}">
            <td style="word-wrap:break-word;">
                <div class="controls">
                    <label class="radio line">
	                    <input type="radio" name="optionsRadios2" value="option1">
                    </label>
                </div>
            </td>
            <td style="word-wrap:break-word;">${status.count}</td>
            <td>${rp.goodsName}</td>
            <td>${rp.goodsCode}</td>
            <td>${rp.classify}</td>
            <td style="word-wrap:break-word;">${rp.address}</td>
            <td>${rp.model}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>