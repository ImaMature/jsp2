<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		//1. 하나의 세션 호출하기
		out.print(session.getAttribute("id"));
		
	
		//2. 여러 개의 세션 호출하기 (Enumeration 인터페이스)
						// [getAttributesNames -> 반환타입(Enumeration)인수]
						// * Enumeration : 리스트 혹은 배열의 항목은 순회		
		Enumeration enumeration = session.getAttributeNames();
		
		while(enumeration.hasMoreElements()){
						// .hasMoreElements : 다음 항목 존재여부 확인
			String name =(String)enumeration.nextElement();	// String으로 형변환해야함
						// .nextElement : 다음 항목 가져오기
						// 쿠키의 이름 가져오기(한 개)
			String value = (String)session.getAttribute(name);	// String으로 형변환해야함
						// 가져온 쿠키 이름의 세션 데이터 호출
			out.println("세션 이름 : " + name + "세션 값은 : " + value);
			
		}
	%>

</body>
</html>