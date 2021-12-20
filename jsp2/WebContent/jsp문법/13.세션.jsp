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
		//1. 쿠키와 달리 세션은 내장객체(미리 만들어진 객체)가 있어서 사용하기 편리
		session.setAttribute("id", "qweqwe");		//.setAttribute : 세션에 이름과 값 넣기
		session.setAttribute("password", "123");
		//세션 저장소[톰캣(서버)]에 저장
		
		//2. 세션의 생명주기 [세션 호출이 없을 때]
		session.setMaxInactiveInterval(60);		//60초 [기본값은 : 30분] 
						//setMaxInactiveInterval(60*30) 이렇게 쓸 수 있다.
						//60초 * 30 = 1분 * 30 = 30분
						//시간이 지나면 세션은 종료됨
	%>
	
	<p>세션 만들기</p>
	<p><a href="13.세션테스트.jsp">확인</a></p>
</body>
</html>