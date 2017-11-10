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

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="col-sm-12">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>交易监控
                    <small>（${limiterConfig.identity.application} / ${limiterConfig.identity.group}
                        / ${limiterConfig.identity.resource}）
                    </small>
                </h5>
            </div>
            <div class="ibox-content">
                <div id="trade" style="height:300px;width:100%;"></div>
            </div>
            <div class="ibox-title">
                <h5>并发监控
                    <small>（最大允许并发：${limiterConfig.config.concurrency}）</small>
                </h5>
            </div>
            <div class="ibox-content">
                <div id="concurrency" style="height:200px;width:100%;"></div>
            </div>
            <div class="ibox-title">
                <h5>QPS监控
                    <small>（最大允许速率：${limiterConfig.config.rate}）</small>
                </h5>
            </div>
            <div class="ibox-content">
                <div id="qps" style="height:200px;width:100%;"></div>
            </div>
            <div class="ibox-title"><h5>耗时监控</h5></div>
            <div class="ibox-content">
                <div id="elapsed" style="height:200px;width:100%;"></div>
            </div>
        </div>
    </div>
</div>

<script src="${ctx}/res/chart/js/jquery.min.js"></script>
<script src="${ctx}/res/chart/js/jquery-ui.min.js"></script>
<script src="${ctx}/res/chart/js/select-widget-min.js"></script>
<script src="${ctx}/res/chart/js/jquery.animsition.min.js"></script>
<script src="https://cdn.bootcss.com/echarts/3.5.3/echarts.min.js"></script>
<script src="${ctx}/res/chart/js/common.js"></script>
<script src="${ctx}/res/echarts-theme/echarts-theme-walden.js"></script>
<script src="${ctx}/res/echarts-theme/echarts-theme-westeros.js"></script>
<script src="${ctx}/res/echarts-theme/echarts-theme-wonderland.js"></script>
<script src="${ctx}/res/echarts-theme/echarts-theme-macarons.js"></script>
<script src="${ctx}/res/echarts-theme/echarts-theme-essos.js"></script>

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
    });
</script>
<script src="${ctx}/res/monitor/trade.js"></script>
<script src="${ctx}/res/monitor/concurrency.js"></script>
<script src="${ctx}/res/monitor/qps.js"></script>
<script src="${ctx}/res/monitor/elapsed.js"></script>
</body>
</html>
