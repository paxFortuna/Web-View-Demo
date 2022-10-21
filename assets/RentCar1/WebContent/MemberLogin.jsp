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
<center>
<form action ="MemberLoginProc.jsp">
<table width="300"  border="1" boarder-color="gray">
	<tr height="100">
		<td align="center" colspan="3">
		<font size="6" color="gray">로그인</font></td>	
	</tr>
	<tr height="40">
		<td width="120" align="center">아이디</td>
		<td width="180" align="center"><input type="text" name="id" size="15"></td>
	</tr>	
	<tr height="40">
		<td width="120" align="center">패스워드</td>
		<td width="180" align="center"><input type="password" name="pass1" size="15"></td>
	</tr>	
	<tr height="40">
		<td align="center" colspan="2"><input type="submit" value="로그인"></td>
	</tr>		
</table>
</form>	
</center>
</body>
</html>