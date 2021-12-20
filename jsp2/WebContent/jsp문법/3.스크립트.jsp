<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h3>스크립트 문</h3>
	<%! int one; String msg; %>
	<% int one=31; String msg = "서블릿 스크립트"; %>
	
	<br>one : <%=one %> <!-- 스크립트 -->
	<br>msg : <%=msg %> <!-- 스크립트 -->
	<br>선언문 one : <%=this.one %> <!-- 선언문 -->
	<br>선언문 msg : <%=this.msg %> <!-- 선언문 -->
	<br>서블릿 경로 : <%=application.getRealPath("/") %> <!-- 서버가 돌아갔을 때 폴더 경로 -->
	
	<%
		float f = 2.3f;
		int i = Math.round(f);
		Date date = new Date(); //java 라이브러리 호출 가능
	%>
	<br> 실수 f의 반올림값은 : <%=f %>
	<br> 현재의 날짜와 시간은 ? <%=date.toString() %>
</body>
</html>