<%@page import="model.MemberBean"%>
<%@page import="model.MemberDAO"%>
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
  	String id = request.getParameter("id"); //memberlist에서 id를 받아줌
  	MemberDAO mdao = new MemberDAO();
  	MemberBean mbean = mdao.oneSelectMember(id);//해당하는 id의 회원정보를 리턴
  %>

  <center>
    <h2>회원 정보 수정하기</h2>

    <form action="RentMain.jsp?center=MemberUpdateProc.jsp"
      method="post">
      <table width="400" border="1">
        <tr height="50">
          <td align="center" width="150">아이디</td>
          <td width="150"><%=mbean.getId()%></td>
        </tr>
        <tr height="50">
          <td align="center" width="150">이메일</td>
          <td width="250"><input type="email" name="email"
            value="<%=mbean.getEmail()%>"></td>
        </tr>
        <tr height="50">
          <td align="center" width="150">전화번호</td>
          <td width="250"><input type="tel" name="tel"
            value="<%=mbean.getTel()%>"></td>
        </tr>
        <tr height="50">
          <td align="center" width="150">패스워드</td>
          <td width="250"><input type="password" name="pass1">
          </td>
        </tr>
        <tr height="50">
          <td align="center" colspan="2"><input type="hidden"
            name="id" value="<%=mbean.getId()%>"> <input
            type="submit" value="회원 수정하기">&nbsp;&nbsp;</td>
        </tr>
      </table>
    </form>
    <button onclick="location.href='RentMain.jsp?center=MemberList.jsp'">회원전체보기</button>
  </center>
</body>
</html>