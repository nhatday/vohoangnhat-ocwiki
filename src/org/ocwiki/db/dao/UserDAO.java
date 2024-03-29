package org.ocwiki.db.dao;

import java.util.Date;
import java.util.List;

import org.ocwiki.data.User;
import org.ocwiki.persistence.HibernateUtil;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

@SuppressWarnings("unchecked")
public class UserDAO {

	public static User create(String userName, String firstName, String lastName,
			String group, String password, String email) {
		Session session = HibernateUtil.getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			User user = new User(userName, firstName, lastName, password, email,
					group, null, null, false, new Date());
			session.save(user);
			tx.commit();
			return user;
		} catch (HibernateException ex) {
			if (tx != null) {
				tx.rollback();
				session.close();
			}
			throw ex;
		}
	}
	
	public static void merge(User user) {
		Session session = HibernateUtil.getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			session.merge(user);
			tx.commit();
		} catch (HibernateException ex) {
			if (tx != null) {
				tx.rollback();
				session.close();
			}
			throw ex;
		}
	}

	/**
	 * Lấy dữ liệu từ DB, nếu không tìm thấy trả về null. 
	 * @param id
	 * @return
	 */
	public static User fetchById(long id) {
		Session session = HibernateUtil.getSession();
		return (User) session.get(User.class, id);
	}
	
	public static User fetchByUsername(String name) {
		Session session = HibernateUtil.getSession();
		Query query = session.createQuery("from User where name = :name");
		query.setString("name", name);
		return (User) query.uniqueResult();
	}

	public static User fetchByEmail(String email) {
		Session session = HibernateUtil.getSession();
		Query query = session.createQuery("from User where email = :email");
		query.setString("email", email);
		return (User) query.uniqueResult();
	}

	public static List<User> fetch(int start, int length) {
		Session session = HibernateUtil.getSession();
		Query query = session.createQuery("from User");
		query.setFirstResult(start);
		query.setMaxResults(length);
		return query.list();
	}

	public static long count() {
		return HibernateUtil.count("select count(*) from User");
	}

	public static void persist(User user) {
		Session session = HibernateUtil.getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			session.saveOrUpdate(user);
			tx.commit();
		} catch (HibernateException ex) {
			if (tx != null) {
				tx.rollback();
				session.close();
			}
			throw ex;
		}
	}

}
