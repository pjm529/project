<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
    
<% String sessId = (String)session.getAttribute("id"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영남인재교육원 : 찾아오는길</title>
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
		
        <div id="container" text-align="center">
         
        	<div id="menu_title">
        		<h2>찾아오는길</h2>
        		<hr style="width: 1200px"> 
        		<br>
        		
        	</div>
        	
		     <div id="content" style="margin-left: 220px;">
		     	<jsp:include page="map.jsp"></jsp:include>
		     </div>
		     <br>
		     <img src="../../images/road.png" style="margin-left: 220px;">   
        </div>
		        
		<div id="footer">
		    <jsp:include page="../../footer.jsp"></jsp:include>
		
		</div>
	</div>
    
    <script src="/project/homepage/js/jquery-3.6.0.min.js"></script>
    <script>
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