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
	String num = request.getParameter("num");
	String comment_writer_id = request.getParameter("comment_writer_id");
	String board_no = request.getParameter("board_no");
%>

<%
	if(sessId == null) { 
%>
	<script>
	 		alert("로그인 후 이용하세요.");
	 		window.location.href = '../../../index.jsp';
	</script>
		
<%	} else {
		if(sessId.equals("admin") || sessId.equals(comment_writer_id)) {
%>
<%

	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	
	try {
		Context init = new InitialContext();
	    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
	    conn = ds.getConnection();
		
		String sql = "delete from board_comment where num =" + num;
		
		// 3. PreparedStatement 생성
		pstmt = conn.prepareStatement(sql);
	
		
		// 4. 쿼리 실행
		pstmt.executeUpdate();
		
		init(conn, pstmt); // 게시글번호 정렬
			
	} catch (SQLException e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	}  finally {
		pstmt.close();
		conn.close();
	}
	
	response.sendRedirect("../../board/viewList/viewBoard.jsp?num="+board_no);
%>

<%!	
public void init(Connection conn, PreparedStatement pstmt) throws SQLException{
	
	ResultSet rs = null;
	
	int count=0;
	String sql = "select count(*) as 'count' from board_comment";
	
	try {
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
			count = rs.getInt("count");
		}
		
		String sqlList[] = {
				"ALTER TABLE board_comment AUTO_INCREMENT=1", 
				"SET @CNT = 0", 
				"UPDATE board_comment SET board_comment.num = @CNT:=@CNT+1",
				"ALTER TABLE board_comment AUTO_INCREMENT="+(count+1), 
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
<%
		} else {
%>	
		<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '../../board/viewList/viewBoard.jsp?num=<%=board_no%>';
		</script>
<%		
		}
	}
%>
