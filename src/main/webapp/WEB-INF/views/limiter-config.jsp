<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="library/master.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>分布式限流 - 限流配置变更</title>
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

    <link href="${ctx}/res/css/plugins/ionRangeSlider/ion.rangeSlider.css" rel="stylesheet">
    <link href="${ctx}/res/css/plugins/ionRangeSlider/ion.rangeSlider.skinFlat.css" rel="stylesheet">
    <link rel="stylesheet" href="${ctx}/res/ionRangeSliderDemo/css/normalize.css"/>
    <link rel="stylesheet" href="${ctx}/res/ionRangeSliderDemo/css/ion.rangeSlider.css"/>
    <link rel="stylesheet" href="${ctx}/res/ionRangeSliderDemo/css/ion.rangeSlider.skinFlat.css"/>
</head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="col-sm-12">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>限流配置信息变更
                    <small>（
                        ${limiterConfig.identity.application}->${limiterConfig.identity.group}->${limiterConfig.identity.resource}）
                    </small>
                </h5>
            </div>
            <div class="ibox-content">
                <form method="post" action="${ctx}/limiter/update-config" class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">限流标题</label>
                        <div class="col-sm-10 has-success">
                            <input type="text" placeholder="请输入限流名称" class="form-control" name="name"
                                   required="" aria-required="true" value="${limiterConfig.config.name}">
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">限流ID</label>
                        <div class="col-sm-10">
                            <input type="text" readonly name="resource" value="${limiterConfig.identity.resource}"
                                   class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">所属组</label>
                        <div class="col-sm-10">
                            <input type="text" readonly name="group" value="${limiterConfig.identity.group}"
                                   class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">所属应用</label>
                        <div class="col-sm-10">
                            <input type="text" readonly name="application" value="${limiterConfig.identity.application}"
                                   class="form-control">
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">限流开关</label>
                        <div class="col-sm-10">
                            <div class="radio i-checks">
                                <label><input type="radio" ${limiterConfig.config.enable=='ON'?'checked':''} value="ON"
                                              name="enableRadio"> <i></i> 启用</label>
                                <label><input type="radio" ${limiterConfig.config.enable=='OFF'?'checked':''} value="OFF"
                                              name="enableRadio"> <i></i> 禁用</label>
                            </div>
                            <input type="text" value="${limiterConfig.config.enable}" style="display: none"
                                   name="enable">
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">并发校验超时时间</label>
                        <div class="col-sm-2 has-success">
                            <input type="text" placeholder="请输入并发获取超时时间" class="form-control" name="concurrencyTimeout" required="" aria-required="true"
                                   value="${limiterConfig.config.concurrencyTimeout}">
                        </div>
                        <div class="col-sm-1 has-success">ms</div>
                    </div>
                    <div class="form-group has-error">
                        <label class="col-sm-2 control-label">并发量</label>
                        <div class="col-sm-10">
                            <input type="text" id="concurrency" value="${limiterConfig.config.concurrency}"
                                   name="concurrency"/>
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">速率校验超时时间</label>
                        <div class="col-sm-2 has-success">
                            <input type="text" placeholder="请输入速率获取超时时间" class="form-control" name="rateTimeout" required="" aria-required="true"
                                   value="${limiterConfig.config.rateTimeout}">
                        </div>
                        <div class="col-sm-1 has-success">ms</div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">速率时间窗</label>
                        <div class="col-sm-2">
                            <input type="text" placeholder="请输入速率时间窗大小" class="form-control" name="granularity"
                                   required="" aria-required="true" value="${limiterConfig.config.granularity}">
                        </div>
                        <div class="col-sm-2">
                            <select class="form-control m-b" name="unit" value="${limiterConfig.config.unit}">
                                <option value="SEC" ${limiterConfig.config.unit=='SEC'?'selected':''}>秒</option>
                                <option value="MIN" ${limiterConfig.config.unit=='MIN'?'selected':''}>分</option>
                                <option value="HOU" ${limiterConfig.config.unit=='HOU'?'selected':''}>时</option>
                                <option value="DAY" ${limiterConfig.config.unit=='DAY'?'selected':''}>天</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group has-error">
                        <label class="col-sm-2 control-label">速率阀值</label>
                        <div class="col-sm-10">
                            <input type="text" id="rate" value="${limiterConfig.config.rate}" name="rate"/>
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">超额策略</label>
                        <div class="col-sm-10">
                            <div class="radio i-checks">
                                <label><input type="radio" ${limiterConfig.config.strategy=='NON'?'checked':''}
                                              value="NON" name="strategyRadio"> <i></i> 不处理</label>
                                <label><input type="radio" ${limiterConfig.config.strategy=='EXCEPTION'?'checked':''}
                                              value="EXCEPTION" name="strategyRadio"> <i></i> 抛异常</label>
                            </div>
                            <input type="text" value="${limiterConfig.config.strategy}" style="display: none"
                                   name="strategy">
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">备注信息</label>
                        <div class="col-sm-10 has-warning">
                            <textarea id="ccomment" name="remarks" class="form-control">${limiterConfig.config.remarks}</textarea>
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                    <div class="form-group">
                        <div class="col-sm-4 col-sm-offset-2">
                            <button class="btn btn-info" type="submit">确认更新</button>
                            <button class="btn btn-white reset-data" type="reset">重置</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 全局js -->
<script src="${ctx}/res/js/jquery.min.js?v=2.1.4"></script>
<script src="${ctx}/res/js/bootstrap.min.js?v=3.3.6"></script>


<!-- All JS -->
<script src="${ctx}/res/ionRangeSliderDemo/js/jquery-1.12.3.min.js"></script>
<script src="${ctx}/res/ionRangeSliderDemo/js/ion.rangeSlider.js"></script>

<script>
    $(document).ready(function () {
        $("#concurrency").ionRangeSlider({
            type: "single",
            min: 0,
            max: 50000,
            from: ${limiterConfig.config.concurrency},
            step: 1,
            grid: true,
            grid_snap: true,
            onFinish: function (data) {
                $('#concurrency').val(data.from);
            }
        });

        $("#rate").ionRangeSlider({
            type: "single",
            min: 0,
            max: 50000,
            from: ${limiterConfig.config.rate},
            step: 1,
            keyboard: true,
            grid: true,
            grid_snap: true,
            onFinish: function (data) {
                $('#rate').val(data.from);
            }
        });

        $("input[name=enableRadio]").on("click", function () {
            var enable = $('input:radio[name=enableRadio]:checked').val();
            $('input[name=enable]').val(enable);
        });

        $("input[name=strategyRadio]").on("click", function () {
            var enable = $('input:radio[name=strategyRadio]:checked').val();
            $('input[name=strategy]').val(enable);
        });

        $(".reset-data").on("click", function () {
            $("#concurrency").data("ionRangeSlider").reset();
            $("#rate").data("ionRangeSlider").reset();
        });
    });
</script>
</body>
</html>