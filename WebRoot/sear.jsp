<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ page language="java" import="com.zxy.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<meta http-equiv=”Content-Type” content=”text/html;charset=GBK”>
  <head>  
  <link href="css/index.css" rel="stylesheet" type="text/css">
    <title>信息搜索</title>
     <script type="text/javascript">
    
	function getprevious(){
		var keywords=document.getElementById("keywords").value;
		if(keywords==""){
			alert("请输入搜索内容");
			return false;
		}
		window.open("MessageServlet?method=search&curPage=${pageModel.previousPage}&keywords="+keywords,"_self");
	};
	function getnext(){
		var keywords=document.getElementById("keywords").value;
		if(keywords==""){
			alert("请输入搜索内容");
			return false;
		}
		window.open("MessageServlet?method=search&curPage=${pageModel.nextPage}&keywords="+keywords,"_self");
	}
	</script>
  </head>
  
    <body>
  <%User user=(User)session.getAttribute("user");
  if(user!=null){
  %>
  <header>
    <div>
        <ul>
       		<c:choose>
    		<c:when test="${!empty user}">
                <li>
                    <input class="search" type="search" name="keywords" id="keywords" placeholder="搜索留言部分" onkeydown="KeyDown()" value="${keywords}">
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
            </c:when>
    		<c:otherwise>
    			<c:redirect url="index.jsp"/>
    		</c:otherwise>
    		</c:choose>
        </ul>
    </div>
</header>
<section>
    	<c:choose>
    		<c:when test="${empty pageModel.list}">
    			 <div style="text-align:center;width:100%;">没有留言信息！</div>
    		</c:when>
    		<c:otherwise>
    			<!-- 输出信息 -->
    			<c:forEach items="${pageModel.list}" var="m">
    				<tr>
    					<td>
    						<div style="margin-top:15px ;margin-bottom: 15px;">
        						<div class="title">
            					<div style="float: left;margin-left:20px;">
               					${m.title}
           						</div>
            					<div style="float: right;margin-right:20px ">
            						<c:if test="${!empty admin}">
                					<ul>
                						<c:choose>
                						<c:when test="${empty m.revert }">
                    						<li><a href="ManagerServlet?method=revert&id=${m.id}">回复</a></li>
                    					</c:when>
                    					<c:when test="${!empty m.revert }">
                    						<li><a href="ManagerServlet?method=revert&id=${m.id}">修改</a></li>
                    					</c:when>
                    					</c:choose>
                    					<li><a href="ManagerServlet?method=delete&id=${m.id}">删除</a></li>
                    					<li><a href="ManagerServlet?method=gag&id=${m.user.id}" style="color:red;">禁言</a></li>
                					</ul>
                					</c:if>
           	 					</div>
        						</div>
        						<div class="content">
           						<div style="padding: 15px 20px;">
            					<div class="content_top">
            						${m.content }
            					</div>
            					<div class="content_bottom">
               			 网友：${m.user.username}&nbsp;|&nbsp;时间：<fmt:formatDate pattern="yyyy-dd-MM HH:mm:ss" value="${m.createTime}"/>&nbsp;|&nbsp;联系方式：&nbsp;${m.user.email}
            					</div>
           						</div>
        						</div>
        					<c:if test="${!empty m.revert.content}">
    						<!-- 评论不为空 -->
        						<div class="answer">
            					<div style="padding:15px 20px">
                				<div class="answer_top">
                    				<span><img src="images/1.png" /></span>
                    				管理员回复：
               			 		</div>
                				<div class="answer_middle">
                   					${m.revert.content}
                				</div>
                				<div class="answer_bottom">
                    				<fmt:formatDate pattern="yyyy-dd-MM HH:mm:ss" value="${m.revert.revertTime}"/>
                				</div>
            					</div>
        						</div>
        					</c:if>
    						</div>
    					</td>
    				</tr>
    			</c:forEach>
    			
    			<!-- 分页 -->
    			<div class="page">
        		<div style="line-height:60px;margin-top:-15px;">
            		<span>总记录数:</span>&nbsp;
            		<span>${pageModel.totalRecords}</span>&nbsp;
            		<span>当前页数:</span>&nbsp;
            		<span>${pageModel.curPage}/${pageModel.totalPage}</span>&nbsp;
					<a onclick="getprevious()" href="">上一页</a>
           		 	<span>
                		<select id="curPage" onchange="changePage()">
                    		<c:forEach begin="1" end="${pageModel.totalPage}" varStatus="vs">
    								<c:choose>
    									<c:when test="${pageModel.curPage ne vs.count}">
    										<option value="${vs.count }">第${vs.count}页</option>
    									</c:when>
    									<c:otherwise>
    										<option value="${vs.count }" selected="selected">第${vs.count}页</option>
    									</c:otherwise>
    								</c:choose>
    						</c:forEach>
                		</select>
            		</span>
            		<a onclick="getnext()" href="">下一页</a>
        		</div>
    			</div>
    		</c:otherwise>
    	</c:choose>
</section>
<footer>

</footer>
    <%}else{
    	response.sendRedirect("index.jsp");
    }
    %>
    
     <script type="text/javascript">
    function changePage(){
		var curPage=document.getElementById("curPage").value;		
		window.open("MessageServlet?method=search&curPage="+curPage);
	};
	function KeyDown(event){
		var e = event || window.event || arguments.callee.caller.arguments[0];
		//e.preventDefault();
		if(e && e.keyCode==13){
			sea();
		}
		return false;
	};
	function sea(){
		var keywords=document.getElementById("keywords").value;
		if(keywords==""){
			alert("请输入搜索内容");
			return false;
		}
		window.open("MessageServlet?method=search&keywords="+keywords,"_self");
	};
    </script>
  </body>
</html>