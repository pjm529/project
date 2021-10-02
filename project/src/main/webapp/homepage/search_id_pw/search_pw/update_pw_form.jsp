<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String sessId = (String) session.getAttribute("search_id");
	if(sessId == null) { 
%>
	<script>
	 		alert("비정상적인 접근입니다.");
	 		window.location.href = '../../index.jsp';
	</script>
		
<%	
	} else {
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영남인재교육원 : 비밀번호찾기</title>
<link rel="stylesheet" href="../../css/signup.css">
</head>

<body>

    <script src="../../js/jquery-3.6.0.min.js"></script>
    <div id="wrap">


        <div id="header">
            <a href="../../index.jsp"><img src="../../images/index/logo.png" id="logo"></a>
        </div>

        <hr>

        <div id="container">

            <form action="insertProcess.jsp" method="POST">

                <div id="idpw">
                    <div id="inputpw">

                        <h4 class="title_pw">
                            <label for="pw">비밀번호</label>
                        </h4>

                        <span>
                            <input id="pw" name="pw" type="password" maxlength="16" >
                        </span>

                        <div class="err_pw">

                            <span class="text_err_pw">
                                비밀번호를 8~16자 입력하세요.
                            </span>

                        </div>

                    </div>

                    <div id="inputchkpw">

                        <h4 class="title_chkpw">
                            <label for="pw">비밀번호 재확인</label>
                        </h4>

                        <span>
                            <input id="chkpw" type="password" maxlength="16">
                        </span>

                        <div class="err_chkpw">

                            <span class="text_err_chkpw">
                                비밀번호가 일치하지 않습니다.
                            </span>

                        </div>
                    </div>
                   
                </div>

                
            </form>

            <button type="submit" id="update_btn"><b>비밀번호 변경하기</b></button><br>

        </div>

        <div id="footer">
            <jsp:include page="../../footer.jsp"></jsp:include>
        </div>

    </div>
    
    <script>
        $(function () {
            hide(2);
            let pw = document.getElementById("pw");

            $("#update_btn").on({
                "mouseover": function () {
                    $("#update_btn").css({ "background-color": "rgb(105, 180, 255)" });
                },
                "mouseleave": function () {
                    $("#update_btn").css({ "background-color": "rgb(155, 205, 255)" });
                }
            });

            $("#update_btn").click(function () {
				
            	if (pw.value == "" || (pw.value.length < 8 || pw.value.length > 17)) {

                    $(".err_pw").show();
                    hide(1);

                } else {

                    $(".err_pw").hide();

                    if (pw.value != chkpw.value || chkpw.value == "") {

                        $(".err_chkpw").show();

                    } else {

                        $(".err_chkpw").hide();
            			$("form").attr("onsubmit", "return true;");
            			$("form").attr("action", "update_pw_process.jsp").submit();;
                    }
                }
            });

            function hide(index) {
                let err_msg = [".err_pw", ".err_chkpw"];

                for (let i = 1; i >= 2 - index; i--) {
                    $(err_msg[i]).hide();
                }
            }
        });
    </script>		
</body>
</html>
<%} %>
