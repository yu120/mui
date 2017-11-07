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
                <form action="${ctx}/limiter/update-global-config" method="post">
                    <div class="ibox-content">
                        <table border="0" class="col-sm-12">
                            <tr>
                                <td><h4 style="display:inline">全局配置</h4>
                                    <small>（集群限流系统参数值配置）</small>
                                </td>
                                <td style="text-align: right">
                                    <button class="btn btn-danger btn-xs" type="submit">
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
                                    <th rowspan="2">打印限流日志</th>
                                    <th rowspan="2">推送限流事件</th>
                                    <th colspan="3" style="text-align: center">监控统计配置</th>
                                    <th rowspan="2">配置拉取周期</th>
                                </tr>
                                <tr>
                                    <th>统计上报</th>
                                    <th>上报周期</th>
                                    <th>数据过期周期</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <th>
                                        <input type="text" name="enable"
                                               value="${globalConfig.enable?'true':'false'}" style="display: none"/>
                                        <input type="checkbox" id="enable"
                                               class="js-switch_1" ${globalConfig.enable?'checked':''}/>
                                    </th>
                                    <th>
                                        <input type="text" name="printExceedLog"
                                               value="${globalConfig.printExceedLog?'true':'false'}"
                                               style="display: none"/>
                                        <input type="checkbox" id="printExceedLog"
                                               class="js-switch_2" ${globalConfig.printExceedLog?'checked':''} />
                                    </th>
                                    <th>
                                        <input type="text" name="broadcastEvent"
                                               value="${globalConfig.broadcastEvent?'true':'false'}"
                                               style="display: none"/>
                                        <input type="checkbox" id="broadcastEvent"
                                               class="js-switch_3" ${globalConfig.broadcastEvent?'checked':''} />
                                    </th>
                                    <th>
                                        <input type="text" name="statisticReportEnable"
                                               value="${globalConfig.statisticReportEnable?'true':'false'}"
                                               style="display: none"/>
                                        <input type="checkbox" id="statisticReportEnable"
                                               class="js-switch_4" ${globalConfig.statisticReportEnable?'checked':''}/>
                                    </th>
                                    <th><input type="text" placeholder="请输入参数……" name="pushStatisticCycle"
                                               class="form-control" value="${globalConfig.pushStatisticCycle}"
                                               style="width:75px;display:inline"/>
                                        ms
                                    </th>
                                    <th><input type="text" placeholder="请输入参数……" name="statisticDataExpire"
                                               class="form-control" value="${globalConfig.statisticDataExpire}"
                                               style="width:90px;display:inline"/>
                                        ms
                                    </th>
                                    <th>
                                        <input type="text" placeholder="请输入参数……" name="pullConfigCycle"
                                               class="form-control"
                                               onblur="onblus()" value="${globalConfig.pullConfigCycle}"
                                               style="width:75px;display:inline"/> ms
                                    </th>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </form>
                <div class="ibox-content">
                    <h4 style="display:inline">限流规则</h4>
                    <small>（限流资源集群参数配置）</small>
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
                                <td>${limiterConfig.config.title}</td>
                                <td>${limiterConfig.identity.resource}</td>
                                <td>${limiterConfig.identity.group}</td>
                                <td>${limiterConfig.identity.application}</td>
                                <td>
                                    <button class="btn btn-${limiterConfig.config.enable?'success':'danger'} btn-circle btn-xs"
                                            title="${limiterConfig.config.enable?'打开':'关闭'}" type="button"
                                            style="background-color:#1AB394">
                                        <i class="fa fa-${limiterConfig.config.enable?'check':'times'}"></i>
                                    </button>
                                </td>
                                <td class="center" style="color: #1AB394">
                                        ${limiterConfig.config.rate}
                                    times /
                                    <c:choose>
                                        <c:when test="${'DAY'==limiterConfig.config.granularity}">d</c:when>
                                        <c:when test="${'HOUR'==limiterConfig.config.granularity}">h</c:when>
                                        <c:when test="${'MINUTE'==limiterConfig.config.granularity}">m</c:when>
                                        <c:when test="${'SECOND'==limiterConfig.config.granularity}">s</c:when>
                                        <c:when test="${'MILLISECOND'==limiterConfig.config.granularity}">ms</c:when>
                                        <c:otherwise><font color="red">未知策略</font></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="center" style="color: #1AB394">${limiterConfig.config.concurrency}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${'EXCEPTION'==limiterConfig.config.strategy}">
                                            <a class="btn btn-danger btn-xs btn-rounded">抛异常</a>
                                        </c:when>
                                        <c:when test="${'NON'==limiterConfig.config.strategy}">
                                            <a class="btn btn-warning btn-xs btn-rounded">不处理</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="btn btn-danger btn-xs btn-rounded">未知策略</a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${limiterConfig.config.remarks}</td>
                                <td>
                                    <a href="${ctx}/limiter/limiter-config/${limiterConfig.identity.application}/${limiterConfig.identity.group}/${limiterConfig.identity.resource}">
                                        <button class="btn btn-success btn-xs" type="button"
                                                style="background-color: #1AB394">
                                            <i class="fa fa-paste"></i> 编辑
                                        </button>
                                    </a>
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
            var colorArray = ['#ED5565', '#1AB394', '#1AB394', '#1AB394']
            for (var i = 1; i <= 4; i++) {
                new Switchery(document.querySelector('.js-switch_' + i), {color: colorArray[i - 1]});
            }

            var nameArray = ['enable', 'printExceedLog', 'broadcastEvent', 'statisticReportEnable']
            $('span[id=enable]').click(function () {
                var obj = $('input[name=enable]');
                if (obj.val() == 'true') {
                    obj.attr('value', false)
                } else {
                    obj.attr('value', true)
                }
            });
            $('span[id=printExceedLog]').click(function () {
                var obj = $('input[name=printExceedLog]');
                if (obj.val() == 'true') {
                    obj.attr('value', false)
                } else {
                    obj.attr('value', true)
                }
            });
            $('span[id=broadcastEvent]').click(function () {
                var obj = $('input[name=broadcastEvent]');
                if (obj.val() == 'true') {
                    obj.attr('value', false)
                } else {
                    obj.attr('value', true)
                }
            });
            $('span[id=statisticReportEnable]').click(function () {
                var obj = $('input[name=statisticReportEnable]');
                if (obj.val() == 'true') {
                    obj.attr('value', false)
                } else {
                    obj.attr('value', true)
                }
            });


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
        }
    );

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