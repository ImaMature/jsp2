<%@page import="DTO.Login"%>
<%@page import="DTO.Member"%>
<%@page import="DAO.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	/*  
	Member member = MemberDao.getmemberDao().memberinfo(loginid);
	 String m = member.getM_id();
	String m_birth = member.getM_birth();
	String m_pw = member.getM_password();
	String m_sex = member.getM_sex();
	System.out.println("m : " + m);
	System.out.println("m_birth : " + m_birth);
	System.out.println("m_pw : " + m_pw);
	System.out.println("m_sex : " + m_sex);
	System.out.print("username : " + newname); */

	
	
	Login login = (Login) session.getAttribute("login");
	String id = login.getM_id();
	//Dto폴더에 Login해놓은거 있음 고거 import해서 세션 만들어서 쓰는거
						
	String newname = request.getParameter("newname"); 
						
	String newsex = request.getParameter("newsex");
	
	String newbirth = request.getParameter("newbirth");
	//System.out.print("newbirth : " + newbirth);
	
	String newphone = request.getParameter("newphone");
	//System.out.println("newphone : " + newphone);
	
	String newAddress = request.getParameter("newAddress");
	//System.out.println("newAddress : " + newAddress);
	
	String newPw = request.getParameter("newpw");
	//System.out.println("바뀐패스워드 : " + newPw);
	
	
	//new name db처리					
	if(newsex != null){
		if(MemberDao.getmemberDao().update("m_sex", newsex, id)){
			out.print("1");
		}else {
			out.print("0");
		}
	}	
	
	if(newname != null){
		if(MemberDao.getmemberDao().update("m_name", newname, id)){
			out.print("1");
		}else {
			out.print("0");
		}
	}
	
	if(newbirth != null) {
		if(MemberDao.getmemberDao().update("m_birth", newbirth, id)){
			out.print("1");
		}else{
			out.print("0");
		}
	}
	
	if(newphone != null){
		if(MemberDao.getmemberDao().update("m_phone", newphone, id)){
			out.print("1");
		}else{
			out.print("0");
		}
	}
	
	if(newAddress != null){
		if(MemberDao.getmemberDao().update("m_address", newAddress, id)){
			out.print("1");
		}else{
			out.print("0");
		}
	}
	
	if(newPw != null){
		if(MemberDao.getmemberDao().update("m_password", newPw, id)){
			out.print("1");
		}else{
			out.print("0");
		}
	}
	
%>
