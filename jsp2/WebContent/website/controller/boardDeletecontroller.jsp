<%@page import="DAO.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int b_num = Integer.parseInt(request.getParameter("b_num"));
	//boardview.jsp에서 .jsp?b_num=으로 받아온것
	//System.out.println("b_num : " +b_num);
			
	//db처리
	boolean rs = BoardDao.getBoardDao().boardDelete(b_num);
	//System.out.println("rs : " +rs);
	
	if(rs) {
		out.print("<script>alert('게시물이 삭제되었습니다.');</script>");
		out.print("<script> location.href='../view/board/boardlist.jsp'; </script>");
		//response.sendRedirect("../../view/boardlist.jsp");
			//1. out.print 2. response [ 페이지 전환 ] 3. alert [x]
			//1. out.print 2. alert, location.href 			[0]
	}else{
		
		response.sendRedirect("../view/board/boardview.jsp?b_num=" + b_num);
		
		//b_num을 전해줘야 게시물 보임
	}
%>