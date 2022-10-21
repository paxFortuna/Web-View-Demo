<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<center>
	<h2>세션 로그인 처리2</h2>	

<%
	//세션을 이용하여 데이터를 불러옴
	String userId = (String)session.getAttribute("id");
	String pass = (String)session.getAttribute("pass1");	
	if(userId.equals("id") && pass.equals("pass1")){		
		
		//아이디와 패스워드가 일치하니까 메인 페이지를 보여줘야 함.
		response.sendRedirect("BoardMain.jsp?id="+userId );
	}else{
%>
	<script>
		alert("아이디와 패스워드가 일치하지 않습니다.");
		history.go(-1);	
	</script>	
<%
	}
%>
	
</center>
</body>
</html>