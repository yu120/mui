<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="library/master.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>服务中心 - 分布式中心</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="favicon.ico">
    <link href="${ctx}/res/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx}/res/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx}/res/css/plugins/footable/footable.core.css" rel="stylesheet">

 	<!-- Sweet Alert -->
    <link href="${ctx}/res/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    
    <link href="${ctx}/res/css/animate.css" rel="stylesheet">
    <link href="${ctx}/res/css/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
    	<div class="row">
    		<div class="col-sm-12">
    			<div class="ibox float-e-margins">
					<div class="ibox-title">
	                    <h5><font color="gray">分布式中心 > </font>服务中心</h5>
	                </div>
                </div>
			</div>
			<div class="col-sm-12">
	            <div class="wrapper wrapper-content animated fadeInUp">
	                <div class="ibox">
	                    <div class="ibox-content">
	                        <div class="row">
	                            <div class="col-sm-12">
	                                <div class="m-b-md">
	                                    <a href="#" class="btn btn-white btn-xs pull-right">编辑服务</a>
	                                    <h2>${fn:substring(serviceName, 0, fn:indexOf(serviceName, "/"))}</h2>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="row">
	                            <div class="col-sm-5">
	                                <dl class="dl-horizontal">
	                                    <dt>Group：</dt>
	                                    <dd>${fn:substring(serviceName, fn:indexOf(serviceName, ":")+1, fn:length(serviceName))}</dd>
	                                    <dt>Version：</dt>
	                                    <dd>${fn:substring(serviceName, fn:indexOf(serviceName, "/")+1, fn:indexOf(serviceName, ":"))}</dd>
	                                    <dt>客户：</dt>
	                                    <dd><a href="#" class="text-navy">百度</a></dd>
	                                    <dt>版本：</dt>
	                                    <dd>v1.4.2</dd>
	                                </dl>
	                            </div>
	                            <div class="col-sm-7" id="cluster_info">
	                                <dl class="dl-horizontal">
	                                    <dt>最后更新：</dt>
	                                    <dd>2014年 11月7日 22:03</dd>
	                                    <dt>创建于：</dt>
	                                    <dd>2014年 2月16日 03:01</dd>
	                                    <dt>团队成员：</dt>
	                                    <dd class="project-people">
	                                        <a href="#">
	                                            <img alt="image" class="img-circle" src="${ctx}/res/img/a3.jpg">
	                                        </a>
	                                        <a href="#">
	                                            <img alt="image" class="img-circle" src="${ctx}/res/img/a1.jpg">
	                                        </a>
	                                        <a href="#">
	                                            <img alt="image" class="img-circle" src="${ctx}/res/img/a2.jpg">
	                                        </a>
	                                        <a href="#">
	                                            <img alt="image" class="img-circle" src="${ctx}/res/img/a4.jpg">
	                                        </a>
	                                        <a href="#">
	                                            <img alt="image" class="img-circle" src="${ctx}/res/img/a5.jpg">
	                                        </a>
	                                    </dd>
	                                </dl>
	                            </div>
	                        </div>
	                        <div class="row m-t-sm">
	                            <div class="col-sm-12">
	                                <div class="panel blank-panel">
	                                    <div class="panel-heading">
	                                        <div class="panel-options">
	                                            <ul class="nav nav-tabs">
	                                                <li class="active">
	                                                	<a href="#tab-providers" data-toggle="tab" aria-expanded="false">
	                                                	Providers [ ${fn:length(service['providers'].statistics)} ]</a>
	                                                </li>
	                                                <li class="">
	                                                	<a href="#tab-consumers" data-toggle="tab" aria-expanded="false">
	                                                	Consumers [ ${fn:length(service['consumers'].statistics)} ]</a>
	                                                </li>
	                                                <li class="">
	                                                	<a href="#tab-routers" data-toggle="tab" aria-expanded="false">
	                                                	Routers [ ${fn:length(service['routers'].statistics)} ]</a>
	                                                </li>
	                                                <li class="">
	                                                	<a href="#tab-configurators" data-toggle="tab" aria-expanded="false">
	                                                	Configurators [ ${fn:length(service['configurators'].statistics)} ]</a>
	                                                </li>
	                                            </ul>
	                                        </div>
	                                    </div>
	
	                                    <div class="panel-body">
	                                        <div class="tab-content">
	                                            <div class="tab-pane active" id="tab-providers">
	                                                <table class="table table-striped">
	                                                    <thead>
	                                                        <tr>
	                                                            <th>Host</th>
	                                                            <th>Application</th>
	                                                            <th>Weight</th>
	                                                            <th>Check</th>
	                                                            <th>Dynamic</th>
	                                                        </tr>
	                                                    </thead>
	                                                    <tbody>
	                                                    	<c:forEach items="${service['providers'].statistics}" var="srvs">
	                                                    		<c:set var="srv" value="${srvs.value}"/>
	                                                    		<c:set var="parameters" value="${srv.parameters}"/>
	                                                    		<tr>
		                                                            <td>${srv.address}</td>
		                                                            <td>${(empty parameters.application)?"——":parameters.application}</td>
		                                                            <td>${(empty parameters.weight)?"100":parameters.weight}</td>
		                                                            <td>${(empty parameters.check)?"true":parameters.check}</td>
		                                                            <td>${(empty parameters.dynamic)?"true":parameters.dynamic}</td>
		                                                        </tr>
	                                                    	</c:forEach>
	                                                    </tbody>
	                                                </table>
	                                            </div>
	                                            <div class="tab-pane" id="tab-consumers">
	                                                <table class="table table-striped">
	                                                    <thead>
	                                                        <tr>
	                                                            <th>Host</th>
	                                                            <th>Application</th>
	                                                            <th>Weight</th>
	                                                            <th>Check</th>
	                                                            <th>Dynamic</th>
	                                                        </tr>
	                                                    </thead>
	                                                    <tbody>
	                                                        <c:forEach items="${service['consumers'].statistics}" var="srvs">
	                                                    		<c:set var="srv" value="${srvs.value}"/>
	                                                    		<c:set var="parameters" value="${srv.parameters}"/>
	                                                    		<tr>
		                                                            <td>${srv.address}</td>
		                                                            <td>${(empty parameters.application)?"——":parameters.application}</td>
		                                                            <td>${(empty parameters.weight)?"100":parameters.weight}</td>
		                                                            <td>${(empty parameters.check)?"true":parameters.check}</td>
		                                                            <td>${(empty parameters.dynamic)?"true":parameters.dynamic}</td>
		                                                        </tr>
	                                                    	</c:forEach>
	                                                    </tbody>
	                                                </table>
	                                            </div>
	                                            <div class="tab-pane" id="tab-routers">
	                                            	<table class="table table-striped">
	                                                    <thead>
	                                                        <tr>
	                                                            <th>状态</th>
	                                                            <th>标题</th>
	                                                            <th>开始时间</th>
	                                                            <th>结束时间</th>
	                                                            <th>说明</th>
	                                                        </tr>
	                                                    </thead>
	                                                    <tbody>
	                                                        <tr>
	                                                            <td>
	                                                                <span class="label label-primary"><i class="fa fa-check"></i> 3已完成</span>
	                                                            </td>
	                                                            <td>文档在线预览功能</td>
	                                                            <td>11月7日 22:03</td>
	                                                            <td>11月7日 20:11</td>
	                                                            <td><p class="small">已经测试通过</p></td>
	                                                        </tr>
	                                                    </tbody>
	                                                </table>
	                                            </div>
	                                            <div class="tab-pane" id="tab-configurators">
	                                                <div class="feed-activity-list">
	                                                    <div class="feed-element">
	                                                        <a href="profile.html#" class="pull-left">
	                                                            <img alt="image" class="img-circle" src="${ctx}/res/img/a1.jpg">
	                                                        </a>
	                                                        <div class="media-body ">
	                                                            <small class="pull-right text-navy">1天前</small>
	                                                            <strong>奔波儿灞</strong> 关注了 <strong>灞波儿奔</strong>.
	                                                            <br>
	                                                            <small class="text-muted">54分钟前 来自 皮皮时光机</small>
	                                                            <div class="actions">
	                                                                <a class="btn btn-xs btn-white"><i class="fa fa-thumbs-up"></i> 赞 </a>
	                                                                <a class="btn btn-xs btn-danger"><i class="fa fa-heart"></i> 收藏</a>
	                                                            </div>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
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
    <script src="${ctx}/res/js/plugins/footable/footable.all.min.js"></script>

    <!-- 自定义js -->
    <script src="${ctx}/res/js/content.js?v=1.0.0"></script>
    <!-- Sweet alert -->
    <script src="${ctx}/res/js/plugins/sweetalert/sweetalert.min.js"></script>

</body>

</html>