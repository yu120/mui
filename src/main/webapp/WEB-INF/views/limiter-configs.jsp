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

</head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>分布式限流
                        <small>微治理 > 分布式限流</small>
                    </h5>
                </div>
                <div class="ibox-content">
                    <table border="0" class="col-sm-12">
                        <tr>
                            <td><h4 style="display:inline">全局配置</h4><small>（集群限流系统参数值配置）</small></td>
                            <td style="text-align: right">
                                <button class="btn btn-danger btn-xs" type="button">
                                    <i class="fa fa-check"></i> 修改配置
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="ibox-content">
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th rowspan="2">限流总开关</th>
                                <th rowspan="2">拉取配置周期</th>
                                <th colspan="3" style="text-align: center">监控统计配置</th>
                                <th colspan="5" style="text-align: center">打印日志配置开关<small>（高并发会输出大量日志）</small></th>
                            </tr>
                            <tr>
                                <th>监控开关</th>
                                <th>监控上报周期</th>
                                <th>数据过期时间</th>
                                <th>刷新配置</th>
                                <th>流量溢出</th>
                                <th>未启动限流</th>
                                <th>统计任务</th>
                                <th>统计异常</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th><input type="checkbox" class="js-switch_1" ${globalConfig.enable?'checked':''}/></th>
                                <th><input type="text" placeholder="请输入参数……" class="form-control"
                                           value="${globalConfig.pullCycle}" style="width:75px;display:inline"/> ms</th>
                                <th><input type="checkbox" class="js-switch_2" ${globalConfig.statisticReportEnable?'checked':''}/></th>
                                <th><input type="text" placeholder="请输入参数……" class="form-control"
                                           value="${globalConfig.statisticReportCycle}" style="width:75px;display:inline"/> ms</th>
                                <th><input type="text" placeholder="请输入参数……" class="form-control"
                                           value="${globalConfig.statisticDataExpire}" style="width:90px;display:inline"/> ms</th>
                                <th><input type="checkbox" class="js-switch_3" ${globalConfig.printRefreshLog?'checked':''}/></th>
                                <th><input type="checkbox" class="js-switch_4" ${globalConfig.printExceedLog?'checked':''}/></th>
                                <th><input type="checkbox" class="js-switch_5" ${globalConfig.printNoStartedLog?'checked':''}/></th>
                                <th><input type="checkbox" class="js-switch_6" ${globalConfig.printStatisticsTaskLog?'checked':''}/></th>
                                <th><input type="checkbox" class="js-switch_7" ${globalConfig.printStatisticsExceptionLog?'checked':''}/></th>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <h4 style="display:inline">限流规则</h4><small>（限流资源集群参数配置）</small>
                    <table class="table table-striped table-bordered table-hover dataTables-example">
                        <thead>
                        <tr>
                            <th>限流标题</th>
                            <th>限流ID</th>
                            <th>所属组</th>
                            <th>所属应用</th>
                            <th>开关</th>
                            <th>速率阀值</th>
                            <th>并发量</th>
                            <th>超额策略</th>
                            <th>备注信息</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${limiterConfigs}" var="limiterConfig">
                            <tr class="gradeX">
                                <td>${limiterConfig.title}</td>
                                <td>${limiterConfig.neuralObject.resource}</td>
                                <td>${limiterConfig.neuralObject.group}</td>
                                <td>${limiterConfig.neuralObject.application}</td>
                                <td>
                                    <button class="btn btn-${limiterConfig.enable?'success':'danger'} btn-circle btn-xs"
                                            title="${limiterConfig.enable?'打开':'关闭'}" type="button" style="background-color: rgb(26, 179, 148)">
                                        <i class="fa fa-${limiterConfig.enable?'check':'times'}"></i>
                                    </button>
                                </td>
                                <td class="center">
                                        ${limiterConfig.rate}
                                    次 /
                                    <c:choose>
                                        <c:when test="${'YEAR'==limiterConfig.granularity}">年</c:when>
                                        <c:when test="${'MONTH'==limiterConfig.granularity}">月</c:when>
                                        <c:when test="${'DAY'==limiterConfig.granularity}">日</c:when>
                                        <c:when test="${'HOUR'==limiterConfig.granularity}">时</c:when>
                                        <c:when test="${'MINUTE'==limiterConfig.granularity}">分</c:when>
                                        <c:when test="${'SECOND'==limiterConfig.granularity}">秒</c:when>
                                        <c:otherwise><font color="red">未知策略</font></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="center">${limiterConfig.concurrency}</td>
                                <td>
                                    <span style="color: ${('EXCEPTION'==limiterConfig.strategy)?'rgb(237, 85, 101)':('NON'==limiterConfig.strategy?'rgb(250, 215, 51)':'gray')}">
                                        <c:choose>
                                            <c:when test="${'EXCEPTION'==limiterConfig.strategy}">抛异常</c:when>
                                            <c:when test="${'NON'==limiterConfig.strategy}">不处理</c:when>
                                            <c:otherwise>未知策略</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                                <td>${limiterConfig.remarks}</td>
                                <td>
                                    <button class="btn btn-success btn-xs" type="button" style="background-color: rgb(26, 179, 148)">
                                        <i class="fa fa-paste"></i> 编辑
                                    </button>
                                    <a href="${ctx}/limiter/limiter-monitor">
                                        <button class="btn btn-info btn-xs" type="button">
                                            <i class="fa fa-line-chart"></i> 监控
                                        </button>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                </div>
            </div>
        </div>
    </div>
