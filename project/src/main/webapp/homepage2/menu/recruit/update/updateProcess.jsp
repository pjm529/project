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
	String num = request.getParameter("num");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String writer = request.getParameter("writer");
	String training_period = request.getParameter("training_period");
	String recruit_period = request.getParameter("recruit_period");
	String time = request.getParameter("time");
	String count = request.getParameter("count");
	String location = request.getParameter("location");
	String professor = request.getParameter("professor");
	
	// 1. JDBC 드라이버 로딩
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		Context init = new InitialContext();
	    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
	    conn = ds.getConnection();
	
		String sql = "update recruit set title = ?, content = ?, writer = ?, training_period = ?, recruit_period = ?"
				+ ", time = ?, count = ?, location = ?, professor = ?, reg_date = current_timestamp where num =" + num;
	
		// 3. PreparedStatement 생성
		pstmt = conn.prepareStatement(sql);
	
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, writer);
		pstmt.setString(4, training_period);
 		pstmt.setString(5, recruit_period);
 		pstmt.setString(6, time);
 		pstmt.setString(7, count);
 		pstmt.setString(8, location);
 		pstmt.setString(9, professor);
	
		// 4. 쿼리 실행
		pstmt.executeUpdate();
	
	} catch (SQLException e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	} finally {
		// 6. 사용한 pstmt 종료
		pstmt.close();
	
		// 7. 커넥션 종료
		conn.close();
	}
	
	response.sendRedirect("../viewList/viewRecruit.jsp?num="+num);
%>

