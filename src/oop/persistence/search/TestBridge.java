package oop.persistence.search;

import oop.data.Answer;
import oop.data.BaseQuestion;
import oop.data.Question;
import oop.data.Resource;
import oop.data.Section;
import oop.data.Test;

import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.hibernate.search.bridge.FieldBridge;
import org.hibernate.search.bridge.LuceneOptions;

public class TestBridge implements FieldBridge {

	@Override
	public void set(String name, Object value, Document document,
			LuceneOptions luceneOptions) {
		if (((Resource<?>)value).getArticle() instanceof Test) {
			Test test = (Test) ((Resource<?>)value).getArticle();
			StringBuilder sections = new StringBuilder();
			StringBuilder questions = new StringBuilder();
			StringBuilder answers = new StringBuilder();
			for (Section section : test.getSections()) {
				sections.append(section.getContent().getText()).append(' ');
				for (Question question : section.getQuestions()) {
					BaseQuestion baseQuestion = question.getBase();
					questions.append(baseQuestion.getContent().getText()).append(' ');
					for (Answer answer : question.getAnswers()) {
						answers.append(answer.getContent().getText()).append(' ');
					}
				}
			}
			document.add(new Field(name + ".sections", sections.toString(),
					Field.Store.NO, Field.Index.ANALYZED));
			document.add(new Field(name + ".questions", questions.toString(),
					Field.Store.NO, Field.Index.ANALYZED));
			document.add(new Field(name + ".answers", answers.toString(),
					Field.Store.NO, Field.Index.ANALYZED));
		}
	}

}
