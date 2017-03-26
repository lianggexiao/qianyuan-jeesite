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

        //财务审核
        function financeAudit(billId) {
            $.jBox.open("iframe:${ctx}/im/finance/bill/toAudit", "审核", 450, 280, {
                buttons:{"通过":"ok","不通过":"notok","关闭":true}, submit:function(v, h, f){
                    var opinion = h.find("iframe")[0].contentWindow.$("#opinion").val();
                    $("#id").val(billId);
                    $("#opinion").val(opinion);
                    if (v=="ok"){
                        $("#financeStatus").val("1");
                        $("#inputForm").submit();
                    }else if(v=="notok"){
                        $("#financeStatus").val("2");
                        $("#inputForm").submit();
                    }
                }, loaded:function(h){
                    $(".jbox-content", document).css("overflow-y","hidden");
                }
            });
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/im/finance/bill/list">报销单列表</a></li>
    <li><a href="${ctx}/im/finance/bill/form">报销单添加</a></li>
</ul>
<form:form id="inputForm" modelAttribute="financeBill" action="${ctx}/im/finance/bill/financeAudit" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <form:hidden path="financeStatus"/>
    <form:hidden path="opinion"/>
</form:form>

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
        <li>
            <label>报销人：</label>
            <form:select path="billUser" class="input-medium">
                <option selected value="">请选择</option>
                <form:options items="${fns:getDictList('im_bill_user')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
        <li>
            <label>报销事项：</label>
            <form:select path="matter" class="input-medium">
                <option selected value="">请选择</option>
                <form:options items="${fns:getDictList('im_matter')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
        <li class="clearfix"></li>
        <li>
            <label>支付情况：</label>
            <form:select path="payment" class="input-medium">
                <option selected value="">请选择</option>
                <form:options items="${fns:getDictList('im_payment')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
        <li>
            <label>报销日期:</label>
            <form:input path="startBillTime" name="createDate" id="createDate" type="text" readonly="readonly" maxlength="20"
                        class="input-medium Wdate"
                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"  placeholder="开始日期"/>
            <span>--</span>
            <form:input path="endBillTime"   name="endDate" id="endDate" type="text" readonly="readonly" maxlength="20"
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
        <th>标题</th>
        <th class="sort-column matter">报销事项</th>
        <th class="sort-column bill_time" width="90px;">报销日期</th>
        <th width="70px;">金额</th>
        <th width="70px;">报销人</th>
        <th width="70px;">支付情况</th>
        <th width="70px;">审核状态</th>
        <th width="180px;">操作</th>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="financeBill">
        <tr>
            <td>${financeBill.title}</td>
            <td>${financeBill.matter}</td>
            <td style="word-wrap:break-word;"><fmt:formatDate value="${financeBill.billTime}" pattern="yyyy-MM-dd" /> </td>
            <td style="word-wrap:break-word;">${financeBill.amount}</td>
            <td style="word-wrap:break-word;">${financeBill.billUser}</td>
            <td style="word-wrap:break-word;">${financeBill.payment}</td>
            <td style="word-wrap:break-word;">
                <c:choose>
                    <c:when test="${financeBill.financeStatus == 0}">
                        未审核
                    </c:when>
                    <c:when test="${financeBill.financeStatus == 1}">
                        审核通过
                    </c:when>
                    <c:when test="${financeBill.financeStatus == 2}">
                        审核不通过
                    </c:when>
                    <c:when test="${financeBill.financeStatus == 3}">
                        待审核
                    </c:when>
                </c:choose>
            </td>
            <td style="word-wrap:break-word;">
                <a href="${ctx}/im/finance/bill/form?id=${financeBill.id}">修改</a>
                <shiro:hasPermission name="im:financebill:submitaudit">
                    <a href="${ctx}/im/finance/bill/submitAudit?id=${financeBill.id}" onclick="return confirmx('确认要提交审核吗？', this.href)">提交审核</a>
                </shiro:hasPermission>
                <shiro:hasPermission name="im:financebill:audit">
                    <a href="javascript:void(0);" onclick="financeAudit('${financeBill.id}');">财务审核</a>
                </shiro:hasPermission>
                <a href="${ctx}/im/finance/bill/delete?id=${financeBill.id}" onclick="return confirmx('确认要删除吗？', this.href)">删除</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>