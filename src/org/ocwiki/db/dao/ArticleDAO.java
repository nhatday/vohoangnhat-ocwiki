package org.ocwiki.db.dao;

import java.util.List;

import org.ocwiki.data.Article;
import org.ocwiki.data.CategorizableArticle;
import org.ocwiki.data.Resource;
import org.ocwiki.data.ResourceSearchReport;
import org.ocwiki.persistence.HibernateUtil;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

@SuppressWarnings("unchecked")
public class ArticleDAO {

	/*
	public static <T extends CategorizableArticle> List<Resource<T>> fetchRelated(
			Class<T> articleType, long resourceId, int limit) {
		Session session = HibernateUtil.getSession();
		String sql = "select {r.*} " +
		"from ocwResource {r} " +
			"join ocwArticle a on r.article = a.id " +
			"join ocwArticleTopic t on a.id = t.article_id " +
		"where t.topic_id in " +
				"(select t2.topic_id from ocwResource r2 " +
				"join ocwArticle a2 on r2.article = a2.id " +
				"join ocwArticleTopic t2 on a2.id = t2.article_id " +
				"where r2.id = :resId) " +
			"and r.id <> :resId " +
			"and r.type = :type " +
		"group by r.id, r.version, r.create_date, r.type, r.article, r.author, r.status, r.link, r.accessibility " +
		"order by count(t.topic_id) desc";
		SQLQuery query = session.createSQLQuery(sql);
		query.addEntity("r", Resource.class);
		query.setLong("resId", resourceId);
		query.setString("type", articleType.getName());
		query.setMaxResults(limit);
		return query.list();
	}
	*/

	public static <T extends CategorizableArticle> List<ResourceSearchReport<T>> fetchRelated(
			Class<T> articleType, long resourceId, int start, int size) {
		Session session = HibernateUtil.getSession();
		String hql = "select new org.ocwiki.data.ResourceSearchReport(r, count(t.id)) " +
				"from Resource r join r.article a join a.topics t " +
				"where r.type=:type and t.id in " +
						"(select t2 from Resource r2 join r2.article a2 join a2.topics t2 " +
						"where r2.id = :resId) " +
					"and r.id <> :resId " +
				"group by r " +
				"order by count(t.id) desc)";
		Query query = session.createQuery(hql);
		query.setLong("resId", resourceId);
		query.setString("type", articleType.getName());
		query.setFirstResult(start);
		query.setMaxResults(size);
		return query.list();
	}
	
	public static <T extends Article> T fetchById(long id) {
		Session session = HibernateUtil.getSession();
		return (T) session.get(Article.class, id);
	}
	
	public static void persist(Article article) {
		Session session = HibernateUtil.getSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			session.saveOrUpdate(article);
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
	 * Lấy các bài viết chưa được phân loại
	 * @return
	 * 
	 */
	public static List<Resource<Article>> fetchUncategorized(int start, int size) {
		Session session = HibernateUtil.getSession();
		Query query = session.createQuery("from Resource where article in (from CategorizableArticle a where a.topics is empty) and status <> 'DELETE'");
		query.setFirstResult(start);
		query.setMaxResults(size);
		return query.list();
	}
	
	public static long countUncategorized(){
		Session session = HibernateUtil.getSession();
		Query query = session.createQuery("Select count (*) from Resource where article in (from CategorizableArticle a where a.topics is empty) and status <> 'DELETE'");
		return (Long)query.uniqueResult();
	}
	
	/**
	 * Lấy các bài viết bị khóa
	 * @return
	 */
	public static List<Resource<Article>> fetchLocked(int start, int size) {
		Session session = HibernateUtil.getSession();
		Query query = session.createQuery("from Resource where accessibility <> 'EVERYONE'");
		query.setFirstResult(start);
		query.setMaxResults(size);
		return query.list();
	}
	
	public static long countLocked(){
		Session session = HibernateUtil.getSession();
		Query query = session.createQuery("Select count (*) from Resource where accessibility <> 'EVERYONE'");
		return (Long)query.uniqueResult();
	}
}
