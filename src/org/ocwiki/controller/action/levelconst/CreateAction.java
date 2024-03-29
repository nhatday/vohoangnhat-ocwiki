package org.ocwiki.controller.action.levelconst;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;

import org.ocwiki.controller.action.AbstractResourceAction;
import org.ocwiki.data.LevelConstraint;
import org.ocwiki.data.SectionStructure;
import org.ocwiki.data.TestStructure;
import org.ocwiki.data.Text;
import org.ocwiki.db.dao.TestStructureDAO;
import org.ocwiki.util.Utils;

import org.hibernate.exception.ConstraintViolationException;

import com.oreilly.servlet.ParameterNotFoundException;

public class CreateAction extends AbstractResourceAction<TestStructure> {

	public CreateAction() {
	}

	@Override
	public void performImpl() throws IOException, ServletException {
		resource = TestStructureDAO.fetchById(getParams()
				.getLong("teststruct"));
		testStructure = resource.getArticle();

		String submit = getParams().get("submit");
		if ("add".equals(submit)) {
			doCreate();
		}
	}

	private void doCreate() {
		testStructure = testStructure.copy();
		
		SectionStructure sectionStructure = null;
		try {
			sectionStructure = Utils.replaceByCopy(testStructure
					.getSectionStructures(), getParams().getInt("section"));
		} catch (NumberFormatException ex) {
			addError("section", "Mã số mục không hợp lệ.");
		} catch (ParameterNotFoundException ex) {
			List<SectionStructure> sectionStructures = testStructure
					.getSectionStructures();
			if (sectionStructures.isEmpty()) {
				sectionStructure = new SectionStructure(new Text(""));
				testStructure.getSectionStructures().add(sectionStructure);
			} else {
				addError("section", "Bạn cần chọn một mục.");
			}
		}

		int quantity = 0;
		try {
			quantity = getParams().getInt("quantity");
			if (quantity <= 0) {
				addError("quantity", "Số lượng phải nguyên dương.");
			}
		} catch (ParameterNotFoundException ex) {
			addError("quantity", "Bạn cần nhập số lượng.");
		} catch (NumberFormatException ex) {
			addError("quantity", "Số lượng không hợp lệ.");
		}

		int level = -1;
		try {
			level = getParams().getInt("level");
			if (level < 1 || level > 5) {
				addError("level", "Độ khó không hợp lệ.");
			}
		} catch (ParameterNotFoundException ex) {
			addError("level", "Bạn cần chọn độ khó.");
		} catch (NumberFormatException ex) {
			addError("level", "Độ khó không hợp lệ.");
		}

		if (hasNoErrors()) {
			try {
				LevelConstraint constraint = new LevelConstraint(level, quantity);
				sectionStructure.getConstraints().add(constraint);
				saveNewRevision(resource, testStructure);
				setNextAction("teststruct.view&tstr=" + resource.getId());
			} catch (ConstraintViolationException ex) {
				addError("level", "Độ khó đã được thêm từ trước.");
			}
		}
	}
	private TestStructure testStructure;
	
	public TestStructure getTest() {
		return testStructure;
	}
	
}
