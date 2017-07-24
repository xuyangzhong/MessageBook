<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ page language="java" import="com.zxy.model.User" %>
<%@ page language="java" import="java.lang.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%response.setHeader("Cache-Control","no-store");%>

<html>
  <head>
    <title>首页</title>
    <STYLE>
body{
	background: #ebebeb;
	font-family: "Helvetica Neue","Hiragino Sans GB","Microsoft YaHei","\9ED1\4F53",Arial,sans-serif;
	color: #222;
	font-size: 12px;
}
*{padding: 0px;margin: 0px;}
.top_div{
	background: #008ead;
	width: 100%;
	height: 400px;
}
.ipt{
	border: 1px solid #d3d3d3;
	padding: 10px 10px;
	width: 290px;
	border-radius: 4px;
	padding-left: 35px;
	-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
	box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
	-webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
	-o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
	transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s
}
.ipt:focus{
	border-color: #66afe9;
	outline: 0;
	-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6);
	box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6)
}
.u_logo{
	background: url("images/username.png") no-repeat;
	padding: 10px 10px;
	position: absolute;
	top: 43px;
	left: 40px;

}
.p_logo{
	background: url("images/password.png") no-repeat;
	padding: 10px 10px;
	position: absolute;
	top: 12px;
	left: 40px;
}
a{
	text-decoration: none;
}
.tou{
	background: url("images/tou.png") no-repeat;
	width: 97px;
	height: 92px;
	position: absolute;
	top: -87px;
	left: 140px;
}
.left_hand{
	background: url("images/left_hand.png") no-repeat;
	width: 32px;
	height: 37px;
	position: absolute;
	top: -38px;
	left: 150px;
}
.right_hand{
	background: url("images/right_hand.png") no-repeat;
	width: 32px;
	height: 37px;
	position: absolute;
	top: -38px;
	right: -64px;
}
.initial_left_hand{
	background: url("images/hand.png") no-repeat;
	width: 30px;
	height: 20px;
	position: absolute;
	top: -12px;
	left: 100px;
}
.initial_right_hand{
	background: url("images/hand.png") no-repeat;
	width: 30px;
	height: 20px;
	position: absolute;
	top: -12px;
	right: -112px;
}
.left_handing{
	background: url("images/left-handing.png") no-repeat;
	width: 30px;
	height: 20px;
	position: absolute;
	top: -24px;
	left: 139px;
}
.right_handinging{
	background: url("images/right_handing.png") no-repeat;
	width: 30px;
	height: 20px;
	position: absolute;
	top: -21px;
	left: 210px;
}

</STYLE>
 <script type="text/javascript">
		function aload(){
			String error=request.getAttribute("login_error");
			if(user!=null){
				alert(error);
			}
		};
 </script>
  </head>
  <SCRIPT src="js/jquery-1.9.1.min.js" type="text/javascript"></SCRIPT>
  <body onload="aload()">
  <% User user=(User)session.getAttribute("user");
  String error=(String)request.getAttribute("login_error");
  if(error!=null){
 	 out.print("<script>alert('"+error+"');</script>");
  }
  
if(user!=null){
	response.sendRedirect("MessageServlet?method=view"); 
}else{
%>
  
  <c:choose>
  <c:when test="${empty user}">
  <form action="UserServlet" method="post" onsubmit="return login()">
  	<input type="hidden" name="method" value="userLogin"/>
 	<DIV class="top_div"></DIV>
	<DIV style="background: rgb(255, 255, 255); margin: -100px auto auto; border: 1px solid rgb(231, 231, 231); border-image: none; width: 400px; height: 200px; text-align: center;">
	<DIV style="width: 165px; height: 96px; position: absolute;">
		<DIV class="tou"></DIV>
		<DIV class="initial_left_hand" id="left_hand"></DIV>
		<DIV class="initial_right_hand" id="right_hand"></DIV>
	</DIV>
	<P style="padding: 30px 0px 10px; position: relative;">
		<SPAN class="u_logo"></SPAN>         
		<INPUT class="ipt" type="text" placeholder="请输入用户名" name="username" id="username"> 
    </P>
	<P style="position: relative;">
		<SPAN class="p_logo"></SPAN>         
		<INPUT class="ipt" id="password" type="password" placeholder="请输入密码" name="password" id="password">   
  	</P>
	<DIV style="height: 50px; line-height: 50px; margin-top: 30px; border-top-color: rgb(231, 231, 231); border-top-width: 1px; border-top-style: solid;">
	<P style="margin: 0px 35px 20px 45px;">
        <SPAN >
           	<A style="color: rgb(204, 204, 204); margin-right: 10px;" href="register.jsp">注册</A>  
		</SPAN>
		<SPAN >
             <input style="background: rgb(0, 142, 173); padding: 7px 10px; border-radius: 4px; border: 1px solid rgb(26, 117, 152); border-image: none; color: rgb(255, 255, 255); font-weight: bold;" type="submit" value="登陆">
             
        </SPAN>
    </P>
    </DIV>
	</DIV>
	<div style="text-align:center;">
	</div>
	</form>
</c:when>
<c:otherwise>
<c:redirect url="MessageServlet?method=view"/>
</c:otherwise>
</c:choose>

	<SCRIPT type="text/javascript">
function login(){
	var username=document.getElementById("username");
	if(username.value==""){
		alert("用户名不能为空");
		return false;
	}else{
		var password=document.getElementById("password");
		if(password.value==""){
			alert("密码不能为空");
			return false;
		}
	}
	
}

$(function(){
	//得到焦点
	$("#password").focus(function(){
		$("#left_hand").animate({
			left: "150",
			top: " -38"
		},{step: function(){
			if(parseInt($("#left_hand").css("left"))>140){
				$("#left_hand").attr("class","left_hand");
			}
		}}, 2000);
		$("#right_hand").animate({
			right: "-64",
			top: "-38px"
		},{step: function(){
			if(parseInt($("#right_hand").css("right"))> -70){
				$("#right_hand").attr("class","right_hand");
			}
		}}, 2000);
	});
	//失去焦点
	$("#password").blur(function(){
		$("#left_hand").attr("class","initial_left_hand");
		$("#left_hand").attr("style","left:100px;top:-12px;");
		$("#right_hand").attr("class","initial_right_hand");
		$("#right_hand").attr("style","right:-112px;top:-12px");
	});
});
</SCRIPT>
<% }
%>
  </body>
</html>
