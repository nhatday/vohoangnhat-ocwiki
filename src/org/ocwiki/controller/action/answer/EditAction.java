package org.ocwiki.controller.action.answer;

import java.io.IOException;

import javax.servlet.ServletException;

import org.ocwiki.controller.action.AbstractResourceAction;
import org.ocwiki.controller.action.ActionException;
import org.ocwiki.data.Choice;
import org.ocwiki.data.MultichoiceQuestion;
import org.ocwiki.data.Text;
import org.ocwiki.db.dao.ResourceDAO;
import org.ocwiki.util.Utils;

import com.oreilly.servlet.ParameterNotFoundException;

public class EditAction extends AbstractResourceAction<MultichoiceQuestion> {

	@Override
	public void performImpl() throws IOException, ServletException {
		try {
			resource = ResourceDAO.fetchById(getParams().getLong("question"));
		} catch (NumberFormatException e) {
			throw new ActionException("Mã câu hỏi không hợp lệ.");
		} catch (ParameterNotFoundException e) {
			throw new ActionException("Bạn cần chọn câu hỏi.");
		}
		
		int answerIndex;
		try {
			answerIndex = getParams().getInt("answer");
		} catch (NumberFormatException e) {
			throw new ActionException("Mã phương án trả lời không hợp lệ.");
		} catch (ParameterNotFoundException e) {
			throw new ActionException("Bạn cần chọn phương án trả lời.");
		}
		
		title("Sửa câu trả lời #" + answerIndex);
		request.setAttribute("question", resource.getArticle());
		
		String submit = getParams().get("submit");
		if ("save".equals(submit)) {

			MultichoiceQuestion question = resource.getArticle().copy();
			Choice choice = Utils.replaceByCopy(question.getChoices(),
					answerIndex);

			try {
				String content = getParams().getString("content");
				choice.setContent(new Text(content));
			} catch (ParameterNotFoundException e) {
				addError("content", "Bạn cần nhập nội dung phương án trả lời.");
			}

			boolean correct = getParams().getBoolean("correct", false);
			choice.setCorrect(correct);

			if (hasNoErrors()) {
				saveNewRevision(resource, question);
				setNextAction("question.view&id=" + resource.getId());
			}
		}
	}	

}
