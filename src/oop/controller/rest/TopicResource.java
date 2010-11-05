package oop.controller.rest;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.MediaType;


import oop.controller.rest.bean.RevisionBean;
import oop.controller.rest.bean.TopicBean;
import oop.controller.rest.bean.TopicMapper;
import oop.controller.rest.util.ObjectResult;
import oop.data.Resource;
import oop.data.Topic;
import oop.db.dao.ArticleDAO;
import oop.db.dao.TopicDAO;

@Path(TopicResource.PATH)
public class TopicResource extends AbstractResource {
	public static final String PATH = "/topics";
	
	@GET
	@Path("/{id: \\d+}")
	public ObjectResult<TopicBean> get(@PathParam("id") long resourceId){
		Topic topic = TopicDAO.fetchById(resourceId).getArticle();
		TopicBean bean = TopicMapper.get().toBean(topic);
		return new ObjectResult<TopicBean>(bean);
	}
	
	@POST
	@Path("/{id: \\d+}")
	@Consumes(MediaType.APPLICATION_JSON)
	public ObjectResult<TopicBean> update(@PathParam("id") long resourceId, RevisionBean<TopicBean> data){
		Resource<Topic> resource = getResourceSafe(resourceId, Topic.class);
		WebServiceUtils.assertValid(resource.getArticle().getId() == data.getArticle().getId(),
				"Ole version");
		Resource<Topic> parentTopic = TopicDAO.fetchById(data.getArticle().getParent().getId());
		Topic topic = TopicMapper.get().toEntity(data.getArticle());
		topic.setId(0);
		topic.setParent(parentTopic);
		ArticleDAO.persist(topic);
		saveNewRevision(resource, topic, data.getSummary(), data.isMinor());
		TopicBean bean = TopicMapper.get().toBean(topic);
		return new ObjectResult<TopicBean>(bean);
	}
}
