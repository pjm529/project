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
	String sessId= (String)session.getAttribute("id");
	String writer_id = request.getParameter("writer_id");
	
	if(sessId == null) { 
%>
	<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '../../../index.jsp';
	</script>
		
<%	} else if (!sessId.equals(writer_id)){ 		
%>
	<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '../../../index.jsp';
	</script>
<%	
	} else {
		String num = request.getParameter("num");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String writer = request.getParameter("writer");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Context init = new InitialContext();
		    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
		    conn = ds.getConnection();
		
			String sql = "update board set title = ?, content = ?, writer = ?, "
					+ "reg_date = current_timestamp where num =" + num;
		
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, writer);
		
			pstmt.executeUpdate();
		
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		} finally {
			pstmt.close();
			conn.close();
		}
		response.sendRedirect("../viewList/viewBoard.jsp?num="+num);
	}
%>




