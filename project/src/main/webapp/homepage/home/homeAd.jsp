<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<a href="menu/ad/ad.jsp">
	<p>구인정보</p>
</a>
<hr>	
<%
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

		String sql = "select num, title from ad order by num desc";

		pstmt = conn.prepareStatement(sql);

		rs = pstmt.executeQuery();

		while (rs.next() && i < 3) {
			num = rs.getString("num");
			title = rs.getString("title");
%>
			<div class="hide" style="width: 450px">
				<span><a href="menu/ad/viewList/viewAd.jsp?num=<%=num %>">· <%=title %></a></span>
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
