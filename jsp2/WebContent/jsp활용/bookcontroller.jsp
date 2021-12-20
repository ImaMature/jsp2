<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="header.jsp" %>
	<%	
		String books = request.getParameter("books"); %>
		
	<table border="1">
		<tr>
			<th>도서번호</th><th>도서이름</th>
		</tr>	
		<% 
			String b = request.getParameter("books"); 
		%>
		<% for(int i =0; i<도서목록.length; i++) {
			if(도서목록[i] != null && 도서목록[i].contains(b)){%>
					<tr>
						<td><%=(i+1)+"번" %></td><td><% out.print(도서목록[i]); %></td>
					</tr>
			<%}
		}
		%>
	</table>
</body>
</html>