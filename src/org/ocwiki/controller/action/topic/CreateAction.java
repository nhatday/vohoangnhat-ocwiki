package org.ocwiki.controller.action.topic;

import java.io.IOException;

import javax.servlet.ServletException;

import org.ocwiki.controller.action.AbstractAction;
import org.ocwiki.controller.action.ActionException;
import org.ocwiki.data.Namespace;
import org.ocwiki.data.Resource;
import org.ocwiki.data.Text;
import org.ocwiki.data.Topic;
import org.ocwiki.db.dao.NamespaceDAO;
import org.ocwiki.db.dao.ResourceDAO;

import org.hibernate.exception.ConstraintViolationException;

import com.oreilly.servlet.ParameterNotFoundException;

public class CreateAction extends AbstractAction {

	@Override
	public void performImpl() throws IOException, ServletException {
		title("Tạo chủ đề mới");
		try {
			String submitted = getParams().get("submit");
			if ("create".equals(submitted)) {
				String name = "";
				try {
					name = getParams().getString("name");
				} catch (ParameterNotFoundException ex) {
					addError("name", "Bạn cần nhập tên chủ đề.");
				}

				Resource<Topic> parent = null;
				try {
					parent = ResourceDAO.fetchById(getParams().getLong(
							"parent"), Topic.class);
				} catch (ParameterNotFoundException e) {
					parent = null;
				} catch (NumberFormatException ex) {
					addError("parent", "Chủ đề không hợp lệ");
				}

				String content = getParams().get("content");
				
				if (hasNoErrors()) {
					Topic newTopic = new Topic(NamespaceDAO
							.fetch(Namespace.TOPIC), name, parent, new Text(
							content));
					Resource<Topic> resource = ResourceDAO.create(getUser(), Topic.class, newTopic);
					setNextAction("article.view?id=" + resource.getId());
					return;
				}
			}
		} catch (NumberFormatException ex) {
			throw new ActionException("ID không hợp lệ");
		} catch (ConstraintViolationException ex) {
			if ("top_name".equals(ex.getConstraintName())) { // trùng tên
				addError("name", "Đã có chủ đề trùng tên");
			} else {
				throw ex;
			}
		}
	}

}
