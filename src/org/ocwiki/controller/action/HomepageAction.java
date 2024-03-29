package org.ocwiki.controller.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;

import org.ocwiki.data.Question;
import org.ocwiki.data.Resource;
import org.ocwiki.data.Test;
import org.ocwiki.data.TextArticle;
import org.ocwiki.db.dao.MultichoiceQuestionDAO;
import org.ocwiki.db.dao.QuestionDAO;
import org.ocwiki.db.dao.TestDAO;
import org.ocwiki.db.dao.TextArticleDAO;
import org.ocwiki.db.dao.UserDAO;

public class HomepageAction extends AbstractAction {

	private List<Resource<Test>> tests;
	private List<Resource<Question>> questions;
	private List<Resource<TextArticle>> textArticles;
	private long testCount;
	private long questionCount;
	private long textArticleCount;
	private long userCount;

	@Override
	public void performImpl() throws IOException, ServletException {
		title("Trang chủ");
		tests = TestDAO.fetchLatest(0, 10);
		textArticles = TextArticleDAO.fetchNewest(0, 10);
		questions = QuestionDAO.fetch(0, 10);
		testCount = TestDAO.count();
		textArticleCount = TextArticleDAO.count();
		questionCount = MultichoiceQuestionDAO.count();
		userCount = UserDAO.count();
	}
	
	public List<Resource<Test>> getTests() {
		return tests;
	}
	
	public List<Resource<Question>> getQuestions() {
		return questions;
	}
	
	public long getTestCount() {
		return testCount;
	}
	
	public long getQuestionCount() {
		return questionCount;
	}
	
	public long getUserCount() {
		return userCount;
	}

	public List<Resource<TextArticle>> getTextArticles() {
		return textArticles;
	}

	public long getTextArticleCount() {
		return textArticleCount;
	}

}
