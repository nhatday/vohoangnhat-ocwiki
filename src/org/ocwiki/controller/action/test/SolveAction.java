package org.ocwiki.controller.action.test;

import java.io.IOException;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletException;

import org.ocwiki.controller.action.AbstractResourceAction;
import org.ocwiki.controller.action.ActionException;
import org.ocwiki.data.Choice;
import org.ocwiki.data.MultichoiceQuestion;
import org.ocwiki.data.ChoiceAnswer;
import org.ocwiki.data.TestAttempt;
import org.ocwiki.data.Answer;
import org.ocwiki.data.Test;
import org.ocwiki.db.dao.HistoryDAO;
import org.ocwiki.db.dao.ResourceDAO;
import org.ocwiki.db.dao.TestDAO;
import org.ocwiki.persistence.HibernateUtil;

public class SolveAction extends AbstractResourceAction<Test> {

	private Test test;

	@Override
	public void performImpl() throws IOException, ServletException {
		String submit = getParams().getString("submit", "");
		resource = TestDAO.fetchById(getParams().getLong("testId"));
		test = resource.getArticle();
		if (test.getQuestionCount() <= 0) {
			throw new ActionException("Đề thi chưa hoàn thiện.");
		}
		if ("done".equals(submit)) {
			Set<Answer> answers = getChoiceAnswers();
			int time = getParams().getInt("time");
			TestAttempt history = new TestAttempt(getUser(),
					ResourceDAO.fetchCurrentRevision(resource), new Date(),
					answers, time);
			HistoryDAO.persist(history);
			setNextAction("history/view?id=" + history.getId());
		} else {
			if (test.getQuestionCount() <= 0) {
				throw new ActionException("Đề thi chưa hoàn thiện.");
			}
			title("Làm đề: " + test.getName());
		}
	}

	private Set<Answer> getChoiceAnswers() {
		Set<Answer> answers = new HashSet<Answer>();
		for (Object obj : request.getParameterMap().keySet()) {
			String key = (String) obj;
			if (key.startsWith("q")) {
				ChoiceAnswer choiceAnswer = new ChoiceAnswer();
				long questionId = Long.parseLong(key.substring(1));
				choiceAnswer.setQuestion(HibernateUtil.load(MultichoiceQuestion.class, questionId));
				String[] params = (String[]) request.getParameterMap().get(key);
				for (int i = 0; i < params.length; i++) {
					long answerId = Long.parseLong(params[i]);
					Choice choice = HibernateUtil.load(Choice.class, answerId);
					choiceAnswer.getChoices().add(choice);
				}
				answers.add(choiceAnswer);
			}
		}
		return answers;
	}

	public Test getTest() {
		return test;
	}
	
}
