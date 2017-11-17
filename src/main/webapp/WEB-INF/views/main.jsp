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
    <link href="${ctx}/res/css/animate.css" rel="stylesheet">
    <link href="${ctx}/res/css/style.css?v=4.1.0" rel="stylesheet">
</head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-3">
            <div class="ibox">
                <div class="ibox-content">
                    <h5>最近1小时内累积交易量</h5>
                    <h1 class="no-margins">23,403</h1>
                    <div class="stat-percent font-bold" style="color: #23b7e5;">98% <i class="fa fa-bolt"></i></div>
                    <small>成功率</small>
                </div>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="ibox">
                <div class="ibox-content">
                    <h5>今日累积交易量</h5>
                    <h1 class="no-margins">438,200</h1>
                    <div class="stat-percent font-bold" style="color: #23b7e5;">98% <i class="fa fa-bolt"></i></div>
                    <small>成功率</small>
                </div>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="ibox">
                <div class="ibox-content">
                    <h5>本周累积交易量</h5>
                    <h1 class="no-margins">1286,200</h1>
                    <div class="stat-percent font-bold" style="color: #23b7e5;">98% <i class="fa fa-bolt"></i></div>
                    <small>成功率</small>
                </div>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="ibox">
                <div class="ibox-content">
                    <h5>本月累积交易量</h5>
                    <h1 class="no-margins">12738,200</h1>
                    <div class="stat-percent font-bold" style="color: #23b7e5;">98% <i class="fa fa-bolt"></i></div>
                    <small>成功率</small>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>实时交易量监控</h5>
                </div>
                <div class="ibox-content">
                    <div id="trade" style="height:300px;width:100%;"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${ctx}/res/chart/js/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/echarts/3.5.3/echarts.min.js"></script>
<script src="${ctx}/res/chart/js/common.js"></script>
<script src="${ctx}/res/echarts-theme/echarts-theme-walden.js"></script>
<script src="${ctx}/res/echarts-theme/echarts-theme-westeros.js"></script>
<script src="${ctx}/res/echarts-theme/echarts-theme-wonderland.js"></script>
<script src="${ctx}/res/echarts-theme/echarts-theme-macarons.js"></script>
<script src="${ctx}/res/echarts-theme/echarts-theme-essos.js"></script>

<script src="${ctx}/res/monitor/all-trade.js"></script>
</body>
</html>
