package oop.controller.action.user;

import java.io.IOException;

import javax.servlet.ServletException;

import oop.conf.Config;
import oop.controller.action.AbstractAction;
import oop.data.User;
import oop.db.dao.UserDAO;
import oop.util.BlockedUserException;
import oop.util.SessionUtils;

public class LogInAction extends AbstractAction {

	@Override
	public void performImpl() throws IOException, ServletException {
		title("Đăng nhập");
		User whoIsLogin = getUser();
		if (whoIsLogin==null){
			if ("Log In".equals(getParams().get("logIn"))) {
				if (!getParams().hasParameter("userName")) {
					// empty user field
					addError("name", "Bạn cần điền tên người dùng.");
				}
				if (!getParams().hasParameter("password")) {
					// empty password field
					addError("pass", "Bạn cần điền mật khẩu.");
				}
				if (hasErrors()) {
					return;
				}
				User user = UserDAO.fetchByUsername(getParams().get("userName"));
				if (user == null) {
					// Khong ton tai nguoi dung
					addError("name", "Người dùng không tồn tại.");
					return;
				}
				String password = getParams().get("password");
				if (!user.matchPassword(password)) {
					// Sai mat khau
					addError("pass", "Sai mật khẩu.");
					return;
				}
				try {
					SessionUtils.login(getSession(), user);
					setNextAction("homepage");
				} catch (BlockedUserException e) {
					addError("name", "Tài khoản của bạn đã bị khoá.");
				}
			}
		}else{
			setRedirect(Config.get().getHomeDir());
		}
	}

}
