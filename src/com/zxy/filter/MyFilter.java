package com.zxy.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

/**
 * 过滤非法文字的过滤器,将设置的屏蔽字改为****
 * @author tinytail
 *
 */

public class MyFilter implements Filter{
	private String words[];
	private String encoding;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		encoding=filterConfig.getInitParameter("encoding");
		System.out.println("encoding="+encoding);
		words=new String[]{"混蛋","呵呵哒","什么鬼"};//屏蔽字
	}
	
	//循环处理提交内容
	public String filter(String param){
		if(param!=null){
		try {
			if(words!=null&&words.length>0){  //判断初始化
				for(int i=0;i<words.length;i++){
					if(param.contains(words[i])){
						param=param.replace(words[i], "****");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		}
		return param;
	}
	
	//内部类重写getParameter方法
	class Request extends HttpServletRequestWrapper{
		public Request(HttpServletRequest req){
			super(req);
		}
		
		@Override
		public String getParameter(String name) {
			return filter(super.getParameter(name));
		}
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding(encoding);
		if(request.getParameter("method")!=null){
			if(request.getParameter("method").equalsIgnoreCase("save")){
				if(encoding!=null){
					request.setCharacterEncoding(encoding);
					System.out.println("title2="+request.getParameter("title"));
					request=new Request((HttpServletRequest)request);
				}
			}
		}
		chain.doFilter(request, response);
	}
	
	@Override
	public void destroy() {
		this.words=null;
		this.encoding=null;
	}
}





