<%@page import="java.io.FileOutputStream"%>
<%@page import="test.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 	<!-- 사용자 뷰X : java -->
 	<%		//스크립트 문 :  java 작성할 때 사용
 		request.setCharacterEncoding("UTF-8"); 				//변수 값을 한글로 요청할 때 사용
 		String id =request.getParameter("id");				//form으로 부터 id 변수 요청
 		String pw = request.getParameter("password");		//form으로 부터 password 변수 요청
 		String name = request.getParameter("name");			//form으로 부터 name 변수 요청
 		
 		//객체화 이유? : 데이터 이동을 편하게 하기 위해
 		Member member = new Member(id, pw, name); 
 		
 		
 		//DB처리 or 파일처리
 		//여기선 파일처리 사용했음
 			//1. 파일 출력 스트릠
 		FileOutputStream fileOutputStream = new FileOutputStream("C:\\Users\\505\\git\\html2\\jsp2\\src\\test\\memberlist.txt", true);
 		//예외처리 발생 안하네? 이유? jsp 서비스에서 작성하고 있기 때문(서블릿에 이미 예외처리가 있다.)
 			//2. 출력할 문자열
 		String outstring = member.getId()+","+member.getPassword()+","+member.getName()+"\n";
 			//3. 문자열 출력 [ 문자열 -> 바이트]
 		fileOutputStream.write(outstring.getBytes());
 				
 		
 		//페이지 이동 [response.sendRedirect("이동페이지경로")] 요거 많이 씀
 		response.sendRedirect("main.jsp");
 	%>
</body>
</html>