package oop.data;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import org.hibernate.search.annotations.IndexedEmbedded;

import oop.util.Copiable;

@XmlRootElement
public class Answer implements Entity, Copiable<Answer> {

	private long id;
	@IndexedEmbedded
	private Text content;
	private boolean correct;

	public Answer() {
	}
	
	public Answer(Text content, boolean correct) {
		super();
		this.correct = correct;
		this.content = content;
	}

	@XmlElement
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	public Text getContent() {
		return content;
	}
	
	public void setContent(Text content) {
		this.content = content;
	}
	
	public void setCorrect(boolean correct) {
		this.correct = correct;
	}

	@XmlElement
	public boolean isCorrect() {
		return correct;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj instanceof Answer) {
			return id == ((Answer) obj).id;
		}
		return super.equals(obj);
	}

	@Override
	public int hashCode() {
		return Long.valueOf(id).hashCode();
	}

	public Answer copy() {
		return new Answer(content, correct);
	}
	
}
