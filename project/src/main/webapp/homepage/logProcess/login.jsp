<%@page import="encoding.SHA256"%>
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
	StringBuffer numBuff = new StringBuffer();
	StringBuffer idBuff = new StringBuffer();
	StringBuffer pwBuff = new StringBuffer();
	StringBuffer nameBuff = new StringBuffer();
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	SHA256 hasing = new SHA256();
	
	String hashpw = SHA256.encodeSha256(pw); //비밀번호 해시
	
	int i = 0;
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		Context init = new InitialContext();
	    DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
	    conn = ds.getConnection();
	
		String sql = "select num, id, pw, name from user order by num";
	
		pstmt = conn.prepareStatement(sql);
	
		rs = pstmt.executeQuery();
	
		while (rs.next()) {
			numBuff.append(rs.getString("num"));
			numBuff.append(",");
			
			idBuff.append(rs.getString("id"));
			idBuff.append(",");
			
			pwBuff.append(rs.getString("pw"));
			pwBuff.append(",");
			
			nameBuff.append(rs.getString("name"));
			nameBuff.append(",");
			i++;
		}
		
	} catch (SQLException e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	} finally {
		rs.close();
		pstmt.close();
		conn.close();
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영남인재교육원</title>
</head>
<body>

	<form action="" post="">
		<input type="hidden" id="id" name="id">
		<input type="hidden" id="name" name="name">
		<input type="hidden" id="num" name="num">
	</form>
		
	 <script src="../js/jquery-3.6.0.min.js"></script>
    <script src="../js/index.js"></script>
    <script>
    	
	 	// DB에서 num, id,pw,name목록 받아오기
	 	let numStr="<%=numBuff.toString()%>"
		let num_arr = numStr.split(",");
	 	
	    let idStr="<%=idBuff.toString()%>"
	    let id_arr = idStr.split(",");
	    
	    let pwStr="<%=pwBuff.toString()%>"
		let pw_arr = pwStr.split(",");
		
	    let nameStr="<%=nameBuff.toString()%>"
		let name_arr = nameStr.split(",");
	    
	    let input_id = "<%=id%>";
        let input_pw = "<%=hashpw%>";  
        
        
        let name = document.getElementById("name");
        let num = document.getElementById("num");
        let id = document.getElementById("id");
        
    	
    	index = $.inArray(input_id, id_arr);
    		
    	if(index == -1) {
    		alert("로그인정보가 올바르지 않습니다.");
        	window.location.href="../index.jsp";
    	} else {
    		if (input_pw == pw_arr[index]) {
            	id.value = input_id;
            	name.value = name_arr[index];
            	num.value = num_arr[index];
            	$("form").attr("action", "loginSuccess.jsp").submit();
            } else {
            	alert("로그인정보가 올바르지 않습니다.");
            	window.location.href="../index.jsp";
            }
    	}
            	
	  </script>
	  
</body>
</html>


