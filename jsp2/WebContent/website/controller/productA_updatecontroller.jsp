<%@page import="DAO.ProductDao"%>
<%@page import="DTO.Login"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	boolean result = ProductDao.getproductDao().p_ActivteUpdate(Integer.parseInt(request.getParameter("p_num")));
																//main.js에서 넘어온 변수 p_num
															
	if(result) {
		out.print("1"); //위에 out.print하고 여기에 또 out.print하니까 둘이 붙어서 같이나옴 새창에 알림 띄우려면 alert해야됨
	}else{
		out.print("2");
	}
%>