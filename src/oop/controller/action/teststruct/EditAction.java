package oop.controller.action.teststruct;

import java.io.IOException;

import javax.servlet.ServletException;

import oop.controller.action.AbstractResourceAction;
import oop.data.TestStructure;
import oop.db.dao.TestStructureDAO;
import oop.db.dao.TextDAO;

import org.hibernate.exception.ConstraintViolationException;

public class EditAction extends AbstractResourceAction<TestStructure> {

	protected TestStructure testStructure;

	@Override
	public void performImpl() throws IOException, ServletException {
		long id = getParams().getLong("tid");
		resource = TestStructureDAO.fetchById(id);
		testStructure = resource.getArticle();

		String submit = getParams().get("tsubmit");
		if ("update".equals(submit)) {
			try {
				testStructure.copy();
				testStructure.setName(getParams().get("tname"));
				testStructure.setContent(TextDAO.create(getParams()
						.getString("tdescription")));
				saveNewRevision(resource, testStructure);

				setNextAction("teststruct.view&tstr=" + resource.getId());
			} catch (ConstraintViolationException ex) {
				addError("name", "Tên cấu trúc đề thi đã dùng.");
			}
		}
	}

	public TestStructure getTestStructure() {
		return testStructure;
	}
	
}
