<%@page import="DAO.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int r_num = Integer.parseInt(request.getParameter("r_num"));
	int b_num = Integer.parseInt(request.getParameter("b_num"));
	//System.out.println(b_num);
	boolean rs = BoardDao.getBoardDao().replyDelete(r_num);
	
	if(rs){
		out.print("<script>alert('리플이 삭제되었습니다.');</script>");
		out.print("<script> location.href='../view/board/boardview.jsp?b_num="+b_num+"'; </script>");
	}else{
		out.print("<script>alert('리플 삭제 실패');</script>");
		out.print("<script> location.href='../view/board/boardview.jsp?b_num="+b_num+"'; </script>");
	}
			
%>