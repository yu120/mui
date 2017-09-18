<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="library/master.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>应用中心 - 分布式中心</title>
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
	                    <h5><font color="gray">分布式中心 > </font>应用中心</h5>
	                </div>
                </div>
			</div>
			
			<c:choose>
				<c:when test="${empty applications}">
					<div class="wrapper wrapper-content">
				        <div class="row">
				            <div class="col-sm-12">
				                <div class="middle-box text-center animated fadeInRightBig">
				                    <h3 class="font-bold">没有发现应用</h3>
				                    <div class="error-desc">
				                        您可以先注册数据后进行查看
				                        <br><a href="${ctx}/web/main" class="btn btn-info m-t">打开主页</a>
				                    </div>
				                </div>
				            </div>
				        </div>
				    </div>
				</c:when>
				<c:otherwise>
					<c:forEach items="${applications}" var="application">
		    			<c:set var="app" value="${application.value}"/>
						<div class="col-sm-6">
			                <div class="ibox float-e-margins">
			                    <div class="ibox-title" style="color:white;background-color: #ed5565">
			                        <h5><i class="fa fa-font text-fff"></i> ${app.app}</h5>
			                        <div class="ibox-tools">
			                        	<c:if test="${fn:length(app.providers) > 0}">
			                        		<span class="badge badge-white text-danger">P</span>
			                        	</c:if>
			                        	<c:if test="${fn:length(app.consumers) > 0}">
			                        		<span class="badge badge-white text-danger">C</span>
			                        	</c:if>
			                        	<c:if test="${fn:length(app.confs) > 0}">
			                        		<span class="badge badge-white text-danger">CF</span>
			                        	</c:if>
			                        </div>
			                    </div>
			                    <div class="ibox-content">
			                        <table class="table table-stripped small m-t-md" style="margin-top:-10px;margin-bottom: 0px">
			                        	<thead>
			                        		<tr>
			                                	<th>Providers</th>
			                                    <th>Consumers</th>
			                                    <th>Configures</th>
			                                    <th>Environments</th>
			                                    <th>Nodes</th>
			                               	</tr>
			                        	</thead>
			                            <tbody>
			                            	<tr>
			                                    <td>
			                                    	<i class="fa ${fn:length(app.providers) > 0?'text-danger':'text-muted'}">
			                                    		<i class="fa fa-tree"></i>
			                                    		[<font title="Providers: ${fn:length(app.providers)}">${fn:length(app.providers)}</font>]
			                                    	</i>
			                                    </td>
			                                    <td>
			                                    	<i class="fa ${fn:length(app.consumers) > 0?'text-danger':'text-muted'}">
			                                    		<i class="fa fa-truck"></i>
			                                    		[<font title="Consumers: ${fn:length(app.consumers)}">${fn:length(app.consumers)}</font>]
			                                    	</i>
			                                    </td>
			                                    <td>
			                                    	<i class="fa ${fn:length(app.confs) > 0?'text-danger':'text-muted'}">
			                                    		<i class="fa fa-creative-commons"></i>
			                                    		[<font title="Configures: ${fn:length(app.confs)}">${fn:length(app.confs)}</font>]
			                                    	</i>
			                                    </td>
			                                    <td>
			                                    	<i class="fa ${fn:length(app.envs) > 0?'text-danger':'text-muted'}">
			                                    		<i class="fa fa-internet-explorer"></i>
			                                    		[<font title="Environments: ${fn:length(app.envs)}">${fn:length(app.envs)}</font>]
			                                    	</i>
			                                    </td>
			                                    <td>
			                                    	<i class="fa ${fn:length(app.nodes) > 0?'text-danger':'text-muted'}">
			                                    		<i class="fa fa-cloud"></i>
			                                    		[<font title="Nodes: ${fn:length(app.nodes)}">${fn:length(app.nodes)}</font>]
			                                    	</i>
			                                    </td>
			                                </tr>
			                            </tbody>
			                        </table>
			                    </div>
			                </div>
			            </div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
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