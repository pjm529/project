<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
<%
	String sessId =(String) session.getAttribute("id");
	session.removeAttribute("search_id");
	if(sessId == null) {
%>
		<jsp:forward page="index/notLogin.jsp"></jsp:forward>
<%

	} else {
%>		<jsp:forward page="index/logined.jsp"></jsp:forward>
<%	
	}
%>

		
