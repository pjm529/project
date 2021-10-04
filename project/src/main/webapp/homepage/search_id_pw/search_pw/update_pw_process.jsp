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
	String sessId = (String) session.getAttribute("search_id");
	String sessName = (String) session.getAttribute("search_name");
	String sessPhone = (String) session.getAttribute("search_phone");
	String sessEmail = (String) session.getAttribute("search_email");
	String sessEmail_domain = (String) session.getAttribute("search_email_domain");

	if(sessId == null || sessName == null || sessPhone == null || sessEmail == null || sessEmail_domain == null) { 
%>
	<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '../../index.jsp';
	</script>
		
<%	
	} else {
		String pw = request.getParameter("pw");
		
		SHA256 hasing = new SHA256();
		String hashpw = SHA256.encodeSha256(pw);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Context init = new InitialContext();
		    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
		    conn = ds.getConnection();
		
			String sql = "update user set pw = ? where id = ? and name = ? and phone = ? and email = ? and email_domain = ?";
		
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1, hashpw);
			pstmt.setString(2, sessId);
			pstmt.setString(3, sessName);
			pstmt.setString(4, sessPhone);
			pstmt.setString(5, sessEmail);
			pstmt.setString(6, sessEmail_domain);
		
			pstmt.executeUpdate();
		
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		} finally {
			pstmt.close();
			conn.close();
		}
		
		session.removeAttribute("search_id");
		session.removeAttribute("search_name");
		session.removeAttribute("search_phone");
		session.removeAttribute("search_email");
		session.removeAttribute("search_email_domain");
%>		
		<script>
			alert("비밀번호 변경이 완료되었습니다.");
			window.location.href = '../../index.jsp';
		</script>
		

<%
	}
%>



