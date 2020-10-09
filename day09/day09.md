# 1.  产品销售排行 

## 1.1   pojo

```java
public class ECharsDataVo{

    private List<Integer> yData;
    private List<String> xData;

    public List<Integer> getyData() {
        return yData;
    }

    public void setyData(List<Integer> yData) {
        this.yData = yData;
    }

    public List<String> getxData() {
        return xData;
    }

    public void setxData(List<String> xData) {
        this.xData = xData;
    }
}

```

## 1.2   mapper

修改ContractProductCMapper.xml

```xml
<!--产品的销售情况-->
<select id="listProductSaleData" resultType="cn.yunhe.pojo.ECharsData">
  SELECT PRODUCT_NO name,COUNT(1) value FROM contract_product_c GROUP BY PRODUCT_NO
</select>

```

 

 

修改ContractProductCMapper

```java
List<ECharsData> listProductSaleData();
```

## 1.3   service

修改StatChartServiceImpl

```java
@Override
public List<ECharsData> listProductSaleData() throws Exception {
    return contractProductCMapper.listProductSaleData();
}

```

## 1.4   controller

修改StatChartController

```java
@RequestMapping("/productSale")
public String toProductSale(){
    return "stat/chart/SaleOrder";
}

@RequestMapping("/listProductSaleData")
@ResponseBody
public ECharsDataVo listProductSaleData()throws Exception{
    List<ECharsData> eCharsData = statChartService.listProductSaleData();
    ECharsDataVo productSaleData = new ECharsDataVo();
    for (int i = 0; i < eCharsData.size(); i++) {
        ECharsData charsData =  eCharsData.get(i);
        productSaleData.getxData().add(charsData.getName());
        productSaleData.getyData().add(charsData.getValue());
    }
    return productSaleData;
}

```

## 1.5   jsp

修改SaleOrder.jsp

```java
<body>
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="main" style="width: 100%;height:400px;"></div>
<script type="text/javascript">
    $(function(){
        $.ajax({
            url:'${ctx}/statChart/listProductSaleData',
            type:'post',
            success:showChars
        });
    });
    function showChars(data) {
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));

        // 指定图表的配置项和数据
        var option = {
            //标题
            title : {
                text: '产品销售排行统计',
                x:'center'
            },
            color: ['#3398DB'],
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: data.xData,
                    axisTick: {
                        alignWithLabel: true
                    }
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '产品销售情况',
                    type: 'bar',
                    barWidth: '100%',
                    data: data.yData
                }
            ]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    }
</script>
</body>
</html>

```

 

# 2.  系统访问压力图 

## 2.1   mapper

创建AccessLogMapper.xml

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="cn.yunhe.mapper.AccessLogMapper" >
    <select id="listAccessLogData" resultType="cn.yunhe.pojo.ECharsData">
        SELECT DATE_FORMAT(CREATE_TIME,'%H') name,count(1) value FROM access_log_p GROUP BY name
    </select>
</mapper>

```

 

创建AccessLogMapper

```java
public interface AccessLogMapper {
    List<ECharsData> listAccessLogData();
}

```

## 2.2   service

修改StatChartServiceImpl

```java
@Override
public List<ECharsData> listAccessLogData() throws Exception {
    return accessLogMapper.listAccessLogData();
}

```

## 2.3   controller

修改StatChartController

```java
@RequestMapping("/onlineInfo")
public String toOnlineInfo(){
    return "stat/chart/UserBrowse";
}

@RequestMapping("/listAccessLogData")
@ResponseBody
public ECharsDataVo listAccessLogData()throws Exception{
    List<ECharsData> eCharsData = statChartService.listAccessLogData();
    ECharsDataVo productSaleData = new ECharsDataVo();
    for (int i = 0; i < eCharsData.size(); i++) {
        ECharsData charsData =  eCharsData.get(i);
        productSaleData.getxData().add(charsData.getName());
        productSaleData.getyData().add(charsData.getValue());
    }
    return productSaleData;
}

```

## 2.4   jsp

修改UserBrowse.jsp

```html
<body>
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="main" style="width: 600px;height:400px;"></div>
<script type="text/javascript">
    $(function(){
        $.ajax({
            url:'${ctx}/statChart/listAccessLogData',
            type:'post',
            success:showChars
        });
    });
    function showChars(data) {
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));

        // 指定图表的配置项和数据
        var option = {
            //标题
            title : {
                text: '用户访问统计',
                x:'center'
            },
            xAxis: {
                type: 'category',
                data: data.xData
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                data: data.yData,
                type: 'line'
            }]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    }
</script>
</body>
</html>

</body>
</html>
</html>
```

 

 

 