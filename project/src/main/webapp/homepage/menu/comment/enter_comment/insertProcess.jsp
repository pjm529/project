<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
	String sessName = (String)session.getAttribute("name");
	String sessId= (String)session.getAttribute("id");
	
	if(sessId == null) { 
%>
	<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '../../../index.jsp';
	</script>
		
<%	} else { 
%>
<%
	String writer_id = (String)session.getAttribute("id");
	String writer = (String)session.getAttribute("name");
	String comment = request.getParameter("comment_text");
	String enter_no = request.getParameter("enter_no");

	if(sessId.equals("admin") && comment != null && enter_no != null) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Context init = new InitialContext();
		    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
		    conn = ds.getConnection();
		
			String sql = "insert into enter_comment (comment, writer, writer_id, enter_no) values (?, ?, ?, ?)";
		
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1,comment);
			pstmt.setString(2, writer);
			pstmt.setString(3, writer_id);
			pstmt.setString(4, enter_no);
			
			pstmt.executeUpdate();
		
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}  finally {
			pstmt.close();
			conn.close();
		}
	
		response.sendRedirect("../../enter/viewList/viewEnter.jsp?num="+enter_no);
		
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


