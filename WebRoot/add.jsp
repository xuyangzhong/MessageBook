<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ page language="java" import="com.zxy.model.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>用户评论</title>
    <link href="css/index.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
    User user=(User)session.getAttribute("user");
    if(user!=null){
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
    <!--内容及评论显示-->
    <form action="MessageServlet" method="post" onsubmit="return ms()">
    <input type="hidden" name="method" value="save">
    <div style="margin-top:15px ;margin-bottom: 15px;">
        <div class="title">
        </div>
        <div class="message_answer">
            <div class="message_answer_top">
                <div class="message_answer_top_title">
                   <label for="title">留言标题：</label>
                </div>
                <div class="message_answer_top_content">
                    <input type="text" name="title" id="title" class="message_title" >
                </div>
            </div>
            <div class="message_answer_middle">
                <div class="message_answer_top_title">
                    <label for="content">留言内容：</label>
                </div>
                <div class="message_answer_top_content">
                    <textarea type="text" name="content" id="content" class="message_content" ></textarea>
                </div>
            </div>
            <div class="message_answer_bottom">
                <input type="submit" name="" value="提交" />
                &nbsp;&nbsp;
                <input type="reset" name="" value="重置" />
            </div>
        </div>
    </div>

</section>
<footer>

</footer>
  <%
    }else{
    	out.print("alert('你还未登录')");
    	response.sendRedirect("index.jsp");
    }
    %>
<script type="text/javascript">
    function ms(){
    	var title=document.getElementById("title");
    	var content=document.getElementById("content");
    	if(title.value==""){
    		alert("请输入标题");
    		return false;
    	}
    	if(content.value==""){
    		alert("请输入内容");
    		return false;
    	}
    }
</script>
</body>
</html>