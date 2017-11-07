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
                <form method="get" class="form-horizontal">
                    <div class="form-group has-success">
                        <label class="col-sm-2 control-label">限流标题</label>
                        <div class="col-sm-10">
                            <input type="text" placeholder="请输入限流标题" class="form-control"
                                   value="${limiterConfig.config.title}">
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">限流ID</label>
                        <div class="col-sm-10">
                            <input type="text" disabled="" value="${limiterConfig.identity.resource}"
                                   class="form-control">
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">所属组</label>
                        <div class="col-sm-10">
                            <input type="text" disabled="" value="${limiterConfig.identity.group}" class="form-control">
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">所属应用</label>
                        <div class="col-sm-10">
                            <input type="text" disabled="" value="${limiterConfig.identity.application}"
                                   class="form-control">
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">限流开关</label>
                        <div class="col-sm-10">
                            <input type="text" name="enable" value="${limiterConfig.config.enable?'true':'false'}" style="display: none"/>
                            <input type="checkbox" id="enable" class="js-switch_1" ${limiterConfig.config.enable?'checked':''}/>
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                    <div class="form-group has-error">
                        <label class="col-sm-2 control-label">并发量</label>
                        <div class="col-sm-10">
                            <input type="text" id="concurrency" value="" name="concurrency"/>
                        </div>
                    </div>

                    <div class="hr-line-dashed"></div>
                    <div class="form-group has-error">
                        <label class="col-sm-2 control-label">速率阀值</label>
                        <div class="col-sm-10">
                            <input type="text" id="qps" value="" name="qps"/>
                        </div>
                    </div>

                    <div class="hr-line-dashed"></div>
                    <div class="form-group has-warning">
                        <label class="col-sm-2 control-label">备注信息</label>
                        <div class="col-sm-10">
                            <textarea id="ccomment" name="comment" class="form-control" required=""
                                      aria-required="true">
                                ${limiterConfig.config.remarks}
                            </textarea>
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                    <div class="form-group">
                        <div class="col-sm-4 col-sm-offset-2">
                            <button class="btn btn-primary" type="submit">保存内容</button>
                            <button class="btn btn-white" type="submit">取消</button>
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
            from: 1000,
            step: 1,
            grid: true,
            grid_snap: true
        });
        $("#qps").ionRangeSlider({
            type: "single",
            min: 0,
            max: 50000,
            from: 8000,
            step: 1,
            grid: true,
            grid_snap: true
        });
    });
</script>
</body>
</html>