package oop.controller.api.topic;

import java.util.List;

import oop.controller.api.AbstractAPI;
import oop.data.Resource;
import oop.data.Topic;
import oop.db.dao.TopicDAO;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;

public class Search extends AbstractAPI {

	@Override
	public Object performImpl() throws Exception {
		String query = getParams().getString("query").replaceAll("%", "%%");
		List<Resource<Topic>> topics = TopicDAO.fetchByNameLike("%" + query + "%");
		
		JsonArray suggestions = new JsonArray();
		JsonArray data = new JsonArray();
		for (Resource<Topic> topic : topics) {
			suggestions.add(new JsonPrimitive(topic.getName()));
			data.add(new JsonPrimitive(topic.getId()));
		}
		return new JsonObject()
				.addProperty("query", query)
				.add("suggestions", suggestions)
				.add("data", data);
	}

}
