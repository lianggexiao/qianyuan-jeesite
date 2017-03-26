<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>区域管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        var errFlag = 0;
        $(document).ready(function () {
            $("#title").focus();
        });

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

            var arr = [];
            $('#page-tbody').find('.gradeX').each(function () {
                var self = $(this);
                var obj = {
                    goodsName: self.attr('data-prd-name'),
                    amount: self.find('.prd-amount').val(),
                    totalAmount: self.find('.prd-totalAmount').val(),
                    remarks: self.find('.prd-remarks').val()
                };
                arr.push(obj);
            });
            $("#objStr").val(JSON.stringify(arr));
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

        function ToGetList(){
            var jBoxConfig = {};
            jBoxConfig.defaults = {
                top:'2%',
            };
            $.jBox.setDefaults(jBoxConfig)
            $.jBox.open("iframe:${ctx}/im/goods/toSelectGoods", "选择产品", 800, 450, {
                buttons:{"确定":"ok","关闭":true}, submit:function(v, h, f){
                    if (v=="ok"){
                        var arr = [];
                        var isRepeat = false;

                        h.find("iframe")[0].contentWindow.$("#dialogTbody").find('input:radio').each(function (i, val) {
                            var self = $(this);
                            if (self[0].checked === true) {
                                var parent = self.parents('tr');
                                var obj = {
                                    id: parent.attr('data-id'),
                                    name: parent.attr('data-prd-name')
                                };
                                arr.push(obj);
                            }
                        });

                        //如果没有选择产品给提示
                        if (arr.length === 0) {
                            alert("请选择一款产品");
                            return false;
                        } else {
                            $('#page-tbody').find('tr').each(function () {
                                var self = $(this);
                                if (arr.length !== 0 && self.attr('data-prd-name') === arr[0].name) {
                                    isRepeat = true;
                                    alert("你已添加过此产品了");
                                }
                            });

                            if (isRepeat) {//如果有重复产品，则跳出去
                                return false;
                            }

                            //插入表格
                            InsertTable(arr);
                        }
                    }
                }, loaded:function(h){
                    $(".jbox-content", document).css("overflow-y","hidden");
                }
            });
        }

        //插入表格
        function InsertTable(arr) {
            var $pageBody = $('#page-tbody');
            var sHtml = '';
            sHtml += '<tr class="odd gradeX" data-id="' + arr[0].id + '" data-prd-name="' + arr[0].name + '" >';
            sHtml += '<td style="width:24px"><div class="checker"><span><input type="checkbox" class="checkboxes"></span></div></td>';
            sHtml += '<td class="newtab"><div>';
            sHtml += '<p>产品名称：<span>' + arr[0].name + '</span></p>';
            sHtml += '</div>';
            sHtml += '</td><td>'
            sHtml += '<p>数量：<input type="text" class="prd-amount" style="width:100px;" value="1">';
            sHtml += '&nbsp;&nbsp; 总金额：<input type="text" class="prd-totalAmount" style="width:100px;" value=""></p>';
            sHtml += '</td><td>'
            sHtml += '<div>备注：<input type="text" class="prd-remarks" value=""></div>';
            sHtml += '</td>';
            sHtml += '</tr>';
            $pageBody.append(sHtml);
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
            <form:select path="matter" class="input-medium">
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
            <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">报销产品:</label>
        <div class="controls">
            <input id="toSelect" class="btn btn-primary" type="button" value="添加产品" onclick="ToGetList();"/>&nbsp;
            <input class="btn" type="button" value="删除产品" onclick="ClickDel();"/>
        </div>
        <hr>
        <table id="page-tbody" class="table table-striped table-bordered table-condensed">
            <c:forEach items="${financeDetailBillList}" var="financeDetailBill">
                <tr class="odd gradeX" data-id="${financeDetailBill.id}"  data-prd-name="${financeDetailBill.goodsName}">
                    <td style="width:24px">
                        <div class="checker"><span><input type="checkbox" class="checkboxes"></span></div>
                    </td>
                    <td>
                        <div>
                            <p>产品名称：<span>${financeDetailBill.goodsName}</span></p>
                        </div>
                    </td>
                    <td>
                        <p>数量：<input type="text" class="prd-amount" style="width:100px;" value="${financeDetailBill.amount}">
                            &nbsp;&nbsp; 总金额：<input type="text" class="prd-totalAmount" style="width:100px;" value="${financeDetailBill.totalAmount}"></p>
                    </td>
                    <td>
                        <div>
                            备注：
                            <input type="text" class="prd-remarks" maxlength="12" value="${financeDetailBill.remarks}">
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="button" onclick="ClickSave();" value="保 存"/>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>