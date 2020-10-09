<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户访问统计</title>
    <script src="/js/jquery.min.js"></script>
    <script src="/js/echarts.js"></script>
    <script>
        $(function () {
            // 基于准备好的dom，初始化echarts实例
            var myChart = echarts.init(document.getElementById('dd'));

            $.ajax({
                url: "getUserBrowse",
                success: function (d) {
                    var option = {
                        xAxis: {
                            type: 'category',
                            boundaryGap: false,
                            data: d.xdata
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            data: d.ydata,
                            type: 'line',
                            areaStyle: {}
                        }]
                    };
                    myChart.setOption(option);
                }
            });


// Enable data zoom when user click bar.
            var zoomSize = 6;
            myChart.on('click', function (params) {
                console.log(dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)]);
                myChart.dispatchAction({
                    type: 'dataZoom',
                    startValue: dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)],
                    endValue: dataAxis[Math.min(params.dataIndex + zoomSize / 2, data.length - 1)]
                });
            });
        });
    </script>
</head>
<body>
<div id="dd" style="width: 100%;height:600px;"></div>
</body>
</html>
