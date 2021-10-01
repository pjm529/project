
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
 

    
<% 
	session.setAttribute("id", request.getParameter("id"));
	session.setAttribute("name", request.getParameter("name"));
	session.setAttribute("num", request.getParameter("num"));
	response.sendRedirect("../index.jsp");
%>
