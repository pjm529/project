<%@page import="encoding.SHA256"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String sessName = (String)session.getAttribute("name");
	String sessId= (String)session.getAttribute("id");
	
	if(sessId == null) { 
%>
	<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '../../../index.jsp';
	</script>
		
<%	
	} else { 
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String writer = request.getParameter("writer");
		String pw = request.getParameter("pw");
		String writer_id = (String)session.getAttribute("id");
		
		SHA256 hasing = new SHA256();
		String hashpw = SHA256.encodeSha256(pw);
		
	
		if(title != null && content != null) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			try {
				Context init = new InitialContext();
			    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
			    conn = ds.getConnection();
			
			    String sql = "insert into enter (title, content, writer, writer_id, pw) values (?, ?, ?, ?, ?)";
			
			 		pstmt = conn.prepareStatement(sql);
			 	
			 		pstmt.setString(1, title);
			 		pstmt.setString(2, content);
			 		pstmt.setString(3, writer);
			 		pstmt.setString(4, writer_id);
			 		pstmt.setString(5, hashpw);
			 	
			 		pstmt.executeUpdate();
			 	
			 	} catch (SQLException e) {
			 		System.out.println(e.getMessage());
			 		e.printStackTrace();
			 	}finally{
					conn.close();
					pstmt.close();
				}
			
			response.sendRedirect("../enter.jsp");
		} else {
%>
			<script>
			 		alert("비정상적인 접근입니다.");
			 		window.location.href = '../../../index.jsp';
			</script>
<%
	}
	
}
%>
