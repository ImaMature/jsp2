<%@page import="org.json.simple.JSONObject"%>
<%@page import="DAO.PorderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	JSONObject jsonObject = new JSONObject();
	//JSONObject <--> //Map
	//JSONObject.put("키" : "값") : 엔트리 추가
	//jsonObject.put("id", "qweqwe");
	//jsonObject.put("password", "qweqwe"); 
	//값 넘기기
	jsonObject = PorderDao.getporderDao().getOrderDateCount();
%>
<%=jsonObject%>