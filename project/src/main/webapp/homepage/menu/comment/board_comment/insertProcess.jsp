<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String writer_id = (String)session.getAttribute("id");
	String writer = (String)session.getAttribute("name");
	String comment = request.getParameter("comment_text");
	String board_no = request.getParameter("num");
	
	// 1. JDBC 드라이버 로딩
	Class.forName("com.mysql.jdbc.Driver");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		Context init = new InitialContext();
	    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
	    conn = ds.getConnection();
	
		String sql = "insert into board_comment (comment, writer, writer_id, board_no) values (?, ?, ?, ?)";
	
		// 3. PreparedStatement 생성
		pstmt = conn.prepareStatement(sql);
	
		pstmt.setString(1,comment);
		pstmt.setString(2, writer);
		pstmt.setString(3, writer_id);
		pstmt.setString(4, board_no);
		
	
		// 4. 쿼리 실행
		pstmt.executeUpdate();
	
	} catch (SQLException e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	}  finally {
		pstmt.close();
		conn.close();
	}
	
	response.sendRedirect("../../board/viewList/viewBoard2.jsp?num="+board_no);
%>
