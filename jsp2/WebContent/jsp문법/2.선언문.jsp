<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h3>선언문</h3>
	<%
		String 스크립트 = "jsp 프로그래밍1";
		int 변수1 = 0;	// 스크립트문에서 변수 선언시 초기값 필수
	%>
	<%!
		String 선언문 = "jsp 프로그래밍2";
		int 변수2;		// 멤버변수 : 초기값 없을 경우 null, 0 자동으로 들어감		
	%>

	<br> 출력결과 : <%=스크립트 %>
	<br> 출력결과 : <%=선언문 %>
	<br> 출력결과 : <%=변수1 %>
	<br> 출력결과 : <%=변수2 %>	
	
	<%! //jsp 선언문 구역
		int one;	int two =2;
		public int plus(){
			return one+two;
		}
		String msg;
		int three;
	%>
	
	<!--  표현식 -->
	<br> one과 two 합은? : <%=plus() %>  	<!-- 메소드 결과 -->
	<br> msg 값은 ? : <%=msg %>  			<!-- 문자열이 초기값이 없을 경우 null -->
	<br> three 값은 ? : <%=three %> 		<!-- 정수열이 초기값이 없을 경우 0 -->
	
</body>
</html>