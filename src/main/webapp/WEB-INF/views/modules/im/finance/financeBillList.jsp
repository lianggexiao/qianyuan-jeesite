<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>报销单管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(function () {
            //多选框  全选
            $("#all").click(function(){
                if(this.checked){
                    $("#tabTbody :checkbox").attr("checked", true);
                }else{
                    $("#tabTbody :checkbox").attr("checked", false);
                }
            });
        });


        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctx}/im/finance/bill/list");
            $("#searchForm").submit();
            return false;
        }

        //批量提交审核
        function batchAudit(){
            //获取选中选项的值
            var flagStatus = 0;
            var valArr = new Array;
            $("#tabTbody :checkbox[checked]").each(function(i){
                var dataStatus = $(this).attr("data-status");
                if(dataStatus != 0){
                    flagStatus = 1;
                }
                valArr[i] = $(this).val();
            });
            var vals = valArr.join(',');
            if(vals == "" || vals == undefined){
                $.jBox.info('请至少选择一条记录', '提示');
                return false;
            }

            if(flagStatus == 1){
                $.jBox.info('只有未审核的才能提交审核！', '警告');
                return false;
            }

            $("#objStr").val(vals);
            $("#auditBatchStatus").val(3);

            var submit = function (v, h, f) {
                if (v == 'ok'){
                    $("#auditForm").submit();
                }else if (v == 'cancel'){

                }
                return true;
            };

            $.jBox.confirm("确定提交审核吗？", "提示", submit);
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

        //财务批量审核
        function financeAuditBatch(){
            //获取选中选项的值
            var flagStatus = 0;
            var valArr = new Array;
            $("#tabTbody :checkbox[checked]").each(function(i){
                var dataStatus = $(this).attr("data-status");
                if(dataStatus != 3){
                    flagStatus = 1;
                }
                valArr[i] = $(this).val();
            });
            var vals = valArr.join(',');
            if(vals == "" || vals == undefined){
                $.jBox.info('请至少选择一条记录', '提示');
                return false;
            }

            if(flagStatus == 1){
                $.jBox.info('只有待审核的才能审核！', '警告');
                return false;
            }

            $("#objStr").val(vals);

            $.jBox.open("iframe:${ctx}/im/finance/bill/toAudit", "审核", 450, 280, {
                buttons:{"通过":"ok","不通过":"notok","关闭":true}, submit:function(v, h, f){
                    var opinion = h.find("iframe")[0].contentWindow.$("#opinion").val();
                    $("#batchOpinion").val(opinion);
                    if (v=="ok"){
                        $("#auditBatchStatus").val("1");
                        $("#auditForm").submit();
                    }else if(v=="notok"){
                        $("#auditBatchStatus").val("2");
                        $("#auditForm").submit();
                    }
                }, loaded:function(h){
                    $(".jbox-content", document).css("overflow-y","hidden");
                }
            });
        }

        function show(id){
            $.jBox.open("iframe:${ctx}/im/finance/bill/toShow?id="+id, "查看", 800, 550, {
                buttons:{"关闭":true}, submit:function(v, h, f){}, loaded:function(h){
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

<form:form id="auditForm" modelAttribute="financeBill" action="${ctx}/im/finance/bill/submitAuditBatch" method="post" class="form-horizontal">
    <form:hidden path="objStr"/>
    <input type="hidden" name="financeStatus" id="auditBatchStatus"/>
    <input type="hidden" name="opinion" id="batchOpinion"/>
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
            <form:select path="matter" class="input-medium" cssStyle="width: 200px;">
                <option selected value="">请选择</option>
                <form:options items="${fns:getDictList('im_matter')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
        <li>
            <label>审核状态：</label>
            <select name="financeStatus" class="input-medium">
                <option selected value="">请选择</option>
                <option value="0">未审核</option>
                <option value="1">审核通过</option>
                <option value="2">审核不通过</option>
                <option value="3">待审核</option>
            </select>
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
        <shiro:hasRole name="yyb-gly">
            <li class="btns"><input class="btn btn-primary" type="button" value="提交审核" onclick="batchAudit();"/>
        </shiro:hasRole>
        <shiro:hasRole name="cwb-gly">
            <li class="btns"><input class="btn btn-primary" type="button" value="财务审核" onclick="financeAuditBatch();"/>
        </shiro:hasRole>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th width="20px;"><input type="checkbox" id="all"></th>
        <th>标题</th>
        <th class="sort-column matter">报销事项</th>
        <th class="sort-column bill_time" width="90px;">报销日期</th>
        <th width="70px;">金额</th>
        <th width="70px;">报销人</th>
        <th width="70px;">支付情况</th>
        <th width="70px;">审核状态</th>
        <th width="180px;">操作</th>
    </thead>
    <tbody id="tabTbody">
    <c:forEach items="${page.list}" var="financeBill">
        <tr>
            <td><input type="checkbox" value="${financeBill.id}" data-status="${financeBill.financeStatus}"></td>
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
                        <span style="color: green">审核通过</span>
                    </c:when>
                    <c:when test="${financeBill.financeStatus == 2}">
                        <span style="color: red">审核不通过</span>
                    </c:when>
                    <c:when test="${financeBill.financeStatus == 3}">
                        <span style="color: goldenrod">待审核</span>
                    </c:when>
                </c:choose>
            </td>
            <td style="word-wrap:break-word;">

                <a href="javascript:void(0)" onclick="show('${financeBill.id}')">查看</a>
                <c:if test="${financeBill.financeStatus == 0}">
                    <a href="${ctx}/im/finance/bill/form?id=${financeBill.id}">修改</a>
                    <shiro:lacksRole name="dept">
                        <a href="${ctx}/im/finance/bill/delete?id=${financeBill.id}" onclick="return confirmx('确认要删除吗？', this.href)">删除</a>
                    </shiro:lacksRole>
                    <shiro:hasPermission name="im:financebill:submitaudit">
                        <a href="${ctx}/im/finance/bill/submitAudit?id=${financeBill.id}" onclick="return confirmx('确认要提交审核吗？', this.href)">提交审核</a>
                    </shiro:hasPermission>
                </c:if>
                <shiro:hasPermission name="im:financebill:audit">
                    <c:if test="${financeBill.financeStatus == 3}">
                        <a href="javascript:void(0);" onclick="financeAudit('${financeBill.id}');">财务审核</a>
                    </c:if>
                </shiro:hasPermission>

                <%--系统管理员可以删除任何数据--%>
                <shiro:hasRole name="dept">
                    <a href="${ctx}/im/finance/bill/delete?id=${financeBill.id}" onclick="return confirmx('确认要删除吗？', this.href)">删除</a>
                </shiro:hasRole>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>