
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
 

    
<% 
	
	
	String checkbox = request.getParameter("checkbox");
		
	
	session.setAttribute("id", request.getParameter("id"));
	session.setAttribute("name", request.getParameter("name"));
	session.setAttribute("num", request.getParameter("num"));

	if (checkbox.equals("on")) {
		
		Cookie cookie = new Cookie("userId",request.getParameter("id"));
		cookie.setHttpOnly(false); 
		cookie.setPath("/");
		
		response.addCookie(cookie);
	%>
		<script>
			window.location.href='../index.jsp';
		</script>
	<%
	} else {
		
		Cookie cookie = new Cookie("userId", "");
		cookie.setHttpOnly(false); 
		cookie.setPath("/");
		cookie.setMaxAge(0);
		response.addCookie(cookie);
%>
		<script>
			window.location.href='../index.jsp';
		</script>
<%
	}
%>
