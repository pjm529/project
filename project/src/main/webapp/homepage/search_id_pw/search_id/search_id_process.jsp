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
	
	// 1. JDBC 드라이버 로딩
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		Context init = new InitialContext();
	    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
	    conn = ds.getConnection();
	
		String sql = "select id from user where name = ? and phone = ?";
	
		// 3. PreparedStatement 생성
		pstmt = conn.prepareStatement(sql);
	
		pstmt.setString(1, name);
		pstmt.setString(2, phone);
	
		// 4. 쿼리 실행
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
	

%>

<%
	if(id!=null){
		
%>
	<jsp:include page="search_success.jsp"></jsp:include>
	 <span>
        <input id="id" name="id" type="text" value=<%=id %> readonly>
    </span>
    <jsp:include page="search_success_foot.jsp"></jsp:include>
<%
	} else {
%>
	<jsp:include page="search_fail.jsp"></jsp:include>
<%		
	}
%>



