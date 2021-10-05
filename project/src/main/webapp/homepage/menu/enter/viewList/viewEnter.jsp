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
	String num = request.getParameter("num");
	String writer_id = request.getParameter("writer_id");
	String sessId = (String)session.getAttribute("id");
	String pw_text = (String)session.getAttribute("pw_text");
	
	if(num == null || pw_text == null) { 
%>
		<script>
		 		alert("비정상적인 접근입니다.");
		 		window.location.href = '../../../index.jsp';
		</script>
		
<%	
	} else if(!(num == null || pw_text == null) || sessId.equals("admin")){
		
		String title = null;
		String content = null;
		String writer = null;
		String pw = null;
		String reg_date = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		
		String count = null;
		try {
			Context init = new InitialContext();
		    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
		    conn = ds.getConnection();
		
			String sql = "select * from enter where num=" + num;
			String sql2 = null;
			
			pstmt = conn.prepareStatement(sql);
		
			rs = pstmt.executeQuery();
		
			if (rs.next()) {
				
				sql2 = "select count(*) as 'count' from enter_comment where enter_no=" + rs.getString("num");
				
				pstmt2 = conn.prepareStatement(sql2);
				
				rs2 = pstmt2.executeQuery();
				
				if(rs2.next()) {
					count = rs2.getString("count");
				}
				title = rs.getString("title");
				content = rs.getString("content");
				writer = rs.getString("writer");
				writer_id = rs.getString("writer_id");
				pw = rs.getString("pw");
				reg_date = rs.getString("reg_date").substring(0, 10);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}  finally{
			rs.close();
			rs2.close();
			conn.close();
			pstmt.close();
			pstmt2.close();
		}
		
		if(sessId.equals("admin") || pw_text.equals(pw)) {
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영남인재교육원 : 문의사항</title>
<link rel="stylesheet" href="../../../css/viewMenu.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<script src="../../../js/jquery-3.6.0.min.js"></script>	
</head>
<body>
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
                  	<input type="hidden" name="writer_id" value=<%=writer_id %>>

                    <table id="view_info" align="center">
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
            
            <br>
			<hr style="width: 1000px;">

			<div id="comment">
				<form action="" method="post">
					<input type="hidden" name="enter_no" value=<%=num%>> <b>댓글</b> [<%=count %>]<br>
					<input id="comment_text" name="comment_text" type="text" maxlength="50" autocomplete="off">
					<button id="add_comment_btn">
						<b>댓글달기</b>
					</button>
				</form>

				<br>
				<%
				try {

					Context init = new InitialContext();
					DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
					conn = ds.getConnection();

					String sql = "select * from enter_comment where enter_no = " + num + " order by reg_date desc";

					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();

					while (rs.next()) {
				%>
				<div>
					<form action="" method="post">
						<input type="hidden" name="enter_no" value=<%=num%>> 
						<input type="hidden" name="num" value=<%=rs.getString("num")%>>
						<input type="hidden" name="comment_writer_id" value=<%=rs.getString("writer_id")%>> 
						
						<span> <b><%=rs.getString("writer")%></b>
							<%=rs.getString("reg_date").substring(0, 16)%></span>
						<button class="delete_comment_btn">x</button>	
							<br> 
						<span><%=rs.getString("comment")%></span>
						
					</form>

				</div>
				<br>
				<%
					}
				} catch (SQLException e) {
					System.out.println(e.getMessage());
					e.printStackTrace();
				} finally {
					rs.close();
					conn.close();
					pstmt.close();
				}
				%>

			</div>
			
        </div>

        <br>
        <div id="footer">
            <jsp:include page="../../../footer.jsp"></jsp:include>
        </div>

    </div>

    <script>
        $(function () {

        	let nullid = "null";
        	let sessId = "<%=sessId%>";
        	let id = "<%=writer_id%>";
        	let result;
			let comment_text = document.getElementById("comment_text");
        	
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
            	window.location.href = '../enter.jsp';
            });
            
            $("#add_comment_btn").click(function() {
				if (sessId != nullid) {
					if(comment_text.value == "") {
						alert("내용을 입력하세요.");
					} else {
						if(sessId == "admin") {
							$("form").attr("onsubmit", "return true;");
							$("form").attr("action","../../comment/enter_comment/insertProcess.jsp").submit();
						} else {
							alert("관리자만 이용할 수 있습니다.");
						}
					}
				} else {
					alert("로그인 후 이용하세요.");
				}
			});

			$(".delete_comment_btn").click(function() {
				
				result = confirm("댓글을 삭제하시겠습니까?");
				
				if(result) {
					if(sessId == "admin") {
						$("form").attr("onsubmit", "return true;");
						$("form").attr("action","../../comment/enter_comment/deleteProcess.jsp").submit();
					} else {
						alert("관리자만 이용할 수 있습니다.");
					}
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
<% 
		} else {		
%> 
		<script>
			alert("비정상적인 접근입니다.");
			window.location.href = '../../../index.jsp';
		</script>
<%		}
	}
%>