<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="library/master.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>配置中心 - 分布式中心</title>
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
	                    <h5><font color="gray">分布式中心 > </font>配置中心</h5>
	                </div>
                </div>
			</div>
			<c:choose>
				<c:when test="${empty confs}">
					<div class="wrapper wrapper-content">
				        <div class="row">
				            <div class="col-sm-12">
				                <div class="middle-box text-center animated fadeInRightBig">
				                    <h3 class="font-bold">没有发现配置</h3>
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
					<c:forEach items="${confs}" var="conf">
		               <div class="col-sm-3">
		                  <div class="panel panel-primary">
		                      <div class="panel-heading" style="font-weight: bold;">
		                          <i class="fa fa-creative-commons"></i> ${conf.key}
		                      </div>
		                      <div class="panel-body">
		                      		<table class="table table-stripped small m-t-md" style="margin-bottom: 0px; margin-top: 0px">
			                            <tbody>
			                            	<c:forEach items="${conf.value}" var="attr">
				                                <tr>
				                                    <td class="no-borders"><i class="fa fa-circle text-navy"></i> ${attr.key}</td>
				                                    <td class="no-borders">${attr.value}</td>
				                                </tr>
			                                </c:forEach>
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
    <script>
        $(document).ready(function() {
            $('.footable').footable();
	        $('.demo3').click(function () {
	            swal({
	                title: "您确定要删除该配置数据项吗",
	                text: "删除后将无法恢复，请谨慎操作！",
	                type: "warning",
	                showCancelButton: true,
	                confirmButtonColor: "#DD6B55",
	                confirmButtonText: "删除",
	                closeOnConfirm: false
	            }, function () {
	            	swal("删除成功！", "您已经永久删除了该配置数据项。", "success");
	            });
	        });
        });
    </script>

</body>

</html>