<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<!DOCTYPE html  PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <center>
    <h2>회원 정보 삭제하기</h2>

    <form action="RentMain.jsp?center=MemberDeleteProc.jsp" method="post">
      <table width="400" border="1">
        <tr height="50">
          <td align="center" width="150">아이디</td>
          <td align="center" width="250"><%=request.getParameter("id")%></td>
        </tr>
        <tr height="50">
          <td align="center" width="150">패스워드</td>
          <td align="center" width="250"><input type="password"
            name="pass1"></td>
        </tr>
        <tr height="50">
          <td align="center" colspan="2"><input type="hidden"
            name="id" value="<%=request.getParameter("id")%>">
            <input type="submit" value="회원 삭제하기">&nbsp;&nbsp;</td>
        </tr>
      </table>
    </form>
    <button onclick="location.href='RentMain.jsp?center=MemberList.jsp'">회원전체보기</button>

  </center>
</body>
</html>