</div>

<!-- 全局js -->
<script src="${ctx}/res/js/jquery.min.js?v=2.1.4"></script>
<script src="${ctx}/res/js/bootstrap.min.js?v=3.3.6"></script>

<script src="${ctx}/res/js/plugins/jeditable/jquery.jeditable.js"></script>

<!-- Data Tables -->
<script src="${ctx}/res/js/plugins/dataTables/jquery.dataTables.js"></script>
<script src="${ctx}/res/js/plugins/dataTables/dataTables.bootstrap.js"></script>

<script src="${ctx}/res/js/plugins/datapicker/bootstrap-datepicker.js"></script>
<script src="${ctx}/res/js/plugins/switchery/switchery.js"></script>
<script src="${ctx}/res/js/plugins/cropper/cropper.min.js"></script>
<!-- Page-Level Scripts -->
<script>
    $(document).ready(function () {
        new Switchery(document.querySelector('.js-switch_1'), {color: '#ED5565'});
        new Switchery(document.querySelector('.js-switch_2'), {color: '#ED5565'});
        new Switchery(document.querySelector('.js-switch_3'), {color: '#1AB394'});
        new Switchery(document.querySelector('.js-switch_4'), {color: '#1AB394'});
        new Switchery(document.querySelector('.js-switch_5'), {color: '#1AB394'});
        new Switchery(document.querySelector('.js-switch_6'), {color: '#1AB394'});
        new Switchery(document.querySelector('.js-switch_7'), {color: '#1AB394'});

        $('.dataTables-example').dataTable();
        /* Init DataTables */
        var oTable = $('#editable').dataTable();
        /* Apply the jEditable handlers to the table */
        oTable.$('td').editable('../example_ajax1.php', {
            "callback": function (sValue, y) {
                var aPos = oTable.fnGetPosition(this);
                oTable.fnUpdate(sValue, aPos[0], aPos[1]);
            },
            "submitdata": function (value, settings) {
                return {
                    "row_id": this.parentNode.getAttribute('id'),
                    "column": oTable.fnGetPosition(this)[2]
                };
            },
            "width": "90%",
            "height": "100%"
        });
    });

    function fnClickAddRow() {
        $('#editable').dataTable().fnAddData([
            "Custom row",
            "New row",
            "New row",
            "New row",
            "New row"]);
    }
</script>

</body>
</html>