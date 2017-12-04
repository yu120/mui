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
    <link href="${ctx}/res/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
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
                                <td>
                                    <h4 style="display:inline">全局配置
                                        <small>（集群限流系统参数值配置）</small>
                                    </h4>
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

                                </tr>
                                <tr>
                                    <th>配置拉取周期</th>
                                    <th>监控上报周期</th>
                                    <th>数据过期周期</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <th>
                                        <input type="text" name="enable"
                                               value="${globalConfig.enable}" style="display: none"/>
                                        <input type="checkbox" id="enable"
                                               class="js-switch_1" ${globalConfig.enable=='ON'?'checked':''}/>
                                    </th>
                                    <th>
                                        <input type="text" name="broadcastEvent"
                                               value="${globalConfig.broadcastEvent}" style="display: none"/>
                                        <input type="checkbox" id="broadcastEvent"
                                               class="js-switch_3" ${globalConfig.broadcastEvent=='ON'?'checked':''} />
                                    </th>
                                    <th>
                                        <input type="text" name="printExceedLog"
                                               value="${globalConfig.printExceedLog}"
                                               style="display: none"/>
                                        <input type="checkbox" id="printExceedLog"
                                               class="js-switch_2" ${globalConfig.printExceedLog=='ON'?'checked':''} />
                                    </th>
                                    <th>
                                        <input type="text" placeholder="请输入参数……" name="pullConfigCycle"
                                               class="form-control"
                                               onblur="onblus()" value="${globalConfig.pullConfigCycle}"
                                               style="width:75px;display:inline"/> ms
                                    </th>
                                    <th>
                                        <input type="text" placeholder="请输入参数……" name="reportStatisticCycle"
                                               class="form-control" value="${globalConfig.reportStatisticCycle}"
                                               style="width:90px;display:inline"/>
                                        ms
                                    </th>
                                    <th>
                                        <input type="text" placeholder="请输入参数……" name="statisticDataExpire"
                                               class="form-control" value="${globalConfig.statisticDataExpire}"
                                               style="width:90px;display:inline"/>
                                        ms
                                    </th>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </form>
                <div class="ibox-content" style="border-top: none;padding-top: 0px;padding-bottom: 5px">
                    <h4 style="display:inline">限流规则
                        <small>（限流资源集群参数配置）</small>
                    </h4>
                </div>
                <div class="ibox-content">
                    <table class="table table-striped table-bordered table-hover dataTables-example">
                        <thead>
                        <tr>
                            <th>名称</th>
                            <th>限流ID</th>
                            <th>所属组</th>
                            <th>所属应用</th>
                            <th>开关</th>
                            <th>速率阀值</th>
                            <th>速率超时</th>
                            <th>并发量</th>
                            <th>并发超时</th>
                            <th>超额策略</th>
                            <th>备注</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${limiterConfigs}" var="limiterConfig">
                            <tr class="gradeX">
                                <td>${limiterConfig.config.name}</td>
                                <td>${limiterConfig.identity.resource}</td>
                                <td>${limiterConfig.identity.group}</td>
                                <td>${limiterConfig.identity.application}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${limiterConfig.config.enable=='ON'}">
                                            <button class="btn btn-info btn-circle" type="button">
                                                <i class="fa fa-check"></i></button>
                                        </c:when>
                                        <c:when test="${limiterConfig.config.enable=='OFF'}">
                                            <button class="btn btn-danger btn-circle" type="button">
                                                <i class="fa fa-times"></i>
                                            </button>
                                        </c:when>
                                        <c:otherwise><font color="red">非法状态</font></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="center" style="color: #1AB394">
                                        ${limiterConfig.config.rate}
                                    req/${limiterConfig.config.granularity}${limiterConfig.config.unit}
                                </td>
                                <td class="center" style="color: #1AB394">${limiterConfig.config.rateTimeout}ms</td>
                                <td class="center" style="color: #1AB394">${limiterConfig.config.concurrency}c</td>
                                <td class="center" style="color: #1AB394">${limiterConfig.config.concurrencyTimeout}ms
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${'EXCEPTION'==limiterConfig.config.strategy}">
                                            <a class="btn btn-danger btn-xs btn-rounded">抛异常</a>
                                        </c:when>
                                        <c:when test="${'NON'==limiterConfig.config.strategy}">
                                            <a class="btn btn-info btn-xs btn-rounded">不处理</a>
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
                                    <a href="${ctx}/limiter/limiter-monitor/${limiterConfig.identity.application}/${limiterConfig.identity.group}/${limiterConfig.identity.resource}">
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
                <div class="ibox-content" style="display: none">
                    <div class="row row-lg">
                        <div class="col-sm-12">
                            <!-- Example Events -->
                            <div class="example-wrap">
                                <div class="example">
                                    <div class="btn-group hidden-xs" id="exampleTableEventsToolbar" role="group">
                                        <button class="btn btn-info" type="submit">批量禁用</button>
                                    </div>
                                    <table id="exampleTableEvents" data-height="400" data-mobile-responsive="true"
                                           data-striped="true">
                                        <thead>
                                        <tr>
                                            <th data-field="state" data-checkbox="true"></th>
                                            <th data-field="id">ID</th>
                                            <th data-field="name">名称</th>
                                            <th data-field="price">价格</th>
                                            <th data-field="column1" data-visible="false">column1</th>
                                            <th data-field="column2" data-visible="false">column2</th>
                                            <th data-field="column3" data-visible="false">column3</th>
                                            <th data-field="column4">操作</th>
                                        </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                            <!-- End Example Events -->
                        </div>
                    </div>
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
            var colorArray = ['#ED5565', '#1AB394', '#1AB394']
            for (var i = 1; i < 4; i++) {
                new Switchery(document.querySelector('.js-switch_' + i), {color: colorArray[i - 1]});
            }

            var nameArray = ['enable', 'printExceedLog', 'broadcastEvent', 'statisticReportEnable']
            $('span[id=enable]').click(function () {
                var obj = $('input[name=enable]');
                if (obj.val() == 'ON') {
                    obj.attr('value', 'OFF')
                } else {
                    obj.attr('value', 'ON')
                }
            });
            $('span[id=broadcastEvent]').click(function () {
                var obj = $('input[name=broadcastEvent]');
                if (obj.val() == 'ON') {
                    obj.attr('value', 'OFF')
                } else {
                    obj.attr('value', 'ON')
                }
            });
            $('span[id=printExceedLog]').click(function () {
                var obj = $('input[name=printExceedLog]');
                if (obj.val() == 'ON') {
                    obj.attr('value', 'OFF')
                } else {
                    obj.attr('value', 'ON')
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
<!-- Bootstrap table -->
<script src="${ctx}/res/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
<script src="${ctx}/res/js/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
<script src="${ctx}/res/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
<!-- Peity -->
<script>
    (function (document, window, $) {
        (function () {
            $('#exampleTableEvents').bootstrapTable({
                url: "${ctx}/res/js/demo/bootstrap_table_test.json",
                search: true,
                pagination: true,
                showColumns: true,
                iconSize: 'outline',
                toolbar: '#exampleTableEventsToolbar',
                icons: {
                    refresh: 'glyphicon-repeat',
                    toggle: 'glyphicon-list-alt',
                    columns: 'glyphicon-list'
                }
            });

            var $result = $('#examplebtTableEventsResult');
            $('#exampleTableEvents').on('all.bs.table', function (e, name, args) {
                console.log('Event:', name, ', data:', args);
            })
                .on('click-row.bs.table', function (e, row, $element) {
                    $result.text('Event: click-row.bs.table');
                })
                .on('dbl-click-row.bs.table', function (e, row, $element) {
                    $result.text('Event: dbl-click-row.bs.table');
                })
                .on('sort.bs.table', function (e, name, order) {
                    $result.text('Event: sort.bs.table');
                })
                .on('check.bs.table', function (e, row) {
                    $result.text('Event: check.bs.table');
                })
                .on('uncheck.bs.table', function (e, row) {
                    $result.text('Event: uncheck.bs.table');
                })
                .on('check-all.bs.table', function (e) {
                    $result.text('Event: check-all.bs.table');
                })
                .on('uncheck-all.bs.table', function (e) {
                    $result.text('Event: uncheck-all.bs.table');
                })
                .on('load-success.bs.table', function (e, data) {
                    $result.text('Event: load-success.bs.table');
                })
                .on('load-error.bs.table', function (e, status) {
                    $result.text('Event: load-error.bs.table');
                })
                .on('column-switch.bs.table', function (e, field, checked) {
                    $result.text('Event: column-switch.bs.table');
                })
                .on('page-change.bs.table', function (e, size, number) {
                    $result.text('Event: page-change.bs.table');
                })
                .on('search.bs.table', function (e, text) {
                    $result.text('Event: search.bs.table');
                });
        })();
    })(document, window, jQuery);
</script>
</body>
</html>