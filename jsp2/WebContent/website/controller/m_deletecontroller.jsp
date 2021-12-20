<%@page import="DTO.Login"%>
<%@page import="DAO.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String pw = request.getParameter("password");
	Login login = (Login)session.getAttribute("login"); //logincontroller에서 setAttribute로정한 입력받은 id의 name값
	String id = login.getM_id();
	//현재 세션에 있는 로그인 정보와 패스워드가 동일하면 탈퇴 아니면 탈퇴X
	/* System.out.print("pw 값 : " + pw);
	System.out.print("id 값 : " + id); */
	boolean rs = MemberDao.getmemberDao().delete(id, pw);
	//System.out.print(rs);
	/* ajax 용 */
	if(rs){
		out.print("1");
		/*out.print ->  스크립트 태그 나가기*/
	}else{
		out.print("0");
	}
	
	/* 일반 */
	/* System.out.print(rs); */
	
	/* if(rs) { // 탈퇴 성공시
		//세션 초기화
		session.setAttribute("loginid", null);
		
		//js
		out.print("<script> alert('회원탈퇴 완료.'); </script>");
		out.print("<script> location.href='../view/main.jsp'; </script>");
		// 메인페이지로 돌아가기
	}else{
		out.print("<script> alert('회원정보가 다릅니다.'); </script>");
		out.print("<script> location.href='../view/member/memberinfo.jsp'; </script>");
	} */
%>