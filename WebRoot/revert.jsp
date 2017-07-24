<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ page language="java" import="com.zxy.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>  
    <title>管理员回复界面</title>
    <link href="css/index.css" rel="stylesheet" type="text/css">
  </head>
  
  <body>
  	<%
  	Message message=(Message)request.getAttribute("message");
  	if(message!=null){
  	%>
<header>
    <div>
        <ul>
       		<c:choose>
    		<c:when test="${!empty user}">
            <form action="" method="post" name="form1">
                <li>
                    <input class="search" type="search" name="keywords" id="keywords" placeholder="搜索留言部分" onkeydown="KeyDown()">
                </li>
                <li class="search_location">
                    <label for="search">
                        <a onclick="sea()" name="search" id="search"><img src="images/search.png"/></a>
                    </label>
                </li>
                <li>欢迎您，${user.username}&nbsp;</li>
                <li>
                   <a href="add.jsp">我要留言</a>
                </li>
                <li>
                   <a href="UserServlet?method=exit">退出</a>
                </li>
            </form>
            </c:when>
    		<c:otherwise>
    			<c:redirect url="index.jsp"/>
    		</c:otherwise>
    		</c:choose>
        </ul>
    </div>
</header>
<section>
	<form action="ManagerServlet" onsubmit="return onrevert()" method="post">
    <input type="hidden" name="method" value="saveOrUpdate">
    <input type="hidden" name="id" value="${message.id }">
    <!--内容及评论显示-->
    <div style="margin-top:15px ;margin-bottom: 15px;">
        <div class="title">
        </div>
        <div class="message_answer">
            <div class="message_answer_top">
                <div class="message_answer_top_title">
                    <label for="messsageTitle">留言标题：</label>
                </div>
                <div class="message_answer_top_content">
                    ${message.title}
                </div>
            </div>
            <div class="message_answer_middle1">
                <div class="message_answer_top_title">
                    <label for="messageContent">留言内容：</label>
                </div>
                <div class="message_answer_top_content">
                    <div style="width: 450px;">
                        ${message.content}
                    </div>
                </div>
            </div>
            <div class="message_answer_middle">
                <div class="message_answer_top_title">
                    <label for="messageContent">回复内容：</label>
                </div>
                <div class="message_answer_top_content">
                    <textarea type="text" name="content" id="content" class="message_content1" >${message.revert.content}</textarea>
                </div>
            </div>
            <div class="message_answer_bottom">
                <input type="submit" name="" value="提交" />
                &nbsp;&nbsp;
                <input type="button" name="index.jsp" value="返回" />
            </div>
        </div>
    </div>
    </form>

</section>
<footer>

</footer>
    
    <%
  	}else{
  		response.sendRedirect("index.jsp");
  	}
    %>
    
    <script type="text/javascript">
    function onrevert(){
    	String content=document.getElementById("content");
    	if(content==""){
    		alert("请输入内容");
    		return false;
    	}
    	return true;
    }
    </script>
  </body>
</html>
