<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 1. JDBC 드라이버 로딩
	String num = request.getParameter("num");
	String id = null;
	String name = null;
	String phone = null;
	String year = null;
	String month = null;
	String day = null;
	String gender = null;
	
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		Context init = new InitialContext();
	    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
	    conn = ds.getConnection();
	    
		String sql = "select * from user where num=" + num;
	
		// 3. PreparedStatement 생성
		pstmt = conn.prepareStatement(sql);
	
		// 4. 쿼리 실행
		rs = pstmt.executeQuery();
	
		// 5. 쿼리 실행 결과 출력
		if (rs.next()) {
			id = rs.getString("id");
			name = rs.getString("name");
			phone = rs.getString("phone");
			year = rs.getString("year");
			month = rs.getString("month");
			day = rs.getString("day");
			gender = rs.getString("gender");
		}
	} catch (SQLException e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	} finally {
		rs.close();
		pstmt.close();
		conn.close();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
</head>
<link rel="stylesheet" href="/project/homepage/css/viewUser.css">
<body style="text-align:center; background-color: #eee;" >

	<script src="../../js/jquery-3.6.0.min.js"></script>
	
	<div id="wrap">
	
		<div id="header">
			<h1>회원정보</h1>
		</div>
		
		<div id="content">
		
	    	<form action="" method="post" onsubmit="return false;">
	    	
	    		<br>
	    		
				<input type="hidden" name="num" value=<%=num %>>	
	        
	            <div id="title">
	            
	                <div>
	                    <b>아이디</b>
	                </div>
	
	                <div>
	                    <input type="text" name="id" readonly value=<%=id %>>
	                </div>
	                
	            </div>
	            
	            <br>
	
	            <div id="name">
	            
	                <div>
	                    <b>이름</b>
	                </div>
	
	                <div>
	                	<input type="text" name="name" readonly value=<%=name%>>
	                </div>
	                
	            </div>
	
	            <br>
	            
	            <div id="phone">
	            
	                <div>
	                    <b>휴대전화</b>
	                </div>
	
	                <div>
	                	<input type="text" name="phone" readonly value=<%=phone%>>
	                </div>
	                
	            </div>
	            
	            <br>
	
	            <div id="birth">
	            
	                <div>
	                    <b>생년월일</b>
	                </div>
	
	                <div>
	                	<input type="text" name="birth" readonly value="<%=year%>-<%=month%>-<%=day%>">
	                </div>
	                
	            </div>
	            
	            <br>
	            
	            <div id="gender">
	            
	                <div>
	                    <b>성별</b>
	                </div>
	
	                <div>
	                	<input type="text" name="gender" readonly 
	                    <%if(gender.equals("male")){
                        %>		value="남" 
                        <%} else { 
                        %>		value="여" 
                        <%} 
                        %>>
	                </div>
	                
	            </div>
	            
	            <br>
	            
	            <div id="btn">
	            
		            <button id="update_btn"><b>수정</b></button>
		            <button id="delete_btn"><b>삭제</b></button>
		            <button id="list_btn"><b>목록</b></button>
		            
	            </div>
	            
	        </form>
	       
		</div>
		
	</div>

		
	<script>
	
		$(function () {  
            let result;
            
			$("#update_btn").click(function() {
				$("form").attr("onsubmit", "return true;");
				$("form").attr("action", "../update/updateForm.jsp").submit();
			});
			
			$("#delete_btn").click(function() {
				result = confirm("회원정보를 삭제하시겠습니까?");
				
				if(result) {
					alert("삭제가 완료되었습니다.");
					$("form").attr("onsubmit", "return true;");
					$("form").attr("action", "../delete/deleteProcess.jsp").submit();
				}
				
			});
			
			$("#list_btn").click(function() {
				 window.location.href = '/project/homepage/home.jsp';
			});
			
		});
	</script>

</body>
</html>