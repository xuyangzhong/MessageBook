package com.zxy.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.zxy.model.Message;
import com.zxy.model.User;
import com.zxy.util.HibernateSessionFactory;
import com.zxy.util.PageModel;

/**
 * 此类负责留言信息相关的数据库操作
 * @author tinytail
 *
 */

public class MessageDao {
	//保存留言
	public void saveMessage(Message message) {
		Session session=null;
		try{
			session=HibernateSessionFactory.getSession();
			session.beginTransaction();
			session.saveOrUpdate(message);
			session.getTransaction().commit();
		}catch(Exception e){
			e.printStackTrace();
			session.getTransaction().commit();
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}
	//得到总记录数
	public int getTotalRecords(Session session){
		String hql="select count(*) from Message";
		Query query=session.createQuery(hql);
		Long totalRecords=(Long)query.uniqueResult();
		return totalRecords.intValue();
	}
	//根据当前页的搜索记录
	public PageModel fingPaging(int curPage,int pageSize){
		Session session=null;
		PageModel pageModel=null;
		try {
			session=HibernateSessionFactory.getSession();
			session.beginTransaction();
			String hql="from Message m order by m.createTime desc";
			List<Message> list=session.createQuery(hql).setFirstResult((curPage-1)*pageSize).setMaxResults(pageSize).list();
			pageModel=new PageModel();
			pageModel.setCurPage(curPage);
			pageModel.setPageSize(pageSize);
			pageModel.setList(list);
			pageModel.setTotalRecords(getTotalRecords(session));
			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		
		return pageModel;
	}
	//删除留言
	public void deleteMessage(int msgid){
		Session session=null;
		try {
			session=HibernateSessionFactory.getSession();
			session.beginTransaction();
			Message message=(Message)session.get(Message.class, msgid);
			session.delete(message);
			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}
	//根据id取得留言
	public Message getMessage(int msgid){
		Session session=null;
		Message message=null;
		try {
			session=HibernateSessionFactory.getSession();
			session.beginTransaction();
			message=(Message)session.get(Message.class, msgid);
			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		
		return message;
	}
	//搜索时根据当前页和关键字得到当前页的记录
	public PageModel searchPaging(int curPage,int pageSize,String keywords){
		Session session=null;
		PageModel pageModel=null;
		List<Message> list=null;
		try {
			session=HibernateSessionFactory.getSession();
			session.beginTransaction();
			String hql="from Message m order by m.createTime desc";
			List<Message> list_temp=session.createQuery(hql).setFirstResult((curPage-1)*pageSize).setMaxResults(pageSize).list();
			//提取关键字
			for(Message ms:list_temp){
				if(ms.getTitle().contains(keywords)){
					if(list==null){
						list=new ArrayList<Message>();
					}
					list.add(ms);
				}else if(ms.getContent().contains(keywords)){
					if(list==null){
						list=new ArrayList<Message>();
					}
					list.add(ms);
				}
			}
			pageModel=new PageModel();
			pageModel.setCurPage(curPage);
			pageModel.setPageSize(pageSize);
			pageModel.setList(list);
			if(list!=null){
				pageModel.setTotalRecords(list.size());
			}else{
				pageModel.setPageSize(1);
			}
			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		
		return pageModel;
	}
}
