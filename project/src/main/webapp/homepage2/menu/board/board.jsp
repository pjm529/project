<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String sessId = (String)session.getAttribute("id"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영남인재교육원 : 게시판</title>
<link rel="stylesheet" href="../../css/menu.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
</head>
<body>
	<br>
    <div id="wrap">

        <div id="header">
            <jsp:include page="../../header.jsp"></jsp:include>
        </div>
        
        

        <div id="container">
        	
        	<div id="menu_title">
				<h2>게시판</h2>
				<br>
			</div>
			
			<table id="board" align="center">
                <tr id="title">
                    <td style="width: 100px;"><b>번호</b></td>
                    <td style="width: 700px;"><b>제목</b></td>
                    <td style="width: 130px;"><b>작성자</b></td>
                    <td style="width: 130px;"><b>등록일</b></td>
                </tr>

               <%
			// 1. JDBC 드라이버 로딩
		
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try{
				
				Context init = new InitialContext();		    
			    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");  
			    conn = ds.getConnection();

				String sql = "select * from board order by num desc";
				
				// 3. PreparedStatement 생성
				pstmt = conn.prepareStatement(sql);
				
				// 4. 쿼리 실행
				rs = pstmt.executeQuery();
				
				// 5. 쿼리 실행 결과 출력
				while(rs.next()) {
		%>
		<tr>
		
			<td>
				<div>
					<%=rs.getString("num") %>
				</div>
			</td>
			
			<td>
				<div class="hide" style="width: 700px">
					<a href="viewList/viewBoard.jsp?num=<%=rs.getString("num")%>">
						<%=rs.getString("title")%></a>
				</div>			
			</td>
			
			
			<td>
				<div class="hide">
					<%=rs.getString("writer")%>
				</div> 
			</td>
			
			<td>
				<div>
					<%=rs.getString("reg_date").substring(0, 10) %>
				</div>
			</td>
			
		</tr>
		<%			
				}
			} catch(SQLException e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
			} finally {
				rs.close();
				pstmt.close();
				conn.close();
			}
		%>

                
            </table>
			<br>
			<div id="insert_btn">
                <button id="add_btn"><b>글 작성</b></button>
            </div>
        </div>

        <br>
        <div id="footer">
            <jsp:include page="../../footer.jsp"></jsp:include>

        </div>

    </div>
    
    <script src="/project/homepage/js/jquery-3.6.0.min.js"></script>
    
    <script>

        $(function () {
			let id = "null";
			let sessId = "<%=sessId %>";
			
            $("#add_btn").click(function () {
                if(id == sessId) {
                	alert("로그인 후 사용하세요.");
                } else {
                	location.href='insert/insertForm.jsp'
                }
            });
        });
    </script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
</body>
</html>