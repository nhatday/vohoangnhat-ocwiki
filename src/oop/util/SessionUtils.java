package oop.util;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.math.RandomUtils;

import oop.data.User;

public final class SessionUtils {

	public static void setUser(HttpSession session, User user) {
		session.setAttribute("user", user);
		session.setAttribute("login", user != null);
		if (user != null) {
			session.setAttribute("editToken", generateEditToken());
		}
	}

	public static User getUser(HttpSession session) {
		return (User) session.getAttribute("user");
	}

	private static String generateEditToken() {
		return Integer.toHexString(RandomUtils.nextInt());
	}

	public static String getEditToken(HttpSession session) {
		return (String) session.getAttribute("editToken");
	}

	public static boolean isLoggedIn(HttpSession session) {
		return getUser(session) != null;
	}

}
