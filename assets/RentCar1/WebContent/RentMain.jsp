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
	String center = request.getParameter("center");
	//처음 실행시에는 center 값이 넘어오지 않기에
	if(center==null){//null처리해줌
		center = "Center.jsp"; //디폴트 center값을 부여
	}

%>
<center>
<table width="1000" border-color="white">
	<tr height="70">
		<!-- Top부분 -->
	<tr height="120" align="center">
		<td align="center" width="1000">
			<jsp:include page="Top.jsp"/></td>
	</tr>
	
		<!-- Center부분 -->
	<tr height="500" align="center">
		<td align="center" width="1000">
			<jsp:include page="<%=center %>"/></td>
	</tr>
	
		<!-- Bottom부분 -->
	<tr height="100" align="center">
		<td align="center" width="1000">
			<jsp:include page="Bottom.jsp"/></td>
	</tr>	
</table>
</center>
</body>
</html>