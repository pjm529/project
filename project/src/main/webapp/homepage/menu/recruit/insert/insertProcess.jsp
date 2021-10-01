<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
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
	 		window.location.href = '../../../index.jsp';
	</script>
		
<%	} else {
		if(sessId.equals("admin")) {
%>

<%

	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String writer = request.getParameter("writer");
	String writer_id = (String)session.getAttribute("id");
	String training_period = request.getParameter("training_period");
	String recruit_period = request.getParameter("recruit_period");
	String time = request.getParameter("time");
	String count = request.getParameter("count");
	String location = request.getParameter("location");
	String professor = request.getParameter("professor");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		Context init = new InitialContext();
	    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
	    conn = ds.getConnection();
	
	    String sql = "insert into recruit (title, content, writer, writer_id, training_period, " +
	    		"recruit_period, time, count, location, professor) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
	 		// 3. PreparedStatement 생성
	 		pstmt = conn.prepareStatement(sql);
	 	
	 		pstmt.setString(1, title);
	 		pstmt.setString(2, content);
	 		pstmt.setString(3, writer);
	 		pstmt.setString(4, writer_id);
	 		pstmt.setString(5, training_period);
	 		pstmt.setString(6, recruit_period);
	 		pstmt.setString(7, time);
	 		pstmt.setString(8, count);
	 		pstmt.setString(9, location);
	 		pstmt.setString(10, professor);
	 	
	 		// 4. 쿼리 실행
	 		pstmt.executeUpdate();
	 	
	 	} catch (SQLException e) {
	 		System.out.println(e.getMessage());
	 		e.printStackTrace();
	 	}finally{
			conn.close();
			pstmt.close();
		}
	
	response.sendRedirect("../recruit.jsp");
%>


<%
		} else {
%>	
		<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '../../../index.jsp';
		</script>
<%	
		}
	}
%>