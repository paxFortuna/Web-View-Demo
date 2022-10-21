<%@page import="db.CrewDAO"%>
<%@page import="db.CrewListBean"%>
<%@page import="db.CarListBean"%>
<%@page import="java.util.Vector"%>
<%@page import="db.RentcarDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
   CrewDAO cdao = new CrewDAO();
  //벡터를 이용하여 상담원 자바빈을 저장
   Vector<CrewListBean> v = cdao.getSelectCrew();
%>

<center>
<table width="1000">
  <tr height="100">
  <td align="center" colspan="3">
  <font size="6" color="gray">상담원 연결</font></td>
  <tr height="240">
  <%  for(int i=0; i<v.size(); i++){
	  CrewListBean cbean= v.get(i); 
  %>
    <td width="333" align="center" >
    <a href="RentMain.jsp?center=detail.jsp?no=<%=cbean.getCrno()%>">
    <img alt="" src="crimg/<%=cbean.getCrimg()%>" width="300" height="200">
    </a><p>
   상담원 이름 : <%=cbean.getCrname() %>
    </td> 
  <% } %> 
  </tr>
</table>
  <hr size="2">
<p> <br>
  <font size="4" color="gray"><b>차량 검색 하기</b></font><br><br>
  <form action="RentMain.jsp?center=detail.jsp" method="post">
    <font size="3" color="gray"><b>유형별 검색</b></font>&nbsp; &nbsp;
    <select name="category">
      <option value="1">소형</option>
      <option value="2">중형</option>
      <option value="3">대형</option> 
    </select>&nbsp; &nbsp;
  <input type="submit" value="검색">&nbsp; &nbsp;
  </form><br>
  <button onclick="location.href='RentMain.jsp?center=detail.jsp'">전체검색</button>  

</center>

</body>
</html>