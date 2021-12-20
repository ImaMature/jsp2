<%@page import="java.io.FileInputStream"%>
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
		<%@include file="header.jsp" %>

		<%
		//한글 아이디 패스워드는 막아야되므로 	request.setCharacterEncoding("UTF-8"); 안함
			String id = request.getParameter("id");
			String password = request.getParameter("password");
			
			// 존재여부 확인
			boolean logincheck = false;
			for(Member member : members) {
				if(member.getId().equals(id) && member.getPassword().equals(password)){
					//로그인 성공
					logincheck = true;
						//세션 생성
						session.setAttribute("loginid", member.getId());
						
						//!중요 : 세션은 서버에서 돌아감 (완전한 전역변수)
						
						
						
						//할당된 세션이 header에서 "loginid(세션명)"와 똑같은 세션명의 세션에 member.getID()의 값을 전달 
						//setAttribute("세션명", 변수) -> getAttribute("같은 세션명")로 호출됨
						
						//session.setMaxInactiveInterval(10);
						//초당 세션 유지시간
						// 10초동안 별도로 요청 하지않으면 세션이 사라짐
						
						response.sendRedirect("main.jsp");
				}
			}
			//로그인 실패
			if(!logincheck){
				response.sendRedirect("login.jsp?result=fail");
				//url 요청 변수도 같이 이동
			}
		%>
</body>
</html>