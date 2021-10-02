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
	String num = request.getParameter("num");
	if(num == null) { 
%>
	<script>
	 		alert("비정상적인 접근입니다.");
	 		window.location.href = '../../../index.jsp';
	</script>
		
<%	
	} else {
		String title = null;
		String content = null;
		String writer = null;
		String writer_id = null;
		String reg_date = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sessId = (String)session.getAttribute("id");
		
		try {
			Context init = new InitialContext();
		    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
		    conn = ds.getConnection();
		
			String sql = "select * from notice where num=" + num;
			pstmt = conn.prepareStatement(sql);
		
			rs = pstmt.executeQuery();
		
			if (rs.next()) {
				title = rs.getString("title");
				content = rs.getString("content");
				writer = rs.getString("writer");
				writer_id = rs.getString("writer_id");
				reg_date = rs.getString("reg_date").substring(0, 10);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}  finally{
			rs.close();
			conn.close();
			pstmt.close();
		}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영남인재교육원 : 공지사항</title>
<link rel="stylesheet" href="../../../css/viewMenu.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
</head>
<body>
	<br>
    <div id="wrap">

        <div id="header">
            <jsp:include page="../../../header.jsp"></jsp:include>
        </div>

        <div id="container">
        
        	<div id="menu_title">
				<h2><%=title %></h2>
				<br>
			</div>

            <div id="board">

                <form action="" method="post" onsubmit="return false;">
					<input type="hidden" name="num" value=<%=num %>>

                    <table id="view_info" align="center" >
                        <tr>
                            <td><b>번호</b></td>
                            <td><b>작성자</b></td>
                            <td><b>등록일</b></td>
                        </tr>
                    </table>
                    
					<table align="center">
                        <tr>
                            <td><%=num %></td>
                            <td><%=writer %></td>
                            <td><%=reg_date %></td>
                        </tr>
                    </table>
                    
                    <br><br><br>
                    
                    <div id="content">
                        <span><%=content %></span>
                    </div>
                    
                    <br>

                    <div id="btn">
                        <button id="update_btn"><b>수정</b></button>
                        <button id="delete_btn"><b>삭제</b></button>
                        <button id="list_btn"><b>목록</b></button>
                    </div>

                </form>

            </div>
            
        </div>

        <br>
        <div id="footer">
            <jsp:include page="../../../footer.jsp"></jsp:include>
        </div>

    </div>
	<script src="../../../js/jquery-3.6.0.min.js"></script>
    <script>
        $(function () {

        	let sessId = "<%=sessId%>";
        	let id = "<%=writer_id%>";
        	let result;
        	
            $("#update_btn").click(function () {
            	if(sessId == id) {
            		$("form").attr("onsubmit", "return true;");
                    $("form").attr("action", "../update/updateForm.jsp").submit();
            	} else {
            		alert("접근 권한이 없습니다.");
            	}
            });

			$("#delete_btn").click(function () {
            	
            	if(sessId == id || sessId == "admin") {
					result = confirm("게시글을 삭제하시겠습니까?");
                	
                	if(result){
    	                alert("삭제가 완료되었습니다.");
    	                $("form").attr("onsubmit", "return true;");
    	                $("form").attr("action", "../delete/deleteProcess.jsp").submit();
                	}
            	} else {
            		alert("접근 권한이 없습니다.");
            	}
            });

            $("#list_btn").click(function () {
            	window.location.href = '../notice.jsp';
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
<%
	}
%>