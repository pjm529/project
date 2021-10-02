<%@page import="encoding.SHA256"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String sessId = (String) session.getAttribute("search_id");
%>

<%
	if(sessId == null) { 
%>
	<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '../../index.jsp';
	</script>
		
<%	} else {
		String pw = request.getParameter("pw");
		
		SHA256 hasing = new SHA256();
		String hashpw = SHA256.encodeSha256(pw);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Context init = new InitialContext();
		    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
		    conn = ds.getConnection();
		
			String sql = "update user set pw = ? where id = ?";
		
			// 3. PreparedStatement 생성
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1, hashpw);
			pstmt.setString(2, sessId);
		
			// 4. 쿼리 실행
			pstmt.executeUpdate();
		
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		} finally {
			pstmt.close();
			conn.close();
		}
		
		session.removeAttribute("search_id");
%>		
		<script>
			alert("비밀번호 변경이 완료되었습니다.");
			window.location.href = '../../index.jsp';
		</script>
		

<%
}
%>



