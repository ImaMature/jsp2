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
	
	<h3>로그인 페이지 입니다.</h3>
	<form action="logincontroller.jsp" method="post">
		<input type="text" name="id" placeholder="Enter ID" > <br>
		<input type="password" name="password" placeholder="Enter Password"> <br>
		<input type="submit" value="로그인">
	</form>
	<form >
	<% String result = request.getParameter("result"); %>
	<% //if(request.getParameter("result") != null ){
		if(result!= null){%>
				
			<h4>로그인 실패</h4>
			
		<%}
	%>
	</form>
	
</body>
</html>