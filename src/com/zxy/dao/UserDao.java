package com.zxy.dao;

/**
 * 此类负责数据库相关的内容，分别为查找和数据持久化
 * @author tinytail
 */

import java.util.Calendar;
import java.util.Date;

import org.hibernate.Query;
import org.hibernate.Session;

import com.zxy.model.User;
import com.zxy.util.HibernateSessionFactory;

public class UserDao {
	
	//把当前用户存入数据库
	public void saveUser(User user){
		Session session=null;
		try {
			session=HibernateSessionFactory.getSession();
			session.beginTransaction();
			session.saveOrUpdate(user);
			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}

	//根据用户名判断数据库是否存在该用户
	public boolean findUserByName(String username){
		Session session=null;
		boolean exist=false;
		try {
			session=HibernateSessionFactory.getSession();
			session.beginTransaction();
			String hql="from User u where u.username=?";
			Query query=session.createQuery(hql).setParameter(0, username);
			Object user=query.uniqueResult();
			if(user!=null){
				exist=true;
			}
			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return exist;
	}

	//根据用户名和密码判断数据库中是否存在此用户
	public User findUser(String username,String password){
		Session session=null;
		User user=null;
		try {
			session=HibernateSessionFactory.getSession();
			session.beginTransaction();
			String hql="from User u where u.username=? and u.password=?";
			Query query=session.createQuery(hql).setParameter(0, username).setParameter(1, password);
			user=(User) query.uniqueResult();
			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return user;
	}
	
	//根据id找到数据库中的用户
	public User findUserById(int id){
		Session session=null;
		User user=null;
		try {
			session=HibernateSessionFactory.getSession();
			session.beginTransaction();
			String hql="from User u where u.id=?";
			Query query=session.createQuery(hql).setParameter(0, id);
			user=(User) query.uniqueResult();
			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return user;
	}
	
	//设置禁言天数时长
	public Date gagDay(Date date,int day){
		Calendar c=Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.DAY_OF_YEAR, day);
		return c.getTime();
	}
	
	//判断是否还处于禁言
	public boolean isgag(User user){
		Date date=new Date();
		return user.getGagTime().after(date);			//禁言时间在当前时间之后，还在禁言，返回true
	}
}










