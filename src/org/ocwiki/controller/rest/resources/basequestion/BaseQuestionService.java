package org.ocwiki.controller.rest.resources.basequestion;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.MediaType;

import org.ocwiki.controller.rest.bean.BaseQuestionBean;
import org.ocwiki.controller.rest.bean.ResourceSearchReportBean;
import org.ocwiki.controller.rest.bean.RevisionBean;
import org.ocwiki.controller.rest.util.ListResult;
import org.ocwiki.controller.rest.util.ObjectResult;

public interface BaseQuestionService {

	@POST
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	public ObjectResult<BaseQuestionBean> add(BaseQuestionBean question)
			throws Exception;

	@GET
	@Path("/{id: \\d+}")
	public ObjectResult<BaseQuestionBean> get(@PathParam("id") long resourceId)
			throws Exception;

	@POST
	@Path("/{id: \\d+}")
	@Consumes(MediaType.APPLICATION_JSON)
	public ObjectResult<BaseQuestionBean> update(@PathParam("id") long resourceId,
			RevisionBean<BaseQuestionBean> data) throws Exception;

	@GET
	@Path("/related/{resourceID: \\d+}")
	public ListResult<ResourceSearchReportBean> listByRelatedResource(
			@PathParam("resourceID") long resourceID) throws Exception ;

}