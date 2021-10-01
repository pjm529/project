<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div id="login">

	<form action="" method="post">
	
		<input type="text" id="id" name="id" class="user_id" placeholder="아이디"required autocomplete="off">
		<br> 
		
		<input type="password" id="pw" name="pw" class="user_pw" placeholder="비밀번호" required>
		
		
		<button id="loginbtn" class="btn btn-secondary btn">로그인</button>
		
	</form>
</div>

<span class="search"> 
		<a href="#">아이디</a> / <a href="#">비밀번호찾기</a> <a href="user/insert/insertForm.jsp">회원가입</a>
</span>