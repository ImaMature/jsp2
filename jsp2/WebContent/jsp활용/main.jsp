<%@page import="test.Member"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<%@include file= "header.jsp" %> <!-- arraylist를 쓸려면 해당 jsp include해야함 -->
	<h3>메인 페이지 구역</h3>
	<h4>회원 현황</h4>
	
	<table>
		<tr>
			<th>번호</th><th>아이디</th><th>이름</th>
		</tr>
		<%
			for(int i =0; i<members.size(); i++) {%>
				<tr>
					<td><%=(i+1) %></td>	<!-- 회원 번호 -->
					<td><%=members.get(i).getId() %></td>
					<td><%=members.get(i).getName() %></td>
				</tr>		
		<%}	%>
	</table>
</body>
</html>