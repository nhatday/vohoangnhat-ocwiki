package oop.controller.rest;

import javax.ws.rs.GET;
import javax.ws.rs.Path;

import oop.controller.OcwikiApp;

@Path(RecaptchaResource.PATH)
public class RecaptchaResource {

	public static final String PATH = "recaptcha";
	
	@GET
	@Path("/key")
	public String getKey() {
		return OcwikiApp.get().getConfig().getRecaptchaPublicKey();
	}
	
}
