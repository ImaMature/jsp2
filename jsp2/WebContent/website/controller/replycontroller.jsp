<%@page import="DAO.BoardDao"%>
<%@page import="DTO.Reply"%>
<%@page import="DTO.Login"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	//내용 전달 받기
	String replycontents = request.getParameter("replycontents");
	//System.out.println(replycontents);
	
	//세션값에서 아이디 가져와서 회원번호 찾기
	Login login = (Login)session.getAttribute("login");
	
	int m_num = login.getM_num();
	
	int b_num = Integer.parseInt(request.getParameter("b_num"));
	
	//System.out.println("b_num : " + b_num);
	
	if(!replycontents.equals("")){
		Reply reply = new Reply(replycontents, m_num, b_num);
		
		boolean rs = BoardDao.getBoardDao().replywrite(reply);
		//System.out.print(rs);
		if(rs){
			out.print("<script>alert('리플이 등록되었습니다.');</script>");
			out.print("<script> location.href='../view/board/boardview.jsp?b_num="+b_num+"'; </script>");
		}
	}
	else{
		out.print("<script>alert('리플 등록 실패.');</script>");
		out.print("<script> location.href='../view/board/boardview.jsp?b_num="+b_num+"'; </script>");
	}
	
	//b_num , m_num

%>