<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>关键字管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctx}/im/keyword/listQuery");
            $("#searchForm").submit();
            return false;
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
//                                $('#goodsId').val(radio[i].id);
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
    <li class="active"><a href="${ctx}/im/keyword/listQuery">关键字列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="keyword" action="${ctx}/im/keyword/list" method="post"
           class="breadcrumb form-search ">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
    <ul class="ul-form">
        <li>
            <label>店铺：</label>
            <form:select path="shopName" class="input-medium">
                <form:options items="${fns:getDictList('im_shop_classify')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
        <li>
            <label>产品:</label>
            <input id="goodsName" name="goodsName" onclick="toSelectGoods();" readonly="true" value="${keyword.goodsName}"/>
        </li>
        <li>
            <label>关键字：</label>
            <form:input path="keyword" htmlEscape="false" maxlength="50" class="input-medium"/>
        </li>
        <li class="clearfix"></li>
        <li>
            <label>统计日期:</label>
            <form:input path="startKeyTime" name="createDate" id="createDate" type="text" readonly="readonly" maxlength="20"
                        class="input-medium Wdate"
                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"  placeholder="开始日期"/>
            <span>--</span>
            <form:input path="endKeyTime"  name="endDate" id="endDate" type="text" readonly="readonly" maxlength="20"
                        class="input-medium Wdate"
                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"  placeholder="结束日期"/>
        </li>
        <li class="btns">
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
        </li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>店铺名称</th>
        <th>产品名称</th>
        <th>搜索关键字</th>
        <th width="300px;">日期</th>
        <th class="sort-column appear_number">访客数</th>
        <th class="sort-column pay_number">支付买家数</th>
        <th>转化率</th>
    </thead>
    <tbody>
    <c:if test="${page.list=='[]'}">
        <tr>
            <td colspan="8">
                没有数据!
            </td>
        </tr>
    </c:if>
    <c:forEach items="${page.list}" var="keyword">
        <tr>
            <td>${keyword.shopName}</td>
            <td>${keyword.goodsName}</td>
            <td>${keyword.keyword}</td>
            <td>${keyword.keyTime}</td>
            <td>${keyword.appearNumber}</td>
            <td>${keyword.payNumber}</td>
            <td>${keyword.rate}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>