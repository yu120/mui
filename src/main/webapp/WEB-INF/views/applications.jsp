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
			
    		<c:forEach items="${applications}" var="application">
    			<c:set var="app" value="${application.value}"/>
    			<c:set var="providersNum" value="${fn:length(app.providers)}"/>
    			<c:set var="consumersNum" value="${fn:length(app.consumers)}"/>
    			<c:set var="providersColor" value="${providersNum>0?'text-success':'text-muted'}"/>
    			<c:set var="consumersColor" value="${consumersNum>0?'text-warning':'text-muted'}"/>
    			<c:choose>
	    			<c:when test="${providersNum > 0}">
		    			<c:choose>
			    			<c:when test="${consumersNum > 0}">
			    				<c:set var="serviceColor" value="text-navy"/>
			    			</c:when>
			    			<c:otherwise>
			    				<c:set var="serviceColor" value="text-success"/>
			    			</c:otherwise>
		    			</c:choose>
	    			</c:when>
	    			<c:otherwise>
	    				<c:choose>
			    			<c:when test="${consumersNum > 0}">
			    				<c:set var="serviceColor" value="text-warning"/>
			    			</c:when>
			    			<c:otherwise>
			    				<c:set var="serviceColor" value="text-muted"/>
			    			</c:otherwise>
		    			</c:choose>
	    			</c:otherwise>
    			</c:choose>
    			<div class="col-sm-3">
	                <div class="widget yellow-bg p-lg text-center">
	                    <div class="m-b-md">
	                        <i class="fa fa-font fa-4x"></i>
	                        <h1 class="m-xs">${app.app}</h1>
	                        <h3 class="font-bold no-margins"></h3>
	                        <small class="font-bold" title="Providers">
	                         	<i class="fa fa-tree"></i>
	                       		<a href="#" style="color: white">[${fn:length(app.providers)}]</a>
	                        </small>
	                        <small class="font-bold" title="Consumers">
	                         	<i class="fa fa-truck"></i>
	                       		<a href="#" style="color: white">[${fn:length(app.consumers)}]</a>
	                        </small>
	                        <small class="font-bold" title="Configurations"> 
	                         	<i class="fa fa-book"></i>
	                       		<a href="#" style="color: white">[${fn:length(app.confs)}]</a>
	                        </small>
	                        <small class="font-bold" title="Configurations"> 
	                         	<i class="fa fa-eye-slash"></i>
	                       		<a href="#" style="color: white">[${fn:length(app.envs)}]</a>
	                        </small>
	                        <small class="font-bold" title="Configurations"> 
	                         	<i class="fa fa-cloud"></i>
	                       		<a href="#" style="color: white">[${fn:length(app.nodes)}]</a>
	                        </small>
	                    </div>
	                </div>
	            </div>
			</c:forEach>
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