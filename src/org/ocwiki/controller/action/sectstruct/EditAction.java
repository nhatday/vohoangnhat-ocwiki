package org.ocwiki.controller.action.sectstruct;

import java.io.IOException;

import javax.servlet.ServletException;

import org.ocwiki.controller.action.AbstractResourceAction;
import org.ocwiki.controller.action.ActionException;
import org.ocwiki.data.SectionStructure;
import org.ocwiki.data.TestStructure;
import org.ocwiki.db.dao.TestStructureDAO;
import org.ocwiki.db.dao.TextDAO;
import org.ocwiki.util.Utils;

public class EditAction extends AbstractResourceAction<TestStructure> {

	@Override
	public void performImpl() throws IOException, ServletException {
		try {
			resource = TestStructureDAO
					.fetchById(getParams().getLong("tstr"));
			TestStructure testStructure = resource.getArticle();
			int sectionIndex = getParams().getInt("section");
			SectionStructure sectionStructure = testStructure
					.getSectionStructures().get(sectionIndex);
			request.setAttribute("section", sectionStructure);
			request.setAttribute("test", testStructure);
			title("Sửa phần " + sectionIndex + " trong cấu trúc đề "
					+ testStructure.getName());

			if (getParams().hasParameter("ssubmit")) {
				testStructure = testStructure.copy();
				sectionStructure = Utils.replaceByCopy(testStructure
						.getSectionStructures(), sectionIndex);
				sectionStructure.setContent(TextDAO.create(getParams()
						.getString("stext")));
				if (getParams().hasParameter("sorder")) {
					sectionIndex = getParams().getInt("sorder");
					testStructure.getSectionStructures().remove(
							sectionStructure);
					testStructure.getSectionStructures().add(sectionIndex,
							sectionStructure);
				}
				saveNewRevision(resource, testStructure);
				
				setNextAction("teststruct.view&tstr=" + resource.getId());
			}
		} catch (NumberFormatException ex) {
			throw new ActionException("ID không hợp lệ");
		}
	}

}
