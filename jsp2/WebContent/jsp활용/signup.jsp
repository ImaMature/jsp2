<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="header.jsp" %> <!-- 헤더페이지 포함 -->
	
	<h3> 회원 페이지 구역 </h3>
	<form action="signupcontroller.jsp" method="post">	<!-- action = 이동할 경로(페이지) / method = 전송방식(get or post) -->
		<input type="text" name="id" placeholder="Enter ID">				<br>
		<input type="password" name="password" placeholder="Enter password"> 	<br>
		<input type="text" name="name" placeholder="Enter Name">
		<input type="submit" value="회원가입">		<!-- 클릭했을 때 from전송 (action 값 = 이동하는 파일) -->
	</form>
</body>
</html>