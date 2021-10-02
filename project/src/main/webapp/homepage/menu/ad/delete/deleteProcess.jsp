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
	
		if(writer_id.equals(sessId) || sessId.equals("admin")) {
			String num = request.getParameter("num");
			
			// 1. JDBC 드라이버 로딩
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			
			try {
				Context init = new InitialContext();
			    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
			    conn = ds.getConnection();
				
				
				String sql = "delete from ad where num =" + num;
				
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
			
			response.sendRedirect("../ad.jsp");
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
	String sql = "select count(*) as 'count' from ad";
	
	try {
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
			count = rs.getInt("count");
		}
		
		String sqlList[] = {
				"ALTER TABLE ad AUTO_INCREMENT=1", 
				"SET @CNT = 0", 
				"UPDATE ad SET ad.num = @CNT:=@CNT+1",
				"ALTER TABLE ad AUTO_INCREMENT="+(count+1), 
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
