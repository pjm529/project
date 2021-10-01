
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	String email_domain = request.getParameter("email_domain");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String gender = request.getParameter("gender");
	
	// 1. JDBC 드라이버 로딩
	Class.forName("com.mysql.jdbc.Driver");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		Context init = new InitialContext();
	    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
	    conn = ds.getConnection();
	
		String sql = "insert into user (id, pw, name, phone, email, email_domain, year, month, day, gender) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
		// 3. PreparedStatement 생성
		pstmt = conn.prepareStatement(sql);
	
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.setString(3, name);
		pstmt.setString(4, phone);
		pstmt.setString(5, email);
		pstmt.setString(6, email_domain);
		pstmt.setString(7, year);
		pstmt.setString(8, month);
		pstmt.setString(9, day);
		pstmt.setString(10, gender);
	
		// 4. 쿼리 실행
		pstmt.executeUpdate();
	
	} catch (SQLException e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	}  finally {
		pstmt.close();
		conn.close();
	}
	
	response.sendRedirect("/project/homepage/index.jsp");
%>
