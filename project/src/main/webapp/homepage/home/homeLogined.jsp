<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>
	
<%
	String sessName = (String)session.getAttribute("name");
	String sessId = (String)session.getAttribute("id");
	String sessNum = (String)session.getAttribute("num");

	if(sessId.equals("admin")) { 
%>
		<div id="login">
			<br>
			<%=sessName%>님 안녕하세요
		</div>

		<span class="search">
			<a href="user/viewList/viewMy.jsp">마이페이지</a> / <a href="user/member.jsp">회원관리</a> / <a href="logProcess/logout.jsp">로그아웃</a>
		</span>
<% 
	} else {
%>
		<div id="login">
			<br>
			<%=sessName%>님 안녕하세요
		</div>
 
		<span class="search"> 
			<a href="user/viewList/viewMy.jsp">마이페이지</a> / <a href="logProcess/logout.jsp">로그아웃</a>
		</span>
<%
	}
%>