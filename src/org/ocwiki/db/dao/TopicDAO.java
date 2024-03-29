package org.ocwiki.db.dao;

import java.util.List;

import org.ocwiki.data.Namespace;
import org.ocwiki.data.Resource;
import org.ocwiki.data.Topic;
import org.ocwiki.persistence.HibernateUtil;

import org.hibernate.Query;
import org.hibernate.Session;

@SuppressWarnings("unchecked")
public final class TopicDAO {

	/**
	 * <p>
	 * Fetch the most popular topics, order by popularity descreasely.
	 * </p>
	 * <p>
	 * Popularity of a topic is measured by the amount of views caused by it,
	 * its descendants and pages that belong to it or its descendants.
	 * </p>
	 * 
	 * TODO: implement the correct query!
	 * @param start
	 * @param size
	 * @return list of arrays of topics and their popularity. The first element
	 * of an array is the topic and the second is the popularity measurement.
	 */
	public static List<Object[]> listPopular(int start, int size) {
		Session session = HibernateUtil.getSession();
		/*
		 * untested hql
		 * 
		String hql = "from Resource r1 where article in (from Topic) " +
				"and status='NORMAL' " +
				"order by (r1.viewCount + (select sum(r2.viewCount) " +
						"from Resource r2 " +
						"where r2.article in (from CategorizableArticle) " +
						"and r1 in elements(r2.article.topics))) desc";
		*/
		String hql = "select r, r.viewCount " +
				"from Resource r where article in (from Topic) " +
				"and status='NORMAL' " +
				"order by viewCount desc";
		Query query = session.createQuery(hql);
		query.setFirstResult(start);
		query.setMaxResults(size);
		return query.list();
	}
	
	public static List<Resource<Topic>> listOrderByName(int start, int size) {
		Session session = HibernateUtil.getSession();
		String hql = "from Resource where article in (from Topic) " +
				"and status='NORMAL' " +
				"order by article.name asc";
		Query query = session.createQuery(hql);
		query.setFirstResult(start);
		query.setMaxResults(size);
		return (List<Resource<Topic>>) query.list();
	}
	
	public static Resource<Topic> fetchByName(String name) {
		return ResourceDAO.fetchByQualifiedName(NamespaceDAO
				.fetch(Namespace.TOPIC), name, Topic.class);
	}

	public static List<Resource<Topic>> fetchByNameLike(String name) {
		Session session = HibernateUtil.getSession();
		String hql = "from Resource where article in " +
				"(from Topic where name like :name) " +
				"and status = 'NORMAL'";
		Query query = session.createQuery(hql);
		query.setString("name", name);
		return query.list();
	}

	/**
	 * Lấy dữ liệu từ DB, nếu không tìm thấy trả về null. 
	 * @param id
	 * @return
	 */
	public static Resource<Topic> fetchById(long id) {
		return ResourceDAO.fetchById(id, Topic.class);
	}

	public static List<Resource<Topic>> fetchTopLevels() {
		Session session = HibernateUtil.getSession();
		Query query = session.createQuery("from Resource where article in (" +
				"from Topic where parent is null) " +
				"and status = 'NORMAL'");
		return query.list();
	}

	/**
	 * Lấy các chủ đề chưa được phân loại
	 * @return
	 */
	public static List<Resource<Topic>> fetchUncategorized(int start, int size) {
		Session session = HibernateUtil.getSession();
		Query query = session.createQuery("from Resource where article in (" +
				"from Topic where parent is null) and id <> " + Topic.ROOT_ID + 
				" and status = 'NORMAL'");
		query.setFirstResult(start);
		query.setMaxResults(size);
		return query.list();
	}
	
	public static long countUncategorized(){
		Session session = HibernateUtil.getSession();
		Query query = session.createQuery("Select count (*) from Resource where article in (" +
				"from Topic where parent is null) and id <> " + Topic.ROOT_ID + 
				" and status = 'NORMAL'");
		return (Long)query.uniqueResult();
	}
	
	/**
	 * Lấy các chủ đề chưa dùng đến
	 * @return
	 */
	public static List<Resource<Topic>> fetchUnused(int start, int size) {
		Session session = HibernateUtil.getSession();
		Query query = session.createQuery("from Resource r where r not in (" +
				"select elements(topics) from CategorizableArticle a " +
					"where a in (select article from Resource where status = 'NORMAL') ) " +
				"and r not in (select parent from Topic t " +
					"where t in (select article from Resource where status = 'NORMAL') ) " +
				"and type = '" + Topic.class.getName() + "' " +
				"and status = 'NORMAL'");
		query.setFirstResult(start);
		query.setMaxResults(size);
		return query.list();
	}
	
	public static long countUnused(){
		Session session = HibernateUtil.getSession();
		Query query = session.createQuery("Select count (*) from Resource r where r not in (" +
				"select elements(topics) from CategorizableArticle a " +
					"where a in (select article from Resource where status = 'NORMAL') ) " +
				"and r not in (select parent from Topic t " +
					"where t in (select article from Resource where status = 'NORMAL') ) " +
				"and type = '" + Topic.class.getName() + "' " +
				"and status = 'NORMAL'");
		return (Long)query.uniqueResult();		
	}

	public static List<Resource<Topic>> getAncestors(long resourceId) {
		return fetchAncestorsNestedSetImpl(resourceId);
	}

	private static List<Resource<Topic>> fetchAncestorsNestedSetImpl(long resourceId) {
		Session session = HibernateUtil.getSession();
		String hql = "select s.resource from TopicSet s where " +
				"s.leftIndex <= (select leftIndex from TopicSet where resource.id=:resId) and " +
				"s.rightIndex >= (select rightIndex from TopicSet where resource.id=:resId) " +
				"and status = 'NORMAL'" +
				"order by s.rightIndex asc";
		Query query = session.createQuery(hql);
		query.setLong("resId", resourceId);
		return query.list();
	}
	
	/*
	private static List<Resource<Topic>> fetchAncestorsRecursiveImpl(
			long resourceId) {
		Resource<Topic> topic = (Resource<Topic>) HibernateUtil.getSession()
				.load(Resource.class, resourceId);
		ArrayList<Resource<Topic>> ancestorList = new ArrayList<Resource<Topic>>();
		addAncestors(ancestorList, topic);
		return ancestorList;
	}

	private static void addAncestors(List<Resource<Topic>> ancestorList,
			Resource<Topic> topic) {
		if (topic == null) {
			return;
		}
		ancestorList.add(topic);
		addAncestors(ancestorList, topic.getArticle().getParent());
	}
	 */

	public static List<Resource<Topic>> fetchChildren(long resourceId) {
		Session session = HibernateUtil.getSession();
		String hql = "from Resource where article in " +
				"(from Topic where parent.id=:resId) " +
				"and status = 'NORMAL'";
		Query query = session.createQuery(hql);
		query.setLong("resId", resourceId);
		return query.list();
	}

	public static long count() {
		String hql = "SELECT COUNT(*) FROM Resource " +
				"where article in (from Topic) " +
				"and status='NORMAL'";
		return HibernateUtil.count(hql);
	}

}
