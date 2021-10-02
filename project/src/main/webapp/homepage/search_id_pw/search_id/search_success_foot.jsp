<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


                
                <br>
                
            	<button id="btn" style="width: 127px"><b>로그인하기</b></button>
            	<button id="search_pw_btn" style="width: 127px"><b>비밀번호찾기</b></button>
			</div>
		</div>
		
        <div id="footer">
            <jsp:include page="../../footer.jsp"></jsp:include>
        </div>

    </div>

    <script>
        $(function () {

            $("#btn").on({
                "mouseover": function () {
                    $("#btn").css({ "background-color": "rgb(105, 180, 255)" });
                },
                
                "mouseleave": function () {
                    $("#btn").css({ "background-color": "rgb(155, 205, 255)" });
                },
                
                "click": function() {
                	window.location.href = '../../index.jsp';
                }
            });

            $("#search_pw_btn").on({
                "mouseover": function () {
                    $("#search_pw_btn").css({ "background-color": "rgb(105, 180, 255)" });
                },
                "mouseleave": function () {
                    $("#search_pw_btn").css({ "background-color": "rgb(155, 205, 255)" });
                },
                
                "click": function() {
                	alert("ㅇㅇ")
                }
            });
        });
    </script>
</body>
</html>




