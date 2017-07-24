package com.zxy.servlet;

/**
 * 此为负责封装或处理用户相关请求操作
 * @author tinytail
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zxy.dao.UserDao;
import com.zxy.model.Administrator;
import com.zxy.model.Guest;
import com.zxy.model.User;

public class UserServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("GBK");
		String method=req.getParameter("method");
		if(method!=null){
			if("guestReg".equalsIgnoreCase(method)){		//判断是否为注册
				UserDao userDao=new UserDao();
				if(req.getParameter("username")!=null&&!req.getParameter("username").isEmpty()){
					if(userDao.findUserByName(req.getParameter("username"))){
						req.setAttribute("register_error", "用户名已存在");
						req.getRequestDispatcher("register.jsp").forward(req, resp);
					}else{
						User user=new Guest();
						user.setUsername(req.getParameter("username"));
						user.setPassword(req.getParameter("password"));
						user.setEmail(req.getParameter("email"));
						user.setGagTime(new Date());							//添加禁言系统，默认禁言时间为注册时间
						userDao.saveUser(user);
						req.getRequestDispatcher("index.jsp").forward(req, resp);
					}
				}
			}else if(method.equalsIgnoreCase("userLogin")){ 					//判断是否为登陆
				String username=req.getParameter("username");					
				String password=req.getParameter("password");
				UserDao userDao=new UserDao();
				User user=userDao.findUser(username, password);				//查找数据库用户名密码
				if(user!=null){
					if(user instanceof Administrator){							//判断登陆的是否为管理员
						req.getSession().setAttribute("admin", user);
					}
					req.getSession().setAttribute("user", user);
					System.out.println("denglu");
					req.getRequestDispatcher("MessageServlet?method=view").forward(req, resp);
				}else{
					req.setAttribute("login_error", "用户名或密码错误");
					req.getRequestDispatcher("index.jsp").forward(req, resp);
				}
			}else if(method.equalsIgnoreCase("exit")){
				if(req.getSession().getAttribute("user")!=null){
					if(req.getSession().getAttribute("admin")!=null){
						req.getSession().removeAttribute("admin");
					}
					req.getSession().removeAttribute("user");
					req.getSession().invalidate();
					resp.sendRedirect("index.jsp");
				}else{
					req.setAttribute("error", "退出错误");
					req.getRequestDispatcher("error.jsp").forward(req, resp);
				}
			}
		}
	}
}
