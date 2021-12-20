<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 성공</title>
</head>
<body>
	<h3>로그인 성공</h3>
	현재 로그인한 아이디 : <%out.print(session.getAttribute("id"));%>
	
	<% 
		Enumeration enumeration = session.getAttributeNames();
		while (enumeration.hasMoreElements()) {
			String s_name = (String)enumeration.nextElement();
			String s_value = (String)session.getAttribute(s_name);
			out.println ("세션 이름 : " + s_name + "세션 값 : " + s_value);
		}
	%> 
	
	
</body>
</html>