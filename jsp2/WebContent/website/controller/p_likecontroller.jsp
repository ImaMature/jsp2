<%@page import="DAO.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//productview에서  onclick="plike(<%=p_num %,<%=m_num %)로 main.js에다가 인수 넘김 //%'>'넣으면 자꾸 주석 탈출해서 그냥 뺐는데 있어야됨
	
	//funtion plike(p_num, m_num){에서 아약스통해서 이리로 전달
	
	int p_num = Integer.parseInt(request.getParameter("p_num"));
	int m_num = Integer.parseInt(request.getParameter("m_num"));
	//out.print("제품번호 : " + p_num);
	//out.print("회원번호 : " + m_num);
	
	//db처리 (out.print() : 자바 -> HTML로 내보내기)
	//Dao에서 return한 값 출력
	out.print(ProductDao.getproductDao().plikeupdate(p_num, m_num));
	
	
			
%>