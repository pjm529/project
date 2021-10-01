<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%String sessId = (String) session.getAttribute("id"); %>
<%String sessNum = (String) session.getAttribute("num"); %>

<%
	if(sessId == null) { 
%>
	<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '/project/homepage/index.jsp';
	</script>
		
<%	} else {

	// 1. JDBC 드라이버 로딩
	String num = sessNum;
	String id = null;
	String name = null;
	String phone = null;
	String email = null;
	String email_domain = null;
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
			email = rs.getString("email");
			email_domain = rs.getString("email_domain");
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
<link rel="stylesheet" href="/project/homepage/css/signup.css">
</head>

<body>
    <script src="/project/homepage/js/jquery-3.6.0.min.js"></script>


    <div id="wrap">


        <div id="header">
            <a href="/project/homepage/index.jsp"><img src="/project/homepage/images/index/logo.png" id="logo"></a>
        </div>

        <hr>

        <div id="container">

            <form action="insertProcess.jsp" method="POST">
				<input type="hidden" name="num" value=<%=num %>>
                <div id="idpw">

                    <div id="inputid">

                        <h4 class="title_id">
                            <label for="id">아이디</label>
                        </h4>

                        <span>
                            <input id="id" name="id" type="text" value=<%=id %> readonly>
                        </span>
                       
                    </div>
                   
                </div>

                <div id="userinfo">

                    <div id="inputname">

                        <h4 class="title_name">
                            <label for="name">이름</label>
                        </h4>

                        <span>
                            <input id="name" name="name" type="text" value=<%=name%> readonly>
                        </span>

                        

                    </div>
                    
                    <div id="inputphone">

                        <h4 class="title_phone">
                            <label for="phone">휴대전화</label>
                        </h4>

                        <span>
                            <input id="phone" name="phone" type="text" value=<%=phone %> readonly>
                        </span>

                    </div>
                    
                    <div id="inputemail">

                        <h4 class="title_email">
                            <label for="email">이메일</label>
                        </h4>

                        <span>
                            <input id="sel_email" name="email" type="text" value=<%=email %><%=email_domain %> readonly>
                        </span>

                    </div>

                    <div id="inputbirth">

                        <h4 class="title_birth">
                            <label for="year">생년월일</label>
                        </h4>

                        <span>
                            <input id="year" name="year" type="text" value=<%=year %> readonly>
                        </span>

                        <span>
                        	<input id="month" name="month" type="text"
                        	value=<%=month %>월 style="width: 71px; height: 30px;" readonly>
                        </span>

                        <span>
                        	<input id="day" name="day" type="text"
                        	value=<%=day %>일 style="width: 71px; height: 30px;" readonly>
                        </span>
                        
       
                    </div>

                    <div id="inputgender">

                        <h4 class="title_gender">
                            <label for="gender">성별</label>
                        </h4>

                        <span>
                       		<input id="gender" name="gender" type="text"
                        	value=<%if(gender.equals("male")){
                                %>		남
                                <%} else { 
                                %>		여 
                                <%
                                } %> style="width: 250px; height: 30px;" readonly>
                        </span>
                        
                    </div>

                </div>

                <div>
                </div>
            </form>
			<button type="submit" id="update_btn"><b>수정하기</b></button><br>
            <button type="submit" id="delete_btn"><b>탈퇴하기</b></button><br>
            

        </div>

        <div id="footer">
            <jsp:include page="../../footer.jsp"></jsp:include>
        </div>

    </div>
    
    <script>
        $(function () {

            // form에 있는 정보 받아오기
            let name = document.getElementById("name");
            let phone = document.getElementById("phone");
            let year = document.getElementById("year");
            let month = document.getElementById("month");
            let day = document.getElementById("day");
            let gender = document.getElementById("gender");

            let result;
         

            $("#update_btn").on({
                "mouseover": function () {
                    $("#update_btn").css({ "background-color": "rgb(105, 180, 255)" });
                },
                "mouseleave": function () {
                    $("#update_btn").css({ "background-color": "rgb(155, 205, 255)" });
                }
            });

            
            $("#delete_btn").on({
                "mouseover": function () {
                    $("#delete_btn").css({ "background-color": "rgb(105, 180, 255)" });
                },
                "mouseleave": function () {
                    $("#delete_btn").css({ "background-color": "rgb(155, 205, 255)" });
                }
            });
            
            $("#update_btn").click(function () {
            	$("form").attr("onsubmit", "return true;");
				$("form").attr("action", "../update/updateFormMy.jsp").submit();
            });

            $("#delete_btn").click(function() {
            	result = confirm("회원정보를 삭제하시겠습니까?");
            	
            	if(result){
	                alert("삭제가 완료되었습니다.");
	                $("form").attr("onsubmit", "return true;");
	                $("form").attr("action", "../delete/deleteProcess.jsp").submit();
            	}
			});
            

        });
    </script>		
</body>
</html>

<%	

	}
%>
