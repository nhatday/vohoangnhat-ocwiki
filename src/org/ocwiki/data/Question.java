package org.ocwiki.data;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlTransient;

import org.ocwiki.util.Copiable;

public class Question implements Entity, Copiable<Question> {

	private long id;
	@XmlElement
	private Resource<? extends BaseQuestion> baseResource;
	@XmlElement
	private Revision<? extends BaseQuestion> baseRevision;
	private double mark;

	public Question() {
	}

	public Question(ArticleContainer<? extends BaseQuestion> baseContainer, double d) {
		setBaseContainer(baseContainer);
		this.mark = d;
	}

	/**
	 * Dành cho JSP, tránh sử dụng hàm này.
	 * 
	 * @return
	 */
	@Deprecated
	public Map<Long, Answer> getAnswerById() {
		Map<Long, Answer> usedAnswerMap = new HashMap<Long, Answer>();
		for (Answer answer : getAnswers()) {
			usedAnswerMap.put(answer.getId(), answer);
		}
		return usedAnswerMap;
	}

	@XmlElement
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	@XmlTransient
	public List<Answer> getAnswers() {
		return getBase().getAnswers();
	}

	@XmlElement
	public double getMark() {
		return mark;
	}

	public void setMark(double mark) {
		this.mark = mark;
	}

	@XmlTransient
	public Text getContent() {
		return getBase().getContent();
	}

	@XmlTransient
	public int getLevel() {
		return getBase().getLevel();
	}

	@XmlElement
	public BaseQuestion getBase() {
		return baseResource.getArticle();
	}

	@XmlTransient
	public ArticleContainer<? extends BaseQuestion> getBaseContainer() {
		return baseRevision == null ? baseResource : baseRevision;
	}
	
	public Resource<? extends BaseQuestion> getBaseResource() {
		return baseResource;
	}
	
	public Revision<? extends BaseQuestion> getBaseRevision() {
		return baseRevision;
	}

	public void setBaseContainer(ArticleContainer<? extends BaseQuestion> baseContainer) {
		if (baseContainer instanceof Resource<?>) {
			baseResource = (Resource<? extends BaseQuestion>) baseContainer;
			baseRevision = null;
		} else if (baseContainer instanceof Revision<?>) {
			baseResource = ((Revision<? extends BaseQuestion>) baseContainer).getResource();
			baseRevision = (Revision<? extends BaseQuestion>) baseContainer;
		}
	}

	@Override
	public Question copy() {
		return new Question(getBaseContainer(), getMark());
	}

	public void setBaseResource(Resource<BaseQuestion> resource) {
		this.baseResource = resource;
	}

	public void setBaseRevision(Revision<BaseQuestion> revision) {
		this.baseRevision = revision;
	}

}