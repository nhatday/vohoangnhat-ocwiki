package org.ocwiki.controller.rest.bean;

import org.ocwiki.data.Article;
import org.ocwiki.data.MultichoiceQuestion;
import org.ocwiki.data.File;
import org.ocwiki.data.Solution;
import org.ocwiki.data.Test;
import org.ocwiki.data.TestStructure;
import org.ocwiki.data.TextArticle;
import org.ocwiki.data.Topic;

import org.hibernate.Hibernate;

public class ArticleMapper implements Mapper<ArticleBean, Article> {

	@Override
	public ArticleBean toBean(Article value) {
		Hibernate.initialize(value);
		if (value instanceof MultichoiceQuestion) {
			return MultichoiceQuestionMapper.get().toBean((MultichoiceQuestion) value);
		}
		if (value instanceof Test) {
			return TestMapper.get().toBean((Test) value);
		}
		if (value instanceof TestStructure) {
			return TestStructureMapper.get().toBean((TestStructure) value);
		}
		if (value instanceof File) {
			return FileMapper.get().toBean((File) value);
		}
		if (value instanceof Solution) { // must be before TextArticle
			return SolutionMapper.get().toBean((Solution) value);
		}
		if (value instanceof TextArticle) {
			return TextArticleMapper.get().toBean((TextArticle) value);
		}
		if (value instanceof Topic) {
			return TopicMapper.get().toBean((Topic) value);
		}
		throw new IllegalArgumentException("unsupported type");
	}

	@Override
	public Article toEntity(ArticleBean bean) {
		if (bean instanceof MultichoiceQuestionBean) {
			return MultichoiceQuestionMapper.get().toEntity((MultichoiceQuestionBean) bean);
		}
		if (bean instanceof TestBean) {
			return TestMapper.get().toEntity((TestBean) bean);
		}
		if (bean instanceof TestStructureBean) {
			return TestStructureMapper.get().toEntity((TestStructureBean) bean);
		}
		if (bean instanceof FileBean) {
			return FileMapper.get().toEntity((FileBean) bean);
		}
		if (bean instanceof SolutionBean) { // must be before TextArticle
			return SolutionMapper.get().toEntity((SolutionBean)bean);
		}
		if (bean instanceof TextArticleBean) {
			return TextArticleMapper.get().toEntity((TextArticleBean) bean);
		}
		if (bean instanceof TopicBean) {
			return TopicMapper.get().toEntity((TopicBean) bean);
		}
		throw new IllegalArgumentException("unsupported type");
	}

	private static ArticleMapper DEFAULT_INSTANCE = new ArticleMapper();

	public static ArticleMapper get() {
		return DEFAULT_INSTANCE;
	}
	
}
