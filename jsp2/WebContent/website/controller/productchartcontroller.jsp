<%@page import="org.json.simple.JSONObject"%>
<%@page import="DAO.PorderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String type = request.getParameter("type");
	//System.out.print(type);
	JSONObject jsonObject = new JSONObject();
	//JSONObject <--> //Map
	//JSONObject.put("키" : "값") : 엔트리 추가
	//jsonObject.put("id", "qweqwe");
	//jsonObject.put("password", "qweqwe"); 
	//int p_num = Integer.parseInt()	
	//값 넘기기 //타입이 1이면
	if(type.equals("1")){
		jsonObject = PorderDao.getporderDao().getOrderDateCount();
	//타입이 2면	
	}else if (type.equals("2")){
		jsonObject = PorderDao.getporderDao().getPcount();
		
	}else if (type.equals("3")){
		int p_num = Integer.parseInt(request.getParameter("p_num"));
		//System.out.println("p_num : " + p_num);
		jsonObject = PorderDao.getporderDao().getpdatecount(p_num);
	}
%>
<%=jsonObject%>
