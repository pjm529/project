
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
	// 1. JDBC 드라이버 로딩
	StringBuffer idBuff = new StringBuffer();
	int i = 0;
	
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		Context init = new InitialContext();
	    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
	    conn = ds.getConnection();
	
		String sql = "select id from user order by num";
	
		// 3. PreparedStatement 생성
		pstmt = conn.prepareStatement(sql);
	
		// 4. 쿼리 실행
		rs = pstmt.executeQuery();
	
		// 5. 쿼리 실행 결과 출력
		while (rs.next()) {
			idBuff.append(rs.getString("id"));
			idBuff.append(",");
			i++;
		}
		
	} catch (SQLException e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	}  finally {
		rs.close();
		pstmt.close();
		conn.close();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영남인재교육원 : 아이디찾기</title>
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

               

                <div id="userinfo">

                    <div id="inputname">

                        <h4 class="title_name">
                            <label for="name">이름</label>
                        </h4>

                        <span>
                            <input id="name" name="name" type="text" autocomplete="off" maxlength="6">
                        </span>

                        <div class="err_name">

                            <span class="text_err_name">
                                이름을 6글자 이하로 입력해주세요.
                            </span>
                            
                        </div>

                    </div>
                    
                    <div id="inputphone">

                        <h4 class="title_phone">
                            <label for="phone">휴대전화</label>
                        </h4>

                        <span>
                            <input id="phone" name="phone" type="text" autocomplete="off" maxlength="11">
                        </span>

                        <div class="err_phone">

                            <span class="text_err_phone">
                                전화번호을 11글자 입력해주세요.
                            </span>
                            
                        </div>

                    </div>
                    
                </div>

                <div>
                </div>
            </form>

            <button type="submit" id="btn"><b>아이디 찾기</b></button>

        </div>

        <div id="footer">
            <jsp:include page="../../footer.jsp"></jsp:include>
        </div>

    </div>

    <script>
        $(function () {
            hide(2);

         	// DB에서 ID목록 받아오기
            let idStr="<%=idBuff.toString()%>"
            let id_arr = idStr.split(",");
            
            console.log(id_arr);
            // form에 있는 정보 받아오기
            let name = document.getElementById("name");
            let phone = document.getElementById("phone");
         

            $("#btn").on({
                "mouseover": function () {
                    $("#btn").css({ "background-color": "rgb(105, 180, 255)" });
                },
                "mouseleave": function () {
                    $("#btn").css({ "background-color": "rgb(155, 205, 255)" });
                }
            });

            $("#btn").click(function () {
            	if (name.value == "" || name.value.length > 6) {
                    $(".err_name").show();
                    hide(1);
                } else {
                    $(".err_name").hide();
                    
                    // phone 체크
                    if(phone.value.length != 11) {
                    	$(".err_phone").show();
                    } else {
                    	search();
                    }
                }
            });

            function search() {

                // DB로 회원정보 보내기
                alert("찾는다.");
                $("form").attr("action", "search_id_process.jsp").submit();
            }

            function hide(index) {
                let err_msg = [".err_name", ".err_phone"];

                for (let i = 1; i >= 2 - index; i--) {
                    $(err_msg[i]).hide();
                }
            }


        });
    </script>
</body>
</html>