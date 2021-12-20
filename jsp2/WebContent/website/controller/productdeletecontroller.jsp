<%@page import="DAO.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//상품 넘버 받아오기
	int p_num = Integer.parseInt(request.getParameter("p_num"));

	//System.out.println("p_num :" + p_num);

	//DB처리하기
	boolean rs = ProductDao.getproductDao().productDelete(p_num);
	//System.out.print("rs : " + rs);
	
	if(rs){
		out.print("<script>alert('해당 상품이 삭제되었습니다.');</script>");
		out.print("<script> location.href='../view/admin/dashboard.jsp'; </script>");
	}else{
		out.print("<script>alert('해당 상품을 삭제하는데 실패했습니다.');</script>");
		out.print("<script> location.href='../view/admin/dashboard.jsp'; </script>");
	}
%>
