<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>  
    <title>注册页面</title>
    <link href="css/index.css" rel="stylesheet" type="text/css">
  </head>
  
  <body>
  <%
  String error=(String)request.getAttribute("register_error");
  if(error!=null){
 	 out.print("<script>alert('"+error+"');</script>");
  }
  %>
<header>
    
</header>
<section>
	<form action="UserServlet" method="post" onsubmit="return tijiao()">
    <input type="hidden" name="method" value="guestReg">
    <div style="margin-top:15px ;margin-bottom: 15px;">
        <div class="title">
        </div>
        <div class="message_answer">
        	<br>
        	<br>
        	<br>
            <div class="message_answer_top">
                <div class="message_answer_top_title">
                   <label for="username">用户名:</label>
                </div>
                <div class="message_answer_top_content">
                    <input type="text" name="username" id="username" class="message_title" >&nbsp;&nbsp;*
                </div>
            </div>
            <div class="message_answer_top">
                <div class="message_answer_top_title">
                   <label for="password">密码:</label>
                </div>
                <div class="message_answer_top_content">
                    <input type="password" name="password" id="password" class="message_title" >&nbsp;&nbsp;*
                </div>
            </div>
            <div class="message_answer_top">
                <div class="message_answer_top_title">
                   <label for="repassword">确认密码:</label>
                </div>
                <div class="message_answer_top_content">
                    <input type="password" name="repassword" id="repassword" class="message_title" >&nbsp;&nbsp;*
                </div>
            </div>
            <div class="message_answer_top">
                <div class="message_answer_top_title">
                   <label for="email">邮箱:</label>
                </div>
                <div class="message_answer_top_content">
                    <input type="text" name="email" id="email" class="message_title" >&nbsp;&nbsp;*
                </div>
            </div>
            <div class="message_answer_bottom">
                <input type="submit" value="提交" />
                &nbsp;&nbsp;
                <input type="reset" value="重置" />
            </div>
        </div>
    </div>

</section>
<footer>

</footer>
	<script type="text/javascript">
    	function tijiao(){
    		var username=document.getElementById("username");
    		if(username.value==""){
    			alert("用户名不能为空");
    			return false;
    		}
    		var password=document.getElementById("password");
    		if(password.value==""){
    			alert("密码不能为空");
    			return false;
    		}
    		var repassword=document.getElementById("repassword");
    		if(repassword.value==""){
    			alert("确认密码不能为空");
    			return false;
    		}
    		if(password.value!=repassword.value){
    			alert("密码输入不一致");
    			return false;
    		}
    		var email=document.getElementById("email");
    		if(email.value==""){
    			alert("邮箱不能为空");
    			return false;
    		}
			//开始必须是一个或者多个单词字符或者是-，加上@，然后又是一个或者多个单词字符或者是-。然后是点“.”和单词字符和-的组合，可以有一个或者多个组合。 
    		var pattern=/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    		var em=document.getElementById("email").value;
    		if(!pattern.test(em)){
    			alert("对不起，您的邮箱格式不正确");
    			return false;
    		}
    		
    	}
    </script>
  </body>
</html>
