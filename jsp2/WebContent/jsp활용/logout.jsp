<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//세션 초기화 (싹 다 날림)
		//session.invalidate();
	
		//해당 세션만 초기화 (로그아웃)		//자바 garbage collection에서 자동으로 garbage 값 관리해줌
		session.setAttribute("loginid", null);
		
		//페이지 이동
		response.sendRedirect("main.jsp");
	 %>
</body>
</html>