<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="header.jsp" %>
	
	<h3>도서 검색</h3>
	<form action="bookcontroller.jsp">
		<input type="text" name="books" placeholder="검색할 단어를 입력해주세요">
		<input type="submit" value="검색">
	</form>
	
</body>
</html>