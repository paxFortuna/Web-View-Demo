<%@page import="db.RentcarDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<title>Insert title here</title>
</head>
<body>

<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String pass = request.getParameter("pass1");
	//회원 아이디와 패스워드가 일치하는지 비교
	RentcarDAO rdao= new RentcarDAO();
	
	//해당 회원이 있는 지 여부를 숫자로 표현
	int result = rdao.getMember(id, pass);
	if(result==0){
    %>
	<script type="text/javascript">
		alert("회원 아이디 또는 패스워드가 틀립니다.");
		location.href='RentMain.jsp?center=MemberLogin.jsp';	
	</script>
	<%
	}else{		
		//로그인 처리가 되었다면
		session.setAttribute("id", id);
		response.sendRedirect("RentMain.jsp");
	}
	%>
</body>
</html>