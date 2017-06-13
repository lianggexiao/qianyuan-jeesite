<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>区域管理</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}/ueditor/ueditor.config.js" charset="utf-8" type="text/javascript" ></script>
    <script src="${ctxStatic}/ueditor/ueditor.all.min.js" charset="utf-8" type="text/javascript" ></script>
    <script type="text/javascript" charset="utf-8" src="${ctxStatic}/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script src="${ctxStatic}/ueditor/jbase64.js" charset="utf-8" type="text/javascript" ></script>
    <script type="text/javascript">
        var editor = null;

        $(document).ready(function () {
            var item = {
                toolbars:[['FullScreen', 'Source', 'Undo', 'Redo','bold','test']],
                wordCount:false,
                elementPathEnabled:false
            };
            editor = UE.getEditor('editor', item);
        });
    </script>
</head>
<body>
<br>
<form:form id="inputForm" modelAttribute="financeBill" action="${ctx}/im/finance/bill/save" method="post" class="form-horizontal">
    <form:hidden path="remarks"/>
    <table>
        <tr>
            <td colspan="2">
                <div class="control-group">
                    <label class="control-label">标题:</label>
                    <div class="controls">
                        <form:input path="title" htmlEscape="false" maxlength="50" class="required"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">报销日期:</label>
                    <div class="controls">
                        <input name="billTime" id="billTime" htmlEscape="false" maxlength="20" readonly="readonly"
                               value="<fmt:formatDate value='${financeBill.billTime}' pattern='yyyy-MM-dd' />"
                               class="input-medium Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"  placeholder="报销日期"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">报销事项:</label>
                    <div class="controls">
                        <form:select path="matter" class="input-medium">
                            <form:options items="${fns:getDictList('im_matter')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">支付情况:</label>
                    <div class="controls">
                        <form:select path="payment" class="input-medium">
                            <form:options items="${fns:getDictList('im_payment')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">报销人:</label>
                    <div class="controls">
                        <form:select path="billUser" class="input-medium">
                            <form:options items="${fns:getDictList('im_bill_user')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="control-group">
                    <label class="control-label">报销金额:</label>
                    <div class="controls">
                        <form:input path="amount" htmlEscape="false" maxlength="50"/>
                        <form:input path="amountCapital" htmlEscape="false" maxlength="50" placeholder="金额大写"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="control-group">
                    <label class="control-label">备注:</label>
                    <div class="controls">
                        <script id="editor" type="text/plain" style="width:99%;height:200px;"></script>
                    </div>
                </div>
            </td>
        </tr>
    </table>
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