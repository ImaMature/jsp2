<%@page import="java.util.Arrays"%>
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
		//데이터 쿠키에 저장할 수 있음. 개인정보 같은 단편적이고 영구적으로 오고가는 데이터들은 서버에 저장. 자주 왔다리갔다리 하는 데이터들은 쿠키에 하기
		Cookie[] cookies = request.getCookies();
		//System.out.print(Arrays.toString(cookies)); 			//배열에 잘들어왔나 확인하기
		if(cookies!=null) {
			for(int i =0; i<cookies.length; i++){
				//System.out.print(cookies[i].getName()+""); 		//쿠키 객체의 i번째 인덱스에서 가져온 이름 값 확인해보기
				if(cookies[i].getName().equals("mycookie")){	//쿠키 찾기 ( i번째 쿠키의 이름값이 mycookie가 맞는지)
				%>
					내 쿠키 이름 : <%=cookies[i].getName() %><br>
					내 쿠키 값 : <%=cookies[i].getValue() %>			
				<%}
			}
		}
	%>
</body>
</html>