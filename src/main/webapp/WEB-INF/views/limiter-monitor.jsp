<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="library/master.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>限流统计 - 分布式限流</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="favicon.ico">
    <link href="${ctx}/res/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx}/res/css/font-awesome.css?v=4.4.0" rel="stylesheet">

    <!-- Data Tables -->
    <link href="${ctx}/res/css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="${ctx}/res/css/animate.css" rel="stylesheet">
    <link href="${ctx}/res/css/style.css?v=4.1.0" rel="stylesheet">
    <link href="${ctx}/res/css/plugins/switchery/switchery.css" rel="stylesheet">

    <link rel="stylesheet" href="${ctx}/res/chart/css/animsition.min.css"/>
    <link rel="stylesheet" href="${ctx}/res/chart/css/drop-down.css"/>
    <link rel="stylesheet" href="${ctx}/res/chart/css/common.css"/>
    <link rel="stylesheet" href="${ctx}/res/chart/css/system.css"/>
</head>

<body>
<div class="data_wrap" style="background: #efeff5; width: 1020px; padding: 10px; overflow: hidden;">
    <div class="animsition">
        <div style="background: white; solid: #efeff5; width: 1020px; overflow: hidden;">
            <div id="main3" style="height:350px; width: 1020px; clear: both; border-top: 10px solid #efeff5;"></div>
        </div>
    </div>
</div>
</div>

<script src="${ctx}/res/chart/js/jquery.min.js"></script>
<script src="${ctx}/res/chart/js/jquery-ui.min.js"></script>
<script src="${ctx}/res/chart/js/select-widget-min.js"></script>
<script src="${ctx}/res/chart/js/jquery.animsition.min.js"></script>
<script src="${ctx}/res/chart/js/echarts.min.js"></script>
<script src="${ctx}/res/chart/js/macarons .js"></script>
<script src="${ctx}/res/chart/js/common.js"></script>

<script>
    $(document).ready(function () {
        //初始化切换
        $(".animsition").animsition({
            inClass: 'fade-in-right',
            outClass: 'fade-out',
            inDuration: 1500,
            outDuration: 800,
            linkElement: '.animsition-link',
            // e.g. linkElement   :   'a:not([target="_blank"]):not([href^=#])'
            loading: true,
            loadingParentElement: 'body', //animsition wrapper element
            loadingClass: 'animsition-loading',
            unSupportCss: ['animation-duration',
                '-webkit-animation-duration',
                '-o-animation-duration'
            ],

            overlay: false,
            overlayClass: 'animsition-overlay-slide',
            overlayParentElement: 'body'
        });

        // 基于准备好的dom，初始化echarts实例
        var myChart3 = echarts.init(document.getElementById('main3'), 'macarons');

        // 指定图表的配置项和数据
        var date = ['10:01:00', '10:01:10', '10:01:20', '10:01:30', '10:01:40', '10:01:50',
            '10:02:00', '10:02:10', '10:02:20', '10:02:30', '10:02:40', '10:02:50',
            '10:03:00', '10:03:10', '10:03:20', '10:03:30', '10:03:40', '10:03:50',
            '10:04:00', '10:04:10', '10:04:20', '10:04:30', '10:04:40', '10:04:50',
            '10:05:00', '10:05:10', '10:05:20', '10:05:30', '10:05:40', '10:05:50'];

        function my_time() {
            var date = [];
            for (var i = 0; i < 30; i++) {
                date.push(new Date().Format("yyyy-MM-dd HH:mm:ss"));
            }
            return date;
        }

        function my_data() {
            var data = [];
            for (var i = 0; i < 30; i++) {
                data.push(Math.round(Math.random() * (500 - 100) + 100));
            }
            ;
            return data;
        }

        var option3 = {
            title: {
                text: '分布式限流流量监控'
            },
            tooltip: {
                trigger: 'axis',
            },
            legend: {
                data: ['平均并发数', '最大并发数', '平均耗时', '最大耗时', 'TPS', '失败率']
            },
            toolbox: {
                show: true,
                feature: {
                    mark: {show: true},
                    dataView: {show: true, readOnly: false},
                    magicType: {show: true, type: ['line', 'bar', 'stack', 'tiled']},
                    restore: {show: true},
                    saveAsImage: {show: true}
                }
            },
            calculable: true,
            xAxis: [
                {
                    type: 'category',
                    boundaryGap: false,
                    data: my_time()
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            grid: {
                left: '3%',
                right: '4%',
                containLabel: true
            },
            dataZoom: [{
                type: 'inside',
                start: 74,
                end: 100,
            }, {
                start: 74,
                end: 100,
                handleSize: '80%',
                handleStyle: {
                    color: '#fff',
                    shadowBlur: 3,
                    shadowColor: 'rgba(0, 0, 0, 0.6)',
                    shadowOffsetX: 2,
                    shadowOffsetY: 2
                }
            }],
            series: [
                {
                    name: '平均并发数',
                    type: 'bar',
                    stack: '总量',
                    barMaxWidth: 30,
                    //itemStyle: {normal: {areaStyle: {type: 'default'}}},
                    data: my_data()
                },
                {
                    name: '最大并发数',
                    type: 'bar',
                    stack: '总量',
                    //itemStyle: {normal: {areaStyle: {type: 'default'}}},
                    data: my_data()
                },
                {
                    name: '平均耗时',
                    type: 'bar',
                    stack: '总量',
                    //itemStyle: {normal: {areaStyle: {type: 'default'}}},
                    data: my_data()
                },
                {
                    name: '最大耗时',
                    type: 'bar',
                    stack: '总量',
                    //itemStyle: {normal: {areaStyle: {type: 'default'}}},
                    data: my_data()
                },
                {
                    name: 'TPS',
                    type: 'bar',
                    stack: '总量',
                    //itemStyle: {normal: {areaStyle: {type: 'default'}}},
                    data: my_data()
                },
                {
                    name: '失败率',
                    type: 'bar',
                    stack: '总量',
                    //itemStyle: {normal: {areaStyle: {type: 'default'}}},
                    data: my_data()
                }
            ]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart3.setOption(option3);
        window.setInterval(function () {
            var data = my_data();
//            $.get("SQLTest.ashx",function(responseTxt,statusTxt,xhr)
//            {
                if (!myChart3) {
                    return;
                }
                myChart3.setOption({
                    xAxis: [{data: my_time()}],
                    series: [
                        {data: my_data()},
                        {data: my_data()},
                        {data: my_data()},
                        {data: my_data()},
                        {data: my_data()},
                        {data: my_data()}
                    ]
                });
//            });
        }, 1000);
    });

    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }
</script>
</body>
</html>
