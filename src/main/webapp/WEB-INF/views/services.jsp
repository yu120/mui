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
			<c:choose>
				<c:when test="${empty services}">
					<div class="wrapper wrapper-content">
				        <div class="row">
				            <div class="col-sm-12">
				                <div class="middle-box text-center animated fadeInRightBig">
				                    <h3 class="font-bold">没有发现服务</h3>
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
		    		<c:forEach items="${services}" var="service">
		    			<c:set var="categories" value="${service.value}"/>
		    			<c:set var="providersNum" value="${fn:length(categories['providers'].analysis['hosts'])}"/>
		    			<c:set var="consumersNum" value="${fn:length(categories['consumers'].analysis['hosts'])}"/>
		    			<c:set var="providersColor" value="${providersNum>0?'text-success':'text-muted'}"/>
		    			<c:set var="consumersColor" value="${consumersNum>0?'text-warning':'text-muted'}"/>
		    			<c:choose>
			    			<c:when test="${providersNum > 0}">
				    			<c:choose>
					    			<c:when test="${consumersNum > 0}">
					    				<c:set var="titleBgColor" value="#23b7e5"/>
					    				<c:set var="serviceColor" value="text-navy"/>
					    			</c:when>
					    			<c:otherwise>
					    				<c:set var="titleBgColor" value="#23c6c8"/>
					    				<c:set var="serviceColor" value="text-success"/>
					    			</c:otherwise>
				    			</c:choose>
			    			</c:when>
			    			<c:otherwise>
			    				<c:choose>
					    			<c:when test="${consumersNum > 0}">
					    				<c:set var="titleBgColor" value="#f8ac59"/>
					    				<c:set var="serviceColor" value="text-warning"/>
					    			</c:when>
					    			<c:otherwise>
					    				<c:set var="titleBgColor" value="gray"/>
					    				<c:set var="serviceColor" value="text-muted"/>
					    			</c:otherwise>
				    			</c:choose>
			    			</c:otherwise>
		    			</c:choose>
						<div class="col-sm-4">
			                <div class="ibox float-e-margins">
			                    <div class="ibox-title" style="color:white;background-color: ${titleBgColor}">
			                        <h5><i class="fa fa-strikethrough text-fff"></i> 
			                        	<a href="${ctx}/mreg/service?serviceName=${service.key}" style="color: white">
			                        		${fn:substring(service.key, 0, fn:indexOf(service.key, "/"))}
			                        	</a>
			                        </h5>
			                        <div class="ibox-tools">
			                        	<c:if test="${providersNum > 0}">
			                        		<span class="badge badge-white ${serviceColor}">P</span>
			                        	</c:if>
			                        	<c:if test="${consumersNum > 0}">
			                        		<span class="badge badge-white ${serviceColor}">C</span>
			                        	</c:if>
			                        </div>
			                    </div>
			                    <div class="ibox-content">
			                        <table class="table table-stripped small m-t-md" style="margin-top:-10px;margin-bottom: 0px">
			                        	<thead>
			                        		<tr>
			                                	<th>Category</th>
			                                    <th>Service</th>
			                                    <th>Host/INT</th>
			                                    <th>Node/ENV</th>
			                               	</tr>
			                        	</thead>
			                            <tbody>
			                            	<tr>
			                                   	<td><i class="fa fa-tree ${providersColor}"> Provider</i></td>
			                                   	<td><i class="fa ${providersColor}"><i class="fa fa fa-glass"></i>[${fn:length(categories['providers'].statistics)}]</i></td>
			                                    <td>
			                                    	<i class="fa ${providersColor}">
			                                    		<i class="fa fa-television"></i>
			                                    		[<font title="Host: ${fn:length(categories['providers'].analysis['hosts'])}">${fn:length(categories['providers'].analysis['hosts'])}</font>/<font 
			                                    		title="Instance: ${fn:length(categories['providers'].analysis['instances'])}">${fn:length(categories['providers'].analysis['instances'])}</font>]
			                                    	</i>
			                                    </td>
			                                    <td>
			                                    	<i class="fa ${providersColor}">
			                                    		<i class="fa fa-cloud"></i>
			                                    		[<font title="Node: ${fn:length(categories['providers'].analysis['hosts'])}">${fn:length(categories['providers'].nodes)}</font>/<font 
			                                    		title="Env ${fn:length(categories['providers'].analysis['instances'])}">${fn:length(categories['providers'].envs)}</font>]
			                                    	</i>
			                                    </td>
			                                </tr>
			                                <tr>
			                                   	<td><i class="fa fa-truck ${consumersColor}"> Consumer</i></td>
			                                   	<td><i class="fa ${consumersColor}"><i class="fa fa fa-cutlery"></i>[${fn:length(categories['consumers'].statistics)}]</i></td>
			                                    <td>
			                                    	<i class="fa ${consumersColor}">
			                                    		<i class="fa fa-television"></i>
			                                    		[<font title="Host: ${fn:length(categories['consumers'].analysis['hosts'])}">${fn:length(categories['consumers'].analysis['hosts'])}</font>/<font 
			                                    		title="Instance: ${fn:length(categories['consumers'].analysis['instances'])}">${fn:length(categories['consumers'].analysis['instances'])}</font>]
			                                    	</i>
			                                    </td>
			                                    <td>
			                                    	<i class="fa ${consumersColor}">
			                                    		<i class="fa fa-cloud"></i>
			                                    		[<font title="Node: ${fn:length(categories['consumers'].analysis['hosts'])}">${fn:length(categories['consumers'].nodes)}</font>/<font 
			                                    		title="Env ${fn:length(categories['consumers'].analysis['instances'])}">${fn:length(categories['consumers'].envs)}</font>]
			                                    	</i>
			                                    </td>
			                                </tr>
			                            </tbody>
			                        </table>
			                        <div class="stat-percent font-bold">
										<i class="fa fa-vimeo ${serviceColor}"></i>
										<a href="#" style="color: gray">${fn:substring(service.key, fn:indexOf(service.key, ":")+1, fn:length(service.key))}</a>
			                        </div>
			                        <small class="font-bold">
			                         	<i class="fa fa-google ${serviceColor}"></i>
			                       		<a href="#" style="color: gray">${fn:substring(service.key, fn:indexOf(service.key, "/")+1, fn:indexOf(service.key, ":"))}</a>
			                        </small>
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