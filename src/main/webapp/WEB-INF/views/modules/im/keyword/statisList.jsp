<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>关键词统计</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}/echarts-2.2.7/dist/echarts.js"></script>
    <script type="text/javascript">
        // 路径配置
        require.config({
            paths: {
                echarts: '${ctxStatic}/echarts-2.2.7/dist'
            }
        });
        require(
                [
                    'echarts',
                    'echarts/theme/macarons',
                    'echarts/chart/line',
                    'echarts/chart/bar'
                ],
                function (ec,theme) {
                    // 基于准备好的dom，初始化echarts图表
                    var myChart = ec.init(document.getElementById('main'),theme);

                    var option = {
                        tooltip : {
                            trigger: 'axis'
                        },
                        legend: {
                            data:${keywordStrList}
                        },
                        toolbox: {
                            show : true,
                            feature : {
                                mark : {show: true},
                                dataView : {show: true, readOnly: false},
                                magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
                                restore : {show: true},
                                saveAsImage : {show: true}
                            }
                        },
                        calculable : true,
                        xAxis : [
                            {
                                type : 'category',
                                boundaryGap : false,
                                data : ${dateList}
                            }
                        ],
                        yAxis : [
                            {
                                type : 'value'
                            }
                        ],
                        series : ${keywordMap}
                    };

                    // 为echarts对象加载数据
                    myChart.setOption(option);
                }
        );

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
        <li class="active"><a href="${ctx}/im/keyword/statis">关键词统计</a></li>
    </ul>
    <form:form id="searchForm" modelAttribute="keyword" action="${ctx}/im/keyword/statis" method="post"
               class="breadcrumb form-search ">
        <ul class="ul-form">
            <li>
                <label>店铺：</label>
                <form:select path="shopName" class="input-medium">
                    <form:options items="${fns:getDictList('im_shop_classify')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                </form:select>
            </li>
            <li>
                <label>产品:</label>
                <input id="goodsName" name="goodsNameStr" onclick="toSelectGoods();" readonly="true" value="${keyword.goodsName}"/>
            </li>
            <li>
                <label>关键字：</label>
                <form:input path="keyword" htmlEscape="false" maxlength="50" class="input-medium"/>
            </li>
            <li>
                <label>统计内容：</label>
                <form:select path="statisStatus" class="input-medium">
                    <form:options items="${fns:getDictList('im_statis_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                </form:select>
            </li>
            <li>
                <label>统计日期:</label>
                <form:input path="endKeyTime"  name="endDate" id="endDate" type="text" readonly="readonly" maxlength="20"
                            class="input-medium Wdate"
                            onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"  placeholder="结束日期"/>
            </li>
            <li class="btns">
                <input id="btnSubmit" class="btn btn-primary" type="submit" value="统计" onclick="return page();"/>
                将会统计前十天数据
            </li>
            <li class="clearfix"></li>
        </ul>
    </form:form>
    <sys:message content="${message}"/>
    <br>
    <div id="main" style="height:500px"></div>
</body>
</html>