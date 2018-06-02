<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>财务统计</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}/echarts-2.2.7/dist/echarts.js"></script>
    <script type="text/javascript">
        // 路径配置
        require.config({
            paths: {
                echarts: '${ctxStatic}/echarts-2.2.7/dist'
            }
        });

        // 使用
        require(
                [
                    'echarts',
                    'echarts/theme/macarons',
                    'echarts/chart/pie'
                ],
                function (ec,theme) {
                    // 基于准备好的dom，初始化echarts图表
                    var myChart = ec.init(document.getElementById('main'),theme);

                    var option = {
                        title : {
                            text: '潜渊月支出统计',
                            subtext: '报销单',
                            x:'center'
                        },
                        tooltip : {
                            trigger: 'item',
                            formatter: "{a} <br/>{b} : {c} ({d}%)"
                        },
                        legend: {
                            orient : 'vertical',
                            x : '100px',
                            y : 'center',
                            data:['商品采购','包装采购','赠品采购','售后服务',
                                '刷单','快递费用','广告费用','店铺运营','公司运营','工资绩效']
                        },
                        toolbox: {
                            show : true,
                            feature : {
                                mark : {show: true},
                                dataView : {show: true, readOnly: false},
                                magicType : {
                                    show: true,
                                    type: ['pie'],
                                    option: {
                                        funnel: {
                                            x: '25%',
                                            width: '50%',
                                            funnelAlign: 'left',
                                            max: 1548
                                        }
                                    }
                                },
                                restore : {show: true},
                                saveAsImage : {show: true}
                            }
                        },
                        calculable : true,
                        series : [
                            {
                                name:'访问来源',
                                type:'pie',
                                radius : '55%',
                                center: ['50%', '60%'],
                                data:${statisData}
                            }
                        ]
                    };

                    // 为echarts对象加载数据
                    myChart.setOption(option);
                }
        );
    </script>
</head>
<body>
    <ul class="nav nav-tabs">
        <li class="active"><a href="${ctx}/im/finance/statis/list">报销单统计</a></li>
    </ul>
    <form:form id="inputForm" modelAttribute="financeBill" action="${ctx}/im/finance/statis/list" method="post" class="form-horizontal">
        <label>统计日期:</label>
        <form:input path="startBillTime" name="createDate" id="createDate" type="text" readonly="readonly" maxlength="20"
                    class="input-medium Wdate"
                    onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"  placeholder="开始日期"/>
        <span>--</span>
        <form:input path="endBillTime" name="endDate" id="endDate" type="text" readonly="readonly" maxlength="20"
                    class="input-medium Wdate"
                    onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"  placeholder="结束日期"/>
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="统计"/>
    </form:form>
    <div id="main" style="height:500px"></div>
</body>
</html>