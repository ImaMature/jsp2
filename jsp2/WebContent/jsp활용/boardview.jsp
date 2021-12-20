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
	<h3>게시물 상세 페이지</h3>
	<%
		int bnum = Integer.parseInt(request.getParameter("bnum"));
	%>
	<table>
		<tr>
			<td>번호 :</td><td><%=bnum %></td>
		</tr>	
		<tr>
			<td>제목 :</td><td><%=boards.get(bnum).getTitle() %></td>
		</tr>	
		<tr>
			<td>내용 :</td><td><%=boards.get(bnum).getContents() %></td>
		</tr>
		<tr>
			<td>작성자 :</td><td><%=boards.get(bnum).getWriter() %></td>
		</tr>	
	</table>
	
</body>
</html>