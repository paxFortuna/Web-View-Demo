<%@page import="db.CarListBean"%>
<%@page import="java.util.Vector"%>
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
<!-- 데이터 베이스에 연결하여 최신순 자동차 3대만 뿌려주는 데이터를 가져옴 -->

<%
	 RentcarDAO rdao = new RentcarDAO();
	//벡터를 이용하여 자동차를 저장
	Vector<CarListBean> v = rdao.getSelectCar();
%>

<center>
<table width="1000">
	<tr height="100">
	<td align="center" colspan="3">
	<font size="6" color="gray">최신형 자동차</font></td>
	<tr height="240">
	<%	for(int i=0; i<v.size(); i++){
	CarListBean bean = v.get(i);	
	%>
		<td width="333" align="center" >
		<a href="RentMain.jsp?center=CarReserveInfo.jsp?no=<%=bean.getNo()%>">
		<img alt="" src="img/<%=bean.getImg() %>" width="300" height="200">
		</a><p>
		차량명 : <%=bean.getName() %>
		</td>	
	<% } %>	
	</tr>
</table>
	<hr size="2">
<p> <br>
	<font size="4" color="gray"><b>차량 검색 하기</b></font><br><br><br>
	<form action="RentMain.jsp?center=CarCategoryList.jsp" method="post">
		<font size="3" color="gray"><b>차량 검색 하기</b></font>&nbsp; &nbsp;
		<select name="category">
			<option value="1">소형</option>
			<option value="2">중형</option>
			<option value="3">대형</option>	
		</select>&nbsp; &nbsp;
	<input type="submit" value="검색">&nbsp; &nbsp;
	</form><br>
	<button onclick="location.href='RentMain.jsp?center=CarAllList.jsp'">전체검색</button>	

</center>

</body>
</html>