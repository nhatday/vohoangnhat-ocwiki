package oop.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oop.conf.Config;

/**
 * Servlet implementation class SetupServlet
 */
public class SetupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SetupServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String sqlPath = getServletContext().getRealPath("/WEB-INF/setup.sql");
		Config config = Config.get();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		printInstructions(response);
		
		File sqlFile = new File(sqlPath);
		if (sqlFile.exists()) {
			String sql = "drop database if exists " + config.getDatabaseName() + ";" +
					"create database " + config.getDatabaseName() + ";" +
					"use " + config.getDatabaseName() + ";" +
					"source " + sqlFile.getName() + ";";
			String[] command = { config.getMysqlCommand(),
					"--database=" + config.getDatabaseName(), 
					"--verbose",
					"--user=" + config.getUserName(),
					"--password=" + config.getPassword(), 
					"--execute=" + sql };
			openDiv(response);
			Process process = new ProcessBuilder(command).directory(
					sqlFile.getParentFile()).start();
			int status = -1;
			try {
				pump(process.getInputStream(), response.getWriter());
				status = process.waitFor();
			} catch (InterruptedException e) {
				e.printStackTrace();
			} finally {
				closeDiv(response);
			}
			if (status == 0) {
				response.getWriter().println("<h3>Cài đặt thành công!</h3>");
			} else {
				response.getWriter().println("Lỗi: " + status);
			}
		} else {
			response.sendRedirect(config.getHomeDir());
		}
	}

	private void printInstructions(HttpServletResponse response) throws IOException {
		String html = "<p>Chương trình cài đặt CSDL:" +
				"<ol>" +
					"<li>Xoá DB được chọn trong tệp cấu hình</li>" +
					"<li>Tạo lại DB</li>" +
					"<li>Tạo bảng và dữ liệu theo tệp /WEB-INF/setup.sql</li>" +
				"</ol>" +
				"<b>Hãy đảm bảo người sử dụng CSDL có quyền xoá-tạo CSDL.</b>" +
				"</p>" +
				"<p>Để cấm script này (khi triển khai) hãy đổi tên tệp setup.sql.";
		response.getWriter().print(html);
	}

	private void closeDiv(HttpServletResponse response) throws IOException {
		response.getWriter().print("</pre></div>");
	}

	private void openDiv(HttpServletResponse response) throws IOException {
		String html = "<div style=\"width: 100%; height: 250px; " +
				"border: solid black 2px; overflow: scroll;\">" +
				"<pre>";
		response.getWriter().print(html);
	}

	private void pump(InputStream inp, PrintWriter writer) throws IOException {
		byte[] buffer = new byte[1024];
		int read;
		while ((read = inp.read(buffer)) > 0) {
			writer.write(new String(buffer, 0, read));
			writer.flush();
		}
	}

}
