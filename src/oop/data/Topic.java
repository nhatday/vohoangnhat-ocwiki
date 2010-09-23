package oop.data;

import javax.xml.bind.annotation.XmlTransient;

import oop.util.Utils;

public class Topic extends Article {

	private Resource<Topic> parent;

	Topic() {
		// default constructor
	}

	public Topic(Namespace namespace, String name, Resource<Topic> parent, Text content) {
		super(namespace, name, content);
		this.parent = parent;
	}
	
	@XmlTransient
	public Resource<Topic> getParent() {
		return parent;
	}

	public void setParent(Resource<Topic> parent) {
		this.parent = parent;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj instanceof Topic) {
			return getId() == ((Topic) obj).getId();
		}
		return false;
	}

	@Override
	public int hashCode() {
		return Utils.hashCode(getId());
	}

	protected <T> T copyTo(T obj) {
		Topic topic = (Topic) obj;
		topic.setName(getName());
		topic.setParent(getParent());
		return super.copyTo(obj);
	};
	
	@Override
	public Topic copy() {
		return copyTo(new Topic());
	}
	
}