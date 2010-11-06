package oop.controller.action.question;

import java.io.IOException;

import javax.servlet.ServletException;

import oop.controller.action.AbstractResourceAction;
import oop.controller.action.ActionException;
import oop.data.BaseQuestion;
import oop.db.dao.BaseQuestionDAO;

public class EnhancedViewAction extends AbstractResourceAction<BaseQuestion> {
	
	private BaseQuestion question;

	@Override
	public void performImpl() throws IOException, ServletException {
		try {
			resource = BaseQuestionDAO.fetchById(getParams().getLong("id"));
			question = resource.getArticle();

			if (question == null) {
				throw new ActionException("Không tìm thấy câu hỏi có mã số " + getParams().get("id"));
			} else {
				title("Câu hỏi "+question.getId());
			}
		} catch (NumberFormatException ex) {
			throw new ActionException("Id không hợp lệ: " + getParams().get("id"));
		}
	}
	
	public BaseQuestion getQuestion() {
		return question;
	}
	
}
