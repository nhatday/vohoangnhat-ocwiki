/**
 * 
 */
package org.ocwiki.controller.rest.util;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement
public class ObjectResult<T> {
	
	@XmlElement
	private T result;
	
	ObjectResult() {
	}

	public ObjectResult(T result) {
		super();
		this.result = result;
	}
	
	public T getResult() {
		return result;
	}
	
}