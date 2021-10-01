
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>

<%
	String sessId =(String) session.getAttribute("id");
	String sessName=(String) session.getAttribute("name");
	String sessNum=(String) session.getAttribute("num");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영남인재교육원</title>
<link rel="stylesheet" href="css/mine.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">

</head>
<body>
    <br>
    <div id="wrap">

        <div id="header">
            <jsp:include page="../header.jsp"></jsp:include>
        </div>

        <div id="container">

            <div id="contents">

                <div id="display">
                
                    <div id="notice">
                        <jsp:include page="../home/homeNotice.jsp"></jsp:include>
                    </div>

                    <div id="board">
                        <jsp:include page="../home/homeBoard.jsp"></jsp:include>
                    </div>

                    <div id="ad">
                        <jsp:include page="../home/homeAd.jsp"></jsp:include>
                    </div>

                    <div id="process">    
                        <jsp:include page="../home/homeProcess.jsp"></jsp:include>
                    </div>

                    <div id="recruit">
                        <jsp:include page="../home/homeRecruit.jsp"></jsp:include>
                    </div>

                    <div id="enter">
                        <jsp:include page="../home/homeEnter.jsp"></jsp:include>
                    </div>

                </div>

            </div>

            <div id="side">

                <div id="sidebar">
					<jsp:include page="../home/homeLogined.jsp"></jsp:include>           
                </div>

                <div id="bkcolor">
                    <button id="chgcolor" class="btn btn-secondary btn">배경색상 바꾸기</button>
                    <button id="reset" class="btn btn-secondary btn">색상 초기화</button>
                </div>

                <div id="sns">
					<jsp:include page="../home/homeSns.jsp"></jsp:include> <!-- sns 창-->   
                </div>

                <div id="game">
                    <p>게임</p>
                    <hr>
                    <span><a href="game/rsp.html">가위바위보</a></span><br>
                    <span><a href="game/worldcup.html">이상형 월드컵</a></span><br>
                    <span><a href="game/race.html?#">경주 게임</a></span>
                </div>


            </div>

        </div>

        <br>
        
        <div id="footer">
            <jsp:include page="../footer.jsp"></jsp:include>
        </div>

    </div>

    <script src="js/jquery-3.6.0.min.js"></script>
    <script src="js/index.js"></script>
    <script>
        
    	
        $("#chgcolor").click(function () {
            $("body").css({ "background-color": rndColor() });
        });

        $("#reset").click(function () {
            $("body").removeAttr("style");
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