<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<script>
		location.href = 'RentMain.jsp?center=BoardMain.jsp'

		var json = {
                "title": "어쩌구",
                "body": "저쩌구",
                "id": 10
              };

              myChannel.postMessage(JSON.stringify(json));
	</script>
</body>
</html>