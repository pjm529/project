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

	String num = request.getParameter("num");
	
	// 1. JDBC 드라이버 로딩
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	
	try {
		Context init = new InitialContext();
	    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
	    conn = ds.getConnection();
		
		
		String sql = "delete from recruit where num =" + num;
		
		// 3. PreparedStatement 생성
		pstmt = conn.prepareStatement(sql);
	
		
		// 4. 쿼리 실행
		pstmt.executeUpdate();
		
		init(conn, pstmt); // 게시글번호 정렬
			
	} catch (SQLException e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	} finally {
		// 6. 사용한 pstmt 종료
		pstmt.close();
	
		// 7. 커넥션 종료
		conn.close();
	} 
	
	response.sendRedirect("/project/homepage/menu/recruit/recruit.jsp");
%>

<%!	
public void init(Connection conn, PreparedStatement pstmt) throws SQLException{
	
	ResultSet rs = null;
	
	int count=0;
	String sql = "select count(*) as 'count' from recruit";
	
	try {
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
			count = rs.getInt("count");
		}
		
		String sqlList[] = {
				"ALTER TABLE recruit AUTO_INCREMENT=1", 
				"SET @CNT = 0", 
				"UPDATE recruit SET recruit.num = @CNT:=@CNT+1",
				"ALTER TABLE recruit AUTO_INCREMENT="+(count+1), 
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
