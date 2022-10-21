<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<body>

  <%	
	//세션을 통하여 아이디를 읽어드림
	String id = (String)session.getAttribute("id");
	//로그인이 되어 있지 않다면 session값이 null처리 해줌
	if(id==null)
		id="GUEST";  
  %>     
     
<table width="1000" border-color="white">
	<tr height="70">
		<td colspan="1" >
		<a href = "RentMain.jsp" style="text-decoration: none">
			<img alt="" src="img/LOGO.PNG" height="65">
		</a>	
		</td>   
                
        <td colspan="2" align="center"><h3> 헤르메스 렌터카에 오신 여러분! 환영합니다!</h3></td><br>
		<td align="right" width="200">
			<%=id %>님	
		<% 
			if(id.equals("GUEST")){ %>
			<button onclick="location.href='RentMain.jsp?center=MemberLogin.jsp'">로그인</button>			
		<%
			}else{ %>
			<button onclick="location.href='RentMain.jsp?center=logoutAction.jsp'">로그아웃</button>
		<%
			}
		%>			
		</td>
		<td align="center" width="100">				
			<button onclick="location.href='RentMain.jsp?center=MemberJoin.jsp'">회원가입</button>	
			<button onclick="location.href='RentMain.jsp?center=list.jsp'">마이페이지</button>				
		</td>	
	</tr>	
  
	<tr height="50">
		<td width="200" align="center" bgcolor="pink">
		<font color="white" size="4"><a href="RentMain.jsp?center=CarReserveMain.jsp" style="text-decoration:none"><b>예약하기</b></a></font>
		</td>
		<td width="200" align="center"bgcolor="pink">
			<font color="white" size="4"><a href="RentMain.jsp?center=CarReserveView.jsp" style="text-decoration:none"><b>예약확인</b></a></font>
		</td>
		<td width="200" align="center"bgcolor="pink">
			<font color="white" size="4"><a href="RentMain.jsp?center=BoardList.jsp" style="text-decoration:none"><b>자유게시판</b></a></font>
		</td>
		<td width="200" align="center"bgcolor="pink">
			<font color="white" size="4"><a href="RentMain.jsp?center=CrewMain.jsp" style="text-decoration:none"><b>직접상담</b></a></font>
		</td>
		<td class="notice" width="200" align="center"bgcolor="pink">
			<font color="white" size="4"><a href='RentMain.jsp?center=detail.jsp' style="text-decoration:none"><b>고객센터</b></a></font>
		</td>		
	</tr>		
</table>

</body>
</html>