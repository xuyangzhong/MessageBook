<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>404 ҳ��δ�ҵ�</title>
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
	font-family: "΢���ź�";
}
.STYLE9 {font-size: 16px}
.STYLE12 {
	font-size: 100px;
	font-family: "΢���ź�";
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
<p class="STYLE7"> �������������ַ����û���ҵ���<br />
����5���Ϊ����ת����ҳ������������ҳ��������������Ҫ����Ϣ��</p>
<p class="STYLE7">����<span class="STYLE9">��������˽������Ϣ��������Ժ����������˴���: 404 ҳ��δ�ҵ�</span></p>
<p class="STYLE7"> ����������������û�з�Ӧ���������    <span class="STYLE9" style="color:red;"><a href="index.jsp">����</a></span><br />
</body>

</html>
