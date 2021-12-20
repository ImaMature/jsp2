<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<%
		request.setCharacterEncoding("UTF-8");
		//요청할때 아스키 코드밖에 안됨
		//그래서 한글 지원하려면 이렇게 인코딩 하는 걸 선언해줘야됨
		// .setCharacterEncoding("인코딩타입") : 요청시 사용되는 인코딩 타입
		String name = request.getParameter("name");
		//전 페이지로부터 변수를 요청
		//request : jsp 내장객체
			//.getParameter("변수명") : 해당 변수명 요청
		String color = request.getParameter("color");
	%>
</head>
<body bgcolor=<%=color %> >
	
	이름 : <%=name %>
	
	
</body>
</html>