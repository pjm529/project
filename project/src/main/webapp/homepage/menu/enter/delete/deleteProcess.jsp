<%@page import="java.sql.ResultSet"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String sessId= (String)session.getAttribute("id");
	String writer_id = request.getParameter("writer_id");
	if(sessId == null || writer_id == null) { 
%>
	<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '../../../index.jsp';
	</script>
		
<%	} else { 
%>
<%
	if(writer_id.equals(sessId) || sessId.equals("admin")) {
		String num = request.getParameter("num");
		
		// 1. JDBC 드라이버 로딩
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		
		try {
			Context init = new InitialContext();
		    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
		    conn = ds.getConnection();
			
			
			String sql = "delete from enter where num =" + num;
			String sql2 = "delete from enter_comment where enter_no =" + num;
			
			pstmt = conn.prepareStatement(sql);
			pstmt2 = conn.prepareStatement(sql2);
			
			pstmt.executeUpdate();
			pstmt2.executeUpdate();
			
			init(conn, pstmt); // 게시글번호 정렬
				
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		} finally {
			pstmt.close();
			pstmt2.close();
		
			conn.close();
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

<%!	
public void init(Connection conn, PreparedStatement pstmt) throws SQLException{
	
	ResultSet rs = null;
	
	int count=0;
	String sql = "select count(*) as 'count' from enter";
	String sql2 = "select count(*) as 'count' from enter_comment";
	
	try {
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
			count = rs.getInt("count");
		}
		
		String sqlList[] = {
				"ALTER TABLE enter AUTO_INCREMENT=1", 
				"SET @CNT = 0", 
				"UPDATE enter SET enter.num = @CNT:=@CNT+1",
				"ALTER TABLE enter AUTO_INCREMENT="+(count+1), 
				};
		
		for(int i = 0 ; i < 4 ; i++) {
			pstmt = conn.prepareStatement(sqlList[i]);
			pstmt.executeUpdate();
		}
	
	} finally {
		rs.close();
	} 
	
	try {
		pstmt = conn.prepareStatement(sql2);
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
			count = rs.getInt("count");
		}
		
		String sqlList[] = {
				"ALTER TABLE enter_comment AUTO_INCREMENT=1", 
				"SET @CNT = 0", 
				"UPDATE enter_comment SET enter_comment.num = @CNT:=@CNT+1",
				"ALTER TABLE enter_comment AUTO_INCREMENT="+(count+1), 
				};
		
		for(int i = 0 ; i < 4 ; i++) {
			pstmt = conn.prepareStatement(sqlList[i]);
			pstmt.executeUpdate();
		}
	
	} finally {
		rs.close();
	}
}
%>
