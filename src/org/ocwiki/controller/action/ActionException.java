package org.ocwiki.controller.action;

public class ActionException extends RuntimeException {

	private static final long serialVersionUID = 6659508927126991913L;
	
	public ActionException(String message) {
		super(message);
	}

	public ActionException(String message, Throwable cause) {
		super(message, cause);
	}
	
}
