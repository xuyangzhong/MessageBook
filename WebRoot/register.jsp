<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>  
    <title>ע��ҳ��</title>
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
                   <label for="username">�û���:</label>
                </div>
                <div class="message_answer_top_content">
                    <input type="text" name="username" id="username" class="message_title" >&nbsp;&nbsp;*
                </div>
            </div>
            <div class="message_answer_top">
                <div class="message_answer_top_title">
                   <label for="password">����:</label>
                </div>
                <div class="message_answer_top_content">
                    <input type="password" name="password" id="password" class="message_title" >&nbsp;&nbsp;*
                </div>
            </div>
            <div class="message_answer_top">
                <div class="message_answer_top_title">
                   <label for="repassword">ȷ������:</label>
                </div>
                <div class="message_answer_top_content">
                    <input type="password" name="repassword" id="repassword" class="message_title" >&nbsp;&nbsp;*
                </div>
            </div>
            <div class="message_answer_top">
                <div class="message_answer_top_title">
                   <label for="email">����:</label>
                </div>
                <div class="message_answer_top_content">
                    <input type="text" name="email" id="email" class="message_title" >&nbsp;&nbsp;*
                </div>
            </div>
            <div class="message_answer_bottom">
                <input type="submit" value="�ύ" />
                &nbsp;&nbsp;
                <input type="reset" value="����" />
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
    			alert("�û�������Ϊ��");
    			return false;
    		}
    		var password=document.getElementById("password");
    		if(password.value==""){
    			alert("���벻��Ϊ��");
    			return false;
    		}
    		var repassword=document.getElementById("repassword");
    		if(repassword.value==""){
    			alert("ȷ�����벻��Ϊ��");
    			return false;
    		}
    		if(password.value!=repassword.value){
    			alert("�������벻һ��");
    			return false;
    		}
    		var email=document.getElementById("email");
    		if(email.value==""){
    			alert("���䲻��Ϊ��");
    			return false;
    		}
			//��ʼ������һ�����߶�������ַ�������-������@��Ȼ������һ�����߶�������ַ�������-��Ȼ���ǵ㡰.���͵����ַ���-����ϣ�������һ�����߶����ϡ� 
    		var pattern=/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    		var em=document.getElementById("email").value;
    		if(!pattern.test(em)){
    			alert("�Բ������������ʽ����ȷ");
    			return false;
    		}
    		
    	}
    </script>
  </body>
</html>
