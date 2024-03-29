package org.ocwiki.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.ocwiki.persistence.HibernateUtil;

import org.apache.commons.lang.StringUtils;

/**
 * Servlet Filter implementation class PrototypeMethodFilter
 */
public class RestFilter implements Filter {

	public RestFilter() { }
	public void init(FilterConfig fConfig) throws ServletException { }
	public void destroy() { }

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		try {
			if (request instanceof HttpServletRequest) {
				String _method = request.getParameter("_method");
				if (!StringUtils.isEmpty(_method)) {
					request = new RestFilter.AlterMethodWrapper(
							(HttpServletRequest) request, _method.toUpperCase());
				}
			}
			chain.doFilter(request, response);
		} finally {
			HibernateUtil.closeSession();
		}
	}

	static class AlterMethodWrapper extends HttpServletRequestWrapper {

		private String method;

		public AlterMethodWrapper(HttpServletRequest request, String method) {
			super(request);
			this.method = method;
		}

		public String getMethod() {
			return method;
		}

	}

}
