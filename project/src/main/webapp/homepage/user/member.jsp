<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
    
<%String sessId = (String) session.getAttribute("id"); %>

<%
	if(sessId == null) { 
%>
	<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '../index.jsp';
	</script>
		
<%	} else {
		if(sessId.equals("admin")) {
%> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
</head>
<body style="text-align:center; background-color: #eee;">
		<br>
		<div id="header">
            <a href="../index.jsp"><img src="../images/index/logo.png" id="logo"></a>
        </div>

        <hr style="width:1200px;">

		<h2><a href="member.jsp" style="color: black">회원목록</a></h2>
		<jsp:include page="viewList/viewUserList.jsp"></jsp:include><br>
</body>
</html>

<%
		} else {
%>	
		<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '../index.jsp';
		</script>
<%	
		}
	}
%>