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
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	String email_domain = request.getParameter("email_domain");
	Boolean success = false;
	
	// 1. JDBC 드라이버 로딩
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String count = null;
	
	try {
		Context init = new InitialContext();
	    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
	    conn = ds.getConnection();
	
		String sql = "select *, count(*) as 'count' from user where id = ? and name = ? and phone = ? " 
				+"and email = ? and email_domain = ?";
	
		// 3. PreparedStatement 생성
		pstmt = conn.prepareStatement(sql);
	
		pstmt.setString(1, id);
		pstmt.setString(2, name);
		pstmt.setString(3, phone);
		pstmt.setString(4, email);
		pstmt.setString(5, email_domain);
	
		// 4. 쿼리 실행
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			count = rs.getString("count");
		}
		
		if(count.equals("1")){
			success = true;
		}
	
	} catch (SQLException e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	} finally {
		rs.close();
		pstmt.close();
		conn.close();
	}
	

%>

<%
	if(success){
		session.setAttribute("search_id", id);
		response.sendRedirect("update_pw_form.jsp");
%>
<%
	} else {
%>
	<jsp:include page="search_fail.jsp"></jsp:include>
<%		
	}
%>



