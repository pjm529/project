<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<a href="menu/enter/enter.jsp">
	<p>입학상담</p>
</a>
<hr>	
<%
	// 1. JDBC 드라이버 로딩
	String num = null;
	String title = null;

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int i = 0;
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
		conn = ds.getConnection();

		String sql = "select num, title from enter order by num desc";
		// 2. 데이터베이스 커넥션 생성

		// 3. PreparedStatement 생성
		pstmt = conn.prepareStatement(sql);

		// 4. 쿼리 실행
		rs = pstmt.executeQuery();

		// 5. 쿼리 실행 결과 출력
		while (rs.next() && i < 3) {
			num = rs.getString("num");
			title = rs.getString("title");
	%>
			<div class="hide" style="width: 450px">
				<span><a href="/project/homepage/menu/enter/viewList/viewEnter.jsp?num=<%=num %>">· <%=title %></a></span>
			</div>
			
<%
			i++;
		}
	} catch (SQLException e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	} finally{
		rs.close();
		conn.close();
		pstmt.close();
	}
%>	