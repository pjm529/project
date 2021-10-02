<%@page import="encoding.SHA256"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String sessId = (String) session.getAttribute("id");
	String sessNum = (String) session.getAttribute("num");
	String num = request.getParameter("num");
	
	if(sessId == null) { 
%>
	<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '../../index.jsp';
	</script>
		
<%	} else {
		if(sessId.equals("admin")||sessNum.equals(num)) {

			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String email_domain = request.getParameter("email_domain");
			String phone = request.getParameter("phone");
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String day = request.getParameter("day");
			String gender = request.getParameter("gender");
			
			SHA256 hasing = new SHA256();
			
			String hashpw = SHA256.encodeSha256(pw);
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			try {
				Context init = new InitialContext();
			    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
			    conn = ds.getConnection();
			
				String sql = "update user set pw = ?, name = ?, phone = ?, email = ?, email_domain = ?,"
						+ " year = ?,  month = ?, day = ?, gender = ? where num =" + num;
			
				pstmt = conn.prepareStatement(sql);
			
				pstmt.setString(1, hashpw);
				pstmt.setString(2, name);
				pstmt.setString(3, phone);
				pstmt.setString(4, email);
				pstmt.setString(5, email_domain);
				pstmt.setString(6, year);
				pstmt.setString(7, month);
				pstmt.setString(8, day);
				pstmt.setString(9, gender);
			
				pstmt.executeUpdate();
			
			} catch (SQLException e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
			} finally {
				pstmt.close();
				conn.close();
			}
			if(sessId.equals("admin")){
				response.sendRedirect("../member.jsp");
			} else {
				session.setAttribute("name", name);
				response.sendRedirect("../../index.jsp");
			}
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
