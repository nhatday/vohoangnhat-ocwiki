package org.ocwiki.controller.rest.bean;

import org.ocwiki.data.Article;
import org.ocwiki.data.ResourceSearchReport;

public class ResourceSearchReportMapper implements
		Mapper<ResourceSearchReportBean, ResourceSearchReport<? extends Article>> {

	@Override
	public ResourceSearchReportBean toBean(ResourceSearchReport<? extends Article> value) {
		ResourceSearchReportBean bean = new ResourceSearchReportBean();
		bean.setResource(ResourceReferenceMapper.get().toBean(
				value.getResource()));
		bean.setScore(value.getScore());
		return bean;
	}

	@Override
	public ResourceSearchReport<Article> toEntity(ResourceSearchReportBean value) {
		ResourceSearchReport<Article> entity = new ResourceSearchReport<Article>();
		entity.setResource(ResourceReferenceMapper.get().toEntity(
				value.getResource()));
		entity.setScore(value.getScore());
		return entity;
	}

	private static ResourceSearchReportMapper DEFAULT_INSTANCE = new ResourceSearchReportMapper();

	public static ResourceSearchReportMapper get() {
		return DEFAULT_INSTANCE;
	}

}
