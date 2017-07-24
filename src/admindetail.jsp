<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="com.zxy.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8"> 
   <title>课程提交名单</title>
   <link rel="stylesheet" href="css/bootstrap.min.css">  
   <script src="js/jquery.min.js"></script>
   <script src="js/bootstrap.min.js"></script>
   <script type="text/javascript">
	function load(){
		var user="${user}";
		var admin="${admin}";
		if(admin==null||admin==""){
			window.location.href="login.jsp";
		}
	}
	</script>
</head>
<body onload="load()">
<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<nav class="navbar navbar-default" role="navigation">
				<div class="navbar-header">
					 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button> <a class="navbar-brand" href="adminindex.jsp"><strong >MyClass</strong></a>
				</div>
				
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
               
               <ul class="nav navbar-nav navbar-right">
                  <li>
                      <a id="username">${user.username}</a>
                  </li>
                  <li class="dropdown">
                      <a class="dropdown-toggle" data-toggle="dropdown">欢迎您<strong class="caret"></strong></a>
                     <ul class="dropdown-menu">
                     	<li>
                     		<a href="adminindex.jsp">回到首页</a>
                     	</li>
                        <li>
                            <a href="ExitServlet">退出</a>
                        </li>
                     </ul>
                  </li>
               </ul>
            </div>
				
			</nav>
		</div>
	</div>
	<div class="row clearfix">
		<div class="col-md-12 column">
		<c:choose>
		<c:when test="${empty detailPeo}">
			<ul class="nav nav-pills">
				<li class="active" id="nonesubmitstar" name="nonesubmitstar">
					 <a onclick="nonesubmitshow()"> <span class="badge pull-right"></span>已提交</a>
				</li>
				<li id="nonenosubmitstar" name="nonenosubmitlstar">
					 <a onclick="nonenosubmitshow()"> <span class="badge pull-right"></span>未提交</a>
				</li>
			</ul>
			<table height="300px"></table>
		</c:when>
		<c:otherwise>
			<ul class="nav nav-pills">
				<li class="active" id="submitstar" name="submitstar">
					 <a onclick="submitshow()" > <span class="badge pull-right">${detailPeo.submitnum eq 0 ? 0 : detailPeo.submitnum }</span>已提交</a>
				</li>
				<li id="nosubmitlstar" name="nosubmitstar">
					 <a onclick="nosubmitshow()"> <span class="badge pull-right">${detailPeo.nosubmitnum eq 0 ? 0 : detailPeo.nosubmitnum }</span>未提交</a>
				</li>
			</ul>
			<table class="table table-hover" id="submittable" name="submittable">
				<thead>
					<tr>
						<th width="25%">
							序号
						</th>
						<th width="25%">
							学号
						</th>
						<th width="25%">
							姓名
						</th>
						<th width="25%">
							提交日期
						</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${detailPeo.submitpeo}" var="h" varStatus="vh">
					<tr>
						<td>
							${vh.count }
						</td>
						<td>
							${h.id}
						</td>
						<td>
							${h.username}
						</td>
						<td>
							${h.subdate }
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<table class="table table-hover hidden" id="nosubmittable" name="nosubmittable">
				<thead>
					<tr>
						<th width="30%">
							序号
						</th>
						<th width="30%">
							学号
						</th>
						<th width="40%">
							姓名
						</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${detailPeo.nosubmitpeo}" var="h" varStatus="vh">
					<tr>
						<td>
							${vh.count }
						</td>
						<td>
							${h.id}
						</td>
						<td>
							${h.username}
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:otherwise>
		</c:choose> 
		</div>
	</div>
</div>
 <script type="text/javascript">
	function submitshow(){
		$("#submitstar").addClass("active");
		$("#nosubmitstar").removeClass("active");
		$("#submittable").removeClass("hidden");
		$("#nosubmittable").addClass("hidden");
	}
	function nosubmitshow(){
		$("#nosubmitstar").addClass("active");
		$("#submitstar").removeClass("active");
		$("#nosubmittable").removeClass("hidden");
		$("#submittable").addClass("hidden");
	}
	function nonesubmitshow(){
		$("#nonesubmitstar").addClass("active");
		$("#nonenosubmitstar").removeClass("active");
	}
	function nonenosubmitshow(){
		$("#nonenosubmitstar").addClass("active");
		$("#nonesubmitstar").removeClass("active");
	}
	</script>
</body>