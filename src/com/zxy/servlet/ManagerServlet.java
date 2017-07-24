package com.zxy.servlet;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zxy.dao.MessageDao;
import com.zxy.dao.UserDao;
import com.zxy.model.Message;
import com.zxy.model.Revert;
import com.zxy.model.User;

public class ManagerServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req,resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("GBK");
		if(req.getSession().getAttribute("user")==null){
			req.setAttribute("error", "对不起，您没有权限操作");
			req.getRequestDispatcher("error.jsp").forward(req, resp);
		}
		String method=req.getParameter("method");
		if(method.equalsIgnoreCase("revert")){
			String id=req.getParameter("id");
			if(id!=null){
				MessageDao dao=new MessageDao();
				Message message=dao.getMessage(Integer.parseInt(id));
				if(message==null){
					req.setAttribute("error", "数据库revert中根据id没找到此message信息");
					req.getRequestDispatcher("error.jsp").forward(req, resp);
				}
				if(message.getContent().indexOf("<br>")!=-1){
					String content=message.getContent().replace("<br>","\n");
					message.setContent(content);
				}
				if(message.getRevert()!=null){
					if(message.getRevert().getContent().indexOf("<br>")!=-1){
						String content=message.getRevert().getContent().replace("<br>","\n");
						message.getRevert().setContent(content);
					}
				}
				req.setAttribute("message", message);
				req.getRequestDispatcher("revert.jsp").forward(req, resp);
			}
		}else if(method.equalsIgnoreCase("delete")){
			String id=req.getParameter("id");
			if(id!=null){
				MessageDao dao=new MessageDao();
				dao.deleteMessage(Integer.parseInt(id));
			}else{
				req.setAttribute("error", "数据库delete中根据id没找到此message信息");
				req.getRequestDispatcher("error.jsp").forward(req, resp);
			}
			req.getRequestDispatcher("index.jsp").forward(req, resp);
		}else if(method.equalsIgnoreCase("saveOrUpdate")){
			String id=req.getParameter("id");
			String content=req.getParameter("content");
			if(content.indexOf("\n")!=-1){
				content=content.replace("\n", "<br>");
			}
			MessageDao dao=new MessageDao();
			Message message=dao.getMessage(Integer.parseInt(id));
			if(message!=null){
				Revert revert=message.getRevert();
				if(revert==null){
					revert=new Revert();
				}
				revert.setContent(content);
				revert.setRevertTime(new Date());
				message.setRevert(revert);
				dao.saveMessage(message);
			}else{
				req.setAttribute("error", "数据库saveOrUpdate中根据id没找到此message信息");
				req.getRequestDispatcher("error.jsp").forward(req, resp);
			}
			req.getRequestDispatcher("index.jsp").forward(req, resp);
		}else if(method.equalsIgnoreCase("gag")){
			String id=req.getParameter("id");
			UserDao dao=new UserDao();
			User user=dao.findUserById(Integer.parseInt(id));
			if(user!=null){
				Date date=dao.gagDay(new Date(), 1);					//设置禁言时长（一天）
				user.setGagTime(date);
				dao.saveUser(user);
			}else{
				req.setAttribute("error", "未找到所要禁言的用户");
				req.getRequestDispatcher("error.jsp").forward(req, resp);
			}
			resp.sendRedirect("index.jsp");
		}else{
			req.setAttribute("error", "操作错误，请重试");
			req.getRequestDispatcher("error.jsp").forward(req, resp);
		}
	}
}
