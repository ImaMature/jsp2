<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<p> jsp : (Java Server Pages)</p>
	<ul>
		<li>1. HTML 코드에 JAVA 코드를 넣어 동적웹페이지를 생성하는 웹어플리케이션 도구</li>
		<li>2. 서블릿으로 변환</li>
		<li>3. java -> 웹프로그래밍[서블릿 : java,html 별도] -> jsp [java.html]</li>
		<li>4. jsp 파일내 java+html+css+js 작성 가능</li>
		<li>5. jsp 실행했을 때 -> 서블릿[java]으로 변환!!!</li>
		<li>6. 사용방법 : java 사용시 태그 안에서 작성</li>
	</ul>
	
	<h1>스크립트 예</h1> <!-- html 구역 -->
	
	<!-- 선언문 태그 -->
		<!-- jsp 구역 (선언문 태그 : 1.변수 선언 O[전역변수], 2.메소드 선언 O, 3.출력 X )-->
	
	<%! String 문자열 = "jsp 선언문"; %>  <!-- ; 안들어가면 실행시켰을 때 오류남 -->
	<%! public String 메소드(){ return "jsp 메소드 선언" ;} %>
	<!-- :전역변수 -->
	
	<!-- 스크립트 태그 -->
		<!-- jsp 구역 ( 스크립트 태그 : 1. 변수 선언 O[지역변수], 2.메소드 선언 X, 3. 출력O -->
			<!-- %뒤에 느낌표가 있고 없고 차이 (있으면 전역변수, 없으면 지역변수) -->			
	
	<%
		String 스크립트 ="jsp 스크립트";
		String 내용 = "jsp 입니다.";
		System.out.print("콘솔에 출력하는 메소드1");	// 콘솔 출력
		out.print("HTML에 출력하는 메소드");			// out : 스크립트 태그 나가기 -> html에 출력
	%>
	
	<!-- 표현식 태그 -->
		<!-- html 구역 -->
	<br> 선언문 출력 : <%=문자열 %> <!-- 표현식 태그 : 변수, 메소드를 호출할때만 사용 -->
	<br> 메소드 출력 : <%=메소드() %> <!-- return 값 나옴 -->
	<br> 스크립트 출력 : <%=스크립트 %> <!--  스크립트 객체값 나옴 -->

	
	<!-- 주석 -->
	<br> html : <!-- HTML 주석 -->
	<br> CSS : /*CSS 주석*/
	<br> jsp : <%-- jsp 주석 --%>
	<br> jsp : <% /*여러줄 주석*/  //한줄 주석%>
</body>
</html>