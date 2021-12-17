package com.project.covidhandong.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("login");
		String requestUri = request.getRequestURI().toString();
		String contextPath = request.getContextPath().toString();
		
		if(requestUri.equals(contextPath + "/") || 
			requestUri.equals(contextPath + "/home")) return true;

		if (obj == null) {
			System.out.println("[Warning] Unconfirmed access without login");
			response.sendRedirect(contextPath + "/login/login");
			return false;
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}
}