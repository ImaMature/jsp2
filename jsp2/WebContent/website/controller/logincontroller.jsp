<%@page import="DTO.Login"%>
<%@page import="DAO.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%	//name갖다가 써먹는거 .getloginid같은거
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		//db 처리
		boolean result = MemberDao.getmemberDao().longin(id, password);
		
		//db결과
		if(result) {
			//세션 부여 [내장 객체 : 기본값(30분)]
			
			//1.회원 아이디로 회원 번호 찾기
			int m_num =	MemberDao.getmemberDao().getmembernum(id);
			
			//2.찾은 번호를 바탕으로 로그인 객체 생성
			Login login = new Login(m_num , id);
			
			//3.세션 (세션명이 바뀌면 다른 것들도 다 바꿔야함)
			// 우선 헤더부터 가서 확인하기
			//세션에 저장하면 서버에 저장되서 전역변수와 같이 된다. setAttribute으로 설정 getAttribute으로 가져온다.
			session.setAttribute("login", login); //세션명, 값(세션데이터)
			
			
			response.sendRedirect("../view/main.jsp");
		}else{
			response.sendRedirect("../view/member/login.jsp?result=fail"); // 실패했을때 ? 변수명 = 값
		}
	%>
</body>
</html>