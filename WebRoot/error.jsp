<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>404 页面未找到</title>
<style type="text/css">
<!--
body,td,th {
	color: #FFFFFF;
}
body {
	background-color: #0099CC;
}
.STYLE7 {
	font-size: 24px;
	font-family: "微软雅黑";
}
.STYLE9 {font-size: 16px}
.STYLE12 {
	font-size: 100px;
	font-family: "微软雅黑";
}
-->
</style></head>

<body>
<%
String tierror=(String)request.getAttribute("tijiao_error");
if(tierror!=null){
	 out.print("<script>alert('"+tierror+"');</script>");
}
%>
<script language="javascript" type="text/javascript">
	setTimeout(function () { this.location.href = "index.jsp" }, 5000);
</script>
<span class="STYLE12">&nbsp;:(</span>
<p class="STYLE7"> 　　您输入的网址我们没有找到。<br />
　　5秒后为您跳转到首页，您可以在首页试着找找您所需要的信息。</p>
<p class="STYLE7">　　<span class="STYLE9">如果您想了解更多信息，则可以稍后在线搜索此错误: 404 页面未找到</span></p>
<p class="STYLE7"> 　　如果您的浏览器没有反应，请点击这里：    <span class="STYLE9" style="color:red;"><a href="index.jsp">返回</a></span><br />
</body>

</html>
