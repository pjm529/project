<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String sessId = (String) session.getAttribute("id");
	String sessNum = (String) session.getAttribute("num");
	String num = request.getParameter("num");

	if(sessId == null) { 
%>
	<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '../../index.jsp';
	</script>
		
<%	} else {
		if(sessId.equals("admin")||sessNum.equals(num)) {
	
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			
			try {
				Context init = new InitialContext();
			    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
			    conn = ds.getConnection();
				
				String sql = "delete from user where num =" + num;
				
				pstmt = conn.prepareStatement(sql);
			
				pstmt.executeUpdate();
				
				init(conn, pstmt); // 게시글번호 정렬
					
			} catch (SQLException e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
			}  finally {
				pstmt.close();
				conn.close();
			}
			
			if(sessId.equals("admin")){
				response.sendRedirect("../member.jsp");
			} else {
				response.sendRedirect("../../logProcess/logout.jsp");
			}
		} else {
%>	
		<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '../../index.jsp';
		</script>
<%	
		}
	}
%>

<%!	
public void init(Connection conn, PreparedStatement pstmt) throws SQLException{
	
	ResultSet rs = null;
	
	int count=0;
	String sql = "select count(*) as 'count' from user";
	
	try {
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
			count = rs.getInt("count");
		}
		
		String sqlList[] = {
				"ALTER TABLE user AUTO_INCREMENT=1", 
				"SET @CNT = 0", 
				"UPDATE user SET user.num = @CNT:=@CNT+1",
				"ALTER TABLE user AUTO_INCREMENT="+(count+1), 
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
