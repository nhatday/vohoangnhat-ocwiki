/**
 * 
 */
package oop.controller.rest.util;

import java.util.Collection;

import javax.xml.bind.annotation.XmlRootElement;

import oop.conf.Config;

@XmlRootElement
public class ListResult<T> {
	
	public Collection<T> result;
	public String next;
	public long count;
	
	ListResult() {
	}

	public ListResult(Collection<T> result) {
		this(result, null);
	}
	
	public ListResult(Collection<T> result, String next) {
		super();
		this.result = result;
		this.next = (next == null ? null : Config.get().getRestPath() + next);
	}
	
	public ListResult(Collection<T> result, String next, long count) {
		super();
		this.result = result;
		this.next = (next == null ? null : Config.get().getRestPath() + next);
		this.count = count;
	}
	
}