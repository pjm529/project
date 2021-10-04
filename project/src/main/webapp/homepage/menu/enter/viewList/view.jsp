<%@page import="javax.websocket.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>

<%
	String num = request.getParameter("num");
	String sessId = (String)session.getAttribute("id");
	
	if(num == null) { 
%>
		<script>
		 		alert("비정상적인 접근입니다.");
		 		window.location.href = '../../../index.jsp';
		</script>
<% 	
	} else if(sessId == null) {
%>
	<script>
		alert("로그인 후 이용해주세요.");
		window.location.href = '../../../index.jsp';
	</script>
<%	
	} else if(sessId.equals("admin")) {
		session.setAttribute("pw_text", "1");
		response.sendRedirect("viewEnter.jsp?num=" + num);
	} else {
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영남인재교육원 : 입학상담</title>
<link rel="stylesheet" href="../../../css/menu.css">
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
                	<h4>비밀번호</h4><br>
                </div>
                
                <form action="" method="post">
                	<input type="hidden" name="num" value=<%=num %>>
                	
                	<input type="password" id="pw_text" name="pw_text">
                	<button id="pw_btn" name="pw_btn">입력</button>
                	<br><br>
                </form>
            </div>

        </div>
        
        <div id="footer">
            <jsp:include page="../../../footer.jsp"></jsp:include>
        </div>
    </div>
    
    <script src="../../../js/jquery-3.6.0.min.js"></script>
    <script>
		$(function () {
            
            $("#pw_btn").on({ 
                "mouseover": function () {
                    $("#pw_btn").css({ "background-color": "rgb(105, 180, 255)" });
                },
                
                "mouseleave": function () {
                    $("#pw_btn").css({ "background-color": "rgb(155, 205, 255)" });
                },
                
                "click": function() {
                	$("form").attr("action", "commit_process.jsp").submit();
               
                }
            });
            
			$("#list_btn").click(function() {
				 window.location.href = '../enter.jsp';
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
<%
	}
%>