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
<title>회원 수정</title>
<link rel="stylesheet" href="/project/homepage/css/viewUser.css">
</head>
<body style="text-align:center; background-color: #eee ">

	<script src="/project/homepage/js/jquery-3.6.0.min.js"></script>
	
	<div id="wrap">
		<div id="header">
			<h1>회원 수정</h1>
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
	                    <input type="text" name="id" id="id_text"  autocomplete="off" value=<%=id %>>
	                </div>
	                
	            </div>
	            
	            <br>
	
	            <div id="name">
	            
	                <div>
	                    <b>이름</b>
	                </div>
	
	                <div>
	                	<input type="text" name="name" id="name_text" autocomplete="off" value=<%=name%>>
	                </div>
	                
	            </div>
	
	            <br>
	
	 			<div id="phone">
	            
	                <div>
	                    <b>이름</b>
	                </div>
	
	                <div>
	                	<input type="text" name="phone" id="phone_text" autocomplete="off" value=<%=phone%>>
	                </div>
	                
	            </div>
	            
	            <br>
	            
	            <div id="birth">
	            
	                <div>
	                    <b>생년월일</b>
	                </div>
	
	                <div>
	                	<span>
                            <input id="year_text" name="year" type="text" autocomplete="off"
                            value=<%=year%> placeholder="년 (4자리)" style="width: 120px;">
                        </span>

                        <span>
                            <select id="month" name="month">
                                <option value=<%=month %>><%=month %>월</option>
                                <option value="01">01월</option>
                                <option value="02">02월</option>
                                <option value="03">03월</option>
                                <option value="04">04월</option>
                                <option value="05">05월</option>
                                <option value="06">06월</option>
                                <option value="07">07월</option>
                                <option value="08">08월</option>
                                <option value="09">09월</option>
                                <option value="10">10월</option>
                                <option value="11">11월</option>
                                <option value="12">12월</option>
                            </select>
                        </span>

                        <span>
                            <input id="day_text" name="day" type="text" autocomplete="off" 
                            value=<%=day%> placeholder="일 (2자리)" style="width: 110px;">
                        </span>
	                </div>
	                
	            </div>
	            
	            <br>
	            
	            <div id="gender">
	            
	                <div>
	                    <b>성별</b>
	                </div>
	
	                <div>
	                	<select id="gender" name="gender">
                                <option value=<%=gender %>>
                               	<%if(gender.equals("male")){
                                %>		남 
                                <%} else { 
                                %>		여 
                                <%
                                } %></option>
                                <option value="male">남</option>
                                <option value="female">여</option>
                        </select>
	                </div>
	                
	            </div>
	            
	            <br>
	            
	            <div id="btn">
	            
		            <button id="update_btn"><b>수정</b></button>
		            <button id="list_btn"><b>목록</b></button>
		            
	            </div>
	            
	        </form>
	       
		</div>
		
	</div>

		
	<script>
	
		$(function () {
			
			let id = document.getElementById("id_text");
            let name = document.getElementById("name_text");
            let year = document.getElementById("year_text");
            let day = document.getElementById("day_text");
            
            
			$("#update_btn").click(function() {
				if(id.value == "" || name.value == "" || year.value == "" || day.value == "") {
					alert("입력 내용을 확인해주세요.")
				} else {
					if(id.value.length < 6 || id.value.length > 12) {
						alert("아이디는 6~12글자로 입력해주세요.");
					} else {
						
						if(year.value.length != 4 || day.value.length != 2) {
							alert("생년월일을 확인해주세요.")
						} else {
							alert("수정이 완료되었습니다.");
							$("form").attr("onsubmit", "return true;");
							$("form").attr("action", "updateProcess.jsp").submit();
						}
					}
				}
			});
			
			
			$("#list_btn").click(function() {
				 window.location.href = '/project/homepage/home.jsp';
			});
			
		});
	</script>

</body>
</html>