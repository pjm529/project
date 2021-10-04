<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
    
<%
	// 1. JDBC 드라이버 로딩
	String num = request.getParameter("num");
	String title = null;
	String content = null;
	String writer = (String)session.getAttribute("name");
	String writer_id = null;
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		Context init = new InitialContext();
	    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
	    conn = ds.getConnection();
	
		String sql = "select * from board where num=" + num;
	
		pstmt = conn.prepareStatement(sql);
	
		rs = pstmt.executeQuery();
	
		if (rs.next()) {
			title = rs.getString("title");
			content = rs.getString("content");
			writer_id = rs.getString("writer_id");
		}
	} catch (SQLException e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	}  finally{
		rs.close();
		conn.close();
		pstmt.close();
	}
	
	String sessId= (String)session.getAttribute("id");
	
	if(sessId == null) { 
%>
	<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '../../../index.jsp';
	</script>
		
<%	
	} else if (!sessId.equals(writer_id)){ 		
%>
	<script>
	 		alert("접근 권한이 없습니다.");
	 		window.location.href = '../../../index.jsp';
	</script>
<%	
	} else {
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영남인재교육원 : 게시판</title>
<link rel="stylesheet" href="../../../css/insert.css">
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

        <div id="container" style="text-align: center;">

            <div>
                <div>
                    <h2>게시판</h2>
                </div>
                <hr id="noticehr">
                <div>

                    <form action="" method="post" onsubmit="return false;">
						<input type="hidden" name="num" value=<%=num %>>
						<input type="hidden" name="writer_id" value=<%=writer_id %>>
                        <br>

                        <div id="title">

                            <div>
                                <b>제목</b>
                            </div>

                            <div>
                                <textarea cols="130" rows="1" id="title_text" name="title" style="resize: none;"
                                    autocomplete="off" placeholder="제목을 입력하세요."><%=title  %></textarea> 
                            </div>

                        </div>

                        <br>

                        <div id="content">

                            <div>
                                <b>내용</b>
                            </div>

                            <div>
                                <textarea cols="130" rows="10" id="content_text" name="content" style="resize: none;"
                                    placeholder="내용을 입력하세요."><%=content %></textarea>
                            </div>

                        </div>

                        <br>

                        <div id="writer">

                            <div>
                                <b>작성자</b>
                            </div>

                            <div>
                                <textarea cols="130" rows="1" id="writer_text" name="writer" style="resize: none;"
                                    readonly><%=writer %></textarea>
                            </div>

                        </div>

                        <br>

                        <div id="btn">

                            <button id="insert_btn"><b>수정</b></button>
                            <button id="list_btn"><b>목록</b></button>

                        </div>

                    </form>

                    <br>

                </div>

            </div>

        </div>
        
        <div id="footer">
            <jsp:include page="../../../footer.jsp"></jsp:include>
        </div>
    </div>


    <script src="../../../js/jquery-3.6.0.min.js"></script>
    <script>
		$(function () {
			
			let title = document.getElementById("title_text");
            let content = document.getElementById("content_text");
            let writer = document.getElementById("writer_text");
            
			$("#insert_btn").click(function(){
				if(title.value == "" || content.value == "" || writer.value == "") {
					alert("입력 내용을 확인해주세요.");
				} else {
					if(writer.value.length > 6) {
						alert("작성자 명은 6글자를 초과할 수 없습니다.");
					} else {
						alert("수정이 완료되었습니다.");
						$("form").attr("onsubmit", "return true;");
						$("form").attr("action", "updateProcess.jsp").submit();
					}
				}
			});
			
			$("#list_btn").click(function() {
				 window.location.href = '../board.jsp';
			});
		});
		
/* ===========================================header menu css================================================ */
    	
    	$("#menu_notice").on({
            "mouseover": function () {
                $("#menu_notice").css({ "font-size": "18px" });
            },
            "mouseleave": function () {
                $("#menu_notice").css({ "font-size": "16px" });
            }
        });
        
        $("#menu_process").on({
            "mouseover": function () {
                $("#menu_process").css({ "font-size": "18px" });
            },
            "mouseleave": function () {
                $("#menu_process").css({ "font-size": "16px" });
            }
        });
        
        $("#menu_recruit").on({
            "mouseover": function () {
                $("#menu_recruit").css({ "font-size": "18px" });
            },
            "mouseleave": function () {
                $("#menu_recruit").css({ "font-size": "16px" });
            }
        });
        
        $("#menu_board").on({
            "mouseover": function () {
                $("#menu_board").css({ "font-size": "18px" });
            },
            "mouseleave": function () {
                $("#menu_board").css({ "font-size": "16px" });
            }
        });
        
        $("#menu_ad").on({
            "mouseover": function () {
                $("#menu_ad").css({ "font-size": "18px" });
            },
            "mouseleave": function () {
                $("#menu_ad").css({ "font-size": "16px" });
            }
        });
        
        $("#menu_enter").on({
            "mouseover": function () {
                $("#menu_enter").css({ "font-size": "18px" });
            },
            "mouseleave": function () {
                $("#menu_enter").css({ "font-size": "16px" });
            }
        });
        
        $("#menu_introduce").on({
            "mouseover": function () {
                $("#menu_introduce").css({ "font-size": "18px" });
            },
            "mouseleave": function () {
                $("#menu_introduce").css({ "font-size": "16px" });
            }
        });
        
        $("#menu_road").on({
            "mouseover": function () {
                $("#menu_road").css({ "font-size": "18px" });
            },
            "mouseleave": function () {
                $("#menu_road").css({ "font-size": "16px" });
            }
        });
	    
    	/* ======================================================================================================= */
    	
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
<%}%>