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
		//1. 쿠키클래스를 이용한 쿠키 객체 만들기 ( 이름, 데이터 )
		Cookie cookie = new Cookie("mycookie", "아이맥");
		//2. 쿠키 생명주기
		cookie.setMaxAge(5); // 쿠키의 생명주기 [60초 = 1분]
				//생명주기가 끝나면 쿠키값이 지워진다.
		//3. 쿠키 내용 변경
		cookie.setValue("애플"); //데이터(value)값을 애플로 설정하면 아이맥 -> 애플로 변경
								// 쿠키의 값이 바뀔 수 있다.
		//4. 클라이언트[브라우저]에게 쿠키 전달						
		response.addCookie(cookie); //응답. 기준을 잘 정해야함
	%>
	<p>쿠키 만들기 </p>
	<p>쿠키 내용 <a href="12.쿠키테스트.jsp">확인</a></p>
	
</body>
</html>