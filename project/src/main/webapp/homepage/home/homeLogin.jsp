<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	String cookie = "";
	Cookie[] cookies = request.getCookies();
	String check ="";

	if (cookies != null && cookies.length > 0) {

		for (int i = 0; i < cookies.length; i++) {

			if (cookies[i].getName().equals("userId")) {
				cookie = cookies[i].getValue();
				check = "checked";
			}
		}
	}
%>

<!DOCTYPE html>
<div id="login">

	<form action="" method="post">
	
		<input type="text" id="id" name="id" class="user_id" placeholder="아이디" value="<%=cookie%>" required autocomplete="off">
		<br> 
		
		<input type="password" id="pw" name="pw" class="user_pw" placeholder="비밀번호" required>
		
		
		<button id="loginbtn" class="btn btn-secondary btn">로그인</button>
		
		<div id="checkbox">
			<input type="checkbox" name="checkbox" <%=check %>>
				<span style="font-size: 13px;"> ID 저장 
				<a href="search_id_pw/search_id/search_id.jsp">아이디</a> / <a href="search_id_pw/search_pw/search_pw.jsp">비밀번호찾기</a> 
				<a href="user/insert/insertForm.jsp">회원가입</a></span>
		</div>
	</form>
</div> 



