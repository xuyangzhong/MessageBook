package com.zxy.servlet;

/**
 * 评论信息控制类
 * 用于封装和操作评论信息
 * @author tinytail
 */

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zxy.dao.MessageDao;
import com.zxy.dao.UserDao;
import com.zxy.model.Message;
import com.zxy.model.User;
import com.zxy.util.PageModel;

public class MessageServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}
	
	//判断是否登陆
	public void isLogin(HttpServletRequest req,HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("GBK");
		if(req.getSession().getAttribute("user")==null){
			req.setAttribute("error", "对不起，您还未登录！");
			req.getRequestDispatcher("error.jsp").forward(req, resp);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
//		String keywords=null;
//		if(req.getParameter("keywords")!=null){
//			keywords=new String(req.getParameter("keywords").getBytes("iso-8859-1"),"GBK");//通过window.open传递，默认方法为get
//		}
		req.setCharacterEncoding("GBK");
		String method=req.getParameter("method");
		if(method!=null){
			if(method.equalsIgnoreCase("save")){		//判断是否是提交
				this.isLogin(req, resp);
				String title=req.getParameter("title");
				System.out.println(title);
				String content=req.getParameter("content");
				if(content.indexOf("\n")!=-1){			//将content里所有换行符替换成<br>
					content=content.replaceAll("\n", "<br>");
				}
				User user=(User)req.getSession().getAttribute("user");
				UserDao userDao=new UserDao();
				if(userDao.isgag(user)){
					SimpleDateFormat sd=new SimpleDateFormat("yyyy-MM-dd hh-mm-ss");
					req.setAttribute("tijiao_error", "您已经被管理员禁言,恢复时间为"+sd.format(user.getGagTime()));
					req.getRequestDispatcher("error.jsp").forward(req, resp);
				}else{
					Message message=new Message();
					message.setTitle(title);
					message.setContent(content);
					message.setUser(user);
					message.setCreateTime(new Date());
					MessageDao messageDao=new MessageDao();
					messageDao.saveMessage(message);
					req.getRequestDispatcher("MessageServlet?method=view").forward(req, resp);
				}
			}else if(method.equalsIgnoreCase("view")){	//判断是否是查看
				this.isLogin(req, resp);
				String page=req.getParameter("curPage");
				int curPage=1;
				int pageSize=5;							//此处规定了各页面显示条数
				if(page!=null){
					curPage=Integer.parseInt(page);
				}
				MessageDao dao=new MessageDao();
				PageModel pageModel=dao.fingPaging(curPage, pageSize);
				req.setAttribute("pageModel", pageModel);
				req.getRequestDispatcher("message.jsp").forward(req, resp);
			}else if(method.equalsIgnoreCase("search")){			//搜索方法
				this.isLogin(req, resp);
				String keywords=null;
				if(req.getParameter("keywords")==null){
						req.setAttribute("error", "无搜索关键字");
						req.getRequestDispatcher("error.jsp").forward(req, resp);
				}else{
					keywords=new String(req.getParameter("keywords").getBytes("iso-8859-1"),"utf-8");
				}
				if(keywords!=null){
					String page=req.getParameter("curPage");
					int curPage=1;
					int pageSize=5;							//此处规定了各页面显示条数
					if(page!=null){
						curPage=Integer.parseInt(page);
					}
					MessageDao dao=new MessageDao();
					PageModel pageModel=dao.searchPaging(curPage,pageSize,keywords);
					req.setAttribute("pageModel", pageModel);
					req.setAttribute("keywords", keywords);
					req.getRequestDispatcher("sear.jsp").forward(req, resp);
				}
			}
		}
	}
}


