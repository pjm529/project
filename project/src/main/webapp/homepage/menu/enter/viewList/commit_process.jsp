<%@page import="encoding.SHA256"%>
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
		String sessId = (String)session.getAttribute("id");
		String num = request.getParameter("num");
		String pw_text = request.getParameter("pw_text");
		String pw = null;
		
		SHA256 hasing = new SHA256();
		String hashpw = SHA256.encodeSha256(pw_text);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			Context init = new InitialContext();
		    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
		    conn = ds.getConnection();
		
			String sql = "select pw from enter where num=" + num;
			// 2. 데이터베이스 커넥션 생성
		
			// 3. PreparedStatement 생성
			pstmt = conn.prepareStatement(sql);
		
			// 4. 쿼리 실행
			rs = pstmt.executeQuery();
		
			// 5. 쿼리 실행 결과 출력
			if (rs.next()) {
				pw = rs.getString("pw");
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}  finally{
			rs.close();
			conn.close();
			pstmt.close();
		}
		
		if(hashpw.equals(pw)) {
			session.setAttribute("pw_text", hashpw);
			response.sendRedirect("viewEnter.jsp?num="+num);
			
		} else {
%>
			<script>
				alert("비밀번호가 올바르지 않습니다.");
				window.location.href = 'view.jsp?num='+<%=num%>;
			</script>							
<%	}%>