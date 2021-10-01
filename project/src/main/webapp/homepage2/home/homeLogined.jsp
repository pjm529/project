<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>
	
<%
	String sessName = (String)session.getAttribute("name");
%>

<div id="login">
	<br>
	<%=sessName%>님 안녕하세요
</div>

<span class="search"> 
		<a href="#">마이페이지</a> / <a href="logProcess/logout.jsp">로그아웃</a>
</span>