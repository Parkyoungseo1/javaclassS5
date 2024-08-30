package com.spring.javaclassS5.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class noMemberInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
		
		// 로그인을 하지 않으면 이용 X
		if(level >5 ) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/message/nomember");
			dispatcher.forward(request, response);
			return false;
		}
		
		return true;
	}
	
}
