<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>区域管理</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" htef="${ctxStatic}/ueditor/themes/default/css/ueditor.css" />
    <script src="${ctxStatic}/ueditor/ueditor.config.js" charset="utf-8" type="text/javascript" ></script>
    <script src="${ctxStatic}/ueditor/ueditor.all.min.js" charset="utf-8" type="text/javascript" ></script>
    <script type="text/javascript" charset="utf-8" src="${ctxStatic}/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script src="${ctxStatic}/ueditor/jbase64.js" charset="utf-8" type="text/javascript" ></script>
    <script type="text/javascript">
        var editor = null;

        $(document).ready(function () {
            var item = {
                maximumWords:4000,
                zIndex:0
            };
            editor = UE.getEditor('editor', item);
        });

        var errFlag = 0;
        //点击保存
        function ClickSave() {
            var title = $("#title").val();
            var billTime = $("#billTime").val();
            if(title == "" || title == undefined){
                alert("标题不能为空");
                return false;
            }
            if(billTime == "" || billTime == undefined){
                alert("报销日期不能为空");
                return false;
            }

            var content = UE.getEditor('editor').getContent();
            $("#remarks").val(BASE64.encoder(content));
            $("#inputForm").submit();
        }

        //点击删除
        function ClickDel() {
            var code = '';
            var arr = [];
            $('#page-tbody').find('.checkboxes').each(function (i, val) {
                var self = $(this);
                if (self[0].checked) {
                    var parent = self.parents('tr');
                    arr.push(parent.rowIndex);
                    $(parent).remove();
                }
            });

            //如果没有选择，则不删除
            if (arr.length === 0) {
                alert('请至少选择一条数据');
            }
        }


    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/im/finance/bill/">报销单列表</a></li>
    <li class="active"><a href="form?id=${financeBill.id}">报销单${not empty financeBill.id?'修改':'添加'}</a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="financeBill" action="${ctx}/im/finance/bill/save" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <form:hidden path="objStr"/>
    <form:hidden path="remarks"/>
    <sys:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">标题:</label>
        <div class="controls">
            <form:input path="title" htmlEscape="false" maxlength="50" class="required"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">报销日期:</label>
        <div class="controls">
            <input name="billTime" id="billTime" htmlEscape="false" maxlength="20" readonly="readonly"
                   value="<fmt:formatDate value='${financeBill.billTime}' pattern='yyyy-MM-dd' />"
                        class="input-medium Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"  placeholder="报销日期"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">报销事项:</label>
        <div class="controls">
            <form:select path="matter" class="input-medium" cssStyle="width: 200px;">
                <form:options items="${fns:getDictList('im_matter')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">报销金额:</label>
        <div class="controls">
            <form:input path="amount" htmlEscape="false" maxlength="50"/>
            <form:input path="amountCapital" htmlEscape="false" maxlength="50" placeholder="金额大写"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">支付情况:</label>
        <div class="controls">
            <form:select path="payment" class="input-medium">
                <form:options items="${fns:getDictList('im_payment')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">报销人:</label>
        <div class="controls">
            <form:select path="billUser" class="input-medium">
                <form:options items="${fns:getDictList('im_bill_user')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">备注:</label>
        <div class="controls">
            <script id="editor" type="text/plain" style="width:95%;height:300px;"></script>
        </div>
    </div>
    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="button" onclick="ClickSave();" value="保 存"/>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
<script type="text/javascript">
    $(document).ready(function () {
        editor.ready(function() {
            editor.setContent($('#remarks').val());  //赋值给UEditor
        });
    });
</script>
</body>
</html>