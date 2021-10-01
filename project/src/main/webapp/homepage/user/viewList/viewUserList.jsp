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

<%
	if(sessId == null) { 
%>
	<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '../../index.jsp';
	</script>
		
<%	} else {
		if(sessId.equals("admin")) {
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<style>
	a{
		text-decoration: none;
	}
</style>

<body>

	<table  border="1" align="center" style="background-color: white">
	
		<tr>
			<td><b>회원번호</b></td>
			<td><b>아이디</b></td>
			<td><b>이름</b></td>
			<td><b>휴대전화</b></td>
			<td><b>이메일</b></td>
			<td><b>생년월일</b></td>
			<td><b>성별</b></td>
			<td><b>가입일</b></td>
		</tr>
		
		<%
		
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try{
				Context init = new InitialContext();
			    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
			    conn = ds.getConnection();

				String sql = "select * from user";
				
				// 3. PreparedStatement 생성
				pstmt = conn.prepareStatement(sql);
				
				// 4. 쿼리 실행
				rs = pstmt.executeQuery();
				
				// 5. 쿼리 실행 결과 출력
				while(rs.next()) {
		%>
		<tr>
		
			<td>
				<div style="width:80px;">
					<%=rs.getString("num") %>
				</div>
			</td>
			
			<td>
				<div style="width: 150px">
					<a href="viewList/viewUser.jsp?num=<%=rs.getString("num")%>">
						<%=rs.getString("id")%></a>
				</div>			
			</td>
			
			<td>
				<div style="width: 150px;">
					<%=rs.getString("name")%>
				</div> 
			</td>
			
			<td>
				<div style="width: 150px;">
					<%=rs.getString("phone")%>
				</div> 
			</td>
			
			<td>
				<div style="width: 200px;">
					<%=rs.getString("email")%><%=rs.getString("email_domain") %>
				</div> 
			</td>
			
			<td>
				<div style="width: 100px;">
					<%=rs.getString("year")%>-<%=rs.getString("month")%>-<%=rs.getString("day")%>
				</div> 
			</td>
			
			<td>
				<div style="width: 80px;">
					<%if(rs.getString("gender").equals("male")){
                    %>		남 
                    <%} else { 
                    %>		여 
                    <% }
                    %>
				</div> 
			</td>
			
			<td>
				<div style="width: 170px;">
					<%=rs.getString("reg_date") %>
				</div>
			</td>
			
		</tr>
		<%			
				}
			} catch(SQLException e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
			} finally {
				rs.close();
				pstmt.close();
				conn.close();
			}
		%>
	</table>
	
</body>
</html>

<%
		} else {
%>	
		<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '../../index.jsp';
		</script>
<%	
		}
	}
%>