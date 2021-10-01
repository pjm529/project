<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String num = request.getParameter("num");
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String gender = request.getParameter("gender");
	
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		Context init = new InitialContext();
	    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
	    conn = ds.getConnection();
	
		String sql = "update user set id = ?, name = ?, year = ?, month = ?, day = ?, gender = ?, "
				+ "reg_date = current_timestamp where num =" + num;
	
		// 3. PreparedStatement 생성
		pstmt = conn.prepareStatement(sql);
	
		pstmt.setString(1, id);
		pstmt.setString(2, name);
		pstmt.setString(3, year);
		pstmt.setString(4, month);
		pstmt.setString(5, day);
		pstmt.setString(6, gender);
	
		// 4. 쿼리 실행
		pstmt.executeUpdate();
	
	} catch (SQLException e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	} finally {
		pstmt.close();
		conn.close();
	}
	
	response.sendRedirect("../viewList/viewUser.jsp?num="+num);
%>

