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

</head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>限流中心
                        <small>微治理 > 分布式限流 > 限流中心</small>
                    </h5>
                </div>
                <div class="ibox-content">
                    <table class="table table-striped table-bordered table-hover dataTables-example">
                        <thead>
                        <tr>
                            <th>标题</th>
                            <th>资源ID</th>
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
                                <td
                                ">
                                <button class="btn btn-${limiterConfig.enable?'success':'danger'} btn-circle btn-xs"
                                        title="${limiterConfig.enable?'打开':'关闭'}" type="button">
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
                                    <span style="color: ${('EXCEPTION'==limiterConfig.strategy)?'red':('EXCEPTION'==limiterConfig.strategy?'rgb(250, 215, 51)':'gray')}">
                                        <c:choose>
                                            <c:when test="${'EXCEPTION'==limiterConfig.strategy}">抛异常</c:when>
                                            <c:when test="${'NON'==limiterConfig.strategy}">不处理</c:when>
                                            <c:otherwise>未知策略</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                                <td>${limiterConfig.remarks}</td>
                                <td>
                                    <button class="btn btn-success btn-xs" type="button"><i class="fa fa-paste"></i> 编辑</button>
                                    <button class="btn btn-info btn-xs" type="button"><i class="fa fa fa-line-chart"></i> 监控</button>
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


<!-- Page-Level Scripts -->
<script>
    $(document).ready(function () {
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