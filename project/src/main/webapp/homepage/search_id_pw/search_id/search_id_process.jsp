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
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String id = null;
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		Context init = new InitialContext();
	    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
	    conn = ds.getConnection();
	
		String sql = "select id from user where name = ? and phone = ?";
	
		pstmt = conn.prepareStatement(sql);
	
		pstmt.setString(1, name);
		pstmt.setString(2, phone);
	
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			id = rs.getString("id");
		}
	
	} catch (SQLException e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	} finally {
		rs.close();
		pstmt.close();
		conn.close();
	}
	
	if(id!=null){
		
		response.sendRedirect("search_success.jsp?id="+id);
		
	} else {
		response.sendRedirect("search_fail.jsp");	
	}
%>